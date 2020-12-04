#Include %A_ScriptDir%/array/count.ahk
#Include %A_ScriptDir%/manager/current_desktop.ahk
#Include %A_ScriptDir%/manager/current_screen.ahk
#Include %A_ScriptDir%/manager/screens.ahk
#Include %A_ScriptDir%/screen/get.ahk

manager_activate_screen(ByRef manager, screen_id) {
    if (array_count(manager_screens(manager)) > 1) {
        current_screen := manager_current_screen(manager)

        current_desktop := manager_current_desktop(manager)

        WinGet, current_window_id, ID, A

        if WinExist("ahk_id" current_window_id) and InStr(desktop_#%manager["active_screen"]%_#%aView%_wndIds, active_window_id ";") and window_is_prog(active_window_id) {
            WinGetPos, x, y, width, height, ahk_id %current_window_id%

            if (screen_get(manager_screens(manager), x + width / 2, y + height / 2) = manager["current_screen_id"])
                desktop_set_active_window(current_screen, current_desktop, current_window_id)
        }
    }

    manager["current_screen_id"] := screen_id

    current_desktop := manager_current_desktop(manager)

    manager_activate_window(manager, current_window_id)
}
