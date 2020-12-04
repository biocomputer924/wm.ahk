#Include %A_ScriptDir%/array/count.ahk
#Include %A_ScriptDir%/array/push.ahk
#Include %A_ScriptDir%/array/reverse.ahk
#Include %A_ScriptDir%/window/move.ahk

tiler_stack_tiles(ByRef desktop, window_ids, rect, axis, reversed, padding, type = "") {
    n := array_count(window_ids)

    if (axis = "x") {
        width := (rect["width"] - padding * (n - 1)) / n
        height := rect["height"]
        dx := width + padding
        dy := 0
    }
    else if (axis = "y") {
        width := rect["width"]
        height := (rect["height"] - padding * (n - 1)) / n
        dx := 0
        dy := height + padding
    }
    else {
        width := rect["width"]
        height := rect["height"]
        dx := 0
        dy := 0
    }

    if reversed {
        window_ids := array_reverse(window_ids)
    }

    for i in window_ids {
        tile_rect := { x: x, y: y, width: width, height: height }

        if (type = "blank")
            array_push_back(desktop["areas"], tile_rect)
        else
            window_move(window_ids[i], tile_rect)

        x += dx
        y += dy
    }
}