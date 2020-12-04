desktop_move_to_index(ByRef desktop, ByRef dest_desktop) {
    dest_desktop["area0"]           := desktop["area_#0"]
    dest_desktop["a_window_ids"]    := desktop["a_window_ids"]
    dest_desktop["layout_axis1"]    := desktop["layout_axis1"]
    dest_desktop["layout_axis2"]    := desktop["layout_axis2"]
    dest_desktop["layout_axis3"]    := desktop["layout_axis3"]
    dest_desktop["layout"]          := desktop["layout"]
    dest_desktop["margins"]         := desktop["margins"]
    dest_desktop["show_stack_area"] := desktop["show_stack_area"]
    dest_desktop["wndIds"]          := desktop["wndIds"]

    StringSplit, dest_desktop["margin,"] dest_desktop["margins,"] `;

    StringTrimRight, wndIds, dest_desktop["window_ids"], 1

    loop PARSE, wndIds, `; {
        windows#%A_LoopField%_screen := n
        windows#%A_LoopField%_tags -= 1 << v - 1
        windows#%A_LoopField%_tags += 1 << w - 1
    }
}
