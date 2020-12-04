#Include %A_ScriptDir%\window\is_hung.ahk

window_activate(id) {
    if window_is_hung(id)
        return 1
    else {
        WinActivate, ahk_id %id%

        WinGet, active_id, ID, A

        return (id != active_id)
    }
}
