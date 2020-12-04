screen_moveToIndex(m, n) {
    screen_#%n%_adesktop_#1 := screen_#%m%_adesktop_#1
    screen_#%n%_adesktop_#2 := screen_#%m%_adesktop_#2
    screen_#%n%_name     := screen_#%m%_name
    screen_#%n%_showBar  := screen_#%m%_showBar
    screen_#%n%_showTaskBar  := screen_#%m%_showTaskBar
    screen_#%n%_taskBarClass := screen_#%m%_taskBarClass
    screen_#%n%_taskBarPos   := screen_#%m%_taskBarPos
    screen_#%n%_height := screen_#%m%_height
    screen_#%n%_width  := screen_#%m%_width
    screen_#%n%_x      := screen_#%m%_x
    screen_#%n%_y      := screen_#%m%_y
    screen_#%n%_barY   := screen_#%m%_barY

    loop % Config_viewCount
        desktop_moveToIndex(m, A_Index, n, A_Index)
}
