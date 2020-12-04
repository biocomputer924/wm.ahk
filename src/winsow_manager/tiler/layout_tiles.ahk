#Include %A_ScriptDir%/rect/split.ahk
#Include %A_ScriptDir%/tiler/stack_tiles.ahk

tiler_layout_tiles(ByRef desktop, rect, type = "") {
    axis := desktop["layout"]["axis"]

    master_area := desktop["master_area"]

    stack_area := desktop["stack_area"]

    border_spacing := desktop["layout"]["border_spacing"]

    mFact := desktop["layout"]["m_fact"]

    mXSet := (master_area["axis"] = "x") ? desktop["layout"]["mx"] : desktop["layout"]["my"]

    mYSet := (master_area["axis"] = "x") ? desktop["layout"]["my"] : desktop["layout"]["mx"]

    mSplit := mXSet * mYSet

    has_stack_area := (type = "blank") ? stack_area["enabled"] : (desktop_tiledWndId0 > mSplit)

    master_area_window_ids = array_slice(desktop["window_ids"], 0, mSplit)

    stack_area_window_ids = array_slice(desktop["window_ids"], mSplit, stack_area_window_ids.Length())

    n := (type = "blank") ? m_split : desktop_tiledWndId0

    if (type = "blank")
        desktop["area0"] := 0
    else {
        if (desktop_tiled = 0)
            return

        if (mSplit > desktop_tiledWndId0)
            mSplit := desktop_tiledWndId0
    }

    if has_stack_area {
        rects := rect_split(rect, axis, 1 - mFact, border_spacing)

        if (desktop["layout"]["reversed"]) {
            master_area_rect := rects[0]
            stack_area_rect := rects[1]
        }
        else {
            master_area_rect := rects[1]
            stack_area_rect := rects[0]
        }
    }
    else {
        master_area_rect := rect
        stack_area_rect := 
    }

    ; Master
    tiler_stack_tiles(desktop, master_area_window_ids, master_area_rect, master_area["axis"], false, 0, type)
    tiler_stack_tiles(desktop, stack_area_window_ids, stack_area_rect, stack_area["axis"], false, 0, type)
}