#Include %A_ScriptDir%/tiler/layout_tiles.ahk

desktop_arrange(ByRef screen, desktop, setLayout = False) {
    rect := {}
    rect["x"] := screen["position"][0] + desktop["layout"]["border_spacing"] + desktop["margin"]["left"]
    rect["y"] := screen["position"][1] + desktop["layout"]["border_spacing"] + desktop["margin"]["top"]
    rect["width"] := screen["width"] - desktop["layout"]["border_spacing"] * 2 - desktop["margin"]["left"] - desktop["margin"]["right"]
    rect["height"] := screen["height"] - desktop["layout"]["border_spacing"] * 2 - desktop["margin"]["top"] - desktop["margin"]["bottom"]

    ; All window actions are performed on independent windows. A delay won't help.
    SetWinDelay, 0

    if config["dynamic_tiling"]["enabled"] and setLayout {
        desktop["tiled_window_ids"]

        tiler_layout_tiles(desktop, rect)
    }
    else if (fn = "tile") {
        tiler_layout_tiles(desktop, rect, "blank")

        if config["continuously_trace_areas"]
            ; desktop_trace_areas(true)
    }

    SetWinDelay, 10
}
