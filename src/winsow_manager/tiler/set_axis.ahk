tiler_set_axis(ByRef desktop, id, d) {
    if (id = 1 or id = 2 or id = 3) {
        if (id = 1) {
            if (d = +2)
                desktop["layout_axis" . id] *= -1
            else {
                f := desktop["layout_axis" . id] / Abs(desktop["layout_axis" . id])

                desktop["layout_axis" . id] := f * manager_loop(Abs(desktop["layout_axis" . id]), d, 1, 2)
            }
        }
        else {
            n := manager_loop(desktop["layout_axis" . id], d, 1, 3)

            ; When we rotate the axis, we may need to swap the X and Y dimensions.
            ; We only need to check this when the master axis changes (id = 2)
            ; if the original axis was 1 (X) or the new axis is 1 (X)  (Y and Z are defined to be the same)
            if (id = 2) and not (n = desktop["layout_axis" . id]) and (n = 1 or desktop["layout_axis" . id] = 1) {
                tmp := desktop_#%m%_#%v%_layoutMX
                desktop_#%m%_#%v%_layoutMX := desktop_#%m%_#%v%_layoutMY
                desktop_#%m%_#%v%_layoutMY := tmp
            }

            desktop["layout_axis" . id] := n
        }

        return 1
    }
    else
        return 0
}