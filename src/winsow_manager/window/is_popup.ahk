window_is_popup(id) {
    WS_POPUP = 0x80000000

    WinGet, style, Style ahk_id %id%

    return style & WS_POPUP
}
