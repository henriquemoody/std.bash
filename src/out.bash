std_out()
{
    local params
    local message
    local interactive
    local escape=1
    local newline=1

    while [[ ${1} = -* ]]; do
        case "${1}" in
            --no-escape | -e )
                escape=0
            ;;
            --no-newline | -n )
                newline=0
            ;;
            *)
                echo "Unrecognized options `${1}`"
                return 1
            ;;
        esac
        shift
    done

    if [[ ${escape} -eq 1 ]]; then
        params="${params} -e"
    fi

    if [[ ${newline} -eq 0 ]]; then
        params="${params} -n"
    fi

    if [[ -z "${INTERACTIVE}" ]]; then
        if [ ! -t 0 ]; then
            interactive=0
        else
            interactive=1
        fi
    else
        interactive="${INTERACTIVE}"
    fi

    if [[ -z "${@}" ]] && [[ "${interactive}" -eq 0 ]]; then
        message=$(cat <&0)
    else
        message="${@}"
    fi

    if [[ ${escape} -eq 0 ]]; then
        echo ${params} "${message}"
        return ${?}
    fi

    if [ "${interactive}" -eq 1 ]; then
        message=$(echo "${message}" | sed -E $'s/\[([0-9;]*)\]/\\\033\[\\1m/g')
    else
        message=$(echo "${message}" | sed -E 's/\[[0-9;]*\]//g')
    fi

    echo ${params} "${message}"
}
