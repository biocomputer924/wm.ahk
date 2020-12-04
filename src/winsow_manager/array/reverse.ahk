array_reverse(ByRef x) {
	y := Object()

	For i in x
		y[x.Length() - i + 1] := x[i]

	Return y
}
