# @depends std_err
# @depends std_out
std_in()
{
    local message
    local prompt=": "
    local arguments=${@}
    local params=""
    local required=0
    local readline=0
    local delimiter
    local nchars
    local preload
    local timeout

    while [[ ! -z "${1}" ]]; do
        case "${1}" in
            -q | --required)
                required=1
            ;;

            -e | --use-readline)
                readline=1
            ;;

            -d | --delimiter)
                delimiter=${2}
                shift
            ;;

            -t | --timeout)
                timeout=${2}
                shift
            ;;

            -n | --nchars)
                nchars=${2}
                shift
            ;;

            -i | --preload)
                preload="${2}"
                shift
            ;;

            -p | --prompt)
                prompt="${2}"
                shift
            ;;

            *)
                message="${1}"
            ;;
        esac
        shift
    done

    if [[ ${readline} -eq 1 ]] || [[ ! -z "${preload}" ]]; then
        params+=" -e"
    fi

    if [[ ! -z ${delimiter} ]] && [[ -z ${nchars} ]]; then
        params+=" -d ${delimiter}"
    fi

    if [[ ! -z ${nchars} ]]; then
        params+=" -n ${nchars}"
    fi

    if [[ ! -z ${timeout} ]]; then
        params+=" -t ${timeout}"
    fi

    std_out --no-newline "${message}${prompt}"

    if [[ -z "${preload}" ]]; then
        read ${params} STDIN
    else
        read ${params} -i "${preload}" STDIN
    fi

    if [[ ${?} -eq 142  ]]; then
        return 2
    fi

    if [[ -z "${STDIN}" ]] && [[ ${required} -eq 1 ]]; then
        std_err "Value is required."
        if [[ -z "${preload}" ]]; then
            std_in "${message}" --required --prompt "${prompt}" ${params}
        else
            std_in "${message}" --required --prompt "${prompt}" --preload "${preload}" ${params}
        fi
    fi
}
