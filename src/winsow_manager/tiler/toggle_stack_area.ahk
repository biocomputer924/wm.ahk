tiler_toggle_stack_area(m ,v) {
    desktop_#%m%_#%v%_show_stack_area := not desktop_#%m%_#%v%_show_stack_area

    if not desktop_#%m%_#%v%_show_stack_area
        desktop_#%m%_#%v%_layout_axis_#3 := 3
}
