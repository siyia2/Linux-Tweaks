#!/bin/sh
if [ ! -h $HOME/.xsession-errors ]; then
 rm $HOME/.xsession-errors
 ln -s /dev/null $HOME/.xsession-errors
fi

if [ ! -h $HOME/.xsession-errors.old ]; then
 rm $HOME/.xsession-errors.old
 ln -s /dev/null $HOME/.xsession-errors.old
fi

exit
