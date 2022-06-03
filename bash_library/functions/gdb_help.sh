# help_gdb guide.
help_gdb() {
    case $1 in
    *)
echo -e $"
${Yellow}gdb command${Color_Off}
    ${Green}Base:${Color_Off}
        quit: exit
        help: help (append command name)
        run: execute name (append args)
        list: print source code (append column number or function name)
        print: print variable value
    ${Green}Interrupt:${Color_Off}
        break [column number or function name]: set interrupt
        info break: list total interrupt
        disp [variable]: print variable value every interrupt
        info disp: list total disp
        next: step one line code (append execute column number)
        step: step one line code, include function inter code.
        cont: Continue execution, until interrupt point or code end.
    ${Green}expressions (EX: print & disp 's args):${Color_Off}
        \$: last expressions
        \$\$: Two previous expressions
        \$7: No.7 expressions
        \$\$7: Last no.7 expressions
    ${Green}stack code:${Color_Off}
        where: show program call info
        up: Going up one level
        down: Going to the next level
    ${Green}other command:${Color_Off}
        [CR]: repeat last command.

    - ${Green} Run local gdb.${Color_Off}
        \"\$1\" is gdb path
        \"\$2\" is debug program path.
        \"\$1\" --quiet -ex=run \"\$2\"

    - ${Green} Run remote gdbserver in target board.${Color_Off}
        \"\$1\" is ip address.
        \"\$2\" is port.
        \"\$3\" is execute file path.

        ${Yellow}gdbserver \"\$1\":\"\$2\" \"\$3\"${Color_Off}

    - ${Green} Run local gdb to connect target gdbserver.${Color_Off}
        \"\$1\" is ip address.
        \"\$2\" is port.

        ${Yellow}gdb << EOF
        target remote \$1:\$2
        EOF${Color_Off}

${Yellow}Reference:${Color_Off}
    http://www.study-area.org/goldencat/debug.htm
    http://kezeodsnx.pixnet.net/blog/post/31901130-gdbserver-remote-debug-%E6%B8%AC%E8%A9%A6
    https://my.oschina.net/shelllife/blog/167914
"
    ;;
    esac
}