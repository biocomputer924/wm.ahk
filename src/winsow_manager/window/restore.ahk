#Include %A_ScriptDir%\window\is_hung.ahk

window_restore(id) {
    if window_is_hung(id) {
        return 1
    }
    else {
        WinRestore, ahk_id %id%

        return 0
    }
}
