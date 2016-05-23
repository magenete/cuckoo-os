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
    cuckoo_os_lightdm_theme_uninstall_system

    cuckoo_os_grub_theme_uninstall_system

    cuckoo_os_style_xfce4_theme_uninstall_system
}


# Uninstall Cuckoo on Linux for user
cuckoo_os_linux_uninstall_user()
{
    cuckoo_os_style_xfce4_theme_uninstall_user
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
        cuckoo_os_lightdm_theme_select_system

        cuckoo_os_grub_theme_select_system
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
    cuckoo_os_style_xfce4_theme_install_system

    cuckoo_os_grub_theme_install_system

    cuckoo_os_lightdm_theme_install_system

    cuckoo_os_linux_select_system
}


# Install and set only for user
cuckoo_os_linux_install_user()
{
    cuckoo_os_style_xfce4_theme_install_user
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
