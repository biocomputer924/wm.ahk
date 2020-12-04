
desktop_trace_areas(continuously = false) {
    v := screen_#%manager["active_screen"]%_adesktop_#1

    if tiler_is_active(manager["active_screen"], v) and not Config_dynamicTiling
        tiler_trace_areas(manager["active_screen"], v, continuously)
}
