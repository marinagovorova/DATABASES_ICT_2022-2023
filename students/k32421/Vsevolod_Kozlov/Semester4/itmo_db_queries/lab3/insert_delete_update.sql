/*
 update
 */

-- Заменить название предмета на "nice discipline", по которому student_surname0 получил больше всего 5


create temporary table cnt_5_marks as
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

update disciplines
set name='nice discipline'
where id_discipline=(select id_discipline from cnt_5_marks
where cnt_5=(select max(cnt_5) from cnt_5_marks));
select * from disciplines where id_discipline=8;

drop table cnt_5_marks;

 -- Назначить повышенную стипендию студенту, который имеет лучший средний балл в группе

-- Увеличить количество selfstudy_hours на 10 для дисциплин с самой низкой средней успеваемостью

create temporary table discipline_avg as
select d.id_discipline, avg(mark) avg_mark from record_book
join study_courses sc
    on record_book.id_study_course = sc.id_study_course
join
    disciplines d on sc.id_discipline = d.id_discipline
where mark <> 2
group by d.id_discipline;

update disciplines
    set selfstudy_hours = selfstudy_hours + 10
where id_discipline in
      (select id_discipline from discipline_avg
       where avg_mark>=all(select avg_mark from discipline_avg)
       limit 1);

drop table discipline_avg;
/*
 delete
 */

-- Удалить учебный план, которые были созданы позже всего и не реализует ни одной дисциплины
select * from study_plans;

delete from study_plans
where id_study_plan in
    (select id_study_plan from study_plans
    where id_study_plan not in
          (select distinct  id_study_plan from study_courses)
    and year>=all(select year from study_plans));

/*
Удалить подразделение, в котором
-не обучается ни один студент
и
-не трудоустроен ни один преподаватель
*/

select * from subdivisions;

delete from subdivisions
where id_subdivision not in
    (select distinct id_subdivision from study_plans
    where id_study_plan in
    (select distinct id_study_plan from groups
    where id_group in
    (select  distinct id_group from student_groups))

    union

    select distinct id_subdivision from employment_contracts);


/*
 Для студента с id_record_book=2 во время его обучения в группе c id_group=0. Если по дисциплине была получена 3 на 1-й попытке, то добавить 4 со второй попытки
 */


select * from record_book
where
    id_group_row =
    (select id_group_row from student_groups
    where id_group=0 and id_record_book=2)
and
    mark=3
and
    try_number=1;

insert into record_book
(id_group_row, id_teacher, id_study_course, mark, try_number)
select id_group_row, id_teacher, id_study_course, 4, 2 from record_book
where
    id_group_row =
    (select id_group_row from student_groups
    where id_group=0 and id_record_book=2)
and
    mark=3
and
    try_number=1;