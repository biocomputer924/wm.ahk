#Include %A_ScriptDir%/desktop/arrange.ahk
#Include %A_ScriptDir%/manager/close_window.ahk
#Include %A_ScriptDir%/manager/screens.ahk
#Include %A_ScriptDir%/screen/work_area.ahk
#Include %A_ScriptDir%/screen/set_work_area.ahk
#Include %A_ScriptDir%/window/set.ahk
#Include %A_ScriptDir%/window/show.ahk

manager_cleanup(ByRef manager) {
    WinGet, active_window_id, ID, A

    manager["hide_show"] := true

    for i in manager["managed_window_ids"] {
        window_show(i)

        if not manager["show_border"]
            window_set(i, "Style", "+0x40000")

        window_set(i, "Style", "+0xC00000")
    }

    ; Show the task bar.
    WinShow, Start, ahk_class Button

    manager["hide_show"] := false

    screens = manager_screens(manager)

    ; Restore window positions and sizes.
    for i in screens {
        screens[i]["status_bar_enabled"] := false
        screens[i]["task_bar_enabled"] := true

        screen_work_area(i)

        for j in manager["desktops"] {
            desktop_arrange(i, j, true)
        }
    }

    window_set(active_window_id, "AlwaysOnTop", "On")
    window_set(active_window_id, "AlwaysOnTop", "Off")

    ; SKAN: Crazy Scripting : Quick Launcher for Portable Apps (http://www.autohotkey.com/forum/topic22398.html)
    DllCall("Shell32.dll\SHAppBarMessage", "UInt", (ABM_REMOVE := 0x1), "UInt", &status_bar_appBarData)
}
