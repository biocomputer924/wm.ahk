#Include %A_ScriptDir%\window\position.ahk

window_move(id, rect) {
    x := rect["x"]
    y := rect["y"]
    width := rect["width"]
    height := rect["height"]

   if not id
        return 0

    current_rect := window_rect(id)

    ; Check if the window has already the given position and size and no action is required.
    if current_rect and (Abs(current_rect["x"] - x) < 2 and Abs(current_rect["y"] - y) < 2 and Abs(position["width"] - width) < 2 and Abs(position["height"] - height) < 2)
        return 0

    if window_is_hung(id)
        return 1
    else {
        WinGet, min_max, MinMax ahk_id %id%

        if (min_max = -1 and not windows[id]["is_minimized"])
            WinRestore, ahk_id %id%
    }

    WM_ENTERSIZEMOVE := 0x0231

    WM_EXITSIZEMOVE := 0x0232

    SendMessage, WM_ENTERSIZEMOVE, , , , ahk_id %id%

    if ErrorLevel {
        return 1
    }
    else {
        WinMove, ahk_id %id%, , %x%, %y%, %width%, %height%

        position := window_rect(id)

        ; if not (min_max = 1) or not window_#% id_isDecorated or manager_windowNotMaximized(width, height) {
        if position and (Abs(position["x"] - x) > 1 or Abs(position["y"] - y) > 1 or Abs(position["width"] - width) > 1 or Abs(position["height"] - height) > 1) {
            x -= position["x"] - x
            y -= position["y"] - y
            width  += width - position["width"] - 1
            height += height - position["height"] - 1

            WinMove, ahk_id %id%, , %x%, %y%, %width%, %height%
        }
        ;}

        SendMessage, WM_EXITSIZEMOVE, , , , ahk_id %id%

        return 0
    }
}
