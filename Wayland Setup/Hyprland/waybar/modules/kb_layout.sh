!/bin/bash
  
KEYBOARD=$(swaymsg -pt get_config | awk '{if ($1 == "input") {name=$2}; if($1 == "xkb_layout") {print name; exit}}')

MANPAGE=$(man --where xkeyboard-config)
case `file -bi $MANPAGE | grep -o "^[^/]*/[^;]*"` in
    'application/x-gzip') CAT='zcat';;
    'application/x-bzip2') CAT='bzcat';;
    'application/x-tar') CAT='tar -O -xf';;
    'application/x-xz') CAT='xzcat';;
    'text/plain') CAT='cat';;
esac

while true; do
    ACTIVE_LANGUAGE=$(swaymsg -t get_inputs | grep -5 $KEYBOARD | tail -1 | sed 's/.*"\(.*\)".*$/\1/gi')
    $CAT $MANPAGE | awk -F'[\t(]' -v var="$ACTIVE_LANGUAGE" 'index($0,var)>=1 {print $1; exit}'

    sleep 1
done

exit
