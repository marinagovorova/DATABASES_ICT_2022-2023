-- Вывести даты сессии для группы K10
select date_time from session_schedule where id_group in
                                             (select  id_group from groups where group_name='K10');

-- Какие дисциплины есть у учебного плана группы K10?
select distinct  id_discipline from study_courses where id_study_plan in
(select  id_study_plan from groups where group_name='K10');


-- Экзамены по каким дисциплиным были у группы K10?

-- Вариант через зачетную книжку
select distinct id_discipline from study_courses where id_study_course in
    (select distinct id_study_course from record_book where id_group_row in
        (select id_group_row from student_groups where id_group in
            (select  id_group from groups where group_name='K10')));

-- Вариант через расписание
select distinct id_discipline from study_courses where id_study_course in
    (select distinct id_study_course from session_schedule where id_group in
            (select  id_group from groups where group_name='K10'));


-- Вывести все выплаты студенту с id_record_book = 13
select pay_date, status from scholarship_payments where id_awarded_scholarship in
(select  id_awarded_scholarship from awarded_scholarships where id_record_book=13);

-- Какие степендии есть у стендента с id_record_book = 13
select * from scholarships where id_scholarship in
(select distinct  id_scholarship from awarded_scholarships where id_record_book=13);

select  * from scholarship_payments;
