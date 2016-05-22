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

Cuckoo OS theme style install/uninstall script.

  Actions:

    -i, --install      Install Cuckoo OS (by default).
    -u, --uninstall    Uninstall Cuckoo OS.
    -e, --select       Select style and mode.
    -D, --screen-size  Define screen size (by default: ${CUCKOO_OS_SYSTEM_SCREEN_SIZE_DEFAULT},min: ${CUCKOO_OS_SYSTEM_SCREEN_SIZE_X_MIN}x${CUCKOO_OS_SYSTEM_SCREEN_SIZE_Y_MIN}, max: ${CUCKOO_OS_SYSTEM_SCREEN_SIZE_X_MAX}x${CUCKOO_OS_SYSTEM_SCREEN_SIZE_Y_MAX}).
                         OS screen sizes: $(from_arr_to_str "$(cuckoo_os_screen_size_list)").

    -V, --version      Print the current version.
    -h, --help         Show this message.

  Arguments:

    -y, --style        Set theme style (by default: ${CUCKOO_OS_STYLE_DEFAULT}).
                         Theme styles: $(from_arr_to_str "$CUCKOO_OS_STYLE_LIST").
    -m, --mode         Set style mode (by default: ${CUCKOO_OS_STYLE_MODE_DEFAULT}).
                         Style modes: $(from_arr_to_str "$CUCKOO_OS_STYLE_MODE_LIST").
    -d, --font-dpi     Set font DPI (by default: ${CUCKOO_OS_STYLE_THEME_FONT_DPI_DEFAULT}, min: ${CUCKOO_OS_STYLE_THEME_FONT_DPI_MIN}, max: ${CUCKOO_OS_STYLE_THEME_FONT_DPI_MAX}).

    -s, --su           Run from superuser (root), using su.
    -U, --su-user      Run from some different user, using su.
    -S, --sudo         Run using sudo.

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
