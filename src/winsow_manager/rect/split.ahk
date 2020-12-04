#Include %A_ScriptDir%/rect/horizontal_split.ahk
#Include %A_ScriptDir%/rect/vertical_split.ahk

rect_split(rect, axis, split_ratio, margin) {
    if axis = "x"
        return rect_horizontal_split(rect, split_ratio, margin)
    else if axis = "y"
        return rect_vertical_split(rect, split_ratio, margin)
}
