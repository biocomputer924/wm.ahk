#Include %A_ScriptDir%\window\is_hung.ahk

window_minimize(id) {
    if window_is_hung(id) {
        return 1
    }
    else {
        WinMinimize, ahk_id %id%

        return 0
    }
}
