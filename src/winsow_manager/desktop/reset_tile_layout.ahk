desktop_reset_tile_layout() {
    m := manager["active_screen"]
    v := screen_#%m%_adesktop_#1

    desktop["area"]          := 0
    desktop["layout_axis1"]     := Config_layout_axis_#1
    desktop["layout_axis2"]     := Config_layout_axis_#2
    desktop["layout_axis3"]     := Config_layout_axis_#3
    desktop["layout_gap_width"] := Config_layout_gap_width
    desktop["layout_m_fact"]    := Config_layoutMFactor
    desktop["layout_m_x"]       := 1
    desktop["layout_m_y"]       := 1
    desktop["margins"]        := [0, 0, 0, 0]
    desktop["show_stack_area"] := true

    StringSplit, desktop_#%m%_#%v%_margin, desktop_#%m%_#%v%_margins, `;

    if tiler_isActive(m, v)
        desktop_arrange(m, v)
}
