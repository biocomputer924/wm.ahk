#Include %A_ScriptDir%/screen/get.ahk

screen_get(ByRef screens, x, y)
{
    n := 0

    for i in screens {
        r := screens[i]["x"] + screens[i]["width"]
        b := screens[i]["y"] + screens[i]["height"]

        ;; Check if the window is on this monitor.
        if (x < screens[i]["x"])
            continue

        if (x > r)
            continue

        if (y < screens[i]["y"])
            continue

        if (y > b)
            continue

        n := i + 1
        break
    }

    return n
}
