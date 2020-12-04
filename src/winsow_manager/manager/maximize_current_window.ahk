#Include %A_ScriptDir%/manager/current_screen.ahk

manager_maximize_current_window(ByRef manager) {
    WinGet, x, ID, A

    if array_contains(manager["managed_window_ids"], x) and not windows[x]["floating"]["enabled"]
        desktop_toggle_floating_window(x)

    window_set(x, "Top", "")

    screen = manager_current_screen(manager)

    window_move(x, screen["rect"])
}
