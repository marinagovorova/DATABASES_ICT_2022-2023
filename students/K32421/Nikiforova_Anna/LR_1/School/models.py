from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, UniqueConstraint, \
    Boolean, Text, Time, Date, ForeignKey, CheckConstraint, Identity
from sqlalchemy.orm import relationship
from datetime import date, time

Base = declarative_base()


class Curriculum(Base):
    __tablename__ = 'Curriculum'
    __table_args__ = ({"schema": "School_schema", "comment": "Таблица \"Учебный план\""})

    curriculum_id = Column('curriculum_id', Integer, Identity(always=True, start=1, increment=1), primary_key=True)
    year_start_date = Column('year_start_date', Date,
                             CheckConstraint(f"'{date(1900, 1, 1)}' <= year_start_date", name="years_start_check"),
                             nullable=False,
                             default=date(date.today().year - 1, 9, 1))
    year_end_date = Column('year_end_date', Date,
                           CheckConstraint("year_start_date < year_end_date", name="years_start_and_end_check"),
                           nullable=False,
                           default=date(date.today().year, 8, 31))
    link_to_the_original = Column('link_to_the_original', Text, nullable=False, default="Not found")
    class_number = Column('class_number', Integer,
                          CheckConstraint("5 <= class_number AND class_number <= 11", name="class_number_check"),
                          nullable=False)
    class_specialization = Column('class_specialization', String(250))

    # disciplines = relationship("Discipline", back_populates="curriculum")
    # classes = relationship("Class", back_populates="curriculum")


class Discipline(Base):
    __tablename__ = 'Discipline'
    __table_args__ = ({"schema": "School_schema", "comment": "Таблица \"Дисциплина\""})

    discipline_id = Column('discipline_id', Integer, Identity(always=True, start=1, increment=1), primary_key=True)
    curriculum_id = Column('curriculum_id', ForeignKey("School_schema.Curriculum.curriculum_id"), nullable=False)
    discipline_code = Column('discipline_code', Integer, nullable=False)
    hours = Column('hours', Integer, CheckConstraint(f"hours >= 0", name="hours_check"),
                   nullable=False, default=0)
    subject_area = Column('subject_area', String(250), nullable=False)
    subject_name = Column('subject_name', String(250), nullable=False)

    # curriculum = relationship("School_schema.Curriculum", back_populates="disciplines")
    # class_where_workload = relationship(
    #     "Class", secondary="School_schema.Workload", back_populates="discipline_in_workload"
    # )
    # teacher_who_has_workload = relationship(
    #     "Teacher", secondary="School_schema.Workload", back_populates="discipline_in_workload"
    # )


class Teacher(Base):
    __tablename__ = 'Teacher'
    __table_args__ = (UniqueConstraint("passport",
                             name="unique_passport"),
                      {"schema": "School_schema", "comment": "Таблица \"Преподаватель\""})

    teacher_personnel_number = Column('teacher_personnel_number', Integer, primary_key=True)
    full_name = Column('full_name', String(250), nullable=False)
    birth_date = Column('birth_date', Date,
                        CheckConstraint(
                            f"'{date(1900, 1, 1)}' <= birth_date AND birth_date < now() - interval '16 years'",
                            name="birth_date_check"),
                        nullable=False)
    passport = Column('passport', String(11), CheckConstraint("passport SIMILAR TO '\d{4}(| )\d{6}'",
                                                              name="passport_check"),
                      nullable=False)
    address = Column('address', String(250))
    phone = Column('phone', String(18), CheckConstraint("phone SIMILAR TO '(\+7|8) \(\d{3}\) \d{3}-\d{2}-\d{2}'",
                                                              name="phone_check"))
    email = Column('email', String(100))

    # educations = relationship("School_schema.Education", back_populates="teacher")
    # class_where_headteacher = relationship(
    #     "Class", secondary="School_schema.Headteacher", back_populates="teacher_who_is_headteacher"
    # )
    # class_where_workload = relationship(
    #     "Class", secondary="School_schema.Workload", back_populates="teacher_who_has_workload"
    # )
    # discipline_in_workload = relationship(
    #     "Discipline", secondary="School_schema.Workload", back_populates="teacher_who_has_workload"
    # )


class Education(Base):
    __tablename__ = 'Education'
    __table_args__ = (UniqueConstraint("diploma",
                             name="unique_diploma"),
                      {"schema": "School_schema", "comment": "Таблица \"Образование\""})

    education_id = Column('education_id', Integer, Identity(always=True, start=1, increment=1), primary_key=True)
    teacher_personnel_number = Column('teacher_personnel_number',
                                      ForeignKey("School_schema.Teacher.teacher_personnel_number"), nullable=False)
    diploma = Column('diploma', String(50), CheckConstraint(f"diploma SIMILAR TO '\d+'",
                                                        name="diploma_check"), nullable=False)
    received = Column('received', Date, CheckConstraint(
        f"'{date(1900, 1, 1)}' <= received AND received < now()",
        name="received_diploma_date_check"), nullable=False)
    education_level = Column('education_level', String(50),
                             CheckConstraint(
                                 "education_level in ('Среднее профессиональное образование', 'Бакалавриат', 'Магистратура', 'Специалитет', 'Аспирантура', 'Докторантура')",
                                 name="education_level_check"), nullable=False)
    qualifications = Column('qualifications', String(200), nullable=False)
    specialization = Column('specialization', String(200), nullable=False)

    # teacher = relationship("School_schema.Teacher", back_populates="educations")


class Class(Base):
    __tablename__ = 'Class'
    __table_args__ = ({"schema": "School_schema", "comment": "Таблица \"Класс\""})

    class_id = Column('class_id', Integer, Identity(always=True, start=1, increment=1), primary_key=True)
    class_letter = Column('class_letter', String(3),
                        CheckConstraint("class_letter SIMILAR TO '[А-ЯЁ]{1}'", name="class_letter_check"),
                        nullable=False)
    status = Column('status', String(20),
                    CheckConstraint("status in ('Действует', 'Формируется', 'Расформирован')",
                                    name="status_check"),
                    nullable=False, default='Действует')
    curriculum_id = Column('curriculum_id', ForeignKey("School_schema.Curriculum.curriculum_id"), nullable=False)

    # curriculum = relationship("School_schema.Curriculum", back_populates="classes")
    # students_in_class = relationship("School_schema.Student_in_class", back_populates="class_")
    # student_who_is_headstudent = relationship(
    #     "Student_in_class", secondary="School_schema.Headstudent", back_populates="class_where_headstudent"
    # )
    # teacher_who_is_headteacher = relationship(
    #     "Teacher", secondary="School_schema.Headteacher", back_populates="class_where_headteacher"
    # )
    # teacher_who_has_workload = relationship(
    #     "Teacher", secondary="School_schema.Workload", back_populates="class_where_workload"
    # )
    # discipline_in_workload = relationship(
    #     "Discipline", secondary="School_schema.Workload", back_populates="class_where_workload"
    # )


class Student(Base):
    __tablename__ = 'Student'
    __table_args__ = ({"schema": "School_schema", "comment": "Таблица \"Ученик\""})

    student_code = Column('student_code', Integer, primary_key=True)
    full_name = Column('full_name', String(250), nullable=False)
    birth_date = Column('birth_date', Date,
                        CheckConstraint(f"'{date(1990, 1, 1)}' <= birth_date AND birth_date < now()",
                                        name="birth_date_check"),
                        nullable=False)
    address = Column('address', String(250))
    phone = Column('phone', String(18))
    email = Column('email', String(100))

    # students_in_class = relationship("School_schema.Student_in_class", back_populates="student")


class Student_in_class(Base):
    __tablename__ = 'Student_in_class'
    __table_args__ = ({"schema": "School_schema", "comment": "Таблица \"Обучающийся\""})

    student_in_class_id = Column('student_in_class_id', Integer, Identity(always=True, start=1, increment=1),
                                 primary_key=True)
    date_from = Column('date_from', Date, CheckConstraint(
        f"'{date(1900, 1, 1)}' <= date_from",
        name="date_from_check"),
                       nullable=False)
    date_to = Column('date_to', Date, CheckConstraint(
        "date_from < date_to",
        name="date_to_check"))
    status = Column('status', String(20),
                    CheckConstraint("status in ('Числится', 'Числился', 'Отчислен', 'В академ. отпуске')",
                                    name="status_check"),
                    nullable=False, default='Числится')
    class_id = Column('class_id', ForeignKey("School_schema.Class.class_id"), nullable=False)
    student_code = Column('student_code', ForeignKey("School_schema.Student.student_code"), nullable=False)

    # class_ = relationship("School_schema.Class", back_populates="students_in_class")
    # student = relationship("School_schema.Student", back_populates="students_in_class")
    # class_where_headstudent = relationship(
    #     "Class", secondary="School_schema.Headstudent", back_populates="student_who_is_headstudent"
    # )
    # attending_student = relationship(
    #     "Lesson", secondary="School_schema.Attendance", back_populates="attended_lesson"
    # )


class Headstudent(Base):
    __tablename__ = 'Headstudent'
    __table_args__ = ({"schema": "School_schema", "comment": "Таблица \"Староста\""})

    headstudent_id = Column('headstudent_id', Integer, Identity(always=True, start=1, increment=1), primary_key=True)
    date_from = Column('date_from', Date, CheckConstraint(
        f"'{date(1900, 1, 1)}' <= date_from",
        name="date_from_check"),
                       nullable=False)
    date_to = Column('date_to', Date, CheckConstraint(
        "date_from < date_to",
        name="date_to_check"))

    student_in_class_id = Column('student_in_class_id',
                                 ForeignKey("School_schema.Student_in_class.student_in_class_id"), nullable=False)

    # student_who_is_headstudent = relationship("School_schema.Student_in_class", back_populates="School_schema.Headstudent")
    # class_where_headstudent = relationship("School_schema.Class", back_populates="School_schema.Headstudent")


class Headteacher(Base):
    __tablename__ = 'Headteacher'
    __table_args__ = ({"schema": "School_schema", "comment": "Таблица \"Классное руководство\""})

    headteacher_id = Column('headteacher_id', Integer, Identity(always=True, start=1, increment=1), primary_key=True)
    date_from = Column('date_from', Date, CheckConstraint(
        f"'{date(1900, 1, 1)}' <= date_from",
        name="date_from_check"),
                       nullable=False)
    date_to = Column('date_to', Date, CheckConstraint(
        "date_from < date_to",
        name="date_to_check"))

    teacher_personnel_number = Column('teacher_personnel_number',
                                      ForeignKey("School_schema.Teacher.teacher_personnel_number"), nullable=False)
    class_id = Column('class_id', ForeignKey("School_schema.Class.class_id"), nullable=False)

    # teacher_who_is_headteacher = relationship("School_schema.Teacher", back_populates="School_schema.Headteacher")
    # class_where_headteacher = relationship("School_schema.Class", back_populates="School_schema.Headteacher")


class Classroom(Base):
    __tablename__ = 'Classroom'
    __table_args__ = ({"schema": "School_schema", "comment": "Таблица \"Кабинет\""})

    classroom_number = Column('classroom_number', Integer, primary_key=True)
    classroom_specialization = Column('classroom_specialization', String(250))
    having_projector = Column('having_projector', Boolean)
    number_of_seats = Column('number_of_seats', Integer,
                             CheckConstraint("number_of_seats >= 0", name="number_of_seats_check"))

    # lesson_in_workload = relationship(
    #     "School_schema.Workload", secondary="School_schema.Schedule", back_populates="classroom_where_lesson"
    # )


class Workload(Base):
    __tablename__ = 'Workload'
    __table_args__ = ({"schema": "School_schema", "comment": "Таблица \"Нагрузка\""})

    workload_id = Column('workload_id', Integer, Identity(always=True, start=1, increment=1), primary_key=True)
    hours = Column('hours', Integer, CheckConstraint("hours >= 0", name="hours_check"), nullable=False)
    date_from = Column('date_from', Date, CheckConstraint(
        f"'{date(1900, 1, 1)}' <= date_from",
        name="date_from_check"),
                       nullable=False)
    date_to = Column('date_to', Date, CheckConstraint(
        "date_from < date_to",
        name="date_to_check"))
    teacher_personnel_number = Column('teacher_personnel_number',
                                      ForeignKey("School_schema.Teacher.teacher_personnel_number"), nullable=False)
    class_id = Column('class_id', ForeignKey("School_schema.Class.class_id"), nullable=False)
    discipline_id = Column('discipline_id', ForeignKey("School_schema.Discipline.discipline_id"), nullable=False)

    # teacher_who_has_workload = relationship("School_schema.Teacher", back_populates="School_schema.Workload")
    # class_where_workload = relationship("School_schema.Class", back_populates="School_schema.Workload")
    # discipline_in_workload = relationship("School_schema.Discipline", back_populates="School_schema.Workload")
    # classroom_where_lesson = relationship(
    #     "School_schema.Classroom", secondary="School_schema.Schedule", back_populates="lesson_in_workload"
    # )
    # plans = relationship("School_schema.Plan", back_populates="workload")


class Schedule(Base):
    __tablename__ = 'Schedule'
    __table_args__ = ({"schema": "School_schema", "comment": "Таблица \"Расписание\""})

    schedule_id = Column('schedule_id', Integer, Identity(always=True, start=1, increment=1), primary_key=True)
    weekday = Column('weekday', String(11),
                     CheckConstraint("weekday in ('Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота')",
                                     name="weekday_check"), nullable=False)
    lesson_type = Column('lesson_type', String(20), CheckConstraint(
        "lesson_type in ('Основное', 'Дополнительное', 'Факультатив', 'Секция', 'Иное')", name="lesson_type_check"),
                         nullable=False, default='Основное')
    date_from = Column('date_from', Date, CheckConstraint(
        f"'{date(1900, 1, 1)}' <= date_from",
        name="date_from_check"),
                       nullable=False)
    date_to = Column('date_to', Date, CheckConstraint(
        "date_from < date_to",
        name="date_to_check"))
    time_from = Column('time_from', Time, CheckConstraint(
        "'06:00:00' <= time_from AND time_from <= '22:00:00'",
        name="time_from_check"),
                       nullable=False)
    time_to = Column('time_to', Time, CheckConstraint(
        "time_from <= time_to AND time_to <= '22:00:00'",
        name="time_to_check"), nullable=False)
    classroom_number = Column('classroom_number', ForeignKey("School_schema.Classroom.classroom_number"),
                              nullable=False)
    workload_id = Column('workload_id', ForeignKey("School_schema.Workload.workload_id"), nullable=False)

    # classroom_where_lesson = relationship("School_schema.Classroom", back_populates="School_schema.Schedule")
    # lesson_in_workload = relationship("School_schema.Workload", back_populates="School_schema.Schedule")
    # lessons = relationship("School_schema.Lesson", back_populates="School_schema.Schedule")


class Plan(Base):
    __tablename__ = 'Plan'
    __table_args__ = (UniqueConstraint("topic_number", "workload_id",
                                       name="unique_combination_of_workload_and_topic_num"),
                      {"schema": "School_schema",
                       "comment": "Таблица \"Календарно-тематический план\""})

    plan_id = Column('plan_id', Integer, Identity(always=True, start=1, increment=1), primary_key=True)
    topic_name = Column('topic_name', String(200), nullable=False, default="Тема не указана")
    topic_number = Column('topic_number', Integer, CheckConstraint("topic_number > 0", name="topic_number_check"),
                          nullable=False)
    hours_per_topic = Column('hours_per_topic', Integer, CheckConstraint("hours_per_topic > 0", name="hours_check"),
                             nullable=False)
    workload_id = Column('workload_id', ForeignKey("School_schema.Workload.workload_id"), nullable=False)

    # workload = relationship("School_schema.Workload", back_populates="plans")
    # evaluation_tools = relationship("School_schema.EvaluationTool", back_populates="plan")


class Lesson(Base):
    __tablename__ = 'Lesson'
    __table_args__ = ({"schema": "School_schema", "comment": "Таблица \"Урок\""})

    lesson_id = Column('lesson_id', Integer, Identity(always=True, start=1, increment=1), primary_key=True)
    lesson_date = Column('lesson_date', Date, CheckConstraint(
        f"'{date(1900, 1, 1)}' <= lesson_date",
        name="lesson_date_check"), nullable=False)
    schedule_id = Column('schedule_id', ForeignKey("School_schema.Schedule.schedule_id"), nullable=False)

    # workload = relationship("Schedule", back_populates="lessons")
    # attended_lesson = relationship(
    #     "School_schema.Student_in_class", secondary="School_schema.Attendance", back_populates="attending_student"
    # )


class EvaluationTool(Base):
    __tablename__ = 'EvaluationTool'
    __table_args__ = ({"schema": "School_schema", "comment": "Таблица \"Оценочное средство\""})

    evaluation_tool_id = Column('evaluation_tool_id', Integer, Identity(always=True, start=1, increment=1),
                                primary_key=True)
    name = Column('name', String(200))
    type_ = Column('type', String(20),
                   CheckConstraint("type in ('К/р', 'С/р', 'Д/з', 'Ведение тетради', 'Работа на уроке', 'Иное')",
                                   name="type_check"), nullable=False)
    description = Column('description', Text)
    plan_id = Column('plan_id', ForeignKey("School_schema.Plan.plan_id"), nullable=False)

    # plan = relationship("School_schema.Plan", back_populates="evaluation_tools")
    # attended_lesson = relationship(
    #     "School_schema.Attendance", secondary="School_schema.Grade", back_populates="evaluation_tool"
    # )


class Attendance(Base):
    __tablename__ = 'Attendance'
    __table_args__ = ({"schema": "School_schema", "comment": "Таблица \"Присутствие на уроке\""})

    attendance_id = Column('attendance_id', Integer, Identity(always=True, start=1, increment=1), primary_key=True)
    attendance = Column('attendance', Boolean, nullable=False, default=True)
    note = Column('note', Text)
    student_in_class_id = Column('student_in_class_id',
                                 ForeignKey("School_schema.Student_in_class.student_in_class_id"), nullable=False)
    lesson_id = Column('lesson_id', ForeignKey("School_schema.Lesson.lesson_id"), nullable=False)

    # attended_lesson = relationship("Lesson", back_populates="Attendance")
    # attending_student = relationship("School_schema.Student_in_class", back_populates="School_schema.Attendance")
    # evaluation_tool = relationship(
    #     "School_schema.EvaluationTool", secondary="School_schema.Grade", back_populates="attended_lesson"
    # )


class Grade(Base):
    __tablename__ = 'Grade'
    __table_args__ = ({"schema": "School_schema", "comment": "Таблица \"Оценка\""})

    grade_id = Column('grade_id', Integer, Identity(always=True, start=1, increment=1), primary_key=True)
    grade = Column('grade', Integer, CheckConstraint("2 <= grade AND grade <= 5", name="grade_check"))
    note = Column('note', Text)
    attendance_id = Column('attendance_id', ForeignKey("School_schema.Attendance.attendance_id"), nullable=False)
    evaluation_tool_id = Column('evaluation_tool_id', ForeignKey("School_schema.EvaluationTool.evaluation_tool_id"),
                                nullable=False)

    # attended_lesson = relationship("School_schema.Attendance", back_populates="School_schema.Grade")
    # evaluation_tool = relationship("School_schema.EvaluationTool", back_populates="School_schema.Grade")
