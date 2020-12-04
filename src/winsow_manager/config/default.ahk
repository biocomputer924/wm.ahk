#Include %A_ScriptDir%/array/push.ahk
#Include %A_ScriptDir%/system/applied_dpi.ahk

config_default() {
    a := {}

    a["status_bar"] := {}
    a["status_bar"]["enabled"] := true
    a["status_bar"]["background_color"] := "000000"
    a["status_bar"]["font"] := {}
    a["status_bar"]["font"]["color"] := "FFFFFF"
    a["status_bar"]["font"]["name"] := "Lucida Console"
    a["status_bar"]["font"]["size"] :=
    a["status_bar"]["horizontal_position"] := "left"
    a["status_bar"]["large_font_size"] := 24
    a["status_bar"]["readin_battery"] := false
    a["status_bar"]["readin_date"] := true
    a["status_bar"]["readin_date_format"] := "ddd, dd. MMM. yyyy"
    a["status_bar"]["readin_time"] := true
    a["status_bar"]["readin_time_format"] := "HH:mm"
    a["status_bar"]["readin_volume"] := false
    a["status_bar"]["readin_interval"] := 30000
    a["status_bar"]["vertical_position"] := "top"
    a["status_bar"]["single_row"] := true
    a["status_bar"]["spacious_bar"] := false
    a["status_bar"]["transparency"] := "off"
    a["status_bar"]["width"] := "100%"

    a["window"] := {}
    a["window"]["border"] := {}
    a["window"]["border"]["enabled"] := true
    a["window"]["border"]["width"] := 0
    a["window"]["scaling_factor"] := 1
    ; Undocumented. The value is retrieved by `a_getSystemSettings()` from the registry.
    ; It should not be set manually by the user,
    ; but is dependant on the setting in the `Display control panel` of Windows under `Appearance and Personalization`.

    a["layout"] := {}
    a["layout"]["border_spacing"] := 0
    a["layout"]["direction"] := "row"
    a["layout"]["m_factor"] := 0.5
    a["master"] := {}
    a["master"]["type"] := "column"
    a["stack"] := {}
    a["stack"]["type"] := "column"
    a["area_trace_timeout"] := 1000
    a["continuously_trace_areas"] := false
    a["dynamic_tiling"] := {}
    a["dynamic_tiling"]["enabled"] := true
    a["ghost_window_sub_string"] := " (Not Responding)"
    a["m_fact_call_interval"] := 700
    a["mouse_follows_focus"] := true
    a["new_window_position"] := "top"
    a["on_active_hidden_windows"] := "view"
    a["shell_messasge_delay"] := 10
    a["sync_monitor_views"] := 0
    a["desktop_follows_tagged"] := false
    a["desktop_margin"] := [0,0,0,0]

    ; "<class>,<title>,<function name>,<is managed>,<m>,<floating enabled>,<decoration enabled>"
    a["rules"] := []
    array_push_back(a["rules"], ".*,.*,,1,0,0,0,1")
    array_push_back(a["rules"], ".*,.*,window_is_child,0,0,0,1,1")
    array_push_back(a["rules"], ".*,.*,window_is_popup,0,0,0,1,1")
    array_push_back(a["rules"], "QWidget,.*,,1,0,0,0,0")
    array_push_back(a["rules"], "SWT_Window0,.*,,1,0,0,0,0")
    array_push_back(a["rules"], "Xming,.*,,1,0,0,0,0")
    array_push_back(a["rules"], "MsiDialog(No)?CloseClass,.*,,1,0,0,1,1")
    array_push_back(a["rules"], "AdobeFlashPlayerInstaller,.*,,1,0,0,1,1")
    array_push_back(a["rules"], "CalcFrame,.*,,1,0,0,1,1")
    array_push_back(a["rules"], "CabinetWClass,.*,,1,0,0,0,1")
    array_push_back(a["rules"], "OperationStatusWindow,.*,,0,0,0,1,1")
    array_push_back(a["rules"], "Chrome_WidgetWin_1,.*,,1,0,0,1,1")
    array_push_back(a["rules"], "Chrome_WidgetWin_1,.*,window_is_popup,0,0,0,1,1")
    array_push_back(a["rules"], "Chrome_RenderWidgetHostHWND,.*,,0,0,0,1,1")
    array_push_back(a["rules"], "IEFrame,.*Internet Explorer,,1,0,0,1,1")
    array_push_back(a["rules"], "MozillaWindowClass,.*Mozilla Firefox,,1,0,0,1,1")
    array_push_back(a["rules"], "MozillaDialogClass,.*,,1,0,0,1,1")
    array_push_back(a["rules"], "ApplicationFrameWindow,.*Edge,,1,0,0,1,1")
    array_push_back(a["rules"], "Microsoft-Windows-SnipperEditor,*,,1,0,0,1,1")
    array_push_back(a["rules"], "Microsoft-Windows-SnipperToolbar,*,,1,0,0,1,1")
    array_push_back(a["rules"], "#32770,.*,,1,0,0,1,1")

    a["maintenance_interval"] := 5000
    a["screen_display_change_messages"] := true
    a["hotkeys"] := []

    a["scaling_factor"] := 96 / system_applied_dpi()

    return a
}
