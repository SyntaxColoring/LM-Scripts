# This file provides some common functionality for the main scripts.  It is
# designed to be sourced, rather than executed.

# Makes the script more robust in general.
set -o errexit
set -o nounset
set -o pipefail

# ANSI escape codes for pretty terminal colors.
readonly GREEN='\033[32;1m'
readonly YELLOW="\033[33;1m"
readonly RED="\033[31;1m"
readonly RESET="\033[0m"

# Prints $1 as an error message to stderr and exits with an error code.
Error() { echo -e "${RED}Error:${RESET} $1" >&2; exit 1; }

# Gives the user a "yes/no" prompt with the text from the first positional
# parameter (if given).  If an affirmative response is received,
# returns success; if a negative response is received, returns failure; if an
# unrecognized response is received, the user is given the prompt again.  This
# function always outputs to the terminal rather than stdout, so it is safe
# to use from within functions that are expected to output their results.
Prompt()
{
	# Only try to output the prompt message if it is given, so no newline is
	# printed if it isn't.
	[ $# -gt 0  ] && echo -e "$1" > /dev/tty
	
	local Response
	echo -en "[${GREEN}Y${RESET}/${RED}N${RESET}] " > /dev/tty
	read Response
	
	# For case insensitivity.
	Response="$(echo "$Response" | tr [A-Z] [a-z])"
	
	if [[ "$Response" =~ ^y(es)?$ ]]; then true
	elif [[ "$Response" =~ ^no?$ ]]; then false
	else
		echo "I don't understand that response.  Try \"yes\" or \"no.\"" > /dev/tty
		# Keep pestering the user until he gives a valid response.
		Prompt
	fi
}; readonly -f Prompt

# Outputs a string of shell code that will parse the program arguments for long options.
# Options that are found have their corresponding variables set to "true" and options
# that are not found have their corresponding variables set to be empty.
# Example:
#   # Let's say that the program was passed the arguments --One Two --Three.
#   eval "$(OptionParser One Two Three)"
#   [ $One ] # True.
#   [ $Two ] # False.  The argument was not preceded by "--" on the command-line.
#   [ $Three ] # False.  OptionParser stops on the first argument that isn't an
#              # option, and Two wasn't an option (see above).
OptionParser()
{
	if [ $# -ge 1 ]; then
		for OptionName in "$@"; do echo -n "$OptionName=; "; done
		echo -n 'while [ $# -ge 1 ]; do case "$1" in'
		for OptionName in "$@"; do
			echo -n " '--$OptionName') $OptionName=true && shift ;;"
		done
		echo -n ' *) break ;; esac; done'
	fi
}; readonly -f OptionParser

# Returns the absolute path to $1.  $1 doesn't have to exist, but its containing
# folder does.
Absolute()
{
	cd "$(dirname "$1")" && echo "$(pwd)/$(basename "$1")"
}

# Makes sure that $1 exists in the $PATH variable.  If it doesn't, adds it to
# $PATH in ~/.bash_profile.  Also prints reminders to the user to reset his
# terminal, when necessary.  These reminders are always printed to the terminal,
# rather than stdout.
AssertPATH()
{
	if [[ ":$PATH:" != *":$1:"* ]]; then
		local AddedLine="PATH=\"$1:\$PATH\""
		if grep -q "$AddedLine" ~/.bash_profile; then
			# The desired directory is already in $PATH via ~/.bash_profile,
			# but the user hasn't updated his terminal so the change hasn't
			# yet taken effect.
			echo -e "${YELLOW}You really should restart Terminal or run \"source ~/.bash_profile\" now....${RESET}" > /dev/tty
		else
			echo -e "\\n# Automatically added by LM Scripts." >> ~/.bash_profile
			echo "$AddedLine" >> ~/.bash_profile
			echo -e "${GREEN}Automatically added${RESET} $1 to PATH variable in ~/.bash_profile." > /dev/tty
			echo -e "${YELLOW}Remember to restart Terminal or run \"source ~/.bash_profile\" to update your environment!${RESET}" > /dev/tty
		fi
	fi
}
