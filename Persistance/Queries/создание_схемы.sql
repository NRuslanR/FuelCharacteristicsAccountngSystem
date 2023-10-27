--create database fca;

create schema fca;

create table fca.roles (
role_id serial primary key,
name varchar not null unique,
display_name varchar not null
);

insert into fca.roles (role_id, name, display_name) 
values (1, 'AircraftTechnician', 'Авиатехник'), (2, 'Accountant', 'Бухгалтер'), (3, 'WarehouseHead', 'Начальник склада');

create table fca.employees (
employee_id serial primary key,
name varchar not null,
surname varchar not null,
birth_date date not null,
patronymic varchar not null,
speciality varchar not null,
employee_role_id int not null references fca.roles (role_id)
);

create table fca.employee_logon_infos (
employee_id int not null primary key references fca.employees (employee_id) on update cascade on delete cascade,
login varchar not null unique
);
 
create table fca.fuel_characteristics_calculation_cards (
card_id serial primary key,
fuel_temperature float not null,
fuel_density float not null,
fuel_rise_level float not null,
fuel_mass float not null,
fuel_kind varchar not null,
reservoir_number int not null,
calculation_performer_id int references fca.employees (employee_id) on update cascade on delete set null,
calculation_performing_datetime timestamp without time zone not null
);

create table fca.reservoir_kinds (
	name varchar not null primary key
);

create table fca.reservoir_kind_reference_suites(
	reservoir_kind_name varchar not null primary key references fca.reservoir_kinds (name) on update cascade on delete cascade,
	hsc_value float not null,
	calibration_chart_location varchar not null
);

--alter table fca.working_time_conditions alter column working_day_beginning_time set not null;

create table fca.working_time_conditions (
conditions_id serial primary key,
name varchar not null,
working_day_beginning_time time not null,
working_day_ending_time time not null,
is_active boolean not null
);

insert into fca.working_time_conditions (name, working_day_beginning_time, working_day_ending_time, is_active) 
values ('Стандартный', '8:00:00', '17:00:00', true);

create view fca.v_employees as
	select 
	*,
	surname || ' ' || name || ' ' || patronymic as full_name
	from fca.employees;

create or replace function fca.create_language_plpgsql() returns boolean
as
$$
	create language plpgsql;
	select true;
$$
language sql; 

create or replace function fca.create_language_plpgsql_if_not_exists() returns boolean
as
$$
	select
		case 
		    when not exists(
			select
			1
			from pg_language
			where lanname = 'plpgsql'
		    )
		then fca.create_language_plpgsql()
		else false end;
		
$$
language sql; 

select fca.create_language_plpgsql_if_not_exists();

create type fca.logon_info_type as (login varchar, password varchar);

create or replace function fca.get_employee_role_logon_data(employee_id bigint) returns setof fca.logon_info_type
as
$$
	select login, ''::varchar as password from fca.employee_logon_infos a where a.employee_id = $1;
$$
language sql;

create or replace function fca.get_employee_role_logon_data_by_login(login varchar) returns setof fca.logon_info_type
as
$$
	select login, ''::varchar as password from fca.employee_logon_infos a where a.login = $1; 
$$
language sql;

create or replace function fca.create_or_update_employee_role(employee_id bigint, role_name varchar, password varchar) returns void
as
$$
declare
	alter_role_query varchar;
	insert_employee_logon_infos_record_query varchar;
	target_query varchar;
	previous_role varchar;
begin

	target_query = '';
	alter_role_query = 'alter role ' || role_name || ' createrole encrypted password ' || quote_literal(password);

	if not exists (select 1 from fca.employee_logon_infos a where a.employee_id = $1 and login = role_name) then
	
		if not exists (select 1 from pg_roles where rolname = role_name) then
		
			if trim(password) <> '' then
				target_query = 'create role ' || role_name || ' createrole login encrypted password ' || quote_literal(password) || ' in role fca_user';

			else raise exception 'Для роли % не назначен пароль', role_name;

			end if;
			
		elsif trim (password) <> '' then 
			target_query = alter_role_query;

		else target_query = '';

		end if;

		if target_query <> '' then
			target_query = target_query || ';';
		end if;

		if not exists (select 1 from fca.employee_logon_infos a where a.employee_id = $1) then 
			target_query = target_query || 'insert into fca.employee_logon_infos (employee_id,login) values (' || employee_id || ',' || quote_literal(role_name) || ')';

		else 
			/*select login into previous_role from fca.employee_logon_infos a where a.employee_id = $1;

			if $2 <> previous_role then
				target_query = target_query || 'drop role if exists ' || previous_role || ';';
			end if;*/

			target_query = target_query || 'update fca.employee_logon_infos set login=' || quote_literal(role_name) || ' where employee_id=' || employee_id;

		end if; 

		execute target_query;

	elsif trim(password) <> '' then
		execute alter_role_query;

	end if;
		
end
$$
language plpgsql;

create or replace function fca.remove_employee_role(employee_id bigint) returns void 
as
$$
declare
	removed_employee_role_name varchar;
begin
	delete from fca.employee_logon_infos a where a.employee_id = $1 returning login into removed_employee_role_name;

	if found then
		execute 'drop role if exists ' || removed_employee_role_name;
	end if;
end
$$
language plpgsql;

create role fca_user createrole;

grant usage on schema fca to fca_user;

grant all privileges on table fca.employee_logon_infos to fca_user; 
grant all privileges on table fca.employees to fca_user;
grant all privileges on table fca.fuel_characteristics_calculation_cards to fca_user;
grant all privileges on table fca.reservoir_kind_reference_suites to fca_user;
grant all privileges on table fca.reservoir_kinds to fca_user;
grant all privileges on table fca.roles to fca_user;
grant all privileges on table fca.v_employees to fca_user;
grant all privileges on table fca.working_time_conditions to fca_user;

grant usage on sequence fca.employees_employee_id_seq to fca_user;
grant usage on sequence fca.fuel_characteristics_calculation_cards_card_id_seq to fca_user;
grant usage on sequence fca.roles_role_id_seq to fca_user;
grant usage on sequence fca.working_time_conditions_conditions_id_seq to fca_user;

grant execute on function fca.create_or_update_employee_role(bigint, varchar, varchar) to fca_user;
grant execute on function fca.get_employee_role_logon_data(bigint) to fca_user;
grant execute on function fca.get_employee_role_logon_data_by_login(varchar) to fca_user;
grant execute on function fca.remove_employee_role(bigint) to fca_user;
