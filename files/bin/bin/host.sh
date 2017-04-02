#!/bin/bash
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    # remote
    echo "☁"
else
    case $(ps -o comm= -p $PPID) in sshd|*/sshd)
        # remote
        echo "☁"
        ;;
    esac 

    # local
    echo "💻"
fi
