#
# A desktop-oriented virtual machines management system written in Shell.
#
# Code is available online at https://github.com/magenete/cuckoo
# See LICENSE for licensing information, and README for details.
#
# Copyright (C) 2016 Magenete Systems OÜ.
#


# Create lightdm.conf.d for Cuckoo
cuckoo_os_lightdm_conf_dir_create()
{
    if [ ! -d "$CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CUCKOO_DIR" ]
    then
        mkdir "$CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CUCKOO_DIR"
    fi

    cp "${CUCKOO_OS_BIN_DIR}screen-size-hd.sh" "$CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CUCKOO_DIR"
    chmod 0755 "${CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CUCKOO_DIR}screen-size-hd.sh"

    cp "${CUCKOO_OS_LIB_DIR}mgt/screen.sh" "$CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CUCKOO_DIR"
    chmod 0644 "${CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CUCKOO_DIR}screen.sh"
}


# Create lightdm.conf for Cuckoo
cuckoo_os_lightdm_conf_file_create()
{
    cat > "$CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CUCKOO_FILE" << _L_I_G_H_T_D_M__C_O_N_F
# Seat defaults
#
# type = Seat type (xlocal, xremote)
# xdg-seat = Seat name to set pam_systemd XDG_SEAT variable and name to pass to X server
# pam-service = PAM service to use for login
# pam-autologin-service = PAM service to use for autologin
# pam-greeter-service = PAM service to use for greeters
# xserver-command = X server command to run (can also contain arguments e.g. X -special-option)
# xserver-layout = Layout to pass to X server
# xserver-config = Config file to pass to X server
# xserver-allow-tcp = True if TCP/IP connections are allowed to this X server
# xserver-share = True if the X server is shared for both greeter and session
# xserver-hostname = Hostname of X server (only for type=xremote)
# xserver-display-number = Display number of X server (only for type=xremote)
# xdmcp-manager = XDMCP manager to connect to (implies xserver-allow-tcp=true)
# xdmcp-port = XDMCP UDP/IP port to communicate on
# xdmcp-key = Authentication key to use for XDM-AUTHENTICATION-1 (stored in keys.conf)
# unity-compositor-command = Unity compositor command to run (can also contain arguments e.g. unity-system-compositor -special-option)
# unity-compositor-timeout = Number of seconds to wait for compositor to start
# greeter-session = Session to load for greeter
# greeter-hide-users = True to hide the user list
# greeter-allow-guest = True if the greeter should show a guest login option
# greeter-show-manual-login = True if the greeter should offer a manual login option
# greeter-show-remote-login = True if the greeter should offer a remote login option
# user-session = Session to load for users
# allow-user-switching = True if allowed to switch users
# allow-guest = True if guest login is allowed
# guest-session = Session to load for guests (overrides user-session)
# session-wrapper = Wrapper script to run session with
# greeter-wrapper = Wrapper script to run greeter with
# guest-wrapper = Wrapper script to run guest sessions with
# display-setup-script = Script to run when starting a greeter session (runs as root)
# display-stopped-script = Script to run after stopping the display server (runs as root)
# greeter-setup-script = Script to run when starting a greeter (runs as root)
# session-setup-script = Script to run when starting a user session (runs as root)
# session-cleanup-script = Script to run when quitting a user session (runs as root)
# autologin-guest = True to log in as guest by default
# autologin-user = User to log in with by default (overrides autologin-guest)
# autologin-user-timeout = Number of seconds to wait before loading default user
# autologin-session = Session to load for automatic login (overrides user-session)
# autologin-in-background = True if autologin session should not be immediately activated
# exit-on-failure = True if the daemon should exit if this seat fails
#


[SeatDefaults]
greeter-setup-script=${CUCKOO_OS_SYSTEM_USR_SHARE_LIGHTDM_CUCKOO_DIR}screen-size-hd.sh
_L_I_G_H_T_D_M__C_O_N_F
}


# Generate lightdm_gtk_greeter_*.conf
cuckoo_os_lightdm_gtk_greeter_file_name()
{
    echo "${CUCKOO_OS}-lightdm-gtk-greeter-${1}.conf"
}


# Create lightdm_gtk_greeter_*.conf
cuckoo_os_lightdm_gtk_greeter_files_create()
{
    for style in $CUCKOO_OS_STYLE_LIST
    do
        cuckoo_os_style_theme_define "$style"

        cat > "${CUCKOO_OS_SYSTEM_ETC_LIGHTDM_DIR}$(cuckoo_os_lightdm_gtk_greeter_file_name "$style")" << _L_I_G_H_T_D_M__G_T_K__G_R_E_E_T_E_R__C_O_N_F
#
# background = Background file to use, either an image path or a color (e.g. #772953)
# theme-name = GTK+ theme to use
# icon-theme-name = Icon theme to use
# font-name = Font to use
# xft-antialias = Whether to antialias Xft fonts (true or false)
# xft-dpi = Resolution for Xft in dots per inch (e.g. 96)
# xft-hintstyle = What degree of hinting to use (none, slight, medium, or hintfull)
# xft-rgba = Type of subpixel antialiasing (none, rgb, bgr, vrgb or vbgr)
# show-indicators = semi-colon ";" separated list of allowed indicator modules. Built-in indicators include "~a11y", "~language", "~session", "~power". Unity indicators can be represented by
# show-clock (true or false)
# clock-format = strftime-format string, e.g. %H:%M
# keyboard = command to launch on-screen keyboard
# position = main window position: x y
# default-user-image = Image used as default user icon, path or #icon-name
# screensaver-timeout = Timeout (in seconds) until the screen blanks when the greeter is called as lockscreen
#


[greeter]
background=${CUCKOO_OS_SYSTEM_IMAGES_CUCKOO_DIR}background/${style}/${CUCKOO_OS_NAME}${CUCKOO_OS_NAME_DIST}.svg
theme-name=${CUCKOO_OS_STYLE_THEME}
icon-theme-name=${CUCKOO_OS_STYLE_THEME_ICON}
font-name=Sans
xft-antialias=true
xft-dpi=${CUCKOO_OS_STYLE_THEME_FONT_DPI}
xft-hintstyle=${CUCKOO_OS_STYLE_THEME_FONT_HINT}
xft-rgba=${CUCKOO_OS_STYLE_THEME_FONT_RGBA}
show-indicators=~power
show-clock=true
clock-format=%H:%M:%S
position=50%,center 20%,center
_L_I_G_H_T_D_M__G_T_K__G_R_E_E_T_E_R__C_O_N_F
    done
}


# Select file lightdm-gtk-greeter by style
cuckoo_os_lightdm_gtk_greeter_file_select()
{
    if [ -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE" ] && [ ! -L "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE" ]
    then
        if [ -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE_DEFAULT" ]
        then
            if [ ! -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE_DEFAULT_BACKUP" ]
            then
                mv "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE" "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE_DEFAULT_BACKUP"
            fi
        else
            mv "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE" "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_FILE_DEFAULT"
        fi
    fi

    if [ ! -f "${CUCKOO_OS_SYSTEM_ETC_LIGHTDM_DIR}$(cuckoo_os_lightdm_gtk_greeter_file_name "$CUCKOO_OS_STYLE")" ]
    then
        cuckoo_os_lightdm_gtk_greeter_files_create
    fi
}
