unit StandardFuelCharacteristicsAccountingSystemAuthorizationService;

interface

uses

  FuelCharacteristicsAccountingSystemAuthorizationService,
  RoleDto,
  RoleMapper,
  Role,
  Employee,
  RoleRepository,
  EmployeeRepository,
  ISessionUnit,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsAccountingSystemAuthorizationService =
  class (
    TInterfacedObject,
    IFuelCharacteristicsAccountingSystemAuthorizationService
  )

    private

      FSession: ISession;
      FEmployeeRepository: IEmployeeRepository;
      FRoleRepository: IRoleRepository;
      FRoleMapper: TRoleMapper;

      function GetEmployeeFromRepository(
        const EmployeeId: Variant;
        const NotFoundExceptionMessage: String = ''
      ): TEmployee;

      function GetRoleFromRepository(
        const RoleId: Variant;
        const NotFoundExceptionMessage: String = ''
      ): TRole;
      
    public

      destructor Destroy; override;
      constructor Create(
        Session: ISession;
        EmployeeRepository: IEmployeeRepository;
        RoleRepository: IRoleRepository
      );

    public

      function IsRoleAssignedToClient(
        const ClientIdentity: Variant;
        const RoleIdentity: Variant
      ): Boolean;

      procedure EnsureThatRoleAssignedToClient(
        const RoleIdentity: Variant;
        const ClientIdentity: Variant
      );

      procedure AssignRoleToClient(
        const RoleIdentity: Variant;
        const ClientIdentity: Variant
      );

    public

      function GetRoles(const ClientIdentity: Variant): TRoleDtos;

      function IsClientAccountant(const ClientIdentity: Variant): Boolean;
      function IsClientWarehouseHead(const ClientIdentity: Variant): Boolean;
      function IsClientAircraftTechnician(const ClientIdentity: Variant): Boolean;
      function IsClientAdmin(const ClientIdentity: Variant): Boolean;
      
      procedure EnsureThatClientIsAccountant(const ClientIdentity: Variant);
      procedure EnsureClientIsWarehouseHead(const ClientIdentity: Variant);
      procedure EnsureClientIsAircraftTechnician(const ClientIdentity: Variant);
      procedure EnsureClientIsAdmin(const ClientIdentity: Variant);
      
      procedure MakeClientAccountant(const ClientIdentity: Variant);
      procedure MakeClientWarehouseHead(const ClientIdentity: Variant);
      procedure MakeClientAircraftTechnician(const ClientIdentity: Variant);
      procedure MakeClientAdmin(const ClientIdentity: Variant);
      
  end;


implementation

uses

  IDomainObjectBaseUnit,
  IDomainObjectBaseListUnit,
  Variants;
  
{ TStandardFuelCharacteristicsAccountingSystemAuthorizationService }

constructor TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
  Create(
    Session: ISession;
    EmployeeRepository: IEmployeeRepository;
    RoleRepository: IRoleRepository
  );
begin

  inherited Create;

  FSession := Session;
  FEmployeeRepository := EmployeeRepository;
  FRoleRepository := RoleRepository;

end;

destructor TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
  Destroy;
begin

  FreeAndNil(FRoleMapper);
  
  inherited;

end;

procedure TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
  EnsureClientIsAdmin(
    const ClientIdentity: Variant
  );
begin

  EnsureClientIsWarehouseHead(ClientIdentity);

end;

procedure TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
  EnsureClientIsAircraftTechnician(
    const ClientIdentity: Variant
  );
begin

  EnsureThatRoleAssignedToClient(AIRCRAFT_TECHNICIAN_ROLE_ID, ClientIdentity);

end;

procedure TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
EnsureClientIsWarehouseHead(
  const ClientIdentity: Variant);
begin

  EnsureThatRoleAssignedToClient(WAREHOUSE_HEAD_ROLE_ID, ClientIdentity);

end;

procedure TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
EnsureThatClientIsAccountant(
  const ClientIdentity: Variant);
begin

  EnsureThatRoleAssignedToClient(ACCOUNTANT_ROLE_ID, ClientIdentity);
  
end;

function TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
GetRoles(
  const ClientIdentity: Variant): TRoleDtos;
var Roles: TRoles;
    Free: IDomainObjectBaseList;
begin

  EnsureClientIsAdmin(ClientIdentity);
  
  Roles := FRoleRepository.GetAllRoles;

  if Assigned(Roles) then begin

    Free := Roles;

    Result := FRoleMapper.ToDtos(Roles);

  end

  else Result := nil;

end;

function TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
IsClientAccountant(
  const ClientIdentity: Variant): Boolean;
begin

  Result := IsRoleAssignedToClient(ClientIdentity, ACCOUNTANT_ROLE_ID);

end;

function TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
  IsClientAdmin(
    const ClientIdentity: Variant
  ): Boolean;
begin

  Result := IsClientWarehouseHead(ClientIdentity);

end;

function TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
IsClientAircraftTechnician(
  const ClientIdentity: Variant): Boolean;
begin

  Result := IsRoleAssignedToClient(ClientIdentity, AIRCRAFT_TECHNICIAN_ROLE_ID);

end;

function TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
IsClientWarehouseHead(
  const ClientIdentity: Variant): Boolean;
begin

  Result := IsRoleAssignedToClient(ClientIdentity, WAREHOUSE_HEAD_ROLE_ID);
  
end;


procedure TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
MakeClientAccountant(
  const ClientIdentity: Variant);

begin

  AssignRoleToClient(ACCOUNTANT_ROLE_ID, ClientIdentity);

end;

procedure TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
  MakeClientAdmin(
    const ClientIdentity: Variant
  );
begin

  MakeClientWarehouseHead(ClientIdentity);

end;

procedure TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
MakeClientAircraftTechnician(
  const ClientIdentity: Variant);
var Role: TRole;
begin

  AssignRoleToClient(AIRCRAFT_TECHNICIAN_ROLE_ID, ClientIdentity);
  
end;

procedure TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
MakeClientWarehouseHead(
  const ClientIdentity: Variant);
begin

  AssignRoleToClient(WAREHOUSE_HEAD_ROLE_ID, ClientIdentity);

end;

procedure TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
AssignRoleToClient(
  const RoleIdentity, ClientIdentity: Variant);
var Employee: TEmployee;
    Role: TRole;

    FreeEmployee, FreeRole: IDomainObjectBase;
begin

  FSession.Start;

  try

    Employee :=
      GetEmployeeFromRepository(
        ClientIdentity,
        'Информация о сотруднике для назначения ' +
        'роли не найдена'
      );

    FreeEmployee := Employee;

    Role :=
      GetRoleFromRepository(
        RoleIdentity,
        Format(
          'Информация о роли для назначения ' +
          'сотруднику "%s" не найдена',
          [Employee.FullName]
        )
      );

    FreeRole := Role;

    Employee.Role := Role;

    FEmployeeRepository.UpdateEmployee(Employee);
    
    FSession.Commit;
    
  except

    on e: Exception do begin

      FSession.Rollback;

      raise;

    end;

  end;

end;

procedure TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
  EnsureThatRoleAssignedToClient(
    const RoleIdentity, ClientIdentity: Variant);
var Employee: TEmployee;
    Role: TRole;

    FreeEmployee, FreeRole: IDomainObjectBase;
begin

  Employee :=
    GetEmployeeFromRepository(
      ClientIdentity,
      'Информация о сотруднике для проверки ' +
      'наличия роли не найдена'
    );

  FreeEmployee := Employee;

  Role :=
    GetRoleFromRepository(
      RoleIdentity,
      Format(
        'Информация о роли для проверки ' +
        'наличия её у сотрудника "%s" не найдена',
        [Employee.FullName]
      )
    );

  FreeRole := Role;

  if not Employee.Role.IsSameAs(Role) then begin

    raise
    TFuelCharacteristicsAccountingSystemAuthorizationServiceException
      .CreateFmt(
        'У сотрудника "%s" отсутствует роль "%s"',
        [
          Employee.FullName,
          Role.DisplayName
        ]
      );
      
  end;
  
end;

function TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
  IsRoleAssignedToClient(
    const ClientIdentity, RoleIdentity: Variant
  ): Boolean;
begin

  try

    EnsureThatRoleAssignedToClient(RoleIdentity, ClientIdentity);

    Result := True;

  except

    on e: TFuelCharacteristicsAccountingSystemAuthorizationServiceException
    do Result := False;

  end;

end;

function TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
GetEmployeeFromRepository(
  const EmployeeId: Variant;
  const NotFoundExceptionMessage: String
): TEmployee;
begin

  Result := FEmployeeRepository.FindEmployeeById(EmployeeId);

  if not Assigned(Result) and (NotFoundExceptionMessage <> '')
  then begin

    raise
    TFuelCharacteristicsAccountingSystemAuthorizationServiceException.Create(
      NotFoundExceptionMessage
    );
    
  end;

end;

function TStandardFuelCharacteristicsAccountingSystemAuthorizationService.
GetRoleFromRepository(
  const RoleId: Variant;
  const NotFoundExceptionMessage: String
): TRole;
begin

  Result := FRoleRepository.FindRoleById(RoleId);

  if not Assigned(Result) and (NotFoundExceptionMessage <> '')
  then begin

    raise
    TFuelCharacteristicsAccountingSystemAuthorizationServiceException.Create(
      NotFoundExceptionMessage
    );
    
  end;
  
end;

end.
