system_battery_status() {
    x := {}

    VarSetCapacity(power_status, (1 + 1 + 1 + 1 + 4 + 4))

    success := DllCall("GetSystemPowerStatus", "UInt", &power_status)

    if (ErrorLevel != 0 or success = 0) {
        MsgBox, 16, % "Power Status", % "Can't get the power status ..."
        return
    }

    ac_line_status := NumGet(power_status, 0, "Char")

    battery_life_percent := NumGet(power_status, 2, "Char")

    if ac_line_status = 0
        x["ac_line_status"] = "off"
    else if ac_line_status = 1
        x["ac_line_status"] = "on"
    else if ac_line_status = 255
        x["ac_line_status"] = "?"
    else
        x["ac_line_status"] = ac_line_status

    if battery_life_percent = 255
        x["battery_life_percent"] = "???"
    else
        x["battery_life_percent"] = battery_life_percent

    return x
}
