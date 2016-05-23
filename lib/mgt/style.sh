#
# A desktop-oriented virtual machines management system written in Shell.
#
# Code is available online at https://github.com/magenete/cuckoo
# See LICENSE for licensing information, and README for details.
#
# Copyright (C) 2016 Magenete Systems OÜ.
#


# Define theme by style
cuckoo_os_style_theme_define()
{
    local cuckoo_os_style="$1"

    [ -z "$cuckoo_os_style" ] && cuckoo_os_style="$CUCKOO_OS_STYLE"

    case "$cuckoo_os_style" in
        light )
            CUCKOO_OS_STYLE_THEME="$CUCKOO_OS_STYLE_THEME_LIGHT"
        ;;
        gray )
            CUCKOO_OS_STYLE_THEME="$CUCKOO_OS_STYLE_THEME_GRAY"
        ;;
        dark )
            CUCKOO_OS_STYLE_THEME="$CUCKOO_OS_STYLE_THEME_DARK"
        ;;
        * )
            cuckoo_os_error "Invalid style '${cuckoo_os_style}'"
        ;;
    esac
}


# Install XFce4 theme by style
cuckoo_os_style_xfce4_theme_install()
{
    if [ -f "$CUCKOO_OS_SYSTEM_USER_XFCE4_CONF_DESKTOP_XML_FILE" ] && [ ! -f "$CUCKOO_OS_SYSTEM_USER_XFCE4_CONF_DESKTOP_XML_DEFAULT_FILE" ]
    then
        cp "$CUCKOO_OS_SYSTEM_USER_XFCE4_CONF_DESKTOP_XML_FILE" "$CUCKOO_OS_SYSTEM_USER_XFCE4_CONF_DESKTOP_XML_DEFAULT_FILE"
    fi

    if [ -f "$CUCKOO_OS_SYSTEM_USER_XFCE4_CONF_XSETTINGS_XML_FILE" ] && [ ! -f "$CUCKOO_OS_SYSTEM_USER_XFCE4_CONF_XSETTINGS_XML_DEFAULT_FILE" ]
    then
        cp "$CUCKOO_OS_SYSTEM_USER_XFCE4_CONF_XSETTINGS_XML_FILE" "$CUCKOO_OS_SYSTEM_USER_XFCE4_CONF_XSETTINGS_XML_DEFAULT_FILE"
    fi
}


# Define XFce4 theme by style
cuckoo_os_style_xfce4_theme_define()
{
    local cuckoo_os_background_file="${CUCKOO_OS_STYLE}/${CUCKOO_OS_NAME}${CUCKOO_OS_NAME_DIST}.png"
    local cuckoo_os_themes_dir="$CUCKOO_OS_STYLE_THEME"
    local cuckoo_os_icons_dir="$CUCKOO_OS_STYLE_THEME_ICON"

    if [ "$CUCKOO_OS_STYLE_MODE" = "$CUCKOO_OS_STYLE_MODE_DEFAULT" ]
    then
        if [ -f "${CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_OS_BACKGROUND_DIR}${cuckoo_os_background_file}" ]
        then
            cuckoo_os_background_file="${CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_OS_BACKGROUND_DIR}${cuckoo_os_background_file}"
        else
            cuckoo_os_background_file="${CUCKOO_OS_ETC_BACKGROUND_DIR}${cuckoo_os_background_file}"
        fi

        if [ -d "${CUCKOO_OS_SYSTEM_THEMES_DIR}${cuckoo_os_themes_dir}" ]
        then
            cuckoo_os_themes_dir="${CUCKOO_OS_SYSTEM_THEMES_DIR}${cuckoo_os_themes_dir}"
        else
            cuckoo_os_themes_dir="${CUCKOO_OS_SYSTEM_USER_XFCE4_THEMES_DIR}${cuckoo_os_themes_dir}"
        fi

        if [ -d "${CUCKOO_OS_SYSTEM_ICONS_DIR}${cuckoo_os_icons_dir}" ]
        then
            cuckoo_os_icons_dir="${CUCKOO_OS_SYSTEM_ICONS_DIR}${cuckoo_os_icons_dir}"
        else
            cuckoo_os_icons_dir="${CUCKOO_OS_SYSTEM_USER_XFCE4_ICONS_DIR}${cuckoo_os_icons_dir}"
        fi
    else
        cuckoo_os_background_file="${CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_OS_BACKGROUND_DIR}${cuckoo_os_background_file}"
        cuckoo_os_themes_dir="${CUCKOO_OS_SYSTEM_THEMES_DIR}${cuckoo_os_themes_dir}"
        cuckoo_os_icons_dir="${CUCKOO_OS_SYSTEM_ICONS_DIR}${cuckoo_os_icons_dir}"
    fi

    cuckoo_os_style_theme_define

    xfconf-query -c "xsettings" -p "/Xft/Antialias" -n -t "int" -s "1"
    xfconf-query -c "xsettings" -p "/Xft/HintStyle" -n -t "string" -s "$CUCKOO_OS_STYLE_THEME_FONT_HINT"
    xfconf-query -c "xsettings" -p "/Xft/RGBA" -n -t "string" -s "$CUCKOO_OS_STYLE_THEME_FONT_RGBA"
    xfconf-query -c "xsettings" -p "/Xfce/LastCustomDPI" -n -t "int" -s "$CUCKOO_OS_STYLE_THEME_FONT_DPI"
    xfconf-query -c "xsettings" -p "/Xft/DPI" -n -t "int" -s "$CUCKOO_OS_STYLE_THEME_FONT_DPI"

    if [ -e "$cuckoo_os_themes_dir" ]
    then
        xfconf-query -c "xsettings" -p "/Net/ThemeName" -t "string" -s "$CUCKOO_OS_STYLE_THEME"
    fi
    if [ -e "$cuckoo_os_icons_dir" ]
    then
        xfconf-query -c "xsettings" -p "/Net/IconThemeName" -t "string" -s "$CUCKOO_OS_STYLE_THEME_ICON"
        xfconf-query -c "xsettings" -p "/Gtk/CursorThemeName" -t "string" -s "$CUCKOO_OS_STYLE_THEME_CURSOR"
    fi

    if [ -f "$cuckoo_os_background_file" ]
    then
        xfconf-query -c "xfce4-desktop" -p "/backdrop/screen0/monitor0/image-show" -n -t "bool" -s "true"
        xfconf-query -c "xfce4-desktop" -p "/backdrop/screen0/monitor0/image-style" -n -t "int" -s "5"
        xfconf-query -c "xfce4-desktop" -p "/backdrop/screen0/monitor0/image-path" -n -t "string" -s "$cuckoo_os_background_file"
    fi
}


# Uninstall XFce4 theme by style
cuckoo_os_style_xfce4_theme_uninstall()
{
    if [ -f "$CUCKOO_OS_SYSTEM_USER_XFCE4_CONF_DESKTOP_XML_DEFAULT_FILE" ]
    then
        mv -f "$CUCKOO_OS_SYSTEM_USER_XFCE4_CONF_DESKTOP_XML_DEFAULT_FILE" "$CUCKOO_OS_SYSTEM_USER_XFCE4_CONF_DESKTOP_XML_FILE"
    fi

    if [ -f "$CUCKOO_OS_SYSTEM_USER_XFCE4_CONF_XSETTINGS_XML_DEFAULT_FILE" ]
    then
        mv -f "$CUCKOO_OS_SYSTEM_USER_XFCE4_CONF_XSETTINGS_XML_DEFAULT_FILE" "$CUCKOO_OS_SYSTEM_USER_XFCE4_CONF_XSETTINGS_XML_FILE"
    fi

    xfconf-query -c "xfce4-desktop" -p "/backdrop/screen0/monitor0" -R -r
    xfconf-query -c "xsettings" -p "/Xft" -R -r
    xfconf-query -c "xsettings" -p "/Net" -R -r
    xfconf-query -c "xsettings" -p "/Gtk" -R -r
}


# Style Light options
cuckoo_os_args_style_light()
{
    CUCKOO_OS_STYLE_FONT_COLOR="#646464"
    CUCKOO_OS_STYLE_FONT_COLOR_GRUB="grey"
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
    CUCKOO_OS_STYLE_FONT_COLOR_GRUB="lightgrey"
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
    CUCKOO_OS_STYLE_FONT_COLOR_GRUB="grey"
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
