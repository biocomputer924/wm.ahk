#Include %A_ScriptDir%/array/count.ahk

manager_search_rule(ByRef window_id, rules) {
    WinGetClass, window_class, ahk_id %window_id%
    WinGetTitle, window_title, ahk_id %window_id%

    if (window_class or window_title) {
        n := array_count(rules)

        for i in rules {
            ; The rules are traversed in reverse order.
            j := n - i + 1

            StringSplit, rule, rules[j], % ","

            if (RegExMatch(window_class, rule1) AND RegExMatch(window_title, rule2) and (rule3 = "" or %rule3%(window_id)) {
                x := {}
                x["is_managed"] := rule4
                x["floating"] := {}
                x["floating"]["enabled"] := rule5
                x["decoration"] := {}
                x["decoration"]["enabled"] := rule6
                x["action"] := rule7

                return x
            }
        }
    }

    x := {}
    x["decoration"] := {}
    x["decoration"]["enabled"] := false
    x["floating"] := {}
    x["floating"]["enabled"] := false
    x["is_managed"] := false
    x["action"] := ""

    return x
}