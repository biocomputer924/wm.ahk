#Include %A_ScriptDir%\window\is_hung.ahk

window_hide(id) {
    if window_is_hung(id) {
        return 1
    }
    else {
        WinHide, ahk_id %id%

        return 0
    }
}
