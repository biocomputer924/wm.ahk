#Include %A_ScriptDir%\window\is_hung.ahk

window_show(id) {
    if window_is_hung(id) {
        return 1
    }
    else {
        WinShow, ahk_id %id%

        return 0
    }
}
