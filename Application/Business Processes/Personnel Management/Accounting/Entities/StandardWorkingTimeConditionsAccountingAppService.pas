unit StandardWorkingTimeConditionsAccountingAppService;

interface

uses

  WorkingTimeConditionsDto,
  WorkingTimeConditionsInfo,
  WorkingTimeConditionsMapper,
  WorkingTimeConditionsInfoMapper,
  WorkingTimeConditions,
  unIWorkingTimeConditions,
  WorkingTimeConditionsAccessRights,
  WorkingTimeConditionsAccountingAppService,
  WorkingTimeConditionsAccountingService,
  EmployeeRepository,
  Employee,
  ISessionUnit,
  SysUtils,
  Classes;

type

  TStandardWorkingTimeConditionsAccountingAppService =
    class (TInterfacedObject, IWorkingTimeConditionsAccountingAppService)

      private

        FSession: ISession;
        
        FEmployeeRepository: IEmployeeRepository;

        FWorkingTimeConditionsAccountingService:
          IWorkingTimeConditionsAccountingService;

        FWorkingTimeConditionsInfoMapper: TWorkingTimeConditionsInfoMapper;

      private

        function GetEmployeeFromRepository(const EmployeeId: Variant): TEmployee;

        procedure EnsureWorkingTimeConditionsIdIsValid(
          const WorkingTimeConditionsId: Variant
        );
        
      public

        destructor Destroy; override;
        
        constructor Create(
          Session: ISession;
          
          EmployeeRepository: IEmployeeRepository;

          WorkingTimeConditionsAccountingService:
            IWorkingTimeConditionsAccountingService
        );

        function GetActiveWorkingTimeConditionsInfo(
          const ClientIdentity: Variant
        ): TWorkingTimeConditionsInfo;

        function GetWorkingTimeConditionsInfo(
          const ClientIdentity: Variant;
          const WorkingTimeConditionsId: Variant
        ): TWorkingTimeConditionsInfo;

        procedure AccountExistingWorkingTimeConditions(
          const ClientIdentity: Variant;
          const WorkingTimeConditionsDto: TWorkingTimeConditionsDto
        );
        
    end;

implementation

uses

  AuxVariantFunctions,
  IDomainObjectBaseUnit;

{ TStandardWorkingTimeConditionsAccountingAppService }

constructor TStandardWorkingTimeConditionsAccountingAppService.
  Create(
    Session: ISession;
    EmployeeRepository: IEmployeeRepository;
    WorkingTimeConditionsAccountingService: IWorkingTimeConditionsAccountingService
  );
begin

  inherited Create;

  FSession := Session;
  FEmployeeRepository := EmployeeRepository;
  FWorkingTimeConditionsAccountingService := WorkingTimeConditionsAccountingService;

  FWorkingTimeConditionsInfoMapper := TWorkingTimeConditionsInfoMapper.Create;

end;

destructor TStandardWorkingTimeConditionsAccountingAppService.Destroy;
begin

  FreeAndNil(FWorkingTimeConditionsInfoMapper);
  
  inherited;

end;

procedure TStandardWorkingTimeConditionsAccountingAppService.
  AccountExistingWorkingTimeConditions(
    const ClientIdentity: Variant;
    const WorkingTimeConditionsDto: TWorkingTimeConditionsDto
  );
var RequestingEmployee: TEmployee;
    WorkingTimeConditions: IWorkingTimeConditions;
    AccessRights: TWorkingTimeConditionsAccessRights;

    FreeEmployee, FreeAccessRights: IDomainObjectBase;
begin

  EnsureWorkingTimeConditionsIdIsValid(WorkingTimeConditionsDto.Id);
  
  RequestingEmployee := GetEmployeeFromRepository(ClientIdentity);

  FreeEmployee := RequestingEmployee;

  FWorkingTimeConditionsAccountingService
    .TakeWorkingTimeConditionsAndAccessRights(
      RequestingEmployee,
      WorkingTimeConditionsDto.Id,
      WorkingTimeConditions,
      AccessRights
    );

  FreeAccessRights := AccessRights;

  FWorkingTimeConditionsInfoMapper
    .WorkingTimeConditionsMapper
      .FillEntityFromDto(
        TWorkingTimeConditions(WorkingTimeConditions.Self),
        WorkingTimeConditionsDto
      );

  FWorkingTimeConditionsAccountingService
    .PerformExistingWorkingTimeConditionsAccounting(
      RequestingEmployee, WorkingTimeConditions
    );

end;

function TStandardWorkingTimeConditionsAccountingAppService.
  GetActiveWorkingTimeConditionsInfo(
    const ClientIdentity: Variant
  ): TWorkingTimeConditionsInfo;
var RequestingEmployee: TEmployee;
    WorkingTimeConditions: IWorkingTimeConditions;
    AccessRights: TWorkingTimeConditionsAccessRights;

    FreeEmployee, FreeAccessRights: IDomainObjectBase;
begin

  RequestingEmployee := GetEmployeeFromRepository(ClientIdentity);

  FreeEmployee := RequestingEmployee;

  FWorkingTimeConditionsAccountingService
    .TakeActiveWorkingTimeConditionsAndAccessRights(
      RequestingEmployee,
      WorkingTimeConditions,
      AccessRights
    );

  FreeAccessRights := AccessRights;

  Result :=
    FWorkingTimeConditionsInfoMapper.MapWorkingTimeConditionsInfoFrom(
      TWorkingTimeConditions(WorkingTimeConditions.Self),
      AccessRights
    );

end;

function TStandardWorkingTimeConditionsAccountingAppService.
  GetWorkingTimeConditionsInfo(
    const ClientIdentity,
    WorkingTimeConditionsId: Variant
  ): TWorkingTimeConditionsInfo;
var RequestingEmployee: TEmployee;
    WorkingTimeConditions: IWorkingTimeConditions;
    AccessRights: TWorkingTimeConditionsAccessRights;

    FreeEmployee, FreeAccessRights: IDomainObjectBase;
begin

  EnsureWorkingTimeConditionsIdIsValid(WorkingTimeConditionsId);
  
  RequestingEmployee := GetEmployeeFromRepository(ClientIdentity);

  FreeEmployee := RequestingEmployee;

  FWorkingTimeConditionsAccountingService
    .TakeWorkingTimeConditionsAndAccessRights(
      RequestingEmployee,
      WorkingTimeConditionsId,
      WorkingTimeConditions,
      AccessRights
    );

  FreeAccessRights := AccessRights;

  Result :=
    FWorkingTimeConditionsInfoMapper.MapWorkingTimeConditionsInfoFrom(
      TWorkingTimeConditions(WorkingTimeConditions.Self),
      AccessRights
    );
    
end;

procedure TStandardWorkingTimeConditionsAccountingAppService.
  EnsureWorkingTimeConditionsIdIsValid(
    const WorkingTimeConditionsId: Variant
  );
begin

  if VarIsNullOrEmpty(WorkingTimeConditionsId) then begin

    raise TWorkingTimeConditionsAccountingAppServiceException.Create(
      'Программная ошибка. Обнаружен ' +
      'недействительный идентификатор ' +
      'режима рабочего времени'
    );
    
  end;

end;

function TStandardWorkingTimeConditionsAccountingAppService.
  GetEmployeeFromRepository(
    const EmployeeId: Variant
  ): TEmployee;
begin

  if VarIsNullOrEmpty(EmployeeId) then begin

    raise TWorkingTimeConditionsAccountingAppServiceException.Create(
      'Программная ошибка. Обнаружен ' +
      'недействительный идентификатор ' +
      'сотрудника'
    );

  end;

  Result := FEmployeeRepository.FindEmployeeById(EmployeeId);

  if not Assigned(Result) then begin

    raise TWorkingTimeConditionsAccountingAppServiceException.Create(
      'Информация о сотруднике не найдена ' +
      'для проведения операции'
    );
    
  end;

end;

end.
