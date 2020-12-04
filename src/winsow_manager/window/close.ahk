#Include %A_ScriptDir%\window\is_hung.ahk

window_close(id) {
    if window_is_hung(id) {
        return 1
    }
    else {
        WinClose, ahk_id %id%

        return 0
    }
}
