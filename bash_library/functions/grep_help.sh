# help_grep guide.
help_grep() {
    case $1 in
    *)
echo -e $"
    ${Green}-i, --ignore-case${Color_Off}
        Ignore case distinctions in patterns and input data, so that characters that differ only in case match each other.Example:
    ${Green}-r, --recursive${Color_Off}
        Read all files under each directory, recursively, following symbolic links only if they are on the command line.
        Note  that  if  no  file  operand  is  given,  grep searches the working directory.
        This is equivalent to the -d recurse option.
    ${Green}-n, --line-number${Color_Off}
        Prefix each line of output with the 1-based line number within its input file.
    ${Green}-a, --text${Color_Off}
        Process a binary file as if it were text; this is equivalent to the --binary-files=text option.
    ${Green}-C NUM, -NUM, --context=NUM${Color_Off}
        Print  NUM  lines  of  output context.  Places a line containing a group separator (--) between contiguous groups of matches.
        With the -o or --only-matching option, this has no effect and a warning is given.

    - ${Green} Find content of file:
        ${Yellow}grep -irnaC 2 find_something ./ 2>/dev/null${Color_Off}
"
    ;;
    esac
}