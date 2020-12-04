manager_on_display_change(a, wParam, uMsg, lParam) {
    MsgBox, 291, , % "Would you like to reset the screen configuration?`n'No' will only rearrange all active views.`n'Cancel' will result in no change."

    IfMsgBox, Yes
        manager_reset_monitor_configuration()
    else IfMsgBox No {
        loop % manager_screenCount {
            desktop_arrange(A_Index, screen_#%A_Index%_adesktop_#1)
        }

        status_bar_update(status_bar)
    }
}
