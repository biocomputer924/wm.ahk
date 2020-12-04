#Include %A_ScriptDir%/manager/current_screen.ahk
#Include %A_ScriptDir%/screen/current_desktop_id.ahk

manager_current_desktop_id(ByRef manager) {
    return screen_current_desktop_id(manager_current_screen(manager))
}
