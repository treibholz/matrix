#!/bin/bash

SYMBOLS='0123456789!@#$%^&*()-_=+[]{}|;:,.<>?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
COLORS=('102;255;102' '255;176;0' '169;169;169')

init_term() {
    shopt -s checkwinsize; (:;:)
    printf '\e[?1049h\e[?25l'
}

deinit_term(){ printf '\e[?1049l\e[?25h'; }

rain() {
    ((startPos=SRANDOM%LINES/9))
    ((dropPos=SRANDOM%COLUMNS+1))
    ((dropLen=SRANDOM%(LINES/3)+2))
    ((dropSpeed=SRANDOM%3+2))
    color="${COLORS[SRANDOM%3]}"


    for (( i = startPos; i <= LINES+dropLen; i++ )); do
        symbol="${SYMBOLS:SRANDOM%${#SYMBOLS}:1}"
        printf '\e[%d;%dH\e[2;38;2;%sm%s\e[m' "$i" "$dropPos" "$color" "$symbol"
        (( i > dropLen ))&& printf '\e[%d;%dH\e[m ' "$((i-dropLen))" "$dropPos"

        sleep "0.$dropSpeed"
    done
}

trap deinit_term EXIT
trap 'wait; stty echo; exit' INT
trap 'init_term' WINCH

matrix() {
    init_term
    stty -echo
    
    for((;;)) { rain & sleep 0.06; }
}

matrix