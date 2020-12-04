manager_resize_active_window() {
    WinGet, x, ID, A

    if array_contains(manager["managed_window_ids"], x) and not windows[x]["is_floating"]
        desktop_toggle_floating_window(x)

    window_set(x, "Top", "")

    WM_SYSCOMMAND = 0x112
    SC_SIZE       = 0xF000

    SendMessage, WM_SYSCOMMAND, SC_SIZE, , , ahk_id %x%
}
