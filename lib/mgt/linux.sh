#
# A desktop-oriented virtual machines management system written in Shell.
#
# Code is available online at https://github.com/magenete/cuckoo
# See LICENSE for licensing information, and README for details.
#
# Copyright (C) 2016 Magenete Systems OÜ.
#


#
cuckoo_os_linux_uninstall_system()
{
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

    grub-mkconfig -o "$CUCKOO_OS_SYSTEM_GRUB_CONFIG_FILE"
}


#
cuckoo_os_linux_uninstall_user()
{
    cuckoo_os_style_xfce_theme_uninstall
}


#
cuckoo_os_linux_uninstall_all()
{
    cuckoo_os_linux_uninstall_system
    cuckoo_os_linux_uninstall_user
}


#
cuckoo_os_linux_uninstall()
{
    rm -f "${CUCKOO_OS_SYSTEM_ETC_LIGHTDM_DIR}cuckoo"*
    [ -L "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE" ] && rm -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE"

    rm -rf "$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_DIR"
    rm -rf "${CUCKOO_OS_SYSTEM_THEMES_DIR}cuckoo"*
    rm -rf "${CUCKOO_OS_SYSTEM_ICONS_DIR}cuckoo"*

    rm -rf "$CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CUCKOO_DIR"
    rm -f "${CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CONF_DIR}cuckoo"*

    if [ -d "$CUCKOO_OS_SYSTEM_GRUB_THEME_DIR" ]
    then
        rm -rf "${CUCKOO_OS_SYSTEM_GRUB_THEME_DIR}cuckoo"*
        [ -z "$(ls "$CUCKOO_OS_SYSTEM_GRUB_THEME_DIR")" ] && rm -rf "$CUCKOO_OS_SYSTEM_GRUB_THEME_DIR"
    fi

    cuckoo_os_linux_uninstall_$CUCKOO_OS_STYLE_MODE
}


#
cuckoo_os_linux_select_system()
{
    cuckoo_os_linux_install_system
}


#
cuckoo_os_linux_select_user()
{
    cuckoo_os_linux_install_user
}


#
cuckoo_os_linux_select_all()
{
    cuckoo_os_linux_select_system
    cuckoo_os_linux_select_user
}


#
cuckoo_os_linux_select()
{
    if [ ! -f "${CUCKOO_OS_SYSTEM_ETC_LIGHTDM_DIR}$(cuckoo_os_lightdm_gtk_greeter_file_name "$CUCKOO_OS_STYLE")" ]
    then
        cuckoo_os_lightdm_gtk_greeter_files_create
    fi

    cuckoo_os_linux_select_$CUCKOO_OS_STYLE_MODE
}


#
cuckoo_os_linux_install_system()
{
    if [ ! -z "$CUCKOO_OS_STYLE" ]
    then
        # LightDM
        ln -sf "${CUCKOO_OS_SYSTEM_ETC_LIGHTDM_DIR}$(cuckoo_os_lightdm_gtk_greeter_file_name "$CUCKOO_OS_STYLE")" "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE"

        # GRUB
        export GRUB_BACKGROUND="${CUCKOO_OS_SYSTEM_GRUB_THEME_DIR}cuckoo/background/${CUCKOO_OS_STYLE}/${CUCKOO_OS_NAME}${CUCKOO_OS_NAME_DIST}.png"
        export GRUB_THEME="${CUCKOO_OS_SYSTEM_GRUB_THEME_DIR}cuckoo/$(cuckoo_os_grub_theme_file_name_define)"
        export GRUB_GFXMODE="${CUCKOO_OS_SYSTEM_GRUB_SCREEN_SIZE}x24"
        export GRUB_GFXPAYLOAD_LINUX="keep"

        grub-mkconfig -o "$CUCKOO_OS_SYSTEM_GRUB_CONFIG_FILE"
    fi
}


#
cuckoo_os_linux_install_user()
{
    cuckoo_os_style_xfce_theme_install
    cuckoo_os_style_xfce_theme_define
}


#
cuckoo_os_linux_install_all()
{
    cuckoo_os_linux_install_system
    cuckoo_os_linux_install_user
}


#
cuckoo_os_linux_install()
{
    if [ -e "$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_DIR" ] && [ -d "$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_DIR" ]
    then
        cuckoo_os_message "WARNING: Directory '${CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_DIR}' already exists"
    else
        mkdir "$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_DIR"
        if [ $? -gt 0 ]
        then
            cuckoo_os_error "Could not create directory '$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_DIR'"
        fi
    fi

    # Cuckoo OS backgrounds
    cp -r "$CUCKOO_OS_ETC_BACKGROUND_DIR" "$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_DIR"
    if [ $? -gt 0 ]
    then
        cuckoo_os_error "Could not copy from '$CUCKOO_OS_ETC_BACKGROUND_DIR' to '$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_DIR'"
    fi
    chown -R root.root "$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_DIR"
    chmod 0755 "$CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_DIR"*

    # XFce themes
    for xfce_theme in $(ls "$CUCKOO_OS_ETC_XFCE_THEME_DIR")
    do
        cp -r "${CUCKOO_OS_ETC_XFCE_THEME_DIR}${xfce_theme}" "${CUCKOO_OS_SYSTEM_THEMES_DIR}cuckoo-${xfce_theme}"
        if [ $? -gt 0 ]
        then
            cuckoo_os_error "Could not copy theme '${CUCKOO_OS_ETC_XFCE_THEME_DIR}${xfce_theme}'"
        fi
    done

    # Xfce icons
    for xfce_icon in $(ls "$CUCKOO_OS_ETC_XFCE_ICON_DIR")
    do
        cp -r "${CUCKOO_OS_ETC_XFCE_ICON_DIR}${xfce_icon}" "${CUCKOO_OS_SYSTEM_ICONS_DIR}cuckoo-${xfce_icon}"
        if [ $? -gt 0 ]
        then
            cuckoo_os_error "Could not copy theme '${CUCKOO_OS_ETC_XFCE_ICON_DIR}${xfce_icon}'"
        fi
    done

    cuckoo_os_grub_theme_dir_create
    cuckoo_os_grub_theme_files_create

    cuckoo_os_lightdm_gtk_greeter_files_create

    cuckoo_os_lightdm_gtk_greeter_file_select

    cuckoo_os_lightdm_conf_dir_create
    cuckoo_os_lightdm_conf_file_create

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
