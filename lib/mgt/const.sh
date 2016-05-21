#!/bin/sh
#
# A desktop-oriented virtual machines management system written in Shell.
#
# Code is available online at https://github.com/magenete/cuckoo
# See LICENSE for licensing information, and README for details.
#
# Copyright (C) 2016 Magenete Systems OÜ.
#


# Define OS screen size list
cuckoo_os_screen_size_list()
{
    local screen_size_list=""

    xrandr -q 2> /dev/null | {
        while IFS= read -r line
        do
            [ "${line#  }" = "$line" ] && continue

            for value in $line
            do
                if [ -z "$screen_size_list" ]
                then
                    screen_size_list="$value"
                else
                    screen_size_list="${screen_size_list} ${value}"
                fi

                break
            done
        done

        echo $screen_size_list
    }
}


CUCKOO_OS_ACTION_DEFAULT="install"
CUCKOO_OS_STYLE_LIST="light gray dark"
CUCKOO_OS_STYLE_DEFAULT="gray"
CUCKOO_OS_STYLE_MODE_LIST="system user"
CUCKOO_OS_STYLE_MODE_DEFAULT="user"

CUCKOO_OS_SYSTEM_GRUB_SCREEN_SIZE="1024x768"
CUCKOO_OS_SYSTEM_SCREEN_SIZE_LIST="$(cuckoo_os_screen_size_list)"
CUCKOO_OS_SYSTEM_SCREEN_SIZE_DEFAULT="1280x720"

CUCKOO_OS_STYLE_THEME_CURSOR="cuckoo-adwaita"
CUCKOO_OS_STYLE_THEME_ICON="cuckoo-adwaita"
CUCKOO_OS_STYLE_THEME_LIGHT="cuckoo-adwaita-grey"
CUCKOO_OS_STYLE_THEME_GRAY="cuckoo-adwaita-graphene"
CUCKOO_OS_STYLE_THEME_DARK="cuckoo-xfce-dusk-green"
CUCKOO_OS_STYLE_THEME_FONT_HINT="hintfull"
CUCKOO_OS_STYLE_THEME_FONT_RGBA="rgb"
CUCKOO_OS_STYLE_THEME_FONT_DPI_MIN=96
CUCKOO_OS_STYLE_THEME_FONT_DPI_MAX=$((CUCKOO_OS_STYLE_THEME_FONT_DPI_MIN * 2))
CUCKOO_OS_STYLE_THEME_FONT_DPI_DEFAULT=$CUCKOO_OS_STYLE_THEME_FONT_DPI_MIN
