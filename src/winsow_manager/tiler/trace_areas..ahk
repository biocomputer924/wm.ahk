tiler_trace_areas(m, v, continuously) {
    x1 := screen_#%m%_x + desktop_#%m%_#%v%_layoutGapWidth + desktop_#%m%_#%v%_margin4
    y1 := screen_#%m%_y + desktop_#%m%_#%v%_layoutGapWidth + desktop_#%m%_#%v%_margin1
    w1 := screen_#%m%_width - 2 * desktop_#%m%_#%v%_layoutGapWidth - desktop_#%m%_#%v%_margin4 - desktop_#%m%_#%v%_margin2
    h1 := screen_#%m%_height - 2 * desktop_#%m%_#%v%_layoutGapWidth - desktop_#%m%_#%v%_margin1 - desktop_#%m%_#%v%_margin3

    title := "bug.n_TRACE_" m "_" v

    Gui, 98: Default
    Gui, Destroy
    Gui, +AlwaysOnTop -Caption +Disabled +ToolWindow
    Gui, Color, %Config_foreColor_#2_#1%
    Gui, Font, c%Config_fontColor_#1_#3% s%Config_largeFontSize%, %Config_fontName%

    borderW := Config_borderWidth + (Config_borderPadding < 0 ? 0 : Config_borderPadding)

    n := desktop_#%m%_#%v%_area_#0

    loop % n {
        x2 := desktop_#%m%_#%v%_area_#%A_Index%_x - x1 + borderW
        y2 := desktop_#%m%_#%v%_area_#%A_Index%_y - y1 + borderW
        w2 := desktop_#%m%_#%v%_area_#%A_Index%_width - 2 * borderW
        h2 := desktop_#%m%_#%v%_area_#%A_Index%_height - 2 * borderW
        y3 := y2 + (h2 - Config_largeFontSize) / 2

        Gui, Add, Progress x%x2% y%y2% w%w2% h%h2% Background%Config_backColor_#1_#3%, 100
        Gui, Add, Text x%x2% y%y3% w%w2% BackgroundTrans Center %A_Index%%
    }

    Gui, Show NoActivate x%x1% y%y1% w%w1% h%h1%, % title
    WinSet, Transparent 191, % title

    if not continuously {
        Sleep, % Config_areaTraceTimeout

        if not Config_continuouslyTraceAreas
            Gui, Destroy
        else
            WinSet, Bottom, , % title
    }
    else
        WinSet, Bottom, , % title
}
