#
# A desktop-oriented virtual machines management system written in Shell.
#
# Code is available online at https://github.com/magenete/cuckoo
# See LICENSE for licensing information, and README for details.
#
# Copyright (C) 2016 Magenete Systems OÜ.
#


# Define Cuckoo theme by style
cucko_os_style_theme_define()
{
    case "$1" in
        light )
            echo "adwaita-grey"
        ;;
        gray )
            echo "adwaita-graphene"
        ;;
        dark )
            echo "xfce-dusk-green"
        ;;
        * )
            cuckoo_os_error "Invalid style '${1}'"
        ;;
    esac
}


# Style Light options
cuckoo_os_args_style_light()
{
    CUCKOO_OS_STYLE_FONT_COLOR="#646464"
    CUCKOO_OS_STYLE_BACKGROUND_COLOR="#dbdbdb"

    case "${CUCKOO_OS_NAME_DIST#/}" in
        alt )
            CUCKOO_OS_NAME_DIST_COLOR="#fdd005"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#feec9b"
        ;;
        arch )
            CUCKOO_OS_NAME_DIST_COLOR="#1793d1"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#a2d4ed"
        ;;
        debian )
            CUCKOO_OS_NAME_DIST_COLOR="#a80030"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#dc99ac"
        ;;
        fedora )
            CUCKOO_OS_NAME_DIST_COLOR="#0a57a4"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#9dbcdb"
        ;;
        opensuse )
            CUCKOO_OS_NAME_DIST_COLOR="#73ba25"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#c7e3a8"
        ;;
        ubuntu )
            CUCKOO_OS_NAME_DIST_COLOR="#0044aa"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#99b4dd"
        ;;
        * )
            CUCKOO_OS_NAME_DIST_COLOR="#ffc42b"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#ffe7aa"
        ;;
    esac
}


# Style Gray options
cuckoo_os_args_style_gray()
{
    CUCKOO_OS_STYLE_FONT_COLOR="#bfbfbf"
    CUCKOO_OS_STYLE_BACKGROUND_COLOR="#484848"

    case "${CUCKOO_OS_NAME_DIST#/}" in
        alt )
            CUCKOO_OS_NAME_DIST_COLOR="#fdd005"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#caae2c"
        ;;
        arch )
            CUCKOO_OS_NAME_DIST_COLOR="#1793d1"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#3787ae"
        ;;
        debian )
            CUCKOO_OS_NAME_DIST_COLOR="#a80030"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#942947"
        ;;
        fedora )
            CUCKOO_OS_NAME_DIST_COLOR="#0a57a4"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#2f6192"
        ;;
        opensuse )
            CUCKOO_OS_NAME_DIST_COLOR="#73ba25"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#72a041"
        ;;
        ubuntu )
            CUCKOO_OS_NAME_DIST_COLOR="#0044aa"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#295496"
        ;;
        * )
            CUCKOO_OS_NAME_DIST_COLOR="#ffc42b"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#cca644"
        ;;
    esac
}


# Style Dark options
cuckoo_os_args_style_dark()
{
    CUCKOO_OS_STYLE_FONT_COLOR="#646464"
    CUCKOO_OS_STYLE_BACKGROUND_COLOR="#161616"

    case "${CUCKOO_OS_NAME_DIST#/}" in
        alt )
            CUCKOO_OS_NAME_DIST_COLOR="#fdd005"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#988221"
        ;;
        arch )
            CUCKOO_OS_NAME_DIST_COLOR="#1793d1"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#296583"
        ;;
        debian )
            CUCKOO_OS_NAME_DIST_COLOR="#a80030"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#6f1f35"
        ;;
        fedora )
            CUCKOO_OS_NAME_DIST_COLOR="#0a57a4"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#23496d"
        ;;
        opensuse )
            CUCKOO_OS_NAME_DIST_COLOR="#73ba25"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#567831"
        ;;
        ubuntu )
            CUCKOO_OS_NAME_DIST_COLOR="#0044aa"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#1f3f70"
        ;;
        * )
            CUCKOO_OS_NAME_DIST_COLOR="#ffc42b"
            CUCKOO_OS_NAME_DIST_SHADOW_COLOR="#997d33"
        ;;
    esac
}
