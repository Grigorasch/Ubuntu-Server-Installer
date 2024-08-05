#!/bin/bash

# Функция для отображения меню
show_menu() {
    clear
    echo "Выберите пункт меню:"
    echo "1) Пункт один"
    echo "2) Пункт два"
    echo "3) Пункт три"
    echo "4) Выход"
    read -p "Введите номер пункта (1-4): " choice
}

while true; do
    show_menu

    case $choice in
        1)
            bash пункт_один.sh
            ;;
        2)
            bash пункт_два.sh
            ;;
        3)
            bash пункт_три.sh
            ;;
        4)
            echo "Выход из программы."
            break
            ;;
        *)
            echo "Неверный выбор, пожалуйста выберите 1, 2, 3, или 4."
            ;;
    esac

    read -p "Нажмите [Enter], чтобы продолжить..." temp
done
