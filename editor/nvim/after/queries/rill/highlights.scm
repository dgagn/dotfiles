[
  "create"
  "alter"
  "drop"
  "rename"
  "enum"
  "down"
  "sql"
  "add"
  "column"
  "value"
  "to"
  "ref"
  "default"
  "on"
  "delete"
  "update"
  "no"
  "index"
  "nullable"
  "primary"
  "unique"
  "constraint"
] @keyword

(timestamps) @keyword
(soft_deletes) @keyword

[
  "true"
  "false"
] @boolean

(column_definition
  name: (identifier) @property)

(reference_target
  table: (identifier) @type)

(reference_target
  column: (identifier) @property)

[
  (create_table
    name: (identifier))
  (alter_table
    name: (identifier))
  (drop_table
    name: (identifier))
  (rename_table
    from: (identifier))
  (rename_table
    to: (identifier))
  (create_enum
    name: (identifier))
  (alter_enum
    name: (identifier))
  (drop_enum
    name: (identifier))
  (rename_enum
    from: (identifier))
  (rename_enum
    to: (identifier))
] @type

[
  (index_declaration
    name: (identifier))
  (constraint_unique_declaration
    name: (identifier))
] @label

[
  "id"
  "string"
  "text"
  "int"
  "integer"
  "bigint"
  "bool"
  "boolean"
  "date"
  "time"
  "datetime"
  "timestamp"
  "timestamptz"
  "json"
  "jsonb"
  "uuid"
  "ulid"
  "remember_token"
  "float"
  "double"
] @type.builtin

(column_definition
  type: (type
    (call_expression
      function: (identifier) @type.builtin)))

(call_expression
  function: (identifier) @function)

(default_clause
  value: (expression
    (string) @constant))

(default_clause
  value: (expression
    (number) @constant))

(default_clause
  value: (expression
    (boolean) @constant))

(default_clause
  value: (expression
    (identifier) @constant))

(reference_action) @keyword.operator

(string) @string
(triple_quoted_string) @string.special
(number) @number
(comment) @comment

[
  "("
  ")"
  "{"
  "}"
  ","
  ";"
  "."
] @punctuation.bracket
