#
# A desktop-oriented virtual machines management system written in Shell.
#
# Code is available online at https://github.com/magenete/cuckoo
# See LICENSE for licensing information, and README for details.
#
# Copyright (C) 2016 Magenete Systems OÜ.
#


# Uninstall Cuckoo on Linux for system
cuckoo_os_linux_uninstall_system()
{
    # Files
    if [ -e "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE_DEFAULT" ] && [ -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE_DEFAULT" ]
    then
        mv -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE_DEFAULT" "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE"
    fi

    if [ -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE_DEFAULT_BACKUP" ]
    then
        if [ -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE" ]
        then
            rm -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE_DEFAULT_BACKUP"
        else
            mv "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE_DEFAULT_BACKUP" "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE"
        fi
    fi

    # Directories
    rm -rf "${CUCKOO_OS_SYSTEM_ETC_LIGHTDM_DIR}${CUCKOO_OS}"
    [ -L "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE" ] && rm -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE"

    rm -rf "$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_OS_DIR"
    rm -rf "${CUCKOO_OS_SYSTEM_THEMES_DIR}${CUCKOO_OS}"*
    rm -rf "${CUCKOO_OS_SYSTEM_ICONS_DIR}${CUCKOO_OS}"*

    rm -rf "$CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CUCKOO_OS_DIR"
    rm -f "${CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CONF_DIR}${CUCKOO_OS}"*

    if [ -d "$CUCKOO_OS_SYSTEM_GRUB_THEME_DIR" ]
    then
        rm -rf "${CUCKOO_OS_SYSTEM_GRUB_THEME_DIR}${CUCKOO_OS}"*
        [ -z "$(ls "$CUCKOO_OS_SYSTEM_GRUB_THEME_DIR")" ] && rm -rf "$CUCKOO_OS_SYSTEM_GRUB_THEME_DIR"
    fi

    # Update GRUB
    grub-mkconfig -o "$CUCKOO_OS_SYSTEM_GRUB_CONFIG_FILE"
}


# Uninstall Cuckoo on Linux for user
cuckoo_os_linux_uninstall_user()
{
    cuckoo_os_style_xfce4_theme_uninstall

    rm -rf "$CUCKOO_OS_SYSTEM_USER_CUCKOO_OS_DIR"

    # XFce4 themes
    rm -f "${CUCKOO_OS_SYSTEM_USER_XFCE4_THEMES_DIR}${CUCKOO_OS}"*

    if [ -z "$(ls "$CUCKOO_OS_SYSTEM_USER_XFCE4_THEMES_DIR")" ]
    then
        rm -rf "$CUCKOO_OS_SYSTEM_USER_XFCE4_THEMES_DIR"
    fi

    # XFce4 icons
    rm -f "${CUCKOO_OS_SYSTEM_USER_XFCE4_ICONS_DIR}${CUCKOO_OS}"*

    if [ -z "$(ls "$CUCKOO_OS_SYSTEM_USER_XFCE4_ICONS_DIR")" ]
    then
        rm -rf "$CUCKOO_OS_SYSTEM_USER_XFCE4_ICONS_DIR"
    fi
}


# Uninstall Cuckoo on Linux in all
cuckoo_os_linux_uninstall()
{
    cuckoo_os_linux_uninstall_$CUCKOO_OS_STYLE_MODE
}


# Update GRUB and LightDM
cuckoo_os_linux_select_system()
{
    if [ ! -z "$CUCKOO_OS_STYLE" ]
    then
        # LightDM
        ln -sf "${CUCKOO_OS_SYSTEM_ETC_LIGHTDM_CUCKOO_OS_GREETER_DIR}${CUCKOO_OS_STYLE}.conf" "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE"

        # GRUB
        export GRUB_BACKGROUND="${CUCKOO_OS_SYSTEM_GRUB_THEME_CUCKOO_OS_BACKGROUND_DIR}${CUCKOO_OS_STYLE}/${CUCKOO_OS_NAME}${CUCKOO_OS_NAME_DIST}.png"
        export GRUB_THEME="${CUCKOO_OS_SYSTEM_GRUB_THEME_DIR}${CUCKOO_OS}/$(cuckoo_os_grub_theme_file_name_define)"
        export GRUB_GFXMODE="${CUCKOO_OS_SYSTEM_GRUB_SCREEN_SIZE}x24"
#        export GRUB_GFXPAYLOAD_LINUX="keep"

        grub-mkconfig -o "$CUCKOO_OS_SYSTEM_GRUB_CONFIG_FILE"
    fi
}


# Update user settings
cuckoo_os_linux_select_user()
{
    cuckoo_os_linux_install_user
}


# Update settings
cuckoo_os_linux_select()
{
    cuckoo_os_linux_select_$CUCKOO_OS_STYLE_MODE
}


# Install and set only for system
cuckoo_os_linux_install_system()
{
    if [ -e "$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_OS_DIR" ] && [ -d "$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_OS_DIR" ]
    then
        cuckoo_os_message "WARNING: Directory '${CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_OS_DIR}' already exists"
    else
        mkdir "$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_OS_DIR"
        if [ $? -gt 0 ]
        then
            cuckoo_os_error "Could not create directory '$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_OS_DIR'"
        fi
    fi

    # Cuckoo OS backgrounds
    cp -r "$CUCKOO_OS_ETC_BACKGROUND_DIR" "$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_OS_DIR"
    if [ $? -gt 0 ]
    then
        cuckoo_os_error "Could not copy from '$CUCKOO_OS_ETC_BACKGROUND_DIR' to '$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_OS_DIR'"
    fi
    chown -R root.root "$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_OS_DIR"
    chmod 0755 "$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_OS_DIR"*

    # XFce4 themes
    for xfce4_theme in $(ls "$CUCKOO_OS_ETC_XFCE4_THEME_DIR")
    do
        cp -r "${CUCKOO_OS_ETC_XFCE4_THEME_DIR}${xfce4_theme}" "${CUCKOO_OS_SYSTEM_THEMES_DIR}${CUCKOO_OS}-${xfce4_theme}"
        if [ $? -gt 0 ]
        then
            cuckoo_os_error "Could not copy theme '${CUCKOO_OS_ETC_XFCE4_THEME_DIR}${xfce4_theme}'"
        fi
    done

    # Xfce4 icons
    for xfce4_icon in $(ls "$CUCKOO_OS_ETC_XFCE4_ICON_DIR")
    do
        cp -r "${CUCKOO_OS_ETC_XFCE4_ICON_DIR}${xfce4_icon}" "${CUCKOO_OS_SYSTEM_ICONS_DIR}${CUCKOO_OS}-${xfce4_icon}"
        if [ $? -gt 0 ]
        then
            cuckoo_os_error "Could not copy theme '${CUCKOO_OS_ETC_XFCE4_ICON_DIR}${xfce4_icon}'"
        fi
    done

    cuckoo_os_grub_theme_dir_create
    cuckoo_os_grub_theme_files_create

    cuckoo_os_lightdm_conf_dir_create
    cuckoo_os_lightdm_conf_file_create
    cuckoo_os_lightdm_gtk_greeter_files_create
    cuckoo_os_lightdm_gtk_greeter_file_select

    cuckoo_os_linux_select_system
}


# Install and set only for user
cuckoo_os_linux_install_user()
{
    mkdir -p "$CUCKOO_OS_SYSTEM_USER_CUCKOO_OS_DIR"

    # XFce4 themes
    mkdir -p "$CUCKOO_OS_SYSTEM_USER_XFCE4_THEMES_DIR"

    for xfce4_theme in $(ls "$CUCKOO_OS_ETC_XFCE4_THEME_DIR")
    do
        ln -s "${CUCKOO_OS_ETC_XFCE4_THEME_DIR}${xfce4_theme}" "${CUCKOO_OS_SYSTEM_THEMES_DIR}${CUCKOO_OS}-${xfce4_theme}"
    done

    # Xfce4 icons
    mkdir -p "$CUCKOO_OS_SYSTEM_USER_XFCE4_ICONS_DIR"

    for xfce4_icon in $(ls "$CUCKOO_OS_ETC_XFCE4_ICON_DIR")
    do
        ln -s "${CUCKOO_OS_ETC_XFCE4_ICON_DIR}${xfce4_icon}" "${CUCKOO_OS_SYSTEM_ICONS_DIR}${CUCKOO_OS}-${xfce4_icon}"
    done

    cuckoo_os_style_xfce4_theme_install
    cuckoo_os_style_xfce4_theme_define
}


# Install by mode
cuckoo_os_linux_install()
{
    cuckoo_os_linux_install_$CUCKOO_OS_STYLE_MODE
}


# Only for Linux
cuckoo_os_linux_dist_define()
{
    . /etc/os-release

    case "$ID" in
        alt )
            CUCKOO_OS_NAME_DIST="/alt"
        ;;
        arch )
            CUCKOO_OS_NAME_DIST="/arch"
        ;;
        debian )
            CUCKOO_OS_NAME_DIST="/debian"
        ;;
        fedora )
            CUCKOO_OS_NAME_DIST="/fedora"
        ;;
        opensuse )
            CUCKOO_OS_NAME_DIST="/opensuse"
        ;;
        ubuntu )
            CUCKOO_OS_NAME_DIST="/xubuntu"
        ;;
        * )
            CUCKOO_OS_NAME_DIST=""
        ;;
    esac
}
