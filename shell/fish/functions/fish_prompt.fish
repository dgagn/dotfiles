function fish_prompt
    set_color brblack
	echo -n "["(date "+%H:%M")"] "
    set_color normal
    printf "%s:" (whoami)

    echo -n (prompt_pwd)

    set_color 96cbfe
    printf '%s' (string trim -l (__fish_git_prompt))
    # printf '%s' (__fish_git_prompt)

    set_color normal
    echo -n '$ '

    set_color normal
end
