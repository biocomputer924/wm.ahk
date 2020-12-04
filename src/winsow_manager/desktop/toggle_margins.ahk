desktop_toggle_margins() {
    if not (config["desktop"]["margins"] = "0;0;0;0") {
        v := screen_#%manager["active_screen"]%_adesktop_#1

        if (desktop_#%manager["active_screen"]%_#%v%_margins = "0;0;0;0")
            desktop_#%manager["active_screen"]%_#%v%_margins := Config_viewMargins
        else
            desktop_#%manager["active_screen"]%_#%v%_margins := "0;0;0;0"

        StringSplit, desktop_#%manager["active_screen"]%_#%v%_margin, desktop_#%manager["active_screen"]%_#%v%_margins, `;

        desktop_arrange(manager["active_screen"], v)
    }
}