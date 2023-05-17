/*список дисциплин, которые должны быть сданы заданной группой с
  указанием дат сдачи и фамилий преподавателей.*/
select date_time, surname
from session_schedule join teachers
    on session_schedule.id_teacher = teachers.id_teacher
where id_group =(select id_group from groups where group_name='K10');


/* список студентов, получивших двойки на первой попытке с указанием фамилии преподавателя, которым они должны пересдать экзамен.
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




/*  фамилии студентов, получивших оценки по дисциплине, которые выше среднего балла по этой дисциплине.
 */

select s.surname as stud_surname, record_book.id_study_course
from record_book
join student_groups sg
    on sg.id_group_row = record_book.id_group_row
join students s
    on sg.id_record_book = s.id_record_book
join (select id_study_course, avg(mark) as avg_mark from record_book where mark<>2 group by id_study_course) avg_mark
    on record_book.id_study_course = avg_mark.id_study_course
where record_book.mark > avg_mark.avg_mark;


/* рейтинговый список групп по заданному направлению по результатам сдачи сессии, упорядочить его по убыванию. */

select sg.group_name, avg(mark) from record_book
join
    (select id_group_row, group_name from student_groups
    join groups g
        on g.id_group = student_groups.id_group
    where g.id_study_plan = 0) sg
on sg.id_group_row = record_book.id_group_row
where mark<>2
group by sg.group_name
order by avg(mark) desc;



/*  Cписки студентов, упорядоченные по группам и фамилиям студентов,назначении на стипендии. Студент получает стипендию, если он сдал сессию без троек.  Если студент не назначен на стипендию, указать 0, если назначен – 1. */
select s.surname, sg.group_name,
       case
           when min(mark) > 3 then 1
           else 0
       end as is_awarder
from record_book
join (select id_record_book, id_group_row, group_name
      from student_groups
      join groups g
      on g.id_group = student_groups.id_group) sg
    on sg.id_group_row = record_book.id_group_row
join students s
    on sg.id_record_book = s.id_record_book
group by (s.surname, sg.group_name)
order by surname, group_name;


/* список студентов, сдавших все положенные экзамены.*/


select id_record_book from record_book
join (select id_group_row, id_study_course, max(try_number) as last_try
      from record_book r2
      group by (id_group_row, id_study_course)) as trys
    on record_book.try_number=last_try and
       record_book.id_group_row = trys.id_group_row and
       record_book.id_study_course = trys.id_study_course
join student_groups sg
    on record_book.id_group_row = sg.id_group_row
group by sg.id_record_book
having min(mark) > 2;

/* список студентов, получивших максимальный средний балл в своей группе. */
select sg.id_record_book, sg.id_group
from
    (select id_group_row, avg(mark) as avg_st
      from record_book
      where mark<>2
      group by id_group_row) avg_st
join
    student_groups sg
on
    sg.id_group_row = avg_st.id_group_row
join
    (select id_group, max(avg_st) as max_group_avg from record_book as r1
    join student_groups sg on
        r1.id_group_row = sg.id_group_row
    join (select id_group_row, avg(mark) as avg_st
          from record_book
          where mark<>2
          group by id_group_row) s_av
    on r1.id_group_row = s_av.id_group_row
    group by id_group) as max_group_avg
on
    sg.id_group = max_group_avg.id_group
where avg_st=max_group_avg;
