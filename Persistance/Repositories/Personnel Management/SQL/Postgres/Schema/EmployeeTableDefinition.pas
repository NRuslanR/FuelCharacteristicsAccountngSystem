unit EmployeeTableDefinition;

interface

uses

  SchemaDefinition;

const

  EMPLOYEE_TABLE_NAME = SCHEMA_NAME + '.' + 'employees';

  EMPLOYEE_TABLE_ID_COLUMN_NAME = 'employee_id';
  EMPLOYEE_TABLE_NAME_COLUMN_NAME = 'name';
  EMPLOYEE_TABLE_SURNAME_COLUMN_NAME = 'surname';
  EMPLOYEE_TABLE_PATRONYMIC_COLUMN_NAME = 'patronymic';
  EMPLOYEE_TABLE_BIRTH_DATE_COLUMN_NAME = 'birth_date';
  EMPLOYEE_TABLE_SPECIALITY_COLUMN_NAME = 'speciality';
  EMPLOYEE_TABLE_ROLE_ID_COLUMN_NAME = 'employee_role_id';
  EMPLOYEE_TABLE_LOGIN_COLUMN_NAME = 'login';
  
implementation

end.
