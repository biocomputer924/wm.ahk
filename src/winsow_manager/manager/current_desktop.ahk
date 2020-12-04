#Include %A_ScriptDir%/manager/current_desktop_id.ahk
#Include %A_ScriptDir%/manager/desktops.ahk

manager_current_desktop(ByRef manager) {
    return manager_desktops(manager)[manager_current_desktop_id(manager)]
}
