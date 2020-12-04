desktop_set_border_spacing(ByRef desktop, n) {
    if (i >= 0 and i < screen_#%manager["active_screen"]%_height and i < screen_#%manager["active_screen"]%_width) {
        n := Ceil(n / 2) * 2

        desktop["border_spacing"] := n

        return 1
    }
    else
        return 0
}
