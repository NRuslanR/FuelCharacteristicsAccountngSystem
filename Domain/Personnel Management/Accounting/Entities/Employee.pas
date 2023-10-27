unit Employee;

interface

uses

  Role,
  DomainObjectUnit,
  DomainException,
  DomainObjectListUnit,
  SysUtils,
  Classes;

type

  TEmployeeException = class (TDomainObjectException)

  end;
  
  TEmployee = class (TDomainObject)

    private

      FName: String;
      FSurname: String;
      FPatronymic: String;
      FBirthDate: TDateTime;
      FSpeciality: String;
      FRole: TRole;
      
      procedure SetBirthDate(const Value: TDateTime);
      procedure SetName(const Value: String);
      procedure SetPatronymic(const Value: String);
      procedure SetSpeciality(const Value: String);
      procedure SetSurname(const Value: String);
      procedure SetRole(const Value: TRole);

    private

      procedure RaiseExceptionIfBirthDateIsNotValid(const Value: TDateTime);
      procedure RaiseExceptionIfPatronymicIsNotValid(const Value: String);
      procedure RaiseExceptionIfRoleIsNotValid(const Value: TRole);
      procedure RaiseExceptionIfSpecialityIsNotValid(const Value: String);
      procedure RaiseExceptionIfSurnameIsNotValid(const Value: String);
      procedure RaiseExceptionIfNameIsNotValid(const Value: String);
      
    protected

      procedure SetInvariantsComplianceRequested(const Value: Boolean); override;

    public

      function HasRole: Boolean;
      
      function IsWarehouseHead: Boolean;
      function IsAccountant: Boolean;
      function IsAircraftTechnician: Boolean;

    public

      function FullName: String;
      
    published

      property Name: String read FName write SetName;
      property Surname: String read FSurname write SetSurname;
      property Patronymic: String read FPatronymic write SetPatronymic;
      property BirthDate: TDateTime read FBirthDate write SetBirthDate;
      property Speciality: String read FSpeciality write SetSpeciality;
      property Role: TRole read FRole write SetRole;
      
  end;

  TEmployeeClass = class of TEmployee;

  TEmployees = class;
  
  TEmployeesEnumerator = class (TDomainObjectListEnumerator)

    protected
      
      function GetCurrentEmployee: TEmployee;

      constructor Create(Employees: TEmployees);

    public

      property Current: TEmployee read GetCurrentEmployee;

  end;
  
  TEmployees = class (TDomainObjectList)

    private
    
      function GetEmployeeByIndex(Index: Integer): TEmployee;
      procedure SetEmployeeByIndex(Index: Integer; const Value: TEmployee);

    public

      procedure InsertEmployee(
        const Index: Integer;
        Employee: TEmployee
      ); virtual;

      function First: TEmployee;
      function Last: TEmployee;

      procedure Add(Employee: TEmployee);
      procedure Remove(Employee: TEmployee);
      function Contains(Employee: TEmployee): Boolean;

      function FindByIdentity(const Identity: Variant): TEmployee;

      function GetEnumerator: TEmployeesEnumerator;

      property Items[Index: Integer]: TEmployee
      read GetEmployeeByIndex
      write SetEmployeeByIndex; default;
      
  end;

implementation

uses

  AuxiliaryDateFunctions;
  
{ TEmployee }

function TEmployee.FullName: String;
begin

  Result := FSurname + ' ' + FName + ' ' + FPatronymic;
  
end;

function TEmployee.HasRole: Boolean;
begin

  Result := Assigned(FRole);
  
end;

function TEmployee.IsAccountant: Boolean;
begin

  Result := HasRole and FRole.IsAccountant;

end;

function TEmployee.IsAircraftTechnician: Boolean;
begin

  Result := HasRole and FRole.IsAircraftTechnician;
  
end;

function TEmployee.IsWarehouseHead: Boolean;
begin

  Result := HasRole and FRole.IsWarehouseHead;

end;

procedure TEmployee.RaiseExceptionIfBirthDateIsNotValid(const Value: TDateTime);
begin

  if not InvariantsComplianceRequested then
    Exit;

  if not IsDateTimeValid(Value) then begin

    raise TEmployeeException.Create(
      'Некорректная дата рождения сотрудника'
    );
    
  end;
  
end;

procedure TEmployee.RaiseExceptionIfNameIsNotValid(const Value: String);
begin

  if not InvariantsComplianceRequested then
    Exit;

  if Trim(Value) = '' then begin

    raise TEmployeeException.Create(
      'Некорректное имя сотрудника'
    );
    
  end;

end;

procedure TEmployee.RaiseExceptionIfPatronymicIsNotValid(const Value: String);
begin

  if not InvariantsComplianceRequested then
    Exit;

  if Trim(Value) = '' then begin

    raise TEmployeeException.Create(
      'Некорректное отчество сотрудника'
    );
    
  end;

end;

procedure TEmployee.RaiseExceptionIfRoleIsNotValid(const Value: TRole);
begin

  if not InvariantsComplianceRequested then
    Exit;

  if not Assigned(Value) then begin

    raise TEmployeeException.Create(
      'Попытка назначить сотруднику ' +
      'не действительную роль'
    );
    
  end;

end;

procedure TEmployee.RaiseExceptionIfSpecialityIsNotValid(const Value: String);
begin

  if not InvariantsComplianceRequested then
    Exit;

  if Trim(Value) = '' then begin

    raise TEmployeeException.Create(
      'Наименование должности ' +
      'сотрудника некорректно'
    );

  end;

end;

procedure TEmployee.RaiseExceptionIfSurnameIsNotValid(const Value: String);
begin

  if not InvariantsComplianceRequested then
    Exit;

  if Trim(Value) = '' then begin

    raise TEmployeeException.Create(
      'Некорректная фамилия сотрудника'
    );
    
  end;

end;

procedure TEmployee.SetBirthDate(const Value: TDateTime);
begin

  RaiseExceptionIfBirthDateIsNotValid(Value);

  FBirthDate := Value;

end;

procedure TEmployee.SetInvariantsComplianceRequested(const Value: Boolean);
begin

  inherited;

  if HasRole then
    FRole.InvariantsComplianceRequested := Value;
    
end;

procedure TEmployee.SetName(const Value: String);
begin

  RaiseExceptionIfNameIsNotValid(Value);
  
  FName := Value;

end;

procedure TEmployee.SetPatronymic(const Value: String);
begin

  RaiseExceptionIfPatronymicIsNotValid(Value);
  
  FPatronymic := Value;

end;

procedure TEmployee.SetRole(const Value: TRole);
begin

  RaiseExceptionIfRoleIsNotValid(Value);

  if FRole = Value then
    Exit;

  FreeAndNil(FRole);
  
  FRole := Value;

  FRole.InvariantsComplianceRequested := InvariantsComplianceRequested;
  
end;

procedure TEmployee.SetSpeciality(const Value: String);
begin

  RaiseExceptionIfSpecialityIsNotValid(Value);
  
  FSpeciality := Value;

end;

procedure TEmployee.SetSurname(const Value: String);
begin

  RaiseExceptionIfSurnameIsNotValid(Value);
  
  FSurname := Value;
  
end;

{ TEmployeesEnumerator }

constructor TEmployeesEnumerator.Create(Employees: TEmployees);
begin

  inherited Create(Employees);

end;

function TEmployeesEnumerator.GetCurrentEmployee: TEmployee;
begin

  Result := TEmployee(GetCurrentDomainObject);

end;

{ TEmployees }

procedure TEmployees.Add(Employee: TEmployee);
begin

  AddDomainObject(Employee);

end;

function TEmployees.Contains(Employee: TEmployee): Boolean;
begin

  Result := inherited Contains(Employee);
  
end;

function TEmployees.FindByIdentity(const Identity: Variant): TEmployee;
begin

  Result := TEmployee(inherited FindByIdentity(Identity));
  
end;

function TEmployees.First: TEmployee;
begin

  Result := TEmployee(inherited First);
  
end;

function TEmployees.GetEnumerator: TEmployeesEnumerator;
begin

  Result := TEmployeesEnumerator.Create(Self);
  
end;

function TEmployees.GetEmployeeByIndex(Index: Integer): TEmployee;
begin

  Result := TEmployee(GetDomainObjectByIndex(Index));
  
end;

procedure TEmployees.InsertEmployee(const Index: Integer; Employee: TEmployee);
begin

  InsertDomainObject(Index, Employee);
  
end;

function TEmployees.Last: TEmployee;
begin

  Result := TEmployee(inherited Last);
  
end;

procedure TEmployees.Remove(Employee: TEmployee);
begin

  DeleteDomainObject(Employee);
  
end;

procedure TEmployees.SetEmployeeByIndex(Index: Integer; const Value: TEmployee);
begin

  SetDomainObjectByIndex(Index, Value);
  
end;

end.
