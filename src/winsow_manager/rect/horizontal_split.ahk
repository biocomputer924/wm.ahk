rect_horizontal_split(rect, split_ratio, margin) {
    x := rect["x"]
    y := rect["y"]
    w := rect["width"]
    h := rect["height"]

    w1 := w * split_ratio - margin / 2
    w2 := w - w1 - margin
    x2 := x + w1 + margin

    return
        , [{ width: w1
            , height: h
            , x: x
            , y: y }
        , { width: w2
            , height: h
            , x: x2
            , y: y }]
}