#Include %A_ScriptDir%\array\join.ahk
#Include %A_ScriptDir%\array\push.ahk

manager_render_current_window_info(ByRef manager) {
    detect_hidden_windows := A_DetectHiddenWindows

    DetectHiddenWindows, On

    WinGet, id, ID, A

    DetectHiddenWindows, %detect_hidden_windows%

    is_hidden := window_get_hidden(id)

    WinGet, window_process_name, ProcessName ahk_id %id%
    WinGet, window_pid, PID, ahk_id %id%
    WinGet, window_style, Style ahk_id %id%
    WinGet, min_max, MinMax ahk_id %id%
    WinGetPos, x, y, width, height, ahk_id %id%

    lines := []

    array_push_back(lines, "Window Information")
    array_push_back(lines, "id: " id . (is_hidden ? " [hidden]" : ""))
    array_push_back(lines, "class: " . window_class)
    array_push_back(lines, "title: " . window_title)
    array_push_back(lines, "process: " . window_process_name . " (" . window_pid . ")")
    array_push_back(lines, "style: " . window_style)
    array_push_back(lines, "metrics: (x: " . x . ", y: " . y . ", width: " . width . ", height: " . height . ")")

    if array_contains(manager["managed_window_ids"], id) {
        array_push_back(lines, "desktop: " . manager["windows"][id]["desktop"])

        if manager["windows"][id]["decoration"]["enabled"]
            array_push_back(lines, "decoration: enabled")
        else
            array_push_back(lines, "decoration: disabled")

        if manager["windows"][id]["floating"]["enabled"]
            array_push_back(lines, "floating: enabled")
        else
            array_push_back(lines, "floating: disabled")
    }

    MsgBox, % array_join(lines, "`n")
}
