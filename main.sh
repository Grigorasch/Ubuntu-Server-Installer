# Обновление пакетов
read -p "Выполнить обновление пакетов? ([y]/n): " update_choice
if [[ -z "$update_choice" ]]; then
    update_choice="y"
fi
if [[ "$update_choice" == "y" ]]; then
    echo "Обновление списка пакетов и сами пакеты."
    apt update && apt upgrade -y
fi


# Функция для отображения меню
show_menu() {
    clear
    echo "Выберите дальнейшее действие:"
    echo "1) Установить базовые программы"
    echo "e) Выход"
    read -p "Введите номер пункта: " choice
}

while true; do
    show_menu
    case $choice in
        1)
            echo "Будут установлены следующие программы:"
            echo "Curl"
            echo "Git"
            echo "GH"
            echo "Нажмите [Enter] для продолжения..."
            read -p "" temp
            
            bash ~/newsrv/soft/curl.sh -i
            bash ~/newsrv/soft/git.sh -i
            bash ~/newsrv/soft/git.sh -a
            ;;
        e)
            echo "Выход из программы."
            break
            ;;
        *)
            echo "Неверный выбор, пожалуйста выберите 1, 2, 3, или 4."
            ;;
    esac
    read -p "Нажмите [Enter], чтобы продолжить..." temp
done
