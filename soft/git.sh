echo "Установка набора основных пакетов."
apt install curl git gh wget -y

# Установка
install() {
    echo "Установка git"
    apt install git gh -y
}

# Авторизация
auth() {
    echo "авторизация на github"
    git config --global user.name "Grigorasch"
    git config --global user.email "pgv856@gmail.com"
    gh auth login
}

if [ "$1" = "-i" ]; then
    install
fi

if [ "$1" = "-a" ]; then
    auth
fi

if [ "$1" = "-h" ]; then
    help
fi

# Вызов справки
help() {
    echo "Использование:"
    echo "  -i  Установить git"
    echo "  -a  Авторизация на github"
    echo "  -h  Показать справку"
}
