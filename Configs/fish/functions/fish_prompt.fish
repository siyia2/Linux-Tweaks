function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l pwd_static (string replace -r "^$HOME" "~" "$PWD")

    set_color $fish_color_command
    echo -n "$USER"
    set_color purple
    echo -n '@'
    set_color $fish_color_command
    echo -n "$hostname"
    set_color purple
    echo -n '@'
    set_color $fish_color_comment
    echo -n "$pwd_static> "
    set_color normal
end
