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
    ARGS_SHORT="iuVh"
    ARGS_LONG="install,uninstall,version,help"
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
            CUCKOO_OS_ACTION="run"
            shift 1
        ;;

    # Arguments

        --dist-version | -v )
            if [ "$(cuckoo_dist_version_value_check "$2")" = "" ]
            then
                cuckoo_os_error "Invalid distributive/version '${2}'"
            else
                CUCKOO_OS_DIST_VERSION="$2"
            fi
            shift 2
        ;;
        --version | -V )
            echo "Cuckoo version: $(cat "${CUCKOO_ETC_VERSION_FILE}")"
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


# Style options parsing
cuckoo_os_args_style_mode()
{
    case "$1" in
        system | s | "" )
            CUCKOO_OS_STYLE_MODE="system"
        ;;
        user | u )
            CUCKOO_OS_STYLE_MODE="user"
        ;;
        all | a )
            CUCKOO_OS_STYLE_MODE="all"
        ;;
        * )
            cuckoo_os_error "Invalid mode option '${1}'"
        ;;
    esac
}


# Action options parsing
cuckoo_os_args_action()
{
    case "$1" in
        install | i )
            CUCKOO_OS_ACTION="install"
        ;;
        uninstall | u )
            CUCKOO_OS_ACTION="uninstall"
        ;;
        select | s )
            CUCKOO_OS_ACTION="select"
        ;;
        version )
            echo "Cuckoo OS version: $(cat "$CUCKOO_OS_ETC_VERSION_FILE")"
            exit 0
        ;;
        help | h )
            cuckoo_os_help
            exit 0
        ;;
        * )
            cuckoo_os_error "Invalid action option '${1}'"
        ;;
    esac
}
