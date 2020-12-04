screen_find_by_position(ByRef screens, p) {
    for i in screens {
        if (screen_contains(screens[i], p))
            return i
    }

    return false
}
