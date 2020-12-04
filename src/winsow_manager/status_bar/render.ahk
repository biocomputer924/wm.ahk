#Include %A_ScriptDir%/array/join.ahk
#Include %A_ScriptDir%/array/push.ahk
#Include %A_ScriptDir%/system/battery_status.ahk

status_bar_render(ByRef status_bar, n) {
    Gui, % n . ": Default"

    Gui, Destroy

    Gui, +AlwaysOnTop -Caption +LastFound +ToolWindow

    Gui, Color, % status_bar["background_color"]

    font := status_bar["font"]

    Gui, Font, % array_join(["c" . font["color"], "s" . font["size"]], " "), % font["name"]

    children = []

    if status_bar["readin_battery"] {
        battery_status := system_battery_status()

        array_push_back(children, {text: "BATTERY: " . battery_status["battery_life_percent"] . "%"})
    }

    if status_bar["readin_volume"] {
        SoundGet, volume, MASTER, VOLUME
        SoundGet, mute, MASTER, MUTE

        array_push_back(children, {text: "VOLUME: " . Round(volume) . "%"})
    }

    if status_bar["readin_date"] {
        FormatTime, date, , % status_bar["readin_date_format"]

        array_push_back(children, {text: date})
    }

    if status_bar["readin_time"] {
        FormatTime, time, , % status_bar["readin_time_format"]

        array_push_back(children, {text: time})
    }

    for i in children {
        Gui, Add, Text, BackgroundTrans Left, % children[i]["text"]
    }

    title := "statusbar" . n

    x := status_bar["position"][0]

    y := status_bar["position"][1]

    width := Round(status_bar["width"] * status_bar["scaling_factor"])

    height := status_bar["height"]

    if status_bar["enabled"]
        Gui, % array_join(["Show", "NoActivate", "x" . x, "y" . y, "w" . width, "h" . height], " "), % title
    else
        Gui, % array_join(["Show", "NoActivate", "Hide", "x" . x, "y" . y, "w" . width, "h" . height], " "), % title

    handle := WinExist(title)

    status_bar_app_bar_data := ""

    app_bar_msg := DllCall("RegisterWindowMessage", Str "AppBarMsg")

    ; app_bar_data: http://msdn2.microsoft.com/en-us/library/ms538008.aspx
    VarSetCapacity(status_bar_app_bar_data, 36, 0)

    offset := NumPut(36, status_bar_app_bar_data)
    offset := NumPut(status_bar_id, offset + 0)
    offset := NumPut(app_bar_msg, offset + 0)
    offset := NumPut(1, offset + 0)
    offset := NumPut(x, offset + 0)
    offset := NumPut(y, offset + 0)
    offset := NumPut(x + width, offset + 0)
    offset := NumPut(y + height, offset + 0)
    offset := NumPut(1, offset + 0)

    DllCall("Shell32.dll\SHAppBarMessage", "UInt", (ABM_NEW := 0x0), "UInt", &status_bar_app_bar_data)
    DllCall("Shell32.dll\SHAppBarMessage", "UInt", (ABM_QUERYPOS := 0x2), "UInt", &status_bar_app_bar_data)
    DllCall("Shell32.dll\SHAppBarMessage", "UInt", (ABM_SETPOS := 0x3), "UInt", &status_bar_app_bar_data)
    ; SKAN: Crazy Scripting : Quick Launcher for Portable Apps (http://www.autohotkey.com/forum/topic22398.html)
}
