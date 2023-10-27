unit EmployeePostgresRepository;

interface

uses

  AbstractPostgresRepositoryUnit,
  DomainObjectUnit,
  Employee,
  Role,
  EmployeeRepository,
  DBTableMappingUnit,
  DataReader,
  VariantListUnit,
  QueryExecutor,
  SysUtils,
  Classes;

type

  TEmployeePostgresRepository =
    class (TAbstractPostgresRepository, IEmployeeRepository)

      protected

        procedure CustomizeTableMapping(
          TableMapping: TDBTableMapping
        ); override;

      protected

        procedure FillDomainObjectFromDataReader(
          DomainObject: TDomainObject;
          DataReader: IDataReader
        ); override;

        function GetQueryParameterValueFromDomainObject(
          DomainObject: TDomainObject;
          const DomainObjectPropertyName: String
        ): Variant; override;

      protected

        function LoadRoleFromDataReader(DataReader: IDataReader): TRole;

      public

        constructor Create(QueryExecutor: IQueryExecutor);
        
        function AddEmployee(Employee: TEmployee): Boolean;
        function AddEmployees(Employees: TEmployees): Boolean;
        function UpdateEmployee(Employee: TEmployee): Boolean;
        function UpdateEmployees(Employees: TEmployees): Boolean;
        function RemoveEmployee(Employee: TEmployee): Boolean;
        function RemoveEmployees(Employees: TEmployees): Boolean;
        function FindEmployeeById(const EmployeeId: Variant): TEmployee;
        function FindEmployeesByIds(const EmployeeIds: TVariantList): TEmployees;
        function GetAllEmployees: TEmployees;

    end;
  
implementation

uses

  PostgresTypeNameConstants,
  StandardFuelCharacteristicsAccountingRepositoryRegistry,
  EmployeeTableDefinition;
  
{ TEmployeePostgresRepository }

constructor TEmployeePostgresRepository.Create(QueryExecutor: IQueryExecutor);
begin

  inherited;
  
end;

procedure TEmployeePostgresRepository.CustomizeTableMapping(
  TableMapping: TDBTableMapping);
begin

  inherited;

  TableMapping.SetTableNameMapping(
    EMPLOYEE_TABLE_NAME, TEmployee, TEmployees
  );

  TableMapping.AddColumnMappingForSelect(
    EMPLOYEE_TABLE_ID_COLUMN_NAME, 'Identity'
  );

  TableMapping.AddColumnMappingForSelect(
    EMPLOYEE_TABLE_NAME_COLUMN_NAME, 'Name'
  );

  TableMapping.AddColumnMappingForSelect(
    EMPLOYEE_TABLE_SURNAME_COLUMN_NAME, 'Surname'
  );

  TableMapping.AddColumnMappingForSelect(
    EMPLOYEE_TABLE_PATRONYMIC_COLUMN_NAME, 'Patronymic'
  );

  TableMapping.AddColumnMappingForSelect(
    EMPLOYEE_TABLE_BIRTH_DATE_COLUMN_NAME, 'BirthDate'
  );

  TableMapping.AddColumnMappingForSelect(
    EMPLOYEE_TABLE_SPECIALITY_COLUMN_NAME, 'Speciality'
  );

  TableMapping.AddColumnMappingForSelect(
    EMPLOYEE_TABLE_ROLE_ID_COLUMN_NAME, 'Role', False
  );

  TableMapping.AddColumnMappingForModification(
    EMPLOYEE_TABLE_NAME_COLUMN_NAME, 'Name'
  );

  TableMapping.AddColumnMappingForModification(
    EMPLOYEE_TABLE_SURNAME_COLUMN_NAME, 'Surname'
  );

  TableMapping.AddColumnMappingForModification(
    EMPLOYEE_TABLE_PATRONYMIC_COLUMN_NAME, 'Patronymic'
  );

  TableMapping.AddColumnMappingForModification(
    EMPLOYEE_TABLE_BIRTH_DATE_COLUMN_NAME, 'BirthDate', DATE_TYPE_NAME
  );

  TableMapping.AddColumnMappingForModification(
    EMPLOYEE_TABLE_SPECIALITY_COLUMN_NAME, 'Speciality'
  );

  TableMapping.AddColumnMappingForModification(
    EMPLOYEE_TABLE_ROLE_ID_COLUMN_NAME, 'Role'
  );

  TableMapping.AddPrimaryKeyColumnMapping(
    EMPLOYEE_TABLE_ID_COLUMN_NAME, 'Identity'
  );
  
end;

function TEmployeePostgresRepository.AddEmployee(Employee: TEmployee): Boolean;
begin

  Result := inherited Add(Employee);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TEmployeePostgresRepository.AddEmployees(
  Employees: TEmployees): Boolean;
begin

  Result := AddDomainObjectList(Employees);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TEmployeePostgresRepository.FindEmployeeById(
  const EmployeeId: Variant): TEmployee;
begin

  Result := TEmployee(FindDomainObjectByIdentity(EmployeeId));

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TEmployeePostgresRepository.FindEmployeesByIds(
  const EmployeeIds: TVariantList): TEmployees;
begin

  Result := TEmployees(FindDomainObjectsByIdentities(EmployeeIds));

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TEmployeePostgresRepository.GetAllEmployees: TEmployees;
begin

  Result := TEmployees(LoadAll);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TEmployeePostgresRepository.RemoveEmployee(
  Employee: TEmployee): Boolean;
begin

  Result := Remove(Employee);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TEmployeePostgresRepository.RemoveEmployees(
  Employees: TEmployees): Boolean;
begin

  Result := RemoveDomainObjectList(Employees);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TEmployeePostgresRepository.UpdateEmployee(
  Employee: TEmployee): Boolean;
begin

  Result := Update(Employee);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TEmployeePostgresRepository.UpdateEmployees(
  Employees: TEmployees): Boolean;
begin

  Result := UpdateDomainObjectList(Employees);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

procedure TEmployeePostgresRepository.FillDomainObjectFromDataReader(
  DomainObject: TDomainObject; DataReader: IDataReader
);
var Employee: TEmployee;
begin

  inherited;

  Employee := DomainObject as TEmployee;

  Employee.Role := LoadRoleFromDataReader(DataReader);

end;

function TEmployeePostgresRepository.GetQueryParameterValueFromDomainObject(
  DomainObject: TDomainObject;
  const DomainObjectPropertyName: String
): Variant;
var Employee: TEmployee;
begin

  Employee := DomainObject as TEmployee;

  if DomainObjectPropertyName = 'Role' then
    Result := Employee.Role.Identity

  else begin

    Result :=
      inherited GetQueryParameterValueFromDomainObject(
        DomainObject, DomainObjectPropertyName
      );
      
  end;
  
end;

function TEmployeePostgresRepository.LoadRoleFromDataReader(
  DataReader: IDataReader
): TRole;
var EmployeeRoleIdColumnName: String;
begin

  EmployeeRoleIdColumnName :=
    TableMapping.ColumnMappingsForSelect.
      FindColumnMappingByObjectPropertyName(
        'Role'
      ).ColumnName;

  Result :=
    TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
    .GetRoleRepository
    .FindRoleById(DataReader[EmployeeRoleIdColumnName]);

end;

end.
