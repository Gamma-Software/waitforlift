#!/bin/bash

_script_completions() {
    arg_index="${COMP_CWORD}"
    if [[ "${arg_index}" -eq 1 ]]; then
        COMPREPLY=($(compgen -W "--path add" -- "${COMP_WORDS[1]}"))
    fi
}
complete -F _script_completions script

