#!/bin/bash

##################################################
# The Docker based Development Environment setup script
######

version=0.1.0

die()
{
	local _ret=$2
	test -n "$_ret" || _ret=1
	test "$_PRINT_HELP" = yes && print_help >&2
	echo "$1" >&2
	exit ${_ret}
}


begins_with_short_option()
{
	local first_option all_short_options='tvh'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_tag="dden"


print_help()
{
	printf '%s\n' "The Docker based Develpment Environment setup script. It will build the docker image using the optional Tag name and create environment initialization script."
	printf 'Usage: %s [-t|--tag <arg>] [-v|--version] [-h|--help]\n' "$0"
	printf '\t%s\n' "-t, --tag: Tag name for the docker image (default: '$_arg_tag')"
	printf '\t%s\n' "-v, --version: Prints version"
	printf '\t%s\n' "-h, --help: Prints help"
}


parse_commandline()
{
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			-t|--tag)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_tag="$2"
				shift
				;;
			--tag=*)
				_arg_tag="${_key##--tag=}"
				;;
			-t*)
				_arg_tag="${_key##-t}"
				;;
			-v|--version)
				echo test v$version
				exit 0
				;;
			-v*)
				echo test v$version
				exit 0
				;;
			-h|--help)
				print_help
				exit 0
				;;
			-h*)
				print_help
				exit 0
				;;
			*)
				_PRINT_HELP=yes die "FATAL ERROR: Got an unexpected argument '$1'" 1
				;;
		esac
		shift
	done
}

parse_commandline "$@"

# Build the image
docker build --tag=${_arg_tag}-image ./dden

# Generate the Create script
sed -e "s/{{ image_name }}/${_arg_tag}-image/" ./dden/create.tmpl > ${_arg_tag}-create.sh
chmod +x ${_arg_tag}-create.sh

# Generate Image Remove script
echo \#!/bin/bash
echo docker rmi ${_arg_tag}-image > ${_arg_tag}-image-remove.sh
echo rm ${_arg_tag}-create.sh ${_arg_tag}-image-remove.sh >> ${_arg_tag}-image-remove.sh
chmod +x ${_arg_tag}-image-remove.sh
