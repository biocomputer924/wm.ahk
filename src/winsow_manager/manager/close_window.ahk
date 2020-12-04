#Include %A_ScriptDir%/window/close.ahk
#Include %A_ScriptDir%/window/is_prog.ahk

manager_close_window(ByRef manager, window_id) {
    if window_is_prog(window_id)
        window_close(window_id)
}
