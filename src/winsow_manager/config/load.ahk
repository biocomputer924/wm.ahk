#Include %A_ScriptDir%/array/push.ahk
#Include %A_ScriptDir%/config/default.ahk

config_load(file_path) {
    a := config_default()

    if not FileExist(file_path)
        return a

    loop READ, %file_path%
    {
        i := InStr(A_LoopReadLine, "=")

        if not i
            continue

        key := SubStr(A_LoopReadLine, 1, i - 1)

        value := SubStr(A_LoopReadLine, i + 1)

        if (type = "hotkeys") {
            i := InStr(value, ":")

            hotkey := {}
            hotkey["pattern"] := SubStr(value, 1, i - 1)
            hotkey["command"] := SubStr(value, i + 2)

            array_push_back(a["hotkeys"], hotkey)
        }
        else if (type = "rules") {
            if array_contains("rules", key)
                a["rules"][SubStr(key, 7)] := value
            else
                array_push_back(a["rules"], value)
        }
    }

    return a
}
