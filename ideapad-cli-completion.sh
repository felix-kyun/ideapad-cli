#!/usr/bin/env bash

_ideapad_cli_completions()
{
    local cur prev commands
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    commands="fan battery-conservation rapid-charge"
    COMPREPLY=()

    case "${prev}" in
        ideapad-cli)
            COMPREPLY=( $(compgen -W "${commands}" -- "${cur}") )
            return 0
            ;;
        fan)
            local fan_options="performance automatic battery"
            COMPREPLY=( $(compgen -W "${fan_options}" -- "${cur}") )
            return 0
            ;;
        battery-conservation|rapid-charge)
            local battery_options="enable disable"
            COMPREPLY=( $(compgen -W "${battery_options}" -- "${cur}") )
            return 0
            ;;
    esac

    return 0
}

complete -F _ideapad_cli_completions ideapad-cli
