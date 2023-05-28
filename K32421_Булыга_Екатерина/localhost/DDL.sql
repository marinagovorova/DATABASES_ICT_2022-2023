CREATE DATABASE IF NOT EXISTS BankDatabase
    WITH
    ENCODING = 'UTF8'
    LC_COLLATE = 'Russian_Russia.1251'
    LC_CTYPE = 'Russian_Russia.1251'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

USE BankDatabase;

CREATE TABLE public.types_of_deposits (
    type_of_deposit_id bigint NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(500) NOT NULL,
    percent integer NOT NULL,
    removable boolean NOT NULL,
    refillable boolean NOT NULL,
    minimal_period interval month NOT NULL,
    initial_balance bigint DEFAULT 0,
    CONSTRAINT types_of_deposits_initial_balance_check CHECK ((initial_balance >= 0)),
    CONSTRAINT types_of_deposits_percent_check CHECK ((percent > 0)),
    CONSTRAINT types_of_deposits_percent_check2 CHECK ((percent < 100)),
    CONSTRAINT types_of_deposits_type_of_deposit_id_check CHECK ((type_of_deposit_id > 0))
);

COMMENT ON TABLE types_of_deposits IS 'Виды вкладов';
COMMENT ON COLUMN types_of_deposits.name IS 'Название';
COMMENT ON COLUMN types_of_deposits.description IS 'Описание';
COMMENT ON COLUMN types_of_deposits.percent IS 'Начисляемый процент';
COMMENT ON COLUMN types_of_deposits.removable IS 'Частичное снятие';
COMMENT ON COLUMN types_of_deposits.refillable IS 'Пополнение';
COMMENT ON COLUMN types_of_deposits.minimal_period IS 'Минимальный срок';
COMMENT ON COLUMN types_of_deposits.initial_balance IS 'Минимальная сумма';

INSERT INTO public.types_of_deposits (type_of_deposit_id, name, description, percent, removable, refillable, minimal_period, initial_balance)
VALUES (1, 'Управляй+', 'Пополняйте и снимайте деньги до неснижаемого остатка в любое время, проценты при этом сохранятся. Начисленные проценты можно снять или перечислить на карту. Если оставлять проценты на вкладе, то каждый месяц они прибавляются к общей сумме и увеличивают доход в следующих периодах.', 5, true, true, '3 mons', 30000);

INSERT INTO public.types_of_deposits (type_of_deposit_id, name, description, percent, removable, refillable, minimal_period, initial_balance) 
VALUES (2, 'Накопительный счет', 'Копите и свободно распоряжайтесь деньгами — ежемесячное начисление процентов, возможность пополнять и снимать без ограничений. Для новых пользователей повышенная ставка.', 7, true, true, '00:00:00', 0);

INSERT INTO public.types_of_deposits (type_of_deposit_id, name, description, percent, removable, refillable, minimal_period, initial_balance)
VALUES (3, 'Вклад Подари жизнь', 'Возможность помочь детям с тяжёлыми заболеваниями', 3, false, false, '1 year', 10000);