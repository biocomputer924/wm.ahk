#Include %A_ScriptDir%\window\is_hung.ahk

window_set(id, name, value) {
    if window_is_hung(id) {
        return 1
    }
    else {
        WinSet, % name, % value, ahk_id %id%

        return 0
    }
}
