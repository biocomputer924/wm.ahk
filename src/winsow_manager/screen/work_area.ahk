screen_work_area(m) {
    SysGet, screen, Monitor %m%

    classes := ["Shell_TrayWnd", "Shell_SecondaryTrayWnd"]

    for i in classes {
        id := WinExist("ahk_class " . classes[i])

        if id {
            WinGetPos, window_x, window_y, window_width, window_height, ahk_id %id%

            x := window_x + window_width / 2
            y := window_y + window_height / 2

            if (x >= screen_left && x <= screen_right && y >= screen_top && y <= screen_bottom) {
                if (classes[i] = "Shell_TrayWnd") or (classes[i] = "Shell_SecondaryTrayWnd")
                    screen["task_bar_class"] := classes[i]

                if (window_height < window_width) {
                    ; Horizontal
                    if (window_y <= screen_top) {
                        window_height += window_y - screen_top
                        screen_top += window_height

                        if (classes[i] = "Shell_TrayWnd") or (classes[i] = "Shell_SecondaryTrayWnd")
                            screen_#%m%_taskBarPos := "top"
                    }
                    else {
                        window_height := screen_bottom - window_y
                        screen_bottom -= window_height
                    }
                }
                else {
                    ; Vertical
                    if (window_x <= screen_left) {
                        window_width += window_x
                        screen_left += window_width
                    }
                    else {
                        window_width := screen_right - window_x
                        screen_right -= window_width
                    }
                }
            }
        }
    }

    bheight := Round(status_bar_height / Config_scalingFactor)

    b_top := 0

    if (config["vertical_bar_position"] = "top") {
        b_top := screen_top

        if screen["status_bar"]["enabled"]
            screen_top += bheight
    }
    else if (config["vertical_bar_position"] = "bottom") {
        b_top := screen_bottom - bheight

        if screen["status_bar"]["enabled"]
            screen_bottom -= bheight
    }

    rect = {}
    rect["x"] := screen_left
    rect["y"] := screen_top
    rect["width"] := screen_right - screen_left
    rect["height"] := screen_bottom - screen_top

    screen["ary"] := b_top

    screen_set_work_area(rect)
}
