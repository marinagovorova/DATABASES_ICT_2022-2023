
/*
 record book
 (id_group_row, mark)
 (id_study_course, id_group_row)
 (mark)
 */

select s.surname as student_name, t.surname as teacher_surname
from record_book
join student_groups sg
    on sg.id_group_row = record_book.id_group_row
join students s
    on sg.id_record_book = s.id_record_book
join teachers t
    on record_book.id_teacher = t.id_teacher
where try_number=1 and mark=2;


-- mark_idx
create index try_mark_idx on record_book(try_number, mark);
create index record_book_idteacher_idx on record_book(id_teacher);
create index record_book_group_row_idx on record_book(id_group_row);
create index group_recordbook_idx on student_groups(id_record_book);


drop index try_mark_idx;
drop index record_book_idteacher_idx;
drop index record_book_group_row_idx;
drop index group_recordbook_idx;


/*
    Если 5-10%, то ок
    Выбор дисциплин, которые
 */


create index mark_idx on record_book(mark);
create index student_surname_idx on students(surname);
create index group_recordbook_idx on student_groups(id_record_book);

drop index mark_idx;
drop index student_surname_idx;
drop index group_recordbook_idx;




select id_discipline, count(*) cnt_5 from record_book
join study_courses sc
    on record_book.id_study_course = sc.id_study_course
where
    id_group_row in
    (select id_group_row from student_groups where id_record_book in
        (select  id_record_book from students where surname='student_surname4'))
    and
    mark=5
group by id_discipline;