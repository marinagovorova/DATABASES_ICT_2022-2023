delete from watering_schedule;
delete from user_plant;
delete from plant;
delete from  plantuser;




insert into plantuser(user_id, user_name, user_surname)
values
(0, 'Anton', 'Pupkin'),
(1, 'Vasy',  'Antonov');

insert into plant(plant_id, plant_name)
values
(0, 'Lily'),
(1, 'Iris'),
(2, 'Rose');

insert into user_plant(user_plant_id, user_id, plant_id)
values
(0, 0, 0),
(1, 0, 1),
(2, 1, 2);

insert into watering_schedule(watering_id, user_plant_id, watering_time)
values
(0, 0, '2023-09-01 10:00:00'),
(1, 0, '2023-09-01 12:00:00'),
(2, 1, '2023-09-01 10:00:00'),
(3, 1, '2023-09-01 12:00:00'),
(4, 2, '2023-09-02 8:00:00'),
(5, 2, '2023-09-02 9:00:00');


select user_name, user_surname from plantuser where user_id=0