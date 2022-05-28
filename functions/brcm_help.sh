# help_brcm guide.
help_brcm() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} brcm [options] ...
${Yellow}Global options:${Color_Off}
	${Green}-M, model${Color_Off}
		Equivalent make PROFILE=\"$model\"
	${Green}-c, clean${Color_Off}
		Equivalent clean
	${Green}-a, all${Color_Off}
		Equivalent PROFILE=\"$model\"
	${Green}-k, kernel${Color_Off}
		Equivalent PROFILE=\"$model\" kernel
	${Green}-m, modules${Color_Off}
		Equivalent PROFILE=\"$model\" modules
	${Green}-u, userspace${Color_Off}
		Equivalent PROFILE=\"$model\" userspace
	${Green}-b, buildimage${Color_Off}
		Equivalent PROFILE=\"$model\" buildimage
"
    ;;
    esac
}