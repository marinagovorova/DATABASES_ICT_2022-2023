PGDMP                          {            Session    15.2    15.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16398    Session    DATABASE     }   CREATE DATABASE "Session" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.utf8';
    DROP DATABASE "Session";
                postgres    false                        2615    16399    session    SCHEMA        CREATE SCHEMA session;
    DROP SCHEMA session;
                postgres    false            �           1247    16664    attestation_type    TYPE     �   CREATE TYPE session.attestation_type AS ENUM (
    'Экзамен',
    'Зачет',
    'Дифференцированный зачет'
);
 $   DROP TYPE session.attestation_type;
       session          postgres    false    6            �           1247    16654    classroom_type    TYPE     �   CREATE TYPE session.classroom_type AS ENUM (
    'Лекционная',
    'Лаборатория',
    'Практическая',
    'Другое'
);
 "   DROP TYPE session.classroom_type;
       session          postgres    false    6            �           1247    16638    learning_type    TYPE     |   CREATE TYPE session.learning_type AS ENUM (
    'Очный',
    'Дистанционный',
    'Смешанный'
);
 !   DROP TYPE session.learning_type;
       session          postgres    false    6            �           0    0    TYPE learning_type    COMMENT     H   COMMENT ON TYPE session.learning_type IS 'Форма обучения';
          session          postgres    false    915            �           1247    16647    semester_type    TYPE     \   CREATE TYPE session.semester_type AS ENUM (
    'Осенний',
    'Весенний'
);
 !   DROP TYPE session.semester_type;
       session          postgres    false    6            �           1247    16676    status    TYPE     �   CREATE TYPE session.status AS ENUM (
    'Обучается',
    'Академ',
    'Отчислен',
    'Восстановлен'
);
    DROP TYPE session.status;
       session          postgres    false    6            �            1259    16493    attestation    TABLE       CREATE TABLE session.attestation (
    grade integer NOT NULL,
    attestation_date date NOT NULL,
    teacher_id integer NOT NULL,
    edu_plan_subject_id integer NOT NULL,
    student_id integer NOT NULL,
    attempt_count integer NOT NULL,
    attestation_id integer NOT NULL
);
     DROP TABLE session.attestation;
       session         heap    postgres    false    6            �           0    0    TABLE attestation    COMMENT     @   COMMENT ON TABLE session.attestation IS 'Аттестация';
          session          postgres    false    233            �            1259    16530    attestation_attestation_id_seq    SEQUENCE     �   CREATE SEQUENCE session.attestation_attestation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE session.attestation_attestation_id_seq;
       session          postgres    false    233    6            �           0    0    attestation_attestation_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE session.attestation_attestation_id_seq OWNED BY session.attestation.attestation_id;
          session          postgres    false    241            �            1259    16498    attestation_timetable    TABLE     5  CREATE TABLE session.attestation_timetable (
    group_id integer NOT NULL,
    edu_plan_subject_id integer NOT NULL,
    classroom_id integer NOT NULL,
    exam_date date NOT NULL,
    teacher_id integer NOT NULL,
    attestation_timetable_id integer NOT NULL,
    semester session.semester_type NOT NULL
);
 *   DROP TABLE session.attestation_timetable;
       session         heap    postgres    false    918    6            �           0    0    TABLE attestation_timetable    COMMENT     W   COMMENT ON TABLE session.attestation_timetable IS 'Расписание сессии';
          session          postgres    false    234            �            1259    16537 2   attestation_timetable_attestation_timetable_id_seq    SEQUENCE     �   CREATE SEQUENCE session.attestation_timetable_attestation_timetable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 J   DROP SEQUENCE session.attestation_timetable_attestation_timetable_id_seq;
       session          postgres    false    6    234            �           0    0 2   attestation_timetable_attestation_timetable_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE session.attestation_timetable_attestation_timetable_id_seq OWNED BY session.attestation_timetable.attestation_timetable_id;
          session          postgres    false    242            �            1259    16437    building    TABLE     �   CREATE TABLE session.building (
    building_id integer NOT NULL,
    address character varying(50) NOT NULL,
    building_name character varying(10) NOT NULL
);
    DROP TABLE session.building;
       session         heap    postgres    false    6            �           0    0    TABLE building    COMMENT     5   COMMENT ON TABLE session.building IS 'Корпус';
          session          postgres    false    219            �            1259    16436    building_building_id_seq    SEQUENCE     �   CREATE SEQUENCE session.building_building_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE session.building_building_id_seq;
       session          postgres    false    219    6            �           0    0    building_building_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE session.building_building_id_seq OWNED BY session.building.building_id;
          session          postgres    false    218            �            1259    16450 	   classroom    TABLE     �   CREATE TABLE session.classroom (
    classroom_id integer NOT NULL,
    capacity integer NOT NULL,
    room integer NOT NULL,
    building_id integer NOT NULL,
    classroom_type session.classroom_type NOT NULL
);
    DROP TABLE session.classroom;
       session         heap    postgres    false    6    921            �           0    0    TABLE classroom    COMMENT     <   COMMENT ON TABLE session.classroom IS 'Аудитория';
          session          postgres    false    222            �            1259    16453    classroom_classroom_id_seq    SEQUENCE     �   CREATE SEQUENCE session.classroom_classroom_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE session.classroom_classroom_id_seq;
       session          postgres    false    6    222            �           0    0    classroom_classroom_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE session.classroom_classroom_id_seq OWNED BY session.classroom.classroom_id;
          session          postgres    false    223            �            1259    16431    edu_plan    TABLE     �   CREATE TABLE session.edu_plan (
    plan_id integer NOT NULL,
    program_id integer NOT NULL,
    learning_type character varying(50) NOT NULL,
    start_year integer NOT NULL
);
    DROP TABLE session.edu_plan;
       session         heap    postgres    false    6            �           0    0    TABLE edu_plan    COMMENT     @   COMMENT ON TABLE session.edu_plan IS 'Учебный план';
          session          postgres    false    217            �            1259    16468    edu_plan_subject    TABLE     �   CREATE TABLE session.edu_plan_subject (
    edu_plan_subject_id integer NOT NULL,
    subject_id integer NOT NULL,
    subject_name character varying(30) NOT NULL,
    learning_type session.learning_type NOT NULL
);
 %   DROP TABLE session.edu_plan_subject;
       session         heap    postgres    false    6    915            �           0    0    TABLE edu_plan_subject    COMMENT     b   COMMENT ON TABLE session.edu_plan_subject IS 'Дисциплина в учебном плане';
          session          postgres    false    227            �            1259    16467 (   edu_plan_subject_edu_plan_subject_id_seq    SEQUENCE     �   CREATE SEQUENCE session.edu_plan_subject_edu_plan_subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 @   DROP SEQUENCE session.edu_plan_subject_edu_plan_subject_id_seq;
       session          postgres    false    227    6            �           0    0 (   edu_plan_subject_edu_plan_subject_id_seq    SEQUENCE OWNED BY     w   ALTER SEQUENCE session.edu_plan_subject_edu_plan_subject_id_seq OWNED BY session.edu_plan_subject.edu_plan_subject_id;
          session          postgres    false    226            �            1259    16407    edu_program    TABLE     �   CREATE TABLE session.edu_program (
    track_id integer NOT NULL,
    name character varying(140)[] NOT NULL,
    program_id integer NOT NULL
);
     DROP TABLE session.edu_program;
       session         heap    postgres    false    6            �           0    0    TABLE edu_program    COMMENT     ]   COMMENT ON TABLE session.edu_program IS 'Образовательная программа';
          session          postgres    false    216            �            1259    16544    edu_program_program_id_seq    SEQUENCE     �   CREATE SEQUENCE session.edu_program_program_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE session.edu_program_program_id_seq;
       session          postgres    false    6    216            �           0    0    edu_program_program_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE session.edu_program_program_id_seq OWNED BY session.edu_program.program_id;
          session          postgres    false    243            �            1259    16400 	   edu_track    TABLE     n   CREATE TABLE session.edu_track (
    name character varying(140)[] NOT NULL,
    track_id integer NOT NULL
);
    DROP TABLE session.edu_track;
       session         heap    postgres    false    6            �           0    0    TABLE edu_track    COMMENT     U   COMMENT ON TABLE session.edu_track IS 'Направление подготовки';
          session          postgres    false    215            �            1259    16553    edu_track_track_id_seq    SEQUENCE     �   CREATE SEQUENCE session.edu_track_track_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE session.edu_track_track_id_seq;
       session          postgres    false    215    6            �           0    0    edu_track_track_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE session.edu_track_track_id_seq OWNED BY session.edu_track.track_id;
          session          postgres    false    244            �            1259    16444    faculty    TABLE     �   CREATE TABLE session.faculty (
    faculty_id integer NOT NULL,
    building_id integer NOT NULL,
    faculty_name character varying(50) NOT NULL
);
    DROP TABLE session.faculty;
       session         heap    postgres    false    6            �           0    0    TABLE faculty    COMMENT     K   COMMENT ON TABLE session.faculty IS 'Подразделение вуза';
          session          postgres    false    221            �            1259    16443    faculty_faculty_id_seq    SEQUENCE     �   CREATE SEQUENCE session.faculty_faculty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE session.faculty_faculty_id_seq;
       session          postgres    false    6    221            �           0    0    faculty_faculty_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE session.faculty_faculty_id_seq OWNED BY session.faculty.faculty_id;
          session          postgres    false    220            �            1259    16522    group    TABLE     �   CREATE TABLE session."group" (
    group_id integer NOT NULL,
    study_year integer NOT NULL,
    course integer NOT NULL,
    group_name character varying(10) NOT NULL,
    semester session.semester_type NOT NULL
);
    DROP TABLE session."group";
       session         heap    postgres    false    6    918            �            1259    16521    group_group_id_seq    SEQUENCE     �   CREATE SEQUENCE session.group_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE session.group_group_id_seq;
       session          postgres    false    240    6            �           0    0    group_group_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE session.group_group_id_seq OWNED BY session."group".group_id;
          session          postgres    false    239            �            1259    16514    scholarship_payments    TABLE     �   CREATE TABLE session.scholarship_payments (
    student_id integer NOT NULL,
    scholarship_id integer NOT NULL,
    paid_scholarship_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL
);
 )   DROP TABLE session.scholarship_payments;
       session         heap    postgres    false    6            �           0    0    TABLE scholarship_payments    COMMENT     P   COMMENT ON TABLE session.scholarship_payments IS 'История выплат';
          session          postgres    false    238            �            1259    16513 ,   scholarship_payments_paid_scholarship_id_seq    SEQUENCE     �   CREATE SEQUENCE session.scholarship_payments_paid_scholarship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 D   DROP SEQUENCE session.scholarship_payments_paid_scholarship_id_seq;
       session          postgres    false    238    6            �           0    0 ,   scholarship_payments_paid_scholarship_id_seq    SEQUENCE OWNED BY        ALTER SEQUENCE session.scholarship_payments_paid_scholarship_id_seq OWNED BY session.scholarship_payments.paid_scholarship_id;
          session          postgres    false    237            �            1259    16503    scholarship_type    TABLE     �   CREATE TABLE session.scholarship_type (
    scholarship_id integer NOT NULL,
    scholarship_type character varying(30) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    amount integer NOT NULL
);
 %   DROP TABLE session.scholarship_type;
       session         heap    postgres    false    6            �           0    0    TABLE scholarship_type    COMMENT     J   COMMENT ON TABLE session.scholarship_type IS 'Тип стипендии';
          session          postgres    false    235            �            1259    16506 #   scholarship_type_scholarship_id_seq    SEQUENCE     �   CREATE SEQUENCE session.scholarship_type_scholarship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE session.scholarship_type_scholarship_id_seq;
       session          postgres    false    6    235            �           0    0 #   scholarship_type_scholarship_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE session.scholarship_type_scholarship_id_seq OWNED BY session.scholarship_type.scholarship_id;
          session          postgres    false    236            �            1259    16475    student    TABLE     �   CREATE TABLE session.student (
    surname character varying(30) NOT NULL,
    name character varying(30) NOT NULL,
    patronymic character varying(30),
    student_id integer NOT NULL
);
    DROP TABLE session.student;
       session         heap    postgres    false    6            �           0    0    TABLE student    COMMENT     6   COMMENT ON TABLE session.student IS 'Студент';
          session          postgres    false    229            �            1259    16481    student_in_group    TABLE       CREATE TABLE session.student_in_group (
    start_date date NOT NULL,
    end_date date NOT NULL,
    group_name character varying(10) NOT NULL,
    student_id integer NOT NULL,
    student_in_group_id integer NOT NULL,
    status session.status NOT NULL
);
 %   DROP TABLE session.student_in_group;
       session         heap    postgres    false    927    6            �           0    0    TABLE student_in_group    COMMENT     O   COMMENT ON TABLE session.student_in_group IS 'Студент в группе';
          session          postgres    false    230            �            1259    16474    student_student_id_seq    SEQUENCE     �   CREATE SEQUENCE session.student_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE session.student_student_id_seq;
       session          postgres    false    6    229            �           0    0    student_student_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE session.student_student_id_seq OWNED BY session.student.student_id;
          session          postgres    false    228            �            1259    16461    subject    TABLE     =  CREATE TABLE session.subject (
    subject_id integer NOT NULL,
    subject_name character varying(30) NOT NULL,
    lecture_hours integer NOT NULL,
    practice_hours integer NOT NULL,
    lab_hours integer NOT NULL,
    edu_practice_hours integer NOT NULL,
    attestation_type session.attestation_type NOT NULL
);
    DROP TABLE session.subject;
       session         heap    postgres    false    6    924            �           0    0    TABLE subject    COMMENT     <   COMMENT ON TABLE session.subject IS 'Дисциплина';
          session          postgres    false    225            �            1259    16460    subject_subject_id_seq    SEQUENCE     �   CREATE SEQUENCE session.subject_subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE session.subject_subject_id_seq;
       session          postgres    false    225    6            �           0    0    subject_subject_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE session.subject_subject_id_seq OWNED BY session.subject.subject_id;
          session          postgres    false    224            �            1259    16487    teacher    TABLE       CREATE TABLE session.teacher (
    teacher_id integer NOT NULL,
    surname character varying(30) NOT NULL,
    name character varying(30) NOT NULL,
    patronymic character varying(30),
    "position" character varying(30) NOT NULL,
    faculty_id integer NOT NULL
);
    DROP TABLE session.teacher;
       session         heap    postgres    false    6            �           0    0    TABLE teacher    COMMENT     B   COMMENT ON TABLE session.teacher IS 'Преподаватель';
          session          postgres    false    232            �            1259    16486    teacher_teacher_id_seq    SEQUENCE     �   CREATE SEQUENCE session.teacher_teacher_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE session.teacher_teacher_id_seq;
       session          postgres    false    6    232            �           0    0    teacher_teacher_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE session.teacher_teacher_id_seq OWNED BY session.teacher.teacher_id;
          session          postgres    false    231            �           2604    16531    attestation attestation_id    DEFAULT     �   ALTER TABLE ONLY session.attestation ALTER COLUMN attestation_id SET DEFAULT nextval('session.attestation_attestation_id_seq'::regclass);
 J   ALTER TABLE session.attestation ALTER COLUMN attestation_id DROP DEFAULT;
       session          postgres    false    241    233            �           2604    16538 .   attestation_timetable attestation_timetable_id    DEFAULT     �   ALTER TABLE ONLY session.attestation_timetable ALTER COLUMN attestation_timetable_id SET DEFAULT nextval('session.attestation_timetable_attestation_timetable_id_seq'::regclass);
 ^   ALTER TABLE session.attestation_timetable ALTER COLUMN attestation_timetable_id DROP DEFAULT;
       session          postgres    false    242    234            �           2604    16440    building building_id    DEFAULT     ~   ALTER TABLE ONLY session.building ALTER COLUMN building_id SET DEFAULT nextval('session.building_building_id_seq'::regclass);
 D   ALTER TABLE session.building ALTER COLUMN building_id DROP DEFAULT;
       session          postgres    false    218    219    219            �           2604    16454    classroom classroom_id    DEFAULT     �   ALTER TABLE ONLY session.classroom ALTER COLUMN classroom_id SET DEFAULT nextval('session.classroom_classroom_id_seq'::regclass);
 F   ALTER TABLE session.classroom ALTER COLUMN classroom_id DROP DEFAULT;
       session          postgres    false    223    222            �           2604    16471 $   edu_plan_subject edu_plan_subject_id    DEFAULT     �   ALTER TABLE ONLY session.edu_plan_subject ALTER COLUMN edu_plan_subject_id SET DEFAULT nextval('session.edu_plan_subject_edu_plan_subject_id_seq'::regclass);
 T   ALTER TABLE session.edu_plan_subject ALTER COLUMN edu_plan_subject_id DROP DEFAULT;
       session          postgres    false    226    227    227            �           2604    16545    edu_program program_id    DEFAULT     �   ALTER TABLE ONLY session.edu_program ALTER COLUMN program_id SET DEFAULT nextval('session.edu_program_program_id_seq'::regclass);
 F   ALTER TABLE session.edu_program ALTER COLUMN program_id DROP DEFAULT;
       session          postgres    false    243    216            �           2604    16554    edu_track track_id    DEFAULT     z   ALTER TABLE ONLY session.edu_track ALTER COLUMN track_id SET DEFAULT nextval('session.edu_track_track_id_seq'::regclass);
 B   ALTER TABLE session.edu_track ALTER COLUMN track_id DROP DEFAULT;
       session          postgres    false    244    215            �           2604    16447    faculty faculty_id    DEFAULT     z   ALTER TABLE ONLY session.faculty ALTER COLUMN faculty_id SET DEFAULT nextval('session.faculty_faculty_id_seq'::regclass);
 B   ALTER TABLE session.faculty ALTER COLUMN faculty_id DROP DEFAULT;
       session          postgres    false    220    221    221            �           2604    16525    group group_id    DEFAULT     t   ALTER TABLE ONLY session."group" ALTER COLUMN group_id SET DEFAULT nextval('session.group_group_id_seq'::regclass);
 @   ALTER TABLE session."group" ALTER COLUMN group_id DROP DEFAULT;
       session          postgres    false    240    239    240            �           2604    16517 (   scholarship_payments paid_scholarship_id    DEFAULT     �   ALTER TABLE ONLY session.scholarship_payments ALTER COLUMN paid_scholarship_id SET DEFAULT nextval('session.scholarship_payments_paid_scholarship_id_seq'::regclass);
 X   ALTER TABLE session.scholarship_payments ALTER COLUMN paid_scholarship_id DROP DEFAULT;
       session          postgres    false    238    237    238            �           2604    16507    scholarship_type scholarship_id    DEFAULT     �   ALTER TABLE ONLY session.scholarship_type ALTER COLUMN scholarship_id SET DEFAULT nextval('session.scholarship_type_scholarship_id_seq'::regclass);
 O   ALTER TABLE session.scholarship_type ALTER COLUMN scholarship_id DROP DEFAULT;
       session          postgres    false    236    235            �           2604    16478    student student_id    DEFAULT     z   ALTER TABLE ONLY session.student ALTER COLUMN student_id SET DEFAULT nextval('session.student_student_id_seq'::regclass);
 B   ALTER TABLE session.student ALTER COLUMN student_id DROP DEFAULT;
       session          postgres    false    228    229    229            �           2604    16464    subject subject_id    DEFAULT     z   ALTER TABLE ONLY session.subject ALTER COLUMN subject_id SET DEFAULT nextval('session.subject_subject_id_seq'::regclass);
 B   ALTER TABLE session.subject ALTER COLUMN subject_id DROP DEFAULT;
       session          postgres    false    224    225    225            �           2604    16490    teacher teacher_id    DEFAULT     z   ALTER TABLE ONLY session.teacher ALTER COLUMN teacher_id SET DEFAULT nextval('session.teacher_teacher_id_seq'::regclass);
 B   ALTER TABLE session.teacher ALTER COLUMN teacher_id DROP DEFAULT;
       session          postgres    false    232    231    232            �          0    16493    attestation 
   TABLE DATA           �   COPY session.attestation (grade, attestation_date, teacher_id, edu_plan_subject_id, student_id, attempt_count, attestation_id) FROM stdin;
    session          postgres    false    233   ��       �          0    16498    attestation_timetable 
   TABLE DATA           �   COPY session.attestation_timetable (group_id, edu_plan_subject_id, classroom_id, exam_date, teacher_id, attestation_timetable_id, semester) FROM stdin;
    session          postgres    false    234   ��       �          0    16437    building 
   TABLE DATA           H   COPY session.building (building_id, address, building_name) FROM stdin;
    session          postgres    false    219   ��       �          0    16450 	   classroom 
   TABLE DATA           _   COPY session.classroom (classroom_id, capacity, room, building_id, classroom_type) FROM stdin;
    session          postgres    false    222   ��       �          0    16431    edu_plan 
   TABLE DATA           S   COPY session.edu_plan (plan_id, program_id, learning_type, start_year) FROM stdin;
    session          postgres    false    217   �       �          0    16468    edu_plan_subject 
   TABLE DATA           i   COPY session.edu_plan_subject (edu_plan_subject_id, subject_id, subject_name, learning_type) FROM stdin;
    session          postgres    false    227   6�       �          0    16407    edu_program 
   TABLE DATA           B   COPY session.edu_program (track_id, name, program_id) FROM stdin;
    session          postgres    false    216   S�       �          0    16400 	   edu_track 
   TABLE DATA           4   COPY session.edu_track (name, track_id) FROM stdin;
    session          postgres    false    215   p�       �          0    16444    faculty 
   TABLE DATA           I   COPY session.faculty (faculty_id, building_id, faculty_name) FROM stdin;
    session          postgres    false    221   ��       �          0    16522    group 
   TABLE DATA           V   COPY session."group" (group_id, study_year, course, group_name, semester) FROM stdin;
    session          postgres    false    240   ��       �          0    16514    scholarship_payments 
   TABLE DATA           v   COPY session.scholarship_payments (student_id, scholarship_id, paid_scholarship_id, start_date, end_date) FROM stdin;
    session          postgres    false    238   ��       �          0    16503    scholarship_type 
   TABLE DATA           k   COPY session.scholarship_type (scholarship_id, scholarship_type, start_date, end_date, amount) FROM stdin;
    session          postgres    false    235   ��       �          0    16475    student 
   TABLE DATA           I   COPY session.student (surname, name, patronymic, student_id) FROM stdin;
    session          postgres    false    229   �       �          0    16481    student_in_group 
   TABLE DATA           v   COPY session.student_in_group (start_date, end_date, group_name, student_id, student_in_group_id, status) FROM stdin;
    session          postgres    false    230   �       �          0    16461    subject 
   TABLE DATA           �   COPY session.subject (subject_id, subject_name, lecture_hours, practice_hours, lab_hours, edu_practice_hours, attestation_type) FROM stdin;
    session          postgres    false    225   ;�       �          0    16487    teacher 
   TABLE DATA           a   COPY session.teacher (teacher_id, surname, name, patronymic, "position", faculty_id) FROM stdin;
    session          postgres    false    232   X�       �           0    0    attestation_attestation_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('session.attestation_attestation_id_seq', 1, false);
          session          postgres    false    241            �           0    0 2   attestation_timetable_attestation_timetable_id_seq    SEQUENCE SET     b   SELECT pg_catalog.setval('session.attestation_timetable_attestation_timetable_id_seq', 1, false);
          session          postgres    false    242            �           0    0    building_building_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('session.building_building_id_seq', 1, false);
          session          postgres    false    218            �           0    0    classroom_classroom_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('session.classroom_classroom_id_seq', 1, false);
          session          postgres    false    223            �           0    0 (   edu_plan_subject_edu_plan_subject_id_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('session.edu_plan_subject_edu_plan_subject_id_seq', 1, false);
          session          postgres    false    226            �           0    0    edu_program_program_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('session.edu_program_program_id_seq', 1, false);
          session          postgres    false    243            �           0    0    edu_track_track_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('session.edu_track_track_id_seq', 1, false);
          session          postgres    false    244            �           0    0    faculty_faculty_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('session.faculty_faculty_id_seq', 1, false);
          session          postgres    false    220            �           0    0    group_group_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('session.group_group_id_seq', 1, false);
          session          postgres    false    239            �           0    0 ,   scholarship_payments_paid_scholarship_id_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('session.scholarship_payments_paid_scholarship_id_seq', 1, false);
          session          postgres    false    237            �           0    0 #   scholarship_type_scholarship_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('session.scholarship_type_scholarship_id_seq', 1, false);
          session          postgres    false    236            �           0    0    student_student_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('session.student_student_id_seq', 1, false);
          session          postgres    false    228            �           0    0    subject_subject_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('session.subject_subject_id_seq', 1, false);
          session          postgres    false    224            �           0    0    teacher_teacher_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('session.teacher_teacher_id_seq', 1, false);
          session          postgres    false    231            �           2606    16687    attestation attempt count check    CHECK CONSTRAINT     �   ALTER TABLE session.attestation
    ADD CONSTRAINT "attempt count check" CHECK (((attempt_count >= 0) AND (attempt_count <= 3))) NOT VALID;
 G   ALTER TABLE session.attestation DROP CONSTRAINT "attempt count check";
       session          postgres    false    233    233            �           2606    16536    attestation attestation_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY session.attestation
    ADD CONSTRAINT attestation_pkey PRIMARY KEY (attestation_id);
 G   ALTER TABLE ONLY session.attestation DROP CONSTRAINT attestation_pkey;
       session            postgres    false    233            �           2606    16543 0   attestation_timetable attestation_timetable_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY session.attestation_timetable
    ADD CONSTRAINT attestation_timetable_pkey PRIMARY KEY (attestation_timetable_id);
 [   ALTER TABLE ONLY session.attestation_timetable DROP CONSTRAINT attestation_timetable_pkey;
       session            postgres    false    234            �           2606    16442    building building_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY session.building
    ADD CONSTRAINT building_pkey PRIMARY KEY (building_id);
 A   ALTER TABLE ONLY session.building DROP CONSTRAINT building_pkey;
       session            postgres    false    219            �           2606    16652    classroom capacity  check    CHECK CONSTRAINT        ALTER TABLE session.classroom
    ADD CONSTRAINT "capacity  check" CHECK (((capacity >= 0) AND (capacity <= 1000))) NOT VALID;
 A   ALTER TABLE session.classroom DROP CONSTRAINT "capacity  check";
       session          postgres    false    222    222            �           2606    16689    scholarship_type check amount    CHECK CONSTRAINT     g   ALTER TABLE session.scholarship_type
    ADD CONSTRAINT "check amount" CHECK ((amount > 0)) NOT VALID;
 E   ALTER TABLE session.scholarship_type DROP CONSTRAINT "check amount";
       session          postgres    false    235    235            �           2606    16685    student_in_group check dates    CHECK CONSTRAINT     q   ALTER TABLE session.student_in_group
    ADD CONSTRAINT "check dates" CHECK ((start_date < end_date)) NOT VALID;
 D   ALTER TABLE session.student_in_group DROP CONSTRAINT "check dates";
       session          postgres    false    230    230    230    230            �           2606    16688    scholarship_type check dates    CHECK CONSTRAINT     q   ALTER TABLE session.scholarship_type
    ADD CONSTRAINT "check dates" CHECK ((start_date < end_date)) NOT VALID;
 D   ALTER TABLE session.scholarship_type DROP CONSTRAINT "check dates";
       session          postgres    false    235    235    235    235            �           2606    16690     scholarship_payments check dates    CHECK CONSTRAINT     u   ALTER TABLE session.scholarship_payments
    ADD CONSTRAINT "check dates" CHECK ((start_date < end_date)) NOT VALID;
 H   ALTER TABLE session.scholarship_payments DROP CONSTRAINT "check dates";
       session          postgres    false    238    238    238    238            �           2606    16686    attestation check grade    CHECK CONSTRAINT     t   ALTER TABLE session.attestation
    ADD CONSTRAINT "check grade" CHECK (((grade >= 2) AND (grade <= 5))) NOT VALID;
 ?   ALTER TABLE session.attestation DROP CONSTRAINT "check grade";
       session          postgres    false    233    233            �           2606    16459    classroom classroom_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY session.classroom
    ADD CONSTRAINT classroom_pkey PRIMARY KEY (classroom_id);
 C   ALTER TABLE ONLY session.classroom DROP CONSTRAINT classroom_pkey;
       session            postgres    false    222            �           2606    16651    group course int check    CHECK CONSTRAINT     w   ALTER TABLE session."group"
    ADD CONSTRAINT "course int check" CHECK (((course >= 1) AND (course <= 4))) NOT VALID;
 @   ALTER TABLE session."group" DROP CONSTRAINT "course int check";
       session          postgres    false    240    240            �           2606    16674     subject edu practice hours check    CHECK CONSTRAINT     v   ALTER TABLE session.subject
    ADD CONSTRAINT "edu practice hours check" CHECK ((edu_practice_hours > 0)) NOT VALID;
 H   ALTER TABLE session.subject DROP CONSTRAINT "edu practice hours check";
       session          postgres    false    225    225            �           2606    16435    edu_plan edu_plan_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY session.edu_plan
    ADD CONSTRAINT edu_plan_pkey PRIMARY KEY (plan_id);
 A   ALTER TABLE ONLY session.edu_plan DROP CONSTRAINT edu_plan_pkey;
       session            postgres    false    217            �           2606    16473 &   edu_plan_subject edu_plan_subject_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY session.edu_plan_subject
    ADD CONSTRAINT edu_plan_subject_pkey PRIMARY KEY (edu_plan_subject_id);
 Q   ALTER TABLE ONLY session.edu_plan_subject DROP CONSTRAINT edu_plan_subject_pkey;
       session            postgres    false    227            �           2606    16552    edu_program edu_program_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY session.edu_program
    ADD CONSTRAINT edu_program_pkey PRIMARY KEY (program_id);
 G   ALTER TABLE ONLY session.edu_program DROP CONSTRAINT edu_program_pkey;
       session            postgres    false    216            �           2606    16561    edu_track edu_track_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY session.edu_track
    ADD CONSTRAINT edu_track_pkey PRIMARY KEY (track_id);
 C   ALTER TABLE ONLY session.edu_track DROP CONSTRAINT edu_track_pkey;
       session            postgres    false    215            �           2606    16449    faculty faculty_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY session.faculty
    ADD CONSTRAINT faculty_pkey PRIMARY KEY (faculty_id);
 ?   ALTER TABLE ONLY session.faculty DROP CONSTRAINT faculty_pkey;
       session            postgres    false    221            �           2606    16527    group group_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY session."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (group_id);
 =   ALTER TABLE ONLY session."group" DROP CONSTRAINT group_pkey;
       session            postgres    false    240            �           2606    16673    subject labs hours check    CHECK CONSTRAINT     e   ALTER TABLE session.subject
    ADD CONSTRAINT "labs hours check" CHECK ((lab_hours > 0)) NOT VALID;
 @   ALTER TABLE session.subject DROP CONSTRAINT "labs hours check";
       session          postgres    false    225    225            �           2606    16671    subject lecture hours check    CHECK CONSTRAINT     l   ALTER TABLE session.subject
    ADD CONSTRAINT "lecture hours check" CHECK ((lecture_hours > 0)) NOT VALID;
 C   ALTER TABLE session.subject DROP CONSTRAINT "lecture hours check";
       session          postgres    false    225    225            �           2606    16672    subject practice hours check    CHECK CONSTRAINT     n   ALTER TABLE session.subject
    ADD CONSTRAINT "practice hours check" CHECK ((practice_hours > 0)) NOT VALID;
 D   ALTER TABLE session.subject DROP CONSTRAINT "practice hours check";
       session          postgres    false    225    225            �           2606    16519 .   scholarship_payments scholarship_payments_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY session.scholarship_payments
    ADD CONSTRAINT scholarship_payments_pkey PRIMARY KEY (paid_scholarship_id);
 Y   ALTER TABLE ONLY session.scholarship_payments DROP CONSTRAINT scholarship_payments_pkey;
       session            postgres    false    238            �           2606    16512 &   scholarship_type scholarship_type_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY session.scholarship_type
    ADD CONSTRAINT scholarship_type_pkey PRIMARY KEY (scholarship_id);
 Q   ALTER TABLE ONLY session.scholarship_type DROP CONSTRAINT scholarship_type_pkey;
       session            postgres    false    235            �           2606    16645    edu_plan start year constraint    CHECK CONSTRAINT     o   ALTER TABLE session.edu_plan
    ADD CONSTRAINT "start year constraint" CHECK ((start_year > 1899)) NOT VALID;
 F   ALTER TABLE session.edu_plan DROP CONSTRAINT "start year constraint";
       session          postgres    false    217    217            �           2606    16529 &   student_in_group student_in_group_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY session.student_in_group
    ADD CONSTRAINT student_in_group_pkey PRIMARY KEY (student_in_group_id);
 Q   ALTER TABLE ONLY session.student_in_group DROP CONSTRAINT student_in_group_pkey;
       session            postgres    false    230            �           2606    16480    student student_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY session.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);
 ?   ALTER TABLE ONLY session.student DROP CONSTRAINT student_pkey;
       session            postgres    false    229            �           2606    16466    subject subject_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY session.subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (subject_id);
 ?   ALTER TABLE ONLY session.subject DROP CONSTRAINT subject_pkey;
       session            postgres    false    225            �           2606    16492    teacher teacher_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY session.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (teacher_id);
 ?   ALTER TABLE ONLY session.teacher DROP CONSTRAINT teacher_pkey;
       session            postgres    false    232            �           2606    16572    classroom building    FK CONSTRAINT     �   ALTER TABLE ONLY session.classroom
    ADD CONSTRAINT building FOREIGN KEY (building_id) REFERENCES session.building(building_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 =   ALTER TABLE ONLY session.classroom DROP CONSTRAINT building;
       session          postgres    false    3296    219    222                       2606    16617 "   attestation_timetable classroom_id    FK CONSTRAINT     �   ALTER TABLE ONLY session.attestation_timetable
    ADD CONSTRAINT classroom_id FOREIGN KEY (classroom_id) REFERENCES session.classroom(classroom_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 M   ALTER TABLE ONLY session.attestation_timetable DROP CONSTRAINT classroom_id;
       session          postgres    false    222    3300    234                       2606    16612 &   attestation_timetable edu_plan_subject    FK CONSTRAINT     �   ALTER TABLE ONLY session.attestation_timetable
    ADD CONSTRAINT edu_plan_subject FOREIGN KEY (edu_plan_subject_id) REFERENCES session.edu_plan_subject(edu_plan_subject_id) NOT VALID;
 Q   ALTER TABLE ONLY session.attestation_timetable DROP CONSTRAINT edu_plan_subject;
       session          postgres    false    3304    234    227            �           2606    16597    attestation edu_plan_subject_id    FK CONSTRAINT     �   ALTER TABLE ONLY session.attestation
    ADD CONSTRAINT edu_plan_subject_id FOREIGN KEY (edu_plan_subject_id) REFERENCES session.edu_plan_subject(edu_plan_subject_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 J   ALTER TABLE ONLY session.attestation DROP CONSTRAINT edu_plan_subject_id;
       session          postgres    false    3304    233    227            �           2606    16567    edu_plan edu_program    FK CONSTRAINT     �   ALTER TABLE ONLY session.edu_plan
    ADD CONSTRAINT edu_program FOREIGN KEY (program_id) REFERENCES session.edu_program(program_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 ?   ALTER TABLE ONLY session.edu_plan DROP CONSTRAINT edu_program;
       session          postgres    false    3292    217    216            �           2606    16587    teacher faculty    FK CONSTRAINT     �   ALTER TABLE ONLY session.teacher
    ADD CONSTRAINT faculty FOREIGN KEY (faculty_id) REFERENCES session.faculty(faculty_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 :   ALTER TABLE ONLY session.teacher DROP CONSTRAINT faculty;
       session          postgres    false    221    232    3298                       2606    16607    attestation_timetable group_id    FK CONSTRAINT     �   ALTER TABLE ONLY session.attestation_timetable
    ADD CONSTRAINT group_id FOREIGN KEY (group_id) REFERENCES session."group"(group_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 I   ALTER TABLE ONLY session.attestation_timetable DROP CONSTRAINT group_id;
       session          postgres    false    3320    234    240                       2606    16632 #   scholarship_payments scholarship_id    FK CONSTRAINT     �   ALTER TABLE ONLY session.scholarship_payments
    ADD CONSTRAINT scholarship_id FOREIGN KEY (scholarship_id) REFERENCES session.scholarship_type(scholarship_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 N   ALTER TABLE ONLY session.scholarship_payments DROP CONSTRAINT scholarship_id;
       session          postgres    false    3316    238    235            �           2606    16582    student_in_group student_id    FK CONSTRAINT     �   ALTER TABLE ONLY session.student_in_group
    ADD CONSTRAINT student_id FOREIGN KEY (student_id) REFERENCES session.student(student_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 F   ALTER TABLE ONLY session.student_in_group DROP CONSTRAINT student_id;
       session          postgres    false    229    3306    230                        2606    16602    attestation student_id    FK CONSTRAINT     �   ALTER TABLE ONLY session.attestation
    ADD CONSTRAINT student_id FOREIGN KEY (student_id) REFERENCES session.student(student_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 A   ALTER TABLE ONLY session.attestation DROP CONSTRAINT student_id;
       session          postgres    false    229    233    3306                       2606    16627    scholarship_payments student_id    FK CONSTRAINT     �   ALTER TABLE ONLY session.scholarship_payments
    ADD CONSTRAINT student_id FOREIGN KEY (student_id) REFERENCES session.student(student_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 J   ALTER TABLE ONLY session.scholarship_payments DROP CONSTRAINT student_id;
       session          postgres    false    229    238    3306            �           2606    16577    edu_plan_subject subject_id    FK CONSTRAINT     �   ALTER TABLE ONLY session.edu_plan_subject
    ADD CONSTRAINT subject_id FOREIGN KEY (subject_id) REFERENCES session.subject(subject_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 F   ALTER TABLE ONLY session.edu_plan_subject DROP CONSTRAINT subject_id;
       session          postgres    false    3302    227    225                       2606    16592    attestation teacher_id    FK CONSTRAINT     �   ALTER TABLE ONLY session.attestation
    ADD CONSTRAINT teacher_id FOREIGN KEY (teacher_id) REFERENCES session.teacher(teacher_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 A   ALTER TABLE ONLY session.attestation DROP CONSTRAINT teacher_id;
       session          postgres    false    232    233    3310                       2606    16622     attestation_timetable teacher_id    FK CONSTRAINT     �   ALTER TABLE ONLY session.attestation_timetable
    ADD CONSTRAINT teacher_id FOREIGN KEY (teacher_id) REFERENCES session.teacher(teacher_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 K   ALTER TABLE ONLY session.attestation_timetable DROP CONSTRAINT teacher_id;
       session          postgres    false    234    3310    232            �           2606    16562    edu_program track    FK CONSTRAINT     �   ALTER TABLE ONLY session.edu_program
    ADD CONSTRAINT track FOREIGN KEY (track_id) REFERENCES session.edu_track(track_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 <   ALTER TABLE ONLY session.edu_program DROP CONSTRAINT track;
       session          postgres    false    216    215    3290            �           0    16481    student_in_group    ROW SECURITY     ?   ALTER TABLE session.student_in_group ENABLE ROW LEVEL SECURITY;          session          postgres    false    230            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �     