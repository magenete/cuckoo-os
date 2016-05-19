#
# A desktop-oriented virtual machines management system written in Shell.
#
# Code is available online at https://github.com/magenete/cuckoo
# See LICENSE for licensing information, and README for details.
#
# Copyright (C) 2016 Magenete Systems OÜ.
#


# Cuckoo OS environment
cuckoo_os_env()
{
    case $(uname -s) in
        Linux )
            CUCKOO_OS_NAME="linux"
            cuckoo_os_linux_dist_define
        ;;
        Darwin )
            CUCKOO_OS_NAME="macosx"
        ;;
        NetBSD )
            CUCKOO_OS_NAME="netbsd"
        ;;
        OpenBSD )
            CUCKOO_OS_NAME="openbsd"
        ;;
        FreeBSD )
            CUCKOO_OS_NAME="freebsd"
        ;;
        DragonflyBSD )
            CUCKOO_OS_NAME="dragonflybsd"
        ;;
        * )
            cuckoo_os_error "Current OS does not supported for Cuckoo"
        ;;
    esac
}
