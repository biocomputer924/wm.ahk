desktop_from(config) {
    desktop := {}

    desktop["area"] := 0
    desktop["active_window_ids"] := []
    desktop["layout_axis1"] := config["layout_axis1"]
    desktop["layout_axis2"] := config["layout_axis2"]
    desktop["layout_axis3"] := config["layout_axis3"]
    desktop["layout"] := config["layout"]
    desktop["layout_m_fact"] := Config_layoutMFactor
    desktop["layout_m_x"] := 1
    desktop["layout_m_y"] := 1
    desktop["margin"] := [0, 0, 0, 0]
    desktop["show_stack_area"] := true
    desktop["window_ids"] := []

    return desktop
}
