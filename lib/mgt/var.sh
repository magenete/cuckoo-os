#!/bin/sh
#
# A desktop-oriented virtual machines management system written in Shell.
#
# Code is available online at https://github.com/magenete/cuckoo
# See LICENSE for licensing information, and README for details.
#
# Copyright (C) 2016 Magenete Systems OÜ.
#


CUCKOO_OS_BIN_DIR="${CUCKOO_OS_DIR}bin/"
CUCKOO_OS_LIB_DIR="${CUCKOO_OS_DIR}lib/"

CUCKOO_OS_ETC_DIR="${CUCKOO_OS_DIR}etc/"
CUCKOO_OS_ETC_BACKGROUND_DIR="${CUCKOO_OS_ETC_DIR}background/"
CUCKOO_OS_ETC_GRUB_DIR="${CUCKOO_OS_ETC_DIR}grub/"
CUCKOO_OS_ETC_LIGHTDM_DIR="${CUCKOO_OS_ETC_DIR}lightdm/"
CUCKOO_OS_ETC_XFCE_DIR="${CUCKOO_OS_ETC_DIR}xfce/"
CUCKOO_OS_ETC_XFCE_THEME_DIR="${CUCKOO_OS_ETC_XFCE_DIR}theme/"
CUCKOO_OS_ETC_XFCE_ICON_DIR="${CUCKOO_OS_ETC_XFCE_DIR}icon/"
CUCKOO_OS_ETC_VERSION_FILE="${CUCKOO_OS_ETC_DIR}VERSION"


CUCKOO_OS_SYSTEM_ETC_LIGHTDM_DIR="/etc/lightdm/"
CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE="${CUCKOO_OS_SYSTEM_ETC_LIGHTDM_DIR}lightdm-gtk-greeter.conf"
CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE_DEFAULT="${CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE}.default"
CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE_DEFAULT_BACKUP="${CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE_DEFAULT}.backup"

CUCKOO_OS_SYSTEM_USER_XFCE_CONF_XML_DIR="${HOME}/.config/xfce4/xfconf/xfce-perchannel-xml/"
CUCKOO_OS_SYSTEM_USER_XFCE_CONF_DESKTOP_XML_FILE="${CUCKOO_OS_SYSTEM_USER_XFCE_CONF_XML_DIR}xfce4-desktop.xml"
CUCKOO_OS_SYSTEM_USER_XFCE_CONF_XSETTINGS_XML_FILE="${CUCKOO_OS_SYSTEM_USER_XFCE_CONF_XML_DIR}xsettings.xml"
CUCKOO_OS_SYSTEM_USER_XFCE_CONF_DISPLAYS_XML_FILE="${CUCKOO_OS_SYSTEM_USER_XFCE_CONF_XML_DIR}displays.xml"

CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_DIR="/usr/share/lightdm/"
CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CUCKOO_DIR="${CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_DIR}cuckoo/"
CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CONF_DIR="${CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_DIR}lightdm.conf.d/"
CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CUCKOO_FILE="${CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CONF_DIR}cuckoo-lightdm.conf"

CUCKOO_OS_SYSTEM_IMAGES_DIR="/usr/share/images/desktop-base/"
CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_DIR="${CUCKOO_OS_SYSTEM_IMAGES_DIR}cuckoo/"

CUCKOO_OS_SYSTEM_THEMES_DIR="/usr/share/themes/"
CUCKOO_OS_SYSTEM_ICONS_DIR="/usr/share/icons/"

CUCKOO_OS_SYSTEM_GRUB_CONFIG_FILE="/boot/grub/grub.cfg"
CUCKOO_OS_SYSTEM_GRUB_THEME_DIR="/boot/grub/themes/"


# Cuckoo OS variables check
cuckoo_os_variables_check()
{
    CUCKOO_OS_ACTION="${CUCKOO_OS_ACTION:=$CUCKOO_OS_ACTION_DEFAULT}"
    CUCKOO_OS_STYLE="${CUCKOO_OS_STYLE:=$CUCKOO_OS_STYLE_DEFAULT}"
    CUCKOO_OS_STYLE_MODE="${CUCKOO_OS_STYLE_MODE:=$CUCKOO_OS_STYLE_MODE_DEFAULT}"

    CUCKOO_OS_SYSTEM_SCREEN_SIZE="${CUCKOO_OS_SYSTEM_SCREEN_SIZE:=CUCKOO_OS_SYSTEM_SCREEN_SIZE_DEFAULT}"
    CUCKOO_OS_STYLE_THEME_FONT_DPI="${CUCKOO_OS_STYLE_THEME_FONT_DPI:=CUCKOO_OS_STYLE_THEME_FONT_DPI_DEFAULT}"
}
