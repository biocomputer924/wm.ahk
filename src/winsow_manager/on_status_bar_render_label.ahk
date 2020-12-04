#Include %A_ScriptDir%/manager/screens.ahk
#Include %A_ScriptDir%/status_bar/render.ahk

on_status_bar_render_label:
    manager := context["manager"]

    screens := manager_screens(manager)
    
    desktops := manager_desktops(manager)

    for i in screens {
        screen := screens[i]

        current_desktop := desktops[current_desktop_id(screen)]

        status_bar_render(current_desktop["status_bar"], i)
    }
return
