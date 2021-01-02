function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

    # User
    set_color $fish_color_command
    echo -n (whoami)
    set_color purple

    echo -n '@'

    # Host
    set_color $fish_color_command
    echo -n (prompt_hostname)
    set_color purple

     echo -n '@'

    # PWD
    set_color $fish_color_comment
    echo -n (prompt_pwd) && echo -n '> '
    set_color normal

    __terlar_git_prompt
    __fish_hg_prompt
    

    if not test $last_status -eq 0
        set_color $fish_color_error
	else 
		set_color $fish_color_command
    end


end
