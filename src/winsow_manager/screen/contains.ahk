screen_contains(ByRef x, p) {
    return p[0] >= x["x"] && p[0] <= x["x"] + x["width"] && p[1] >= x["y"] && p[1] <= x["y"] + x["height"])
}
