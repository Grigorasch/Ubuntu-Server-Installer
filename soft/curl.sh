install() {
    echo "Установка curl"
    apt install curl -y
}

if [ "$1" = "-i" ]; then
    install
fi
