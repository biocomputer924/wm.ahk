desktop_set_layout_property(name, i, d, opt = 0) {
    a := false

    v := screen_#%manager["active_screen"]%_adesktop_#1

    l := desktop_#%manager["active_screen"]%_#%v%_layout_#1

    if tiler_isActive(manager["active_screen"], v) {
        if (name = "Axis")
            a := tiler_setAxis(manager["active_screen"], v, opt, d)
        else if (name = "MFactor") {
            if (opt = 0)
                opt := 1

            a := tiler_setMFactor(manager["active_screen"], v, i, d, opt)
        }
        else if (name = "MX")
            a := tiler_setMX(manager["active_screen"], v, d)
        else if (name = "MY")
            a := tiler_setMY(manager["active_screen"], v, d)
    }

    if (name = "GapWidth") and (tiler_isActive(manager["active_screen"], v) or (Config_layoutFunction_#%l% = "monocle"))
        a := desktop_setGapWidth(i, d)

    if a
        desktop_arrange(manager["active_screen"], v)
}
