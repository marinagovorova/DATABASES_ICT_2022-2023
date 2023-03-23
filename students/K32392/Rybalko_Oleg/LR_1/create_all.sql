-- TYPES
CREATE TYPE ВидАттестации AS ENUM ('зачет', 'экзамен', 'дифференцируемый зачет');
CREATE TYPE ТипАудитории AS ENUM ('лекционная', 'лаборатория', 'класс');
CREATE TYPE ВидЗанятия AS ENUM ('лабораторное', 'лекционное', 'классное');

-- TABLES
CREATE TABLE ОбразовательнаяПрограмма (
    Код INTEGER PRIMARY KEY,
    Название TEXT NOT NULL,
    ОбъемЧасов INTEGER NOT NULL,
    Тип TEXT NOT NULL,
    Описание TEXT
);

CREATE TABLE Подразделение (
    Код INTEGER PRIMARY KEY,
    Название TEXT NOT NULL,
    КодОбразовательнойПрограммы INTEGER NOT NULL,
    Описание TEXT,
    CONSTRAINT fk_КодОбразовательнойПрограммы 
        FOREIGN KEY(КодОбразовательнойПрограммы) 
            REFERENCES ОбразовательнаяПрограмма(Код)
);

CREATE TABLE Программа (
    Идентификатор INTEGER PRIMARY KEY,
    Цена NUMERIC NOT NULL,
    КодПодразделения INTEGER NOT NULL,
    CONSTRAINT fk_КодПодразделения 
        FOREIGN KEY(КодПодразделения) 
            REFERENCES Подразделение(Код)
);

CREATE TABLE НаборНаПрограмму (
    Код INTEGER PRIMARY KEY,
    ДатаНачала DATE NOT NULL,
    ДатаОкончания DATE NOT NULL,
    Цена NUMERIC NOT NULL,
    ИдентификаторПрограммы INTEGER NOT NULL,
    CONSTRAINT fk_ИдентификаторПрограммы 
        FOREIGN KEY (ИдентификаторПрограммы)
            REFERENCES Программа(Идентификатор)  
);

CREATE TABLE Группа (
    Идентификатор SERIAL PRIMARY KEY,
    Номер INTEGER NOT NULL,
    МаксКоличествоЧеловек INTEGER,
    КодНабора INTEGER NOT NULL,
    CONSTRAINT fk_КодНабора
        FOREIGN KEY (КодНабора)
            REFERENCES НаборНаПрограмму(Код)
);

CREATE TABLE Площадка (
    Идентификатор INTEGER PRIMARY KEY,
    Адрес TEXT NOT NULL,
    Название TEXT,
    КодПодразделения INTEGER NOT NULL,
    CONSTRAINT fk_КодПодразделения
        FOREIGN KEY (КодПодразделения)
            REFERENCES Подразделение(Код)
);

CREATE TABLE Слушатель (
    НомерПаспорта INTEGER PRIMARY KEY,
    СерияПаспорта INTEGER NOT NULL,
    Имя TEXT NOT NULL,
    Фамилия TEXT NOT NULL,
    НомерТелефона TEXT,
    ЭлектроннаяПочта TEXT
);

CREATE TABLE Обучается (
    Идентификатор INTEGER PRIMARY KEY,
    ИдентификаторГруппы INTEGER NOT NULL,
    ДатаНачалаОбучения DATE NOT NULL,
    ДатаОкончанияОбучения DATE NOT NULL, 
    Статус TEXT NOT NULL,
    ИдентификаторСлушателя INTEGER NOT NULL,
    CONSTRAINT fk_ИдентификаторГруппы
        FOREIGN KEY (ИдентификаторГруппы)
            REFERENCES Группа(Идентификатор),
    CONSTRAINT fk_ИдентификаторСлушателя
        FOREIGN KEY (ИдентификаторСлушателя)
            REFERENCES Слушатель(НомерПаспорта)
);

CREATE TABLE Аудитория (
    Номер INTEGER,
    ИдентификаторПлощадки INTEGER NOT NULL,
    ТИП ТипАудитории,
    CONSTRAINT pk_НомерАудиторииНаПлощадке
        PRIMARY KEY (Номер, ИдентификаторПлощадки),
    CONSTRAINT fk_ИдентификаторПлощадки
        FOREIGN KEY (ИдентификаторПлощадки)
            REFERENCES Площадка(Идентификатор)
);

CREATE TABLE Дисциплина (
    Идентификатор INTEGER PRIMARY KEY,
    Название TEXT NOT NULL,
    ВидАттестации ВидАттестации,
    КоличествоЧасов INTEGER NULL CHECK (КоличествоЧасов >= 0),
    КоличествоЛекций INTEGER NOT NULL CHECK (КоличествоЛекций >= 0),
    КоличествоПрактик INTEGER NOT NULL CHECK (КоличествоПрактик >= 0),
    КоличествоЛаб INTEGER NOT NULL CHECK (КоличествоЛаб >= 0)
);

CREATE TABLE ДисциплинаНаПрограмме (
    Идентификатор INTEGER PRIMARY KEY,
    ИдентификаторПрограммы INTEGER NOT NULL,
    ИдентификаторДисциплины INTEGER NOT NULL,
    CONSTRAINT fk_ИдентификаторПрограммы 
        FOREIGN KEY (ИдентификаторПрограммы)
            REFERENCES Программа(Идентификатор),
    CONSTRAINT fk_ИдентификаторДисциплины
        FOREIGN KEY (ИдентификаторДисциплины)
            REFERENCES Дисциплина(Идентификатор)
);

CREATE TABLE Преподаватель (
    Идентификатор SERIAL PRIMARY KEY,
    Имя TEXT NOT NULL,
    Отчество TEXT,
    Должность TEXT NOT NULL
);

CREATE TABLE Занятие (
    Идентификатор SERIAL PRIMARY KEY,
    ИдентификаторДисципНаПрог INTEGER NOT NULL,
    ИдентификаторПреподавателя INTEGER NOT NULL,
    ИдентификаторГруппы INTEGER NOT NULL,
    НомерПары INTEGER NOT NULL CHECK (НомерПары > 0 AND НомерПары < 9),
    Вид ВидЗанятия NOT NULL,
    ДатаПроведения TIMESTAMP NOT NULL,

    CONSTRAINT fk_ИдентификаторДисципНаПрог
        FOREIGN KEY (ИдентификаторДисципНаПрог)
            REFERENCES ДисциплинаНаПрограмме(Идентификатор),
    CONSTRAINT fk_ИдентификаторПреподавателя 
        FOREIGN KEY (ИдентификаторПреподавателя)
            REFERENCES Преподаватель(Идентификатор),
    CONSTRAINT fk_ИдентификаторГруппы
        FOREIGN KEY (ИдентификаторГруппы)
            REFERENCES Группа(Идентификатор)
);