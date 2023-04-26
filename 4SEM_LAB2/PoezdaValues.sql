-- Insert data into stop table
INSERT INTO "trains_sheme"."stop"("stop_number", "name", "type")
VALUES (1, 'CHL', 'city'),
       (2, 'MSC', 'city'),
       (3, 'SPB', 'city'),
       (8, 'EKB', 'city'),
       (5, 'ROS', 'city'),
       (6, 'NSB', 'city'),
       (7, 'KUR', 'town');

-- Insert data into passenger table
INSERT INTO "trains_sheme"."passenger"("passenger_id", "passport_data", "surname", "name", "middle_name", "phone_number", "email")
VALUES (1, '1234567890', 'Ivanov', 'Ivan', 'Ivanovich', '+79991234567', 'ivanov@example.com'),
       (9, '2345678901', 'Petrov', 'Petr', 'Petrovich', '+79992345678', 'petrov@example.com'),
       (3, '3456789012', 'Sidorov', 'Sergey', 'Sergeevich', '+79993456789', 'sidorov@example.com'),
       (4, '4567890123', 'Smirnov', 'Alexey', 'Alexeevich', '+79994567890', 'smirnov@example.com'),
       (5, '5678901234', 'Kuznetsov', 'Dmitry', 'Dmitrievich', '+79995678901', 'kuznetsov@example.com'),
       (6, '6789012345', 'Popov', 'Andrey', 'Andreevich', '+79996789012', 'popov@example.com'),
       (7, '7890123456', 'Vasiliev', 'Vasiliy', 'Vasilievich', '+79997890123', 'vasiliev@example.com');

-- Insert data into shedule table
INSERT INTO "trains_sheme"."shedule"("route_number", "arrival_time", "depature_time", "type", "periodic", "destination", "depature_point")
VALUES (1, '12:00:00', '12:10:00', 'express', 'daily', 2, 5),
       (2, '13:00:00', '13:10:00', 'express', 'daily', 5, 3),
       (3, '14:00:00', '14:10:00', 'local', 'daily', 6, 3),
       (4, '15:00:00', '15:10:00', 'local', 'daily', 2, 6),
       (5, '16:00:00', '16:10:00', 'regional', 'daily', 7, 2),
       (6, '17:00:00', '17:10:00', 'regional', 'daily', 2, 7),
       (7, '18:00:00', '18:10:00', 'express', 'daily', 2, 3);

-- Insert data into train table
INSERT INTO "trains_sheme"."train"("train_number", "on_shedule_or_not", "depature_date", "arrival_date", "train_name", "status", "route_number")
VALUES (1, 'yes', '2023-04-25', '2023-04-25', 'Train 1', 'success', 1),
       (9, 'yes', '2023-04-25', '2023-04-25', 'Train 2', 'success', 2),
       (10, 'yes', '2023-04-26', '2023-04-27', 'Train 3', 'success', 3),
       (4, 'yes', '2023-04-26', '2023-04-27', 'Train 4', 'success', 4),
       (21, 'yes', '2023-04-26', '2023-04-26', 'Train 5', 'success', 5),
       (16, 'yes', '2023-04-26', '2023-04-26', 'Train 6', 'success', 6),
       (7, 'yes', '2023-04-25', '2023-04-25', 'Train 7', 'success', 7);

-- Insert data into carriage table
INSERT INTO "trains_sheme"."carriage"("carriage_number", "number_in_train", "type", "number_of_seats", "train_number")
VALUES (8, 1, 'coupe', 18, 1),
       (2, 2, 'reserved seat', 54, 1),
       (3, 1, 'SV', 10, 2),
       (4, 2, 'general', 60, 2),
       (5, 1, 'seated', 60, 3),
       (6, 2, 'soft', 20, 3),
       (10, 1, 'coupe', 18, 4);

-- Insert data into seat table
INSERT INTO "trains_sheme"."seat"("seat_number", "seat_number_carriage", "carriage_number", "status")
VALUES (1, 1, 1, 'occupied'),
       (2, 2, 1, 'free'),
       (3, 3, 1, 'reserved'),
       (4, 1, 2, 'occupied'),
       (5, 2, 2, 'free'),
       (6, 1, 3, 'occupied'),
       (7, 2, 3, 'free');

-- Insert data into stop_shedule table
INSERT INTO "trains_sheme"."stop_shedule"("route_number", "stop_number", "arrival_time", "depature_time", "stop_time")
VALUES (1, 1, '12:00:00', '12:10:00', '00:10:00'),
       (1, 3, '12:30:00', '12:40:00', '00:10:00'),
       (1, 5, '13:00:00', '13:10:00', '00:10:00'),
       (1, 7, '13:30:00', '13:40:00', '00:10:00'),
       (2, 1, '13:00:00', '13:10:00', '00:10:00'),
       (2, 4, '13:30:00', '13:40:00', '00:10:00'),
       (2, 6, '14:00:00', '14:10:00', '00:10:00');

-- Insert data into checkout table
INSERT INTO "trains_sheme"."checkout"("checkout_number", "locality", "address")
VALUES (1, 'City1', 'Address1'),
       (2, 'City2', 'Address2'),
       (3, 'City3', 'Address3'),
       (4, 'City4', 'Address4'),
       (5, 'City5', 'Address5'),
       (6, 'City6', 'Address6'),
       (7, 'City7', 'Address7');

-- Insert data into ticket table
INSERT INTO "trains_sheme"."ticket"("passenger_id", "destination", "depature_point", "seat_number", "status", "price", "in_checkout_or_not", "checkout_number")
VALUES (1, 2, 1, 1, 'paid', 1000, 'yes', 1),
       (3, 2, 1, 2, 'back', 1500, 'no', 2),
       (3, 2, 1, 3, 'changed', 2000, 'yes', 3),
       (4, 2, 1, 4, 'paid', 2500, 'no', 4),
       (5, 2, 1, 5, 'back', 3000, 'yes', 5),
       (6, 2, 1, 6, 'changed', 3500, 'no', 6),
       (7, 2, 1, 7, 'paid', 4000, 'yes', 7);
