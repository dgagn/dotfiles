local ok_telescope, telescope = pcall(require, "telescope")
if not ok_telescope then
  return
end

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

-- Trim helper (Lua 5.1 compatible)
local function trim(s)
  return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

-- Given a timew summary line, extract the tags string.
-- Example line:
-- W46 2025-11-12 Wed @3 setup            16:09:19 16:09:21 0:00:02
-- We want "setup" (or "foo bar" if multiple tags).
local function parse_tags(line)
  local tags = line:match("@%d+%s+(.-)%s+%d%d:%d%d:%d%d")
  if not tags then
    return nil
  end

  tags = trim(tags)
  if tags == "" then
    return nil
  end

  return tags
end

-- Extract @ID from a line (without the '@')
local function parse_id(line)
  local id = line:match("@(%d+)")
  return id
end

-- Build the list of lines to show in Telescope
-- We call `timew summary :day :ids` and only keep lines with tags.
local function timew_list()
  local handle = io.popen("timew summary :day :ids 2>/dev/null")
  if not handle then
    return { "Failed to run `timew summary :day :ids`" }
  end

  local result = handle:read("*a")
  handle:close()

  local items = {}

  for line in result:gmatch("[^\r\n]+") do
    local tags = parse_tags(line)
    if tags then
      table.insert(items, line)
    end
  end

  if #items == 0 then
    table.insert(items, "No tagged intervals for :day")
  end

  return items
end

local function run_timew(cmd)
  local parts = {}
  for word in cmd:gmatch("%S+") do
    table.insert(parts, word)
  end
  table.insert(parts, 1, "timew")

  vim.fn.jobstart(parts, { detach = true })
end

local function timew_picker(opts)
  opts = opts or {}

  pickers.new(opts, {
    prompt_title = "Timewarrior (:day)",
    finder = finders.new_table({
      results = timew_list(),
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      local function stop_timew()
        actions.close(prompt_bufnr)
        run_timew("stop")
      end

      local function continue_timew()
        local selection = action_state.get_selected_entry()
        if not selection then
          return
        end
        local line = selection.value or ""
        actions.close(prompt_bufnr)

        local tags = parse_tags(line)
        if tags then
          run_timew("continue " .. tags)
        else
          vim.notify("Could not extract tags from line", vim.log.levels.WARN)
        end
      end

      local function delete_timew()
        local selection = action_state.get_selected_entry()
        if not selection then
          return
        end
        local line = selection.value or ""
        local id = parse_id(line)
        if not id then
          vim.notify("Could not find @ID in line", vim.log.levels.WARN)
          return
        end

        actions.close(prompt_bufnr)
        run_timew("delete @" .. id)
      end

      local function start_timew_custom()
        actions.close(prompt_bufnr)
        vim.ui.input({ prompt = "Timew tags: " }, function(input)
          if input and trim(input) ~= "" then
            run_timew("start " .. input)
          else
            vim.notify("No tags given, not starting timew", vim.log.levels.INFO)
          end
        end)
      end

      map("i", "<C-s>", stop_timew)
      map("i", "<CR>",  continue_timew)
      map("i", "<C-x>", delete_timew)
      map("i", "<C-n>", start_timew_custom)

      map("n", "<C-s>", stop_timew)
      map("n", "<CR>",  continue_timew)
      map("n", "<C-x>", delete_timew)
      map("n", "<C-n>", start_timew_custom)

      return true
    end,
  }):find()
end

return telescope.register_extension({
  exports = {
    timew = timew_picker,
  },
})
