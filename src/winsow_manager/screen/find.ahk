screen_find(ByRef screens) {
    for i in screens {
        SysGet, name, MonitorName %i%

        if not (name = screens[i]["name"])
            return i
    }

    return 0
}
