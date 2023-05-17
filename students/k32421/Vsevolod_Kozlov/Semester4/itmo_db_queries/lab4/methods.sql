




-- Для повышении стипендии отличникам на 10%

-- У меня нет отдельной стипендии для отличников, поэтому повышу социальную стипендию на 10%
create or replace function increase_social_scholarship()
returns void as
$$
declare
    prev_amount int;
    scholarship_name text;
begin
    scholarship_name := 'социальная имя';
    select money_amount into prev_amount
    from scholarships
    where name=scholarship_name;
    update scholarships
    set
        money_amount = prev_amount * 1.1
    where
        name = scholarship_name;
end;
$$ language plpgsql;


select from increase_social_scholarship();

select * from scholarships;

-- Для перевода студентов на следующий курс

-- Так как у меня нет курса студента, а есть только история групп студента, то вместо перевода на курс я реализую добавления новой группы в историю групп, что аналогично повышению курса студента, ведь каждая группа привязана к курсу
create or replace function
    plus_course(id_record_book_inp int, id_new_group_inp int)
returns void as
$$
    declare
        current_course int;
        new_group_course int;
    begin
        select max(course) into current_course from groups
        where id_group in
              (select id_group from student_groups where id_record_book=id_record_book_inp);

        select course into new_group_course from groups
        where id_group = id_new_group_inp;

        if new_group_course <> current_course+1 then
            raise exception 'new course of group is not larger than current course of group by one';
        end if;

        insert into student_groups(id_record_book, id_group)
        values (id_record_book_inp, id_new_group_inp);
    end;
$$ language plpgsql;


select * from student_groups;

select  * from student_groups where id_record_book=20;

select * from groups;

select plus_course(20, 5);





CREATE OR REPLACE FUNCTION reset_serial_sequences() RETURNS void AS $$
DECLARE
    name_of_table text;
    name_of_column text;
    sequence_name text;
    max_value bigint;
BEGIN
    FOR name_of_table, name_of_column IN
        SELECT table_name, column_name FROM information_schema.columns
        WHERE column_default LIKE 'nextval%'
    LOOP
        sequence_name := pg_get_serial_sequence(name_of_table, name_of_column);

        if name_of_column is not null then
            EXECUTE format('SELECT max(%I) FROM %I', name_of_column, name_of_table) INTO max_value;

            EXECUTE format('SELECT setval(%L, %s)', sequence_name, max_value + 1);
        end if;

    END LOOP;
END;
$$ LANGUAGE plpgsql;


select reset_serial_sequences();

select  setval('public.subdivision_id_subdivision_seq', 1);

select * from information_schema.columns;



SELECT pg_get_serial_sequence('subdivisions', 'id_subdivision');


-- Для изменения оценки при успешной пересдаче экзамена

select * from scholarships;

create or replace function change_mark(input_id_study_course int, input_id_group_row int, new_mark int) returns void as
$$
    DECLARE
        last_try_number int;
        var_id_teacher int;
    begin
        select max(try_number) into last_try_number from record_book
        where
            id_study_course = input_id_study_course and
            id_group_row = input_id_group_row;

        select id_teacher into var_id_teacher from record_book
        where
            id_study_course = input_id_study_course and
            id_group_row = input_id_group_row and
            try_number=last_try_number;

        if last_try_number = 3 then
            raise exception 'Невозможно пересдать экзамен, так как были использованы все попытки';
        end if;

        insert into record_book(id_group_row, id_teacher, id_study_course, mark, try_number)
        values (input_id_group_row, var_id_teacher, input_id_study_course, new_mark, last_try_number+1);
    end;
$$ language plpgsql;


select * from record_book
where
    try_number = 3;

select * from record_book
where
    id_group_row = 0 and
    id_study_course = 2;


select change_mark(2, 0, 5);




