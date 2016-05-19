#
# A desktop-oriented virtual machines management system written in Shell.
#
# Code is available online at https://github.com/magenete/cuckoo
# See LICENSE for licensing information, and README for details.
#
# Copyright (C) 2016 Magenete Systems OÜ.
#


# Options definition
cuckoo_os_args()
{
    ARGS_SHORT="iusS:M:Vh"
    ARGS_LONG="install,uninstall,select,style:,mode:,version,help"
    OPTS="$(getopt -o "${ARGS_SHORT}" -l "${ARGS_LONG}" -a -- "$@" 2>/dev/null)"
    if [ $? -gt 0 ]
    then
        cuckoo_os_error "Invalid option(s) value"
    fi

    eval set -- "$OPTS"

    # Options parsing
    while [ $# -gt 0 ]
    do
        case $1 in
        -- )
            shift 1
        ;;

    # Actions

        --install | -i )
            CUCKOO_OS_ACTION="install"
            shift 1
        ;;
        --uninstall | -u )
            CUCKOO_OS_ACTION="uninstall"
            shift 1
        ;;
        --select | -s )
            CUCKOO_OS_ACTION="select"
            shift 1
        ;;

    # Arguments

        --style | -S )
            if [ "$(valid_value_in_arr "$CUCKOO_OS_STYLE_LIST" "$2")" = "" ]
            then
                cuckoo_os_error "Cuckoo OS style '${2}' is not supported"
            else
                CUCKOO_OS_STYLE="$2"

                cuckoo_os_args_style_$CUCKOO_OS_STYLE
            fi
            shift 2
        ;;
        --mode | -M )
            if [ "$(valid_value_in_arr "$CUCKOO_OS_STYLE_MODE_LIST" "$2")" = "" ]
            then
                cuckoo_os_error "Cuckoo OS style mode '${2}' is not supported"
            else
                CUCKOO_OS_STYLE_MODE="$2"
            fi
            shift 2
        ;;
        --version | -V )
            echo "Cuckoo OS version: $(cat "$CUCKOO_OS_ETC_VERSION_FILE")"
            exit 0
        ;;
        --help | -h )
            cuckoo_os_help
            exit 0
        ;;
        * )
            cuckoo_os_error "Invalid option(s)"
        ;;
        esac
    done
}
