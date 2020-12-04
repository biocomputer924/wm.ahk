window_is_child(id) {
    WS_CHILD = 0x40000000

    WinGet, x, Style ahk_id %id%

    return x & WS_CHILD
}
