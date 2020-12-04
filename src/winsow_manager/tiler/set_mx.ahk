tiler_set_mx(ByRef desktop, d) {
    n := desktop_#%m%_#%v%_layoutMX + d

    if (n >= 1) and (n <= 9) {
        desktop_#%m%_#%v%_layoutMX := n
        return 1
    }
    else
        return 0
}
