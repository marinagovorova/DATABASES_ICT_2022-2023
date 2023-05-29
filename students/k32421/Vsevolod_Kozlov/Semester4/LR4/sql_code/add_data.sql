insert into education(name, description)
select 'Школа № 35', 'Обычная школа, ничего необычного'
union
select 'ИТМО', 'Классный уник, очень необычно';


insert into job(name, description)
select 'Завод', 'Обычный завод для работяг'
union
select 'facebook', 'IT корпорация зла';


insert into person(name, surname, about)
select 'Всеволод',  'Козлов',  'Хороший человек'
union
select 'Иван', 'Иванов', 'Прекрасный человек';


select * from person;

insert into person_education(id_person, id_education, is_finished)
select 1, 1, TRUE
union
select 1, 2, TRUE
union
select 2, 1, TRUE
union
select 2, 2, FALSE;

insert into person_job(id_person, id_job, position)
select 1, 1, 'junior'::position_enum
union
select 1, 2, 'middle'::position_enum
union
select 2, 1, 'senior'::position_enum
union
select 2, 2, 'senior'::position_enum;


insert into person(name, surname, about)
select 'Антон',  'Безрогов',  'Разгильдяй по жизни, поэт в душе'

select * from job;

SELECT currval('person_id_person_seq');

SELECT * FROM pg_catalog.pg_sequences;

select column_name from information_schema.columns where table_name='person';

select * from person_job;