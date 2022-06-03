# help_gpg guide.
help_gpg() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} gpg [options] ...
${Yellow}Global options:${Color_Off}
	${Green}list${Color_Off}
		Listing GPG public/secret key.
	${Green}-g, generate${Color_Off}
		Generate GPG key.
	${Green}-e, edit${Color_Off}
		Edit GPG key.
	${Green}-d, delete${Color_Off}
		Delete GPG key.
	${Green}-i, import${Color_Off}
		Import GPG key.
	${Green}-s, sign${Color_Off}
		Sign GPG key.
	${Green}-e, export${Color_Off}
		-p, pub
			Export GPG public key.
		-s, sec
			Export GPG secret key.

    - ${Green} Sign GPG public key with specific GPG private key. ${Color_Off}
    ${Yellow} gpg --default-key 48A42CD69D73F230ACA720821C33B8A5C61085EE --edit-key 301B76C11C6D0D4AF4222FC6E06566C8DEF6BE6B ${Color_Off}
"
    ;;
    esac
}