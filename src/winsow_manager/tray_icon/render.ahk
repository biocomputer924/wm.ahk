tray_icon_render(x) {
    Menu, Tray, DeleteAll
    Menu, Tray, NoStandard
    Menu, Tray, Tip, % x["name"]
    Menu, Tray, Add,
    Menu, Tray, Add, Exit, % x["on_quit_label"]
}
