unit Role;

interface

uses

  DomainException,
  DomainObjectUnit,
  DomainObjectListUnit,
  SysUtils,
  Classes;

const

  AIRCRAFT_TECHNICIAN_ROLE_ID = 1;
  ACCOUNTANT_ROLE_ID = 2;
  WAREHOUSE_HEAD_ROLE_ID = 3;

  AIRCRAFT_TECHNICIAN_ROLE_NAME = 'AircraftTechnician';
  ACCOUNTANT_ROLE_NAME = 'Accountant';
  WAREHOUSE_HEAD_ROLE_NAME = 'WarehouseHead';

  AIRCRAFT_TECHNICIAN_ROLE_DISPLAY_NAME = 'Авиатехник';
  ACCOUNTANT_ROLE_DISPLAY_NAME = 'Бухгалтер';
  WAREHOUSE_HEAD_ROLE_DISPLAY_NAME = 'Начальник склада';

type

  TRoleException = class (TDomainException)

  end;
  
  TRole = class (TDomainObject)

    private

      FName: String;
      FDisplayName: String;

      procedure SetDisplayName(const Value: String);
      procedure SetName(const Value: String);

    private

      procedure RaiseExceptionIfNameIsNotValid(const Name: String);
      procedure RaiseExceptionIfDisplayNameIsNotValid(const DisplayName: String);
      
    public

      function IsWarehouseHead: Boolean;
      function IsAccountant: Boolean;
      function IsAircraftTechnician: Boolean;
      
    published

      property Name: String read FName write SetName;
      property DisplayName: String read FDisplayName write SetDisplayName;

  end;

  TRoleClass = class of TRole;

  TRoles = class;

  TRolesEnumerator = class (TDomainObjectListEnumerator)

    protected
      
      function GetCurrentRole: TRole;

      constructor Create(Roles: TRoles);

    public

      property Current: TRole read GetCurrentRole;

  end;
  
  TRoles = class (TDomainObjectList)

    private
    
      function GetRoleByIndex(Index: Integer): TRole;
      procedure SetRoleByIndex(Index: Integer; const Value: TRole);

    public

      procedure InsertRole(
        const Index: Integer;
        Role: TRole
      ); virtual;

      function First: TRole;
      function Last: TRole;

      procedure Add(Role: TRole);
      procedure Remove(Role: TRole);
      function Contains(Role: TRole): Boolean;

      function FindByIdentity(const Identity: Variant): TRole;

      function GetEnumerator: TRolesEnumerator;

      property Items[Index: Integer]: TRole
      read GetRoleByIndex
      write SetRoleByIndex; default;
      
  end;

implementation

{ TRole }

function TRole.IsAccountant: Boolean;
begin

  Result := Name = ACCOUNTANT_ROLE_NAME;

end;

function TRole.IsAircraftTechnician: Boolean;
begin

  Result := Name = AIRCRAFT_TECHNICIAN_ROLE_NAME;

end;

function TRole.IsWarehouseHead: Boolean;
begin

  Result := Name = WAREHOUSE_HEAD_ROLE_NAME;
  
end;

procedure TRole.RaiseExceptionIfDisplayNameIsNotValid(
  const DisplayName: String);
begin

  if not InvariantsComplianceRequested then
    Exit;

  if Trim(DisplayName) = '' then begin

    raise TRoleException.Create(
      'Наименование роли некорректно'
    );

  end;
  
end;

procedure TRole.RaiseExceptionIfNameIsNotValid(const Name: String);
begin

  if not InvariantsComplianceRequested then
    Exit;

  if Trim(Name) = '' then begin

    raise TRoleException.Create(
      'Наименование роли некорректно'
    );
    
  end;

end;

procedure TRole.SetDisplayName(const Value: String);
begin

  RaiseExceptionIfDisplayNameIsNotValid(Value);
  
  FDisplayName := Value;

end;

procedure TRole.SetName(const Value: String);
begin

  RaiseExceptionIfNameIsNotValid(Value);
  
  FName := Value;
  
end;

{ TRolesEnumerator }

constructor TRolesEnumerator.Create(Roles: TRoles);
begin

  inherited Create(Roles);

end;

function TRolesEnumerator.GetCurrentRole: TRole;
begin

  Result := TRole(GetCurrentDomainObject);

end;

{ TRoles }

procedure TRoles.Add(Role: TRole);
begin

  AddDomainObject(Role);

end;

function TRoles.Contains(Role: TRole): Boolean;
begin

  Result := inherited Contains(Role);
  
end;

function TRoles.FindByIdentity(const Identity: Variant): TRole;
begin

  Result := TRole(inherited FindByIdentity(Identity));
  
end;

function TRoles.First: TRole;
begin

  Result := TRole(inherited First);
  
end;

function TRoles.GetEnumerator: TRolesEnumerator;
begin

  Result := TRolesEnumerator.Create(Self);
  
end;

function TRoles.GetRoleByIndex(Index: Integer): TRole;
begin

  Result := TRole(GetDomainObjectByIndex(Index));
  
end;

procedure TRoles.InsertRole(const Index: Integer; Role: TRole);
begin

  InsertDomainObject(Index, Role);

end;

function TRoles.Last: TRole;
begin

  Result := TRole(inherited Last);
  
end;

procedure TRoles.Remove(Role: TRole);
begin

  DeleteDomainObject(Role);
  
end;

procedure TRoles.SetRoleByIndex(Index: Integer; const Value: TRole);
begin

  SetDomainObjectByIndex(Index, Value);
  
end;

end.
