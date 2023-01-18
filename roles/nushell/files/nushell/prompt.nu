def get_right_prompt [] {
    # right prompt ideas
    # 1. just the time on the right
    # 2. date and time on the right
    # 3. git information on the right
    # 4. maybe git and time
    # 5. would like to get CMD_DURATION_MS going there too when it's implemented
    # 6. all of the above, chosen by def parameters

    let use_nerd_fonts = true
    let R = (ansi reset)
    let TIME_BG = "#3A95C7"
    let TERM_FG = "#ffffff"
    let left_transition_nf = (char -u e0b2)
    let left_transition = (char -u 1f780)
    # let left_transition = ""

    let time_segment = ([
        (ansi { fg: $TIME_BG })
        (if ($use_nerd_fonts == true) {
            $left_transition_nf # 
        } else {
            $left_transition
        })
        (ansi { fg: $TERM_FG bg: $TIME_BG})
        (char space)
        (date now | date format '%I:%M:%S %p')
        (char space)
        ($R)
    ] | str collect)

    $time_segment
}
