#Include %A_ScriptDir%\window\is_hung.ahk

window_maximize(id) {
    if window_is_hung(id) {
        return 1
    }
    else {
        WinMaximize, ahk_id %id%

        return 0
    }
}
