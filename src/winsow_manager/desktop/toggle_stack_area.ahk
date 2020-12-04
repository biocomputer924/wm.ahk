desktop_toggle_stack_area() {
    v := screen_#%manager["active_screen"]%_adesktop_#1

    if tiler_is_active(manager["active_screen"], v) and not Config_dynamicTiling {
        tiler_toggle_stack_area(manager["active_screen"], v)

        desktop_arrange(manager["active_screen"], v)
    }
}
