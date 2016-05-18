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
    case $(uname -m) in
        x86_64 | amd64 )
            CUCKOO__OSARCH="${CUCKOO_OS_ARCH:=x86_64}"
        ;;
        x86 | i386 | i486 | i586 | i686 | i786 )
            CUCKOO_OS_ARCH="${CUCKOO_OS_ARCH:=x86}"
        ;;
        * )
            cuckoo_os_error "Current OS architecture is not supported"
        ;;
    esac
}


# Define OS name
cuckoo_os_name_define()
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
