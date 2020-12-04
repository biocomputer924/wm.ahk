tiler_set_my(m, v, d) {
    n := desktop_#%m%_#%v%_layoutMY + d

    if n >= 1 and n <= 9 {
        desktop_#%m%_#%v%_layoutMY := n
        return 1
    }
    else
        return 0
}
