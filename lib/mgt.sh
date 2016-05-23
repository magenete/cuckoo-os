#!/bin/sh
#
# A desktop-oriented virtual machines management system written in Shell.
#
# Code is available online at https://github.com/magenete/cuckoo
# See LICENSE for licensing information, and README for details.
#
# Copyright (C) 2016 Magenete Systems OÜ.
#


CUCKOO_OS_DIR="${CUCKOO_OS_DIR:=$(cd "$(dirname "$0")/.." && pwd -P)}/"

CUCKOO_OS_ACTION=""
CUCKOO_OS_NAME=""
CUCKOO_OS_STYLE=""
CUCKOO_OS_STYLE_THEME=""
CUCKOO_OS_STYLE_THEME_ICON=""
CUCKOO_OS_STYLE_THEME_CURSOR=""
CUCKOO_OS_STYLE_THEME_FONT_DPI=""
CUCKOO_OS_STYLE_FONT_COLOR=""
CUCKOO_OS_STYLE_FONT_COLOR_GRUB=""
CUCKOO_OS_STYLE_BACKGROUND_COLOR=""
CUCKOO_OS_STYLE_MODE=""
CUCKOO_OS_NAME_DIST=""
CUCKOO_OS_NAME_DIST_COLOR=""
CUCKOO_OS_SUPERUSER_COMMAND=""
CUCKOO_OS_SYSTEM_SCREEN_SIZE=""


# Load all Cuckoo OS MGT libs
for mgt_lib_file in $(ls "${CUCKOO_OS_DIR}lib/mgt/"*.sh)
do
    . "$mgt_lib_file"
done


# Launch
if [ "$(whoami)" = "$USER" ] && [ "$(basename $HOME)" = "$USER" ]
then
    cuckoo_os_env

    cuckoo_os_variables

    cuckoo_os_args $@

    cuckoo_os_variables_check

    if [ "$CUCKOO_OS_SUPERUSER_COMMAND" = "sudo" ]
    then
        $CUCKOO_OS_SUPERUSER_COMMAND sh -c "\"${CUCKOO_OS_BIN_DIR}${CUCKOO_OS}\" \"$(cuckoo_os_args_without_superuser "$@")\""
    elif [ -z "$CUCKOO_OS_SUPERUSER_COMMAND" ]
    then
        [ "$CUCKOO_OS_ACTION" = "uninstall" ] && cuckoo_os_screen_size_uninstall_$CUCKOO_OS_STYLE_MODE

        [ "$CUCKOO_OS_ACTION" != "screen-size" ] && cuckoo_os_${CUCKOO_OS_NAME}_${CUCKOO_OS_ACTION}

        if [ ! -z "$CUCKOO_OS_SYSTEM_SCREEN_SIZE" ]
        then
            case "$CUCKOO_OS_ACTION" in
                install | screen-size )
                    cuckoo_os_screen_size_install_$CUCKOO_OS_STYLE_MODE
                ;;
            esac
        fi
    else
        $CUCKOO_OS_SUPERUSER_COMMAND --command "\"${CUCKOO_OS_BIN_DIR}${CUCKOO_OS}\" \"$(cuckoo_os_args_without_superuser "$@")\""
    fi
else
    cuckoo_os_error "Invalid ENV of current user '${USER}'"
fi
