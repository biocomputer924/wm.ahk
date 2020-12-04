#Include %A_ScriptDir%/array/push.ahk
#Include %A_ScriptDir%/manager/screens.ahk
#Include %A_ScriptDir%/screen/get.ahk

manager_initial_sync(ByRef manager) {
    screens := manager_screens(manager)

    f := []

    for i in screens
        array_push_back(f, [])

    WinGet, window_list, List, , ,

    loop % window_list {
        id := window_list%A_Index%

        WinGetPos, x, y, w, h, ahk_id %id%

        j := screen_get(manager_screens(manager), x + w / 2, y + h / 2)

        if j > 0
            array_push_back(f[j], id)
    }

    for i in f
        for j in f[i]
            manager_manage(manager, i, 1, f[i][j])
}