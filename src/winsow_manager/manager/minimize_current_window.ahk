#Include %A_ScriptDir%/manager/current_screen.ahk

manager_minimize_current_window(ByRef manager) {
    WinGet, x, ID, A

    aView := screen_#%manager["active_screen"]%_adesktop_#1

    StringReplace, desktop_#%manager["active_screen"]%_#%aView%_a_window_ids, desktop_#%manager["active_screen"]%_#%aView%_a_window_ids, % aWndId ";",, All

    if array_contains(manager["managed_window_ids"], x) and not windows[x]["floating"]["enabled"]
        desktop_toggle_floating_window(x)

    window_set(x, "Bottom", "")

    window_minimize(x)
}
