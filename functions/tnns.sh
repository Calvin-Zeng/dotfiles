# tnns extra commands.
tnns() {
    case $1 in
    -g|generate)
        shift
        openssl genrsa -aes256 -passout pass:"$1" -out private.pem "$2"
        openssl rsa -in private.pem -passin pass:"$1" -pubout -out public.pem
        openssl req -x509 -new -days 100000 -key private.pem -passin pass:"$1" -out certificate.pem -subj "/C=US/ST=Utah/L=Hello/O=The Night Night Show, Inc./OU=IT/CN=yourdomain.com"
        # Display x509 certifivate info.
        openssl x509 -in certificate.pem -text
        openssl x509 -pubkey -noout -in certificate.pem
        ;;
    -e|encrypt)
        shift
        openssl smime -encrypt -binary -aes-256-cbc -in "$1" -out "$1".tar -outform DER "$2"
        ;;
    -d|decrypt)
        shift
        openssl smime -decrypt -binary -in "$1" -inform DER -out "$2" -inkey "$3" -passin pass:"$4"
        ;;
    esac
}
