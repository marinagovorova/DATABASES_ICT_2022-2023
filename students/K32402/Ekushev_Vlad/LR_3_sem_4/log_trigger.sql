CREATE TYPE public.cud_operation_enum AS ENUM
    ('insert', 'update', 'delete');

ALTER TYPE public.cud_operation_enum
    OWNER TO postgres;

create table scholarship_assignment_logs(
	id serial primary key,
	op_type cud_operation_enum not null,
	op_timestamp timestamp,
	affected_id int null,
	affected_person_id int null,
	affected_scholarship_id int null
);

CREATE FUNCTION public.scholarship_assignment_log()
    RETURNS trigger
    LANGUAGE 'plpgsql'
     NOT LEAKPROOF
AS $BODY$
declare
	op_type cud_operation_enum;
begin
	if tg_op='INSERT' then
		op_type := 'insert';
		insert into scholarship_assignment_logs(op_type, op_timestamp, affected_id, affected_person_id, affected_scholarship_id)
		values (op_type, now(), new.id, new.person_id, new.scholarship_id);
		return new;
	end if;
	if tg_op='UPDATE' then
		op_type := 'update';
		insert into scholarship_assignment_logs(op_type, op_timestamp, affected_id, affected_person_id, affected_scholarship_id)
		values (op_type, now(), old.id, old.person_id, old.scholarship_id);
		return new;
	end if;
	if tg_op='DELETE' then
		op_type := 'delete';
		insert into scholarship_assignment_logs(op_type, op_timestamp, affected_id, affected_person_id, affected_scholarship_id)
		values (op_type, now(), old.id, old.person_id, old.scholarship_id);
		return old;
	end if;
end;
$BODY$;

ALTER FUNCTION public.scholarship_assignment_log()
    OWNER TO postgres;

create trigger scholarship_assignment_log_trigger
	after insert or update or delete on scholarship_assignment
	for each row execute procedure scholarship_assignment_log();