state=$(echo "$1" | cut -d " " -f 3)
case "$state" in
    open)
rfkill unblock all        ;;
    close)
rfkill unblock all        ;;
    *)
        # panic: not a state I know about!
esac
