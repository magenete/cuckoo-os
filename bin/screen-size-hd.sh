

. "$(realpath "$(readlink -f "$(dirname "$0")")")/screen.sh"


CUCKOO_OS_SYSTEM_SCREEN_SIZE_LIST_DEFAULT="1920x1080 1600x900 1280x720"
CUCKOO_OS_SYSTEM_SCREEN_HZ=60

CUCKOO_OS_SYSTEM_ETC_LIGHTDM_CUCKOO_OS_SCREEN_SIZE_FILE="/etc/lightdm/cuckoo-os/screen-size"


if [ -z "$1" ]
then
    HD_SCREEN_SIZE_LIST="$CUCKOO_OS_SYSTEM_SCREEN_SIZE_LIST_DEFAULT"
else
    HD_SCREEN_SIZE_LIST="$@"
fi


for screen_size in $HD_SCREEN_SIZE_LIST
do
    CUCKOO_OS_SYSTEM_SCREEN_SIZE="$screen_size"

    cuckoo_os_screen_size_add
done


if [ -f "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_CUCKOO_OS_SCREEN_SIZE_FILE" ]
then
    CUCKOO_OS_SYSTEM_SCREEN_SIZE="$(cat "$CUCKOO_OS_SYSTEM_ETC_LIGHTDM_CUCKOO_OS_SCREEN_SIZE_FILE" 2> /dev/null)"

    [ ! -z "$CUCKOO_OS_SYSTEM_SCREEN_SIZE" ] && cuckoo_os_screen_size_define
fi
