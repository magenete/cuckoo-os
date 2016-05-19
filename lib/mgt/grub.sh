#
# A desktop-oriented virtual machines management system written in Shell.
#
# Code is available online at https://github.com/magenete/cuckoo
# See LICENSE for licensing information, and README for details.
#
# Copyright (C) 2016 Magenete Systems OÜ.
#


#
cucko_os_grub_theme_file_name_define()
{
    local cuckoo_os_style="$1"
    local cuckoo_os_name_dist="$2"

    [ -z "$cuckoo_os_style" ] && cuckoo_os_style="$CUCKOO_OS_STYLE"
    [ "$#" -lt 2 ] && [ -z "$cuckoo_os_name_dist" ] && cuckoo_os_name_dist="$CUCKOO_OS_NAME_DIST"
    [ ! -z "$cuckoo_os_name_dist" ] && cuckoo_os_name_dist="-${cuckoo_os_name_dist#/}"

    echo "${CUCKOO_OS_NAME}${cuckoo_os_name_dist}-${cuckoo_os_style}.theme"
}


#
cucko_os_grub_theme_files_create()
{
    for style in $CUCKOO_OS_STYLE_LIST
    do
        for dist_name in $(ls "${CUCKOO_OS_SYSTEM_GRUB_THEME_DIR}cuckoo/background/${style}/linux/"*.png) ""
        do
            [ ! -z "$dist_name" ] && dist_name="/$(basename "$dist_name" .png)"

            cuckoo_os_args_style_$style

            cat > "${CUCKOO_OS_SYSTEM_GRUB_THEME_DIR}cuckoo/$(cucko_os_grub_theme_file_name_define "$style" "$dist_name")" << _G_R_U_B__T_H_E_M_E__F_I_L_E
#
# A desktop-oriented virtual machines management system written in Shell.
#
# Code is available online at https://github.com/magenete/cuckoo
# See LICENSE for licensing information, and README for details.
#
# Copyright (C) 2016 Magenete Systems OÜ.
#


# Global Property
title-text: "GNU/GRUB 2"
title-font: "FreeSans Regular 24"
title-color: "${CUCKOO_OS_STYLE_FONT_COLOR}"

message-font: "Fixed Regular 10"
message-color: "${CUCKOO_OS_NAME_DIST_COLOR}"
message-bg-color: "${CUCKOO_OS_STYLE_BACKGROUND_COLOR}"

desktop-color: "${CUCKOO_OS_STYLE_BACKGROUND_COLOR}"
desktop-image: "background/${style}/${CUCKOO_OS_NAME}${dist_name}.png"

#terminal-box: "terminal_box_*.png"
terminal-font: "Fixed Regular 10"


# Show boot menu
+ boot_menu
{
    top = 112
    left = 25%
    width = 50%
    height = 160
    menu_pixmap_style = "background/${style}/menu_item_*.png"

    item_color = "${CUCKOO_OS_NAME_DIST_SHADOW_COLOR}"
    item_font = "FreeSans Regular 24"
    item_height = 40
    item_padding = 0
    item_spacing = 0

    selected_item_color = "${CUCKOO_OS_NAME_DIST_COLOR}"
    selected_item_font = "FreeSans Regular 24"
    selected_item_pixmap_style = "background/${style}/menu_item_select_*.png"

    icon_width = 0
    icon_height = 0
    item_icon_space = 40

    scrollbar = false
}


+ label
{
    left = 49%
    top = 75%
    height = 40
    width = 2%

    id = "__timeout__"

    color = "lightgrey"
}


# Show action menu
+ hbox
{
    top = 95%
    left = 33%

    + label {
        text = "enter: "
        font = "FreeSans Regular 15"
        color = "${CUCKOO_OS_NAME_DIST_COLOR}"
        align = "left"
    }
    + label {
        text = "Boot selection  "
        font = "FreeSans Regular 15"
        color = "${CUCKOO_OS_STYLE_FONT_COLOR}"
        align = "left"
    }

    + label {
        text = "    e: "
        font = "FreeSans Regular 15"
        color = "${CUCKOO_OS_NAME_DIST_COLOR}"
        align = "left"
    }
    + label {
        text = "Edit selection  "
        font = "FreeSans Regular 15"
        color = "${CUCKOO_OS_STYLE_FONT_COLOR}"
        align = "left"
    }

    + label {
        text = "    c: "
        font = "FreeSans Regular 15"
        color = "${CUCKOO_OS_NAME_DIST_COLOR}"
        align = "left"
    }
    + label {
        text = "GRUB commandline"
        font = "FreeSans Regular 15"
        color = "${CUCKOO_OS_STYLE_FONT_COLOR}"
        align = "left"
    }
}
_G_R_U_B__T_H_E_M_E__F_I_L_E
        done
    done
}


#
cucko_os_grub_theme_dir_create()
{
    if [ ! -d "$CUCKOO_OS_SYSTEM_GRUB_THEME_DIR" ]
    then
        mkdir "$CUCKOO_OS_SYSTEM_GRUB_THEME_DIR"
    fi

    cp -r "$CUCKOO_OS_ETC_GRUB_DIR" "${CUCKOO_OS_SYSTEM_GRUB_THEME_DIR}cuckoo"
}
