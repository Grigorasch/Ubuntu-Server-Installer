# Энциклопедия 

    Инструкцияя проверена на Ubuntu 22.04.
    Вначале каждого раздела по установке и настройке есть код обозначенный термином *pipeline* который обозначает единую команду выполняющую все шаги поочередно.

> ## **Оглавление**
> * [**Первоначальная настройка сервера**](#setup)
> * [**Настройка Nodejs**](#nodejs)
> * [**Настройка PM2**](#pm2)
> * **Настройка БД**
> * * [**Настройка MongoDB Server**](#mongodb)
> * * [**Настройка MySQL**](#mysql)
---

# Первоначальная настройка сервера [#setup]

> ### **pipeline**
> ```bash
>  apt update && apt upgrade -y && \
>  apt install curl -y && \
>  apt install git gh -y && \
>  git config --global user.name "Grigorasch"  && \
>  git config --global user.email "pgv856@gmail.com"  && \
>  gh auth login
> ```
---

## Первоначальная установка
- В первую очередь необходимо обновить перечень пакетов и сами пакеты
```bash
apt update && apt upgrade -y
```
- Установить программы первой необходимости:
- 1) Установка curl
     ```bash
     apt install curl -y
     ```
- 1) Установка git
     ```bash
      apt install git gh -y && \
      git config --global user.name "Grigorasch"  && \
      git config --global user.email "pgv856@gmail.com"  && \
      gh auth login
     ```

---


##  Перечень установки
1. [**Node.js**](#nodejs)
2. [**MongoDB Server**](#mongodb)
3. [**MySQL**](#mysql)

## Инструкции по установке и настройке программ

Перед началом установки необходимо обязательно обновить список пакетов и
установить доступные обновления пакетов.

```bash
apt update && apt upgrade
```
---

# **Node.js [#nodejs]**

> Актуальную инструкцию по установке последней версии Node.js смотри
> в [репозитории Git](https://github.com/nodesource/distributions)

1. Прежде чем начать, убедитесь, что в вашей системе установлен curl. Если curl не установлен, вы можете установить его с помощью следующей команды:

```bash
sudo apt-get install -y curl
```

2. Загрузите сценарий установки:

```bash
curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
```

3. Запустите сценарий установки с помощью sudo:

```bash
sudo -E bash nodesource_setup.sh
```

4. Установить Node.js:

```bash
sudo apt-get install -y nodejs
```

5. Проверьте установку:

```bash
node -v
```

---
> ### **pipeline**
> ```bash
>  curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh && \
>  sudo -E bash nodesource_setup.sh && \
>  sudo apt-get install -y nodejs  && \
>  node -v 
> ```
---

# **MongoDB Server [#mongodb]**

> Настройка сервера включает в себя следующие разделы   
> 1. [**Установка MongoDB Server**](#setupdb)
> 1. [**Запуск MongoDB**](#startdb)
> 1. [**Создание базы данных**](#createdb)
> 1. [**Создание пользователей**](#usersdb)
> 1. [**Настройки безопасности**](#securedb)
> 1. [**Настройка IP адреса и порта**](#netdb)

### **Установка MongoDB Server {#setupdb}**

> Актуальную инструкцию по установке MongoDB смотри на
> [оффициальном сайте](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/)

1. Для настройки необходимо чтобы в вашей системе были установлены gnupg и curl.
Установить их можно при помощи следующей команды.

```bash
sudo apt-get install gnupg curl
```

2. Импортируйте открытый ключ, используемый системой управления пакетами
Чтобы импортировать открытый GPG-ключ MongoDB, выполните следующую команду:

```bash
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
--dearmor
```

3. Создайте файл списка для MongoDB. Для Ubuntu 22.04 (Jammy) создайте
/etc/apt/sources.list.d/mongodb-org-7.0.list

```bash
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
```

4. Перезагрузите локальную базу данных пакетов. Выполните следующую команду для
перезагрузки локальной базы данных пакетов:

```bash
sudo apt-get update
```

5. Установите пакеты

```bash
sudo apt-get install -y mongodb-org
```
6. Автозапуск MongoDB после перезагрузки вклчается следующей командой

```bash
sudo systemctl enable mongod
```

7. Необязательно. Хотя вы можете указать любую доступную версию MongoDB, apt-get пакеты будут обновлены, когда станет доступна более новая версия. Чтобы предотвратить непреднамеренные обновления, вы можете закрепить пакет на текущей установленной версии.:

```bash
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-database hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-mongosh hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections
```

### **Запуск MongoDB {#startdb}**

1. Запуск MongoDB.

```bash
sudo systemctl start mongod
```

2. Проверка состояния MongoDB.

```bash
sudo systemctl status mongod
```

3. Остановка MongoDB.

```bash
sudo systemctl stop mongod
```

4. Перезапуск MongoDB.

```bash
sudo systemctl restart mongod
```

5. Начните использовать MongoDB. Запустите mongosh сеанс на том же хост-компьютере,
что и mongod. Вы можете запустить mongosh без каких-либо параметров командной
строки для подключения к amongod, который запущен на вашем локальном хостинге с
портом по умолчанию 27017.

```bash
mongosh
```

### **Создание базы данных {#createdb}**

База данных состоит из следующих коллекций:

1. ***users*** - коллекция состоит из документов, каждый из которых содержит
информацию о пользователе.

2. ***comics*** - каждый документ коллекции содержит полную информацию о комиксе,
сам комикс, как завершенное издание, а так же все данные накопленные в ходе его
разработки.

Создание базы данных и вышеописанных колекций выполняется при помощи следующих
команд

```js
use comic-box;
db.createCollection("users", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name", "email", "password"],
      properties: {
        name: {
          bsonType: "string",
          minLength: 3,
          description: "Должно быть строкой и содержать не менее 3х символов"
        },
        email: {
          bsonType: "string",
          minLength: 1,
          description: "Должно быть строкой ненулевой длины"
        },
        password: {
          bsonType: "string",
          minLength: 1,
          description: "Должно быть строкой ненулевой длины"
        }
      }
    }
  }
});
db.users.createIndex({ email: 1 }, { unique: true });
db.createCollection("comics", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["title", "description", "cover", "story", "price", "rate"],
      properties: {
        title: {
          bsonType: "string",
          minLength: 3,
          description: "Должно быть строкой и содержать не менее 3 символов"
        },
        description: {
          bsonType: "string",
          minLength: 1,
          maxLength: 2000,
          description: "Должно быть строкой ненулевой длины и не более 2000 символов"
        },
        cover: {
          bsonType: "binData",
          description: "Должно быть файлом картинки"
        },
        story: {
          bsonType: "object",
          description: "Должно быть объектом"
        },
        price: {
          bsonType: "double",
          minimum: 0.00,
          description: "Должно быть числом с двумя цифрами после запятой и минимум 0.00"
        },
        rate: {
          bsonType: "double",
          minimum: 0.0,
          maximum: 5.0,
          description: "Должно быть числом с плавающей точкой от 0 до 5"
        }
      }
    }
  }
});
db.comics.createIndex({ title: 1 });
```

### **Создание пользователей {#usersdb}**

Предоставляется три пользователя. Суперпользователь нужен для полной настройки
базы. Сервер используется при общении сервера с базой данных и имеет права только
на чтение и запись документов в коллекции. Админ нужен для администрирования базы.

```js
use admin
db.createUser(
  {
    user: "rootUser",
    pwd: "rootpass",
    roles: [
       { role: "root", db: "admin" }
    ]
  }
);
db.createUser(
  {
    user: "server",
    pwd: "serverpass",
    roles: [
       { role: "readWrite", db: "comic-box" }
    ]
  }
);
db.createUser(
  {
    user: "admin",
    pwd: "adminpass",
    roles: [
       { role: "dbAdmin", db: "comic-box" }
    ]
  }
);
```

### **Настройки безопасности {#securedb}**

1. Для включения авторизации необходимо отредактировать файл конфигураций

```bash
vim /etc/mongod.conf
```

2. В разделе *security* добавить строку

```
security:
  authorization: enabled
```

3. Подключение к базе данных возможно только при вводе правильного пользователя
и пароля

```bash
mongosh -u "rootUser" -p
```

### **Настройка IP адреса и порта {#netdb}**

1. IP адресс сервера и порт необходимо установить в файле конфигурации. Открыть
файл конфигуации можно командой

```bash
vim /etc/mongod.conf
```

2. В разделе сетевого интерфейса указываются следующие данные:

```
# network interfaces
net:
  port: 20724
  bindIp: 188.130.154.236
```

3. Подключение к базе данных выполняется с указанием адреса и порта сервера

```bash
mongosh mongodb://188.130.154.236:20724 -u "server" -p
```

---

# **MySQL** [#mysql]

- Установка БД выполняется путем выполнения команды:

```bash
sudo apt install mysql-server mysql-client
```

# **PM2** [#pm2]

    Для установки менеджера процессов PM2 необходима предварительная установка Nodejs

1. Установка PM2 глобально
```bash
npm install pm2 -g
```

2. Запуск приложения
```bash
pm2 start add.js
```
  * Сохранение стандартного вывода/логов/ошибок в файл
  ```bash
  pm2 start add.js  --output out.log --log log.txt --error err.log
  ```

  * Для вывода журнала на экран
  ```bash
  pm2 logs
  pm2 logs APP-NAME # Вывод журнала только приложения APP-NAME
  ```

  * Отправка команды приложению
  ```bash
  pm2 send your-app "command"  # Отправка одиночной команды
  pm2 attach your-app          # Отправка всех последующих команд 
                               # приложению. Ctrl+C чтобы прекратить
  ```

3. Вывести перечень запущенных приложений
```bash
pm2 list
```

4. Остановка выполнения приложения
```bash
pm2 stop [id]    # Остановка приложения
pm2 delete [id]  # Остановить и удалить приложение из списка PM2
```

5. Перезапуск приложения
```bash
pm2 restart api    # Перезапуск приложения
pm2 restart app1 app3 app4    # Перезапуск нескольких приложений
```