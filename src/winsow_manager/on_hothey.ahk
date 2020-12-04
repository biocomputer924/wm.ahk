on_hothey(key) {
    hotkeys := context["hotkeys"]

    for i in hotkeys {
        if (key = hotkeys[i]["key"]) {
            eval(hotkeys[i]["command"])
            Break
        }
    }
}

eval(command) {
    i := InStr(command, "(")
    j := InStr(command, ")", false i)

    if i and j {
        function_name := SubStr(command, 1, i - 1)

        arguments := SubStr(command, i + 1, j - (i + 1))

        StringReplace, arguments, arguments, %A_SPACE%, , All

        StringSplit, argument, arguments, `,

        if (argument0 = 0)
            %function_name%()
        else if (argument0 = 1)
            %function_name%(arguments)
        else if (argument0 = 2)
            %function_name%(argument1, argument2)
        else if (argument0 = 3)
            %function_name%(argument1, argument2, argument3)
        else if (argument0 = 4)
            %function_name%(argument1, argument2, argument3, argument4)
    }
}