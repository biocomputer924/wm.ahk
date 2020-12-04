#Include %A_ScriptDir%/screen/get.ahk

window_is_not_visible(id) {
    WS_VISIBLE = 0x10000000

    WinGet, style, Style ahk_id %id%

    if (style & WS_VISIBLE) {
        WinGetPos, x, y, w, h, ahk_id %id%

        has_dimensions := w > 0 and h > 0

        is_on_screen := screen_get(x + 5, y + 5) or screen_get(x + w - 5, y + 5) or screen_get(x + w, y + h - 5) or screen_get(x + 5, y + h - 5)

        return (not has_dimensions or not is_on_screen)
    }
    else
        return true
}
