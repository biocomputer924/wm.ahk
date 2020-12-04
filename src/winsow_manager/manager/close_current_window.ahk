#Include %A_ScriptDir%/manager/close_window.ahk

manager_close_current_window(ByRef manager) {
    WinGet, window_id, ID, A

    return manager_close_window(manager, window_id)
}
