/*
 список студентов, получивших двойки на первой попытке с указанием фамилии преподавателя, которым они должны пересдать экзамен;
 */


create or replace view first_mark_two  as
    select s.surname as student_name, t.surname as teacher_surname
    from record_book
    join student_groups sg
        on sg.id_group_row = record_book.id_group_row
    join students s
        on sg.id_record_book = s.id_record_book
    join teachers t
        on record_book.id_teacher = t.id_teacher
    where try_number=1 and mark=2;


select *
from first_mark_two;


/*
 данных о студентах при получении ими хотя бы одной оценки 2 (после 3-й попытки).
 */

/*
 Так как у меня никто не отчислился из института, то есть нет ни одного с студента с 2 на 3-й попытке, то создам представление для студентов, побывавших на ппа2
 */



create or replace view students_ppa2 as
    select s.surname as student_name, t.surname as teacher_surname
    from record_book
    join student_groups sg
        on sg.id_group_row = record_book.id_group_row
    join students s
        on sg.id_record_book = s.id_record_book
    join teachers t
        on record_book.id_teacher = t.id_teacher
    where try_number=2 and mark=2;

select * from students_ppa2;
