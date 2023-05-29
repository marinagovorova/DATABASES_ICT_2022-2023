create or replace function get_students()
returns setof students as $$
    select * from students;
$$ language sql;


select hello();

select * from get_students();


create or replace function get_groups_by_id(record_book_id_inp int)
returns setof groups as $$
DECLARE
    groupids int[];
begin
    select array_agg(id_group) into groupids from student_groups
    where id_record_book = record_book_id_inp;
    return query
    select * from groups
    where id_group = any(groupids);
end;
$$ language plpgsql;



select * from get_groups_by_id(1);
