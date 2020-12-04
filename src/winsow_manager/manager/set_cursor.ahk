manager_set_cursor(ByRef manager, window_id) {
    if window_id {
        WinGetPos, x, y, width, height, ahk_id %window_id%

        DllCall("SetCursorPos", "Int", Round(x + width / 2), "Int", Round(y + height / 2))
    }
    else {
        x := Round(manager_current_screen(manager)["x"] + manager_current_screen(manager)["width"] / 2)
        y := Round(manager_current_screen(manager)["y"] + manager_current_screen(manager)["height"] / 2)

        DllCall("SetCursorPos", "Int", x, "Int", y)
    }
}
