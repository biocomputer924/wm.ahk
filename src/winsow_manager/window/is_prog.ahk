window_is_prog(id) {
    WinGetClass, class, ahk_id %id%

    WinGetTitle, title, ahk_id %id%

    if not (class = "Progman") and not (class = "WorkerW") and not (class = "DesktopBackgroundClass") and not (class = "AutoHotkeyGui" and SubStr(title, 1, 10) = "bug.n_BAR_")
        return id
    else
        return 0
}
