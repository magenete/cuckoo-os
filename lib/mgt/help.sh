#
# A desktop-oriented virtual machines management system written in Shell.
#
# Code is available online at https://github.com/magenete/cuckoo
# See LICENSE for licensing information, and README for details.
#
# Copyright (C) 2016 Magenete Systems OÜ.
#


# Help message
cuckoo_os_help()
{
    cat << _H_E_L_P

Usage: $(basename $0) [actions] [arguments]

Cuckoo OS style install/uninstall script.

  Action:

    -i, --install      Install Cuckoo OS (by default).
    -u, --uninstall    Uninstall Cuckoo OS.
    -s, --select       Select mode.

        --version      Print the current version.
    -h, --help         Show this message.

  Arguments:

    -l, --style-light  Set light theme.
    -g, --style-gray   Set gray theme (by default).
    -d, --style-dark   Set dark theme.

    -S, --system       Set system themes (by default).
    -U, --user         Set user themes.
    -A, --all          Set system and user themes.

_H_E_L_P
}


# Convert from Array to String
from_arr_to_str()
{
    local str=""
    local sep=","

    [ ! -z "$2" ] && sep="$2"

    for char in $1
    do
        if [ -z "$str" ]
        then
            str="$char"
        else
            str="${str}${sep} ${char}"
        fi
    done

    echo "$str"
}


# Valid value in array:
#   - return value if valid
#   - returm epty string if not valid
valid_value_in_arr()
{
    for value in $1
    do
        if [ "$value" = "$2" ]
        then
            echo "$value"
            break
        fi
    done

    echo ""
}
