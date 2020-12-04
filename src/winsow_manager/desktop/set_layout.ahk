desktop_set_layout(i, d = 0) {
    v := screen_#%manager["active_screen"]%_adesktop_#1

    if (i = -1)
        i := desktop_#%manager["active_screen"]%_#%v%_layout_#2
    else if (i = 0)
        i := desktop_#%manager["active_screen"]%_#%v%_layout_#1

    i := manager_loop(i, d, 1, Config_layoutCount)

    if (i > 0) and (i <= Config_layoutCount) {
        if not (i = desktop_#%manager["active_screen"]%_#%v%_layout_#1) {
            desktop_#%manager["active_screen"]%_#%v%_layout_#2 := desktop_#%manager["active_screen"]%_#%v%_layout_#1
            desktop_#%manager["active_screen"]%_#%v%_layout_#1 := i
        }

        desktop_arrange(manager["active_screen"], v, true)
    }
}
