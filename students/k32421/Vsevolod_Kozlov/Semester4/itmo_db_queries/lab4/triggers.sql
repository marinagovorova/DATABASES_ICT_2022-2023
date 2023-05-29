create type cud_operation as enum('update', 'insert', 'delete');

-- Создание таблицы для логов
create table subdivision_logs(
    id_log serial primary key,
    operation_type cud_operation not null,
    operation_time timestamp without time zone,
    affected_id_subdivision int null,
    affected_subdivision_name text null
);

drop table subdivision_logs;

select * from subdivisions;

-- Создание метода для триггера
CREATE OR REPLACE FUNCTION subdivision_add_to_log() RETURNS TRIGGER AS $$
DECLARE
    var_operation_type cud_operation;
BEGIN
    IF  TG_OP = 'INSERT' THEN
        var_operation_type := 'insert';
        insert into
            subdivision_logs(operation_type, operation_time, affected_id_subdivision, affected_subdivision_name)
        VALUES
            (var_operation_type, now(), new.id_subdivision, new.name);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        var_operation_type := 'update';
        insert into
            subdivision_logs(operation_type, operation_time, affected_id_subdivision, affected_subdivision_name)
        VALUES
            (var_operation_type, now(), old.id_subdivision, old.name);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        var_operation_type := 'delete';
        insert into
            subdivision_logs(operation_type, operation_time, affected_id_subdivision, affected_subdivision_name)
        VALUES
            (var_operation_type, now(), old.id_subdivision, old.name);
        RETURN OLD;
    END IF;
END
$$ LANGUAGE plpgsql;


-- Создание триггера
create trigger log_trigger
    after insert or update or delete on subdivisions
    for each row execute procedure subdivision_add_to_log();

drop trigger log_trigger on subdivisions;

update subdivisions
set
    name = 'fancy name'
where id_subdivision=9;


update subdivisions
set
    name = 'name 9'
where id_subdivision=9;


insert into subdivisions(name, headquarter_address, type) values
    ('new subdivision', 'new address', 'основной');



select * from subdivision_logs;

delete from subdivisions where id_subdivision = 11;


-- Метод для триггера
create or replace function check_study_course() returns trigger as
$$
declare
    var_id_study_courses int[];
begin
    select array_agg(id_study_course) into var_id_study_courses from study_courses
    where id_study_plan =
      (select id_study_plan from groups where id_group =
        (select id_group from student_groups where id_group_row=new.id_group_row));

    if new.id_study_course <> any(var_id_study_courses) then
        raise EXCEPTION 'Нет такого учебного курса в учебном плане группы';
    end if;

    return new;
end
$$ language plpgsql;
-- Создание триггера
create trigger study_course_trigger
    before insert on record_book
    for each row execute procedure check_study_course();



select * from record_book;

insert into record_book(id_group_row, id_teacher, id_study_course, mark, try_number)
VALUES (0, 10, 10, 5, 1);





delete from record_book where id_row_record_book =