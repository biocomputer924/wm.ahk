#Include %A_ScriptDir%/manager/current_screen_id.ahk
#Include %A_ScriptDir%/manager/screens.ahk

manager_current_screen(ByRef manager) {
    return manager_screens(manager)[manager_current_screen_id(manager)]
}
