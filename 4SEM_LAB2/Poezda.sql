CREATE TABLE IF NOT EXISTS "trains_sheme"."stop"
(
    "stop_number" SERIAL PRIMARY KEY,
    "name" VARCHAR(50) NOT NULL,
	"type" VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS "trains_sheme"."passenger"
(
	"passenger_id" SERIAL PRIMARY KEY,
    "passport_data" VARCHAR(50),
	"surname" VARCHAR(50) NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "middle_name" VARCHAR(50) NOT NULL,
    "phone_number" VARCHAR(12),
    "email" VARCHAR(50)
);


CREATE TABLE IF NOT EXISTS "trains_sheme"."shedule"
(
    "route_number" SERIAL PRIMARY KEY,
	"arrival_time" TIME NOT NULL,
    "depature_time" TIME NOT NULL,
	"type" VARCHAR(50) NOT NULL,
	"periodic" VARCHAR(50) NOT NULL,
	"destination" SERIAL NOT NULL REFERENCES "trains_sheme"."stop"("stop_number"),
	"depature_point" SERIAL NOT NULL REFERENCES "trains_sheme"."stop"("stop_number")
);

CREATE TABLE IF NOT EXISTS "trains_sheme"."train"
(
    "train_number" SERIAL PRIMARY KEY,
	"on_shedule_or_not" VARCHAR(50),
	"depature_date" DATE NOT NULL,
    "arrival_date" DATE NOT NULL,
	"train_name" VARCHAR(50),
	"status" VARCHAR(50) NOT NULL,
	"route_number" SERIAL NOT NULL REFERENCES "trains_sheme"."shedule"
	CONSTRAINT check_cPol CHECK 
    	("status" IN ('success', 'failure', 'on the way', 'at the station')),
	CONSTRAINT check_date CHECK 
    	("arrival_date" >= "depature_date")
);

CREATE TABLE IF NOT EXISTS "trains_sheme"."carriage"
(
    "carriage_number" SERIAL PRIMARY KEY,
	"number_in_train" SERIAL NOT NULL,
    "type" VARCHAR(50),
	"number_of_seats" SERIAL NOT NULL,
	"train_number" SERIAL NOT NULL REFERENCES "trains_sheme"."train",
	CONSTRAINT check_type CHECK 
    	("type" IN ('coupe', 'reserved seat', 'SV', 'general', 'seated', 'soft'))
);

CREATE TABLE IF NOT EXISTS "trains_sheme"."seat"
(
    "seat_number" SERIAL PRIMARY KEY,
	"seat_number_carriage" SERIAL NOT NULL,
	"carriage_number" SERIAL NOT NULL REFERENCES "trains_sheme"."carriage",
    "status" VARCHAR(50) NOT NULL,
	CONSTRAINT check_status CHECK 
    	("status" IN ('occupied', 'reserved', 'free'))
);


CREATE TABLE IF NOT EXISTS "trains_sheme"."stop_shedule"
(
	"route_stop_number" SERIAL NOT NULL
    "route_number" SERIAL NOT NULL REFERENCES "trains_sheme"."shedule",
	"stop_number" SERIAL NOT NULL REFERENCES "trains_sheme"."stop",
    "arrival_time" TIME NOT NULL,
    "depature_time" TIME NOT NULL,
	"stop_time" TIME NOT NULL,
   	PRIMARY KEY ("route_stop_number")
);

CREATE TABLE IF NOT EXISTS "trains_sheme"."checkout"
(
    "checkout_number" SERIAL PRIMARY KEY,
	"locality" VARCHAR(50),
    "address" VARCHAR(50)
);


CREATE TABLE IF NOT EXISTS "trains_sheme"."ticket"
(
	"ticket_id" SERIAL PRIMARY KEY,
    "passenger_id" SERIAL NOT NULL REFERENCES "trains_sheme"."passenger",
	"destination" SERIAL NOT NULL REFERENCES "trains_sheme"."stop"("stop_number"),
	"depature_point" SERIAL NOT NULL REFERENCES "trains_sheme"."stop"("stop_number"),
    "seat_number" SERIAL NOT NULL REFERENCES "trains_sheme"."seat",
    "status" VARCHAR(50) NOT NULL,
    "price" SERIAL NOT NULL,
    "in_checkout_or_not" VARCHAR(50) NOT NULL,
	"checkout_number" SERIAL NOT NULL REFERENCES "trains_sheme"."checkout",
	CONSTRAINT check_status CHECK 
    	("status" IN ('paid', 'back', 'changed')),
	CONSTRAINT check_in_or CHECK 
    	("in_checkout_or_not" IN ('yes', 'no'))
);

INSERT INTO "trains_sheme"."stop" ("stop_number", "name", "type")
VALUES
('04', 'Vasilkovka', 'village'),
('09', 'Zalezhnoe', 'PGT'),
('117', 'Novoe', 'town'),
('29', 'Gribanovka', 'village'),
('114', 'Visokiy Bor', 'town');


INSERT INTO "trains_sheme"."passenger" ("passenger_id", "passport_data", "surname",
										"name", "middle_name", "phone_number", "email")
VALUES 
('02', '7777860245', 'Komarov', 'Alexander', 'Viktorovich', '89234523782', 'vasilov@mail.ru'),
('08', '7627860245', 'Vasiliev', 'Aleksei', 'Ivanovich', '89234523782', 'vasiliev@mail.ru'),
('17', '1884567890', 'Ivanova', 'Mariya', 'Sergeevna', '89123456789', 'ivanova@mail.ru'),
('20', '5345238901', 'Petrov', 'Dmitrii', 'Andreevich', '89234567890', 'petrov@mail.ru'),
('56', '98456721012', 'Smirnova', 'Elena', 'Aleksandrovna', '89345678901', 'smirnova@mail.ru'),
('40', '7467890663', 'Kuznetsov', 'Ivan', 'Pavlovich', '89456789012', 'kuznetsov@mail.ru');

INSERT INTO "trains_sheme"."shedule" ("route_number", "arrival_time", "depature_time",
									  "type", "periodic", "destination", "depature_point")
VALUES 
('18', '18:53', '10:20', 'EL', 'Per Day', '04', '09'),
('23', '09:45', '17:15', 'EL', 'Per Day', '09', '04'),
('17', '14:30', '20:10', 'EL', 'Per 2 Days', '114', '117'),
('15', '07:20', '11:10', 'EL', 'Per 2 Days', '117', '09'),
('32', '12:00', '16:40', 'EL', 'Per Day', '114', '29'),
('21', '08:40', '13:10', 'EL', 'Per Day', '04', '29');

INSERT INTO "trains_sheme"."train" ("train_number", "on_shedule_or_not", "depature_date",
									"arrival_date", "train_name", "status", "route_number")
VALUES
('03', '1', '19/02/2023', '20/02/2023', 'DR189', 'success', '18'),
('08', '1', '25/01/2022', '25/01/2023', 'DR189', 'success', '18'),
('02', '1', '05/12/2022', '05/12/2022', 'DR104', 'success', '21'),
('05', '1', '21/02/2023', '21/02/2023', 'DR805', 'failure', '15'),
('11', '1', '30/01/2023', '30/01/2023', 'DDR464', 'success', '23'),
('06', '1', '14/11/2022', '14/11/2022', 'DDR785', 'success', '32');


INSERT INTO "trains_sheme"."carriage" ("carriage_number", "number_in_train",
									   "type", "number_of_seats", "train_number")
VALUES
('01', '1', 'coupe', '30', '03'),
('12', '4', 'reserved seat', '60', '08'),
('07', '2', 'reserved seat', '60', '03'),
('23', '5', 'general', '80', '11'),
('09', '1', 'coupe', '30', '02');
									
INSERT INTO "trains_sheme"."seat" ("seat_number", "seat_number_carriage",
								   "carriage_number", "status")
VALUES
('15', '07', '01', 'free'),
('457', '12', '23', 'occupied'),
('800', '13', '07', 'occupied'),
('98', '17', '23', 'free'),
('114', '04', '01', 'occupied');



