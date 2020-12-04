; Key definitions
; Window management
#Down::manager_activate_window(context["manager"], +1)
#Up::manager_activate_window(context["manager"], -1)
#c::manager_close_window()
#+d::window_toggle_decor()
#+f::desktop_toggle_floating_window()
#+m::manager_move_window()
#^m::manager_minimize_window()
#+s::manager_size_window()
#+x::manager_maximize_window()
#i::manager_render_active_window_info()
!Down::desktop_move_window(+1)
!Up::desktop_move_window(-1)
!+Enter::manager_maximize_window()
!BackSpace::desktop_toggle_stack_area()

; Layout management
#Tab::desktop_set_layout(-1)
#Left::desktop_set_layout_property("MFactor", 0, -0.05)
#Right::desktop_set_layout_property("MFactor", 0, +0.05)
#^t::desktop_set_layout_property("Axis", 0, +1, 1)
#^Enter::desktop_set_layout_property("Axis", 0, +2, 1)
#^Tab::desktop_set_layout_property("Axis", 0, +1, 2)
#^+Tab::desktop_set_layout_property("Axis", 0, +1, 3)
#^Up::desktop_set_layout_property("MY", 0, +1)
#^Down::desktop_set_layout_property("MY", 0, -1)
#^Right::desktop_set_layout_property("MX", 0, +1)
#^Left::desktop_set_layout_property("MX", 0, -1)
#^Backspace::desktop_resetTile_layout()

; View/Tag management
#BackSpace::screen_activate_desktop(-1)

; Monitor management
#.::manager_activate_screen(context["manager"], 0, +1)
#,::manager_activate_screen(context["manager"], 0, -1)
#+.::manager_set_window_screen(context["manager"], 0, +1)
#+,::manager_set_window_screen(context["manager"], 0, -1)
#^+.::manager_set_desktop_screen(context["manager"], 0, +1)
#^+,::manager_set_desktop_screen(context["manager"], 0, -1)

; GUI management
#+Space::screen_toggle_bar()
#+y::screen_toggleNotifyIconOverflow_window()
!+y::desktop_trace_areas()

; Administration
#^e::Run edit context["config_file_path"]
#^r::Reload
#^q::ExitApp
