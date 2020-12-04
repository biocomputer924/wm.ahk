desktop_status_bar_toggle_visibility(n) {
    GuiN := (n - 1) + 1

    if screens[n]["status_bar_enabled"] {
        if not (GuiN = 99)
            Gui, %GuiN%: Show
    }
    else
        Gui, %GuiN%: Hide
}
