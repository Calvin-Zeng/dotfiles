#!/bin/bash
# No use \w show current directory.

__split_pwd() {
	# preserve exit status
	local exit=$?
	local ttyString="[XX:XX:XX][X.XX][XXGi]calvin@calvinnb-ThinkBook-14:[XX]|[XXXX]|[XXX files][XXXMb] "
	local tmp_pwd=${PWD}
	local pwd_size=${#tmp_pwd}
	local pwd_slash_count=$(echo $tmp_pwd | grep -o '/' | wc -l)
	local printf_format='%s'

	TERMWIDTH=${COLUMNS}

	let fillsize=${TERMWIDTH}-${#ttyString}

	case "$#" in
		0|1)	printf_format="${1:-$printf_format}"
		;;
		*)	return $exit
		;;
	esac

	if [ "$fillsize" -gt "$pwd_size" ]
	then
		printf -- "$printf_format" "${tmp_pwd}"
		return $exit
	fi

	if [ "${#ttyString}" -gt "$fillsize" ]
	then
		printf -- "\n$printf_format" "${tmp_pwd}"
		return $exit
	fi

	if [ "$fillsize" -le "$pwd_size" ]
	then
		while [ "$fillsize" -le "$pwd_size" ]
		do
			cut_string="-f1-${pwd_slash_count}"
			pwd_size=${#tmp_pwd}
			tmp_pwd="$(echo ${tmp_pwd} | cut -d'/' $cut_string)"
			pwd_slash_count=$(expr ${pwd_slash_count} - 1)
		done

		tmp_pwd+="/../${PWD##*/}"
		printf -- "$printf_format" "${tmp_pwd}"
	fi
    return $exit
}
