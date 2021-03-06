#
# A desktop-oriented virtual machines management system written in Shell.
#
# Code is available online at https://github.com/magenete/cuckoo
# See LICENSE for licensing information, and README for details.
#
# Copyright (C) 2016 Magenete Systems OÜ.
#


# Current screen size
cuckoo_os_screen_size_current()
{
    xrandr -q 2> /dev/null | {
        while IFS= read -r line
        do
            [ "${line# }" = "$line" ] && continue

            line="$(echo $line)"

            if [ "$line" != "${line%%\**}" ]
            then
                echo "${line%%\ *}"

                break
            fi
        done
    }
}


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


# Define OS screen device
cuckoo_os_screen_define_dev()
{
    local screen_size_device=""

    xrandr -q 2> /dev/null | {
        while IFS= read -r line
        do
            if [ "${line# }" = "$line" ]
            then
                screen_size_device=""

                for value in $line
                do
                    if [ -z "$screen_size_device" ]
                    then
                        screen_size_device="$value"
                    else
                        if [ "$value" = "connected" ]
                        then
                            echo "$screen_size_device"
                        else
                            screen_size_device=""
                        fi

                        break
                    fi
                done
            fi
        done
    }
}


# Check screen size
cuckoo_os_screen_size_check()
{
    xrandr -q 2> /dev/null | {
        while IFS= read -r line
        do
            [ "${line# }" = "$line" ] && continue

            line="$(echo $line)"

            if [ "${line#$CUCKOO_OS_SYSTEM_SCREEN_SIZE }" != "$line" ]
            then
                echo "$CUCKOO_OS_SYSTEM_SCREEN_SIZE"
                break
            fi
        done
    }
}


# Add screen size
cuckoo_os_screen_size_add()
{
    local screen_size_x="${CUCKOO_OS_SYSTEM_SCREEN_SIZE%%x*}"
    local screen_size_y="${CUCKOO_OS_SYSTEM_SCREEN_SIZE#${screen_size_x}x}"

    local screen_size_args=""

    gtf "$screen_size_x" "$screen_size_y" "$CUCKOO_OS_SYSTEM_SCREEN_HZ" -x 2> /dev/null | {
        while IFS= read -r line
        do
            line="$(echo $line)"

            [ "${line#Modeline}" = "$line" ] && continue

            screen_size_args="$(echo ${line#Modeline \"${CUCKOO_OS_SYSTEM_SCREEN_SIZE}_${CUCKOO_OS_SYSTEM_SCREEN_HZ}.00\"})"

            xrandr --newmode "$CUCKOO_OS_SYSTEM_SCREEN_SIZE" $screen_size_args
            xrandr --addmode "$(cuckoo_os_screen_define_dev)" "$CUCKOO_OS_SYSTEM_SCREEN_SIZE"
        done
    }
}


# Define screen size
cuckoo_os_screen_size_define()
{
    if [ -z "$(cuckoo_os_screen_size_check "$screen_size")" ]
    then
        cuckoo_os_screen_size_add
    fi

    xrandr --output "$(cuckoo_os_screen_define_dev)" --mode "$CUCKOO_OS_SYSTEM_SCREEN_SIZE"
}


# Check screen size value
cuckoo_os_screen_size_value_check()
{
    local x="${1%%x*}"
    local y="${1#${x}x}"

    if [ ! -z "$x" ] && [ ! -z "$y" ] && [ $x -ge $CUCKOO_OS_SYSTEM_SCREEN_SIZE_X_MIN ] && [ $x -le $CUCKOO_OS_SYSTEM_SCREEN_SIZE_X_MAX ] && [ $y -ge $CUCKOO_OS_SYSTEM_SCREEN_SIZE_Y_MIN ] && [ $y -le $CUCKOO_OS_SYSTEM_SCREEN_SIZE_Y_MAX ]
    then
        echo "$1"
    else
        echo ""
    fi
}


# Uninstall screen size for user
cuckoo_os_screen_size_uninstall_user()
{
    if [ -f "$CUCKOO_OS_SYSTEM_USER_CUCKOO_OS_SCREEN_SIZE_DEFAULT_FILE" ]
    then
        CUCKOO_OS_SYSTEM_SCREEN_SIZE="$(cat "$CUCKOO_OS_SYSTEM_USER_CUCKOO_OS_SCREEN_SIZE_DEFAULT_FILE" 2> /dev/null)"

        [ ! -z "$CUCKOO_OS_SYSTEM_SCREEN_SIZE" ] && cuckoo_os_screen_size_define

        rm -f "$CUCKOO_OS_SYSTEM_USER_CUCKOO_OS_SCREEN_SIZE_DEFAULT_FILE"
    fi

    if [ -f "$CUCKOO_OS_SYSTEM_USER_CUCKOO_OS_SCREEN_SIZE_FILE" ]
    then
        rm -f "$CUCKOO_OS_SYSTEM_USER_CUCKOO_OS_SCREEN_SIZE_FILE"
    fi

    if [ -z "$(ls "$CUCKOO_OS_SYSTEM_USER_CUCKOO_OS_DIR")" ]
    then
        rm -rf "$CUCKOO_OS_SYSTEM_USER_CUCKOO_OS_DIR"
    fi

    if [ -f "$CUCKOO_OS_SYSTEM_USER_AUTOSTART_CUCKOO_OS_SCREEN_SIZE_FILE" ]
    then
        rm -f "$CUCKOO_OS_SYSTEM_USER_AUTOSTART_CUCKOO_OS_SCREEN_SIZE_FILE"
    fi
}


# Uninstall screen size for system
cuckoo_os_screen_size_uninstall_system()
{
    if [ -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_CUCKOO_OS_SCREEN_SIZE_DEFAULT_FILE" ]
    then
        CUCKOO_OS_SYSTEM_SCREEN_SIZE="$(cat "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_CUCKOO_OS_SCREEN_SIZE_DEFAULT_FILE" 2> /dev/null)"

        [ ! -z "$CUCKOO_OS_SYSTEM_SCREEN_SIZE" ] && cuckoo_os_screen_size_define

        rm -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_CUCKOO_OS_SCREEN_SIZE_DEFAULT_FILE"
    fi

    if [ -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_CUCKOO_OS_SCREEN_SIZE_FILE" ]
    then
        rm -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_CUCKOO_OS_SCREEN_SIZE_FILE"
    fi
}


# Install screen size for user
cuckoo_os_screen_size_install_user()
{
    mkdir -p "$CUCKOO_OS_SYSTEM_USER_CUCKOO_OS_DIR"

    if [ ! -f "$CUCKOO_OS_SYSTEM_USER_CUCKOO_OS_SCREEN_SIZE_DEFAULT_FILE" ]
    then
        printf "$(cuckoo_os_screen_size_current)" > "$CUCKOO_OS_SYSTEM_USER_CUCKOO_OS_SCREEN_SIZE_DEFAULT_FILE"
    fi

    cuckoo_os_screen_size_define

    printf "$CUCKOO_OS_SYSTEM_SCREEN_SIZE" > "$CUCKOO_OS_SYSTEM_USER_CUCKOO_OS_SCREEN_SIZE_FILE"

    mkdir -p "$CUCKOO_OS_SYSTEM_USER_AUTOSTART_DIR"
    cat > "$CUCKOO_OS_SYSTEM_USER_AUTOSTART_CUCKOO_OS_SCREEN_SIZE_FILE" << _S_C_R_E_E_N__S_I_Z_E__U_S_E_R
[Desktop Entry]
Type=Application
Name=Cuckoo OS
Exec=cuckoo-os --screen-size "${CUCKOO_OS_SYSTEM_SCREEN_SIZE}"
_S_C_R_E_E_N__S_I_Z_E__U_S_E_R
}


# Install screen size for system
cuckoo_os_screen_size_install_system()
{
    mkdir -p "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_CUCKOO_OS_DIR"

    if [ ! -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_CUCKOO_OS_SCREEN_SIZE_DEFAULT_FILE" ]
    then
        printf "$(cuckoo_os_screen_size_current)" > "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_CUCKOO_OS_SCREEN_SIZE_DEFAULT_FILE"
    fi

    cuckoo_os_screen_size_define

    printf "$CUCKOO_OS_SYSTEM_SCREEN_SIZE" > "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_CUCKOO_OS_SCREEN_SIZE_FILE"
}
