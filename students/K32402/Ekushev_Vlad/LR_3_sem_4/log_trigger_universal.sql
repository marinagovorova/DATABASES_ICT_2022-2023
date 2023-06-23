CREATE OR REPLACE TYPE public.cud_operation_enum AS ENUM
    ('insert', 'update', 'delete');

ALTER TYPE public.cud_operation_enum
    OWNER TO postgres;

create table logs(
	id serial primary key,
	op_type cud_operation_enum not null,
	op_timestamp timestamp not null,
	old_data text,
	new_data text
);

CREATE FUNCTION public.log_operation()
    RETURNS trigger
    LANGUAGE 'plpgsql'
     NOT LEAKPROOF
AS $BODY$
declare
	op_type cud_operation_enum;
begin
	if tg_op='INSERT' then
		op_type := 'insert';
		insert into logs(op_type, op_timestamp, new_data)
		values (op_type, now(), new::text);
		return new;
	end if;
	if tg_op='UPDATE' then
		op_type := 'update';
		insert into logs(op_type, op_timestamp, old_data, new_data)
		values (op_type, now(), old::text, new::text);
		return new;
	end if;
	if tg_op='DELETE' then
		op_type := 'delete';
		insert into logs(op_type, op_timestamp, old_data)
		values (op_type, now(), old::text);
		return old;
	end if;
end;
$BODY$;

ALTER FUNCTION public.log_operation()
    OWNER TO postgres;

create trigger scholarship_assignment_log_trigger
	after insert or update or delete on scholarship_assignment
	for each row execute procedure log_operation();