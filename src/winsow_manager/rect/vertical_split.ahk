rect_vertical_split(rect, split_ratio, margin) {
    x := rect["x"]
    y := rect["y"]
    w := rect["width"]
    h := rect["height"]

    h1 := h * split_ratio - margin / 2
    h2 := h - h1 - margin
    y2 := y + h1 + margin

    r := {width: w, height: h1, x: x, y: y}
    s := {width: w, height: h2, x: x, y: y2}

    return [r, s]
}