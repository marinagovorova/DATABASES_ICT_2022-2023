CREATE TABLE IF NOT EXISTS worker_position  (
    id SERIAL PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    salary INTEGER NOT NULL
);

ALTER TABLE worker_position
    ADD CONSTRAINT CK_WORKER_POSITION_SALARY CHECK (
        salary > 0
    );



CREATE TABLE IF NOT EXISTS worker  (
    id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    phone_number CHAR(12) NOT NULL,
    passport_number CHAR(10) UNIQUE NOT NULL,
    rating INTEGER DEFAULT 50,
    position_id INTEGER NOT NULL
);

ALTER TABLE worker
    ADD CONSTRAINT FK_WORKER_ON_WORKER_POSITION FOREIGN KEY (position_id)
        REFERENCES worker_position (id);

ALTER TABLE worker
    ADD CONSTRAINT CK_WORKER_RATING_RANGE CHECK (
        rating BETWEEN 1 AND 100
    );



CREATE TABLE IF NOT EXISTS shift  (
    id SERIAL PRIMARY KEY,
    time_from TIMESTAMP NOT NULL,
    time_to TIMESTAMP NOT NULL
);

ALTER TABLE shift
    ADD CONSTRAINT CK_SHIFT_DURATION CHECK (
        time_to > time_from
    );


CREATE TABLE IF NOT EXISTS  rate (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) UNIQUE NOT NULL,
    price_per_km FLOAT NOT NULL
);

ALTER TABLE rate
    ADD CONSTRAINT CK_RATE_PRICE_PER_KM CHECK (
        price_per_km > 0
    );


CREATE TABLE IF NOT EXISTS  car_type (
    id SERIAL PRIMARY KEY,
    model VARCHAR(50) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    construction_date DATE NOT NULL,
    manufacturer_country VARCHAR(30) NOT NULL,
    body VARCHAR(20) NOT NULL,
    displacement FLOAT NOT NULL,
    rate_id INTEGER NOT NULL
);

ALTER TABLE car_type
    ADD CONSTRAINT CK_CAR_TYPE_DISPLACEMENT CHECK (
        displacement > 0
    );

ALTER TABLE car_type
    ADD CONSTRAINT FK_CAR_TYPE_ON_TYPE FOREIGN KEY (rate_id)
        REFERENCES rate (id);




CREATE TABLE IF NOT EXISTS  car (
    id SERIAL PRIMARY KEY,
    government_number CHAR(9) UNIQUE NOT NULL,
    market_price INTEGER NOT NULL,
    mileage INTEGER NOT NULL,
    owner VARCHAR(30) NOT NULL,
    maintenance_date DATE NOT NULL,
    type_id INTEGER NOT NULL
);

ALTER TABLE car
    ADD CONSTRAINT CK_CAR_MARKET_PRICE CHECK (
        market_price > 0
    );

ALTER TABLE car
    ADD CONSTRAINT CK_CAR_MILEAGE CHECK (
        mileage >= 0
    );

ALTER TABLE car
    ADD CONSTRAINT FK_CAR_ON_CAR_TYPE FOREIGN KEY (type_id)
        REFERENCES car_type (id);



CREATE TABLE IF NOT EXISTS worker_shift (
    id SERIAL PRIMARY KEY,
    worker_id INTEGER NOT NULL,
    shift_id INTEGER NOT NULL,
    car_id INTEGER NOT NULL,
    start_time TIMESTAMP NOT NULL,
    status VARCHAR(9) NOT NULL
);

ALTER TABLE worker_shift
    ADD CONSTRAINT FK_WORKER_SHIFT_ON_WORKER FOREIGN KEY (worker_id)
        REFERENCES worker (id);

ALTER TABLE worker_shift
    ADD CONSTRAINT FK_WORKER_SHIFT_ON_SHIFT FOREIGN KEY (shift_id)
        REFERENCES shift (id);

ALTER TABLE worker_shift
    ADD CONSTRAINT FK_WORKER_SHIFT_ON_CAR FOREIGN KEY (car_id)
        REFERENCES car (id);



CREATE TABLE IF NOT EXISTS usr (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);


CREATE TABLE IF NOT EXISTS bank_details (
    id SERIAL PRIMARY KEY,
    card_number CHAR(16) NOT NULL,
    usr_id INTEGER NOT NULL,
    duration CHAR(5) NOT NULL,
    cvv CHAR(3) NOT NULL,
    cardholder_name VARCHAR(50) NOT NULL
);

ALTER TABLE bank_details
    ADD CONSTRAINT FK_BANK_DETAILS_ON_USR FOREIGN KEY (usr_id)
        REFERENCES usr (id);


ALTER TABLE bank_details
    ADD CONSTRAINT CK_BANK_DETAILS_DURATION CHECK (
        duration LIKE '__/__'
    );


CREATE TABLE IF NOT EXISTS  ordr (
    id SERIAL PRIMARY KEY,
    usr_id INTEGER NOT NULL,
    worker_id INTEGER NOT NULL,
    car_id INTEGER NOT NULL,
    time_start_plan TIMESTAMP NOT NULL,
    address_from VARCHAR(200) NOT NULL,
    address_to VARCHAR(200) NOT NULL,
    payment_format VARCHAR(10) NOT NULL,
    distance_km FLOAT NOT NULL,
    driver_rate INTEGER,
    usr_rate INTEGER,
    time_start_fact TIMESTAMP NOT NULL,
    time_end TIMESTAMP NOT NULL
);

ALTER TABLE ordr
    ADD CONSTRAINT FK_ORDR_ON_USR FOREIGN KEY (usr_id)
        REFERENCES usr (id);

ALTER TABLE ordr
    ADD CONSTRAINT FK_ORDR_ON_WORKER FOREIGN KEY (worker_id)
        REFERENCES worker (id);

ALTER TABLE ordr
    ADD CONSTRAINT FK_ORDR_ON_CAR FOREIGN KEY (car_id)
        REFERENCES car (id);

ALTER TABLE ordr
    ADD CONSTRAINT CK_ORDR_DISTANCE CHECK (
        distance_km > 0
    );

ALTER TABLE ordr
    ADD CONSTRAINT CK_ORDR_ENF CHECK (
        time_end > time_start_fact
    );