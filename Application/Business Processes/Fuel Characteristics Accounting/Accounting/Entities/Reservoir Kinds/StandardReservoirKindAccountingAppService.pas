unit StandardReservoirKindAccountingAppService;

interface

uses

  ReservoirKindAccountingAppService,
  ReservoirKindInfo,
  EmployeeRepository,
  ReservoirKind,
  unIReservoirKind,
  ReservoirKindAccessRights,
  ReservoirKindInfoMapper,
  ISessionUnit,
  ReservoirKindAccountingService,
  Employee,
  SysUtils,
  Classes;

type

  TStandardReservoirKindAccountingAppService =
    class (TInterfacedObject, IReservoirKindAccountingAppService)

      private

        FReservoirKindInfoMapper: TReservoirKindInfoMapper;
        
      protected

        FSession: ISession;
        FEmployeeRepository: IEmployeeRepository;
        FReservoirKindAccountingService: IReservoirKindAccountingService;

        function GetEmployeeFromRepository(const EmployeeId: Variant): TEmployee;
        procedure EnsureReservoirKindIdValid(const ReservoirKindId: Variant);

        function MapReservoirKindInfoFrom(
          ReservoirKind: TReservoirKind;
          ReservoirKindAccessRights: TReservoirKindAccessRights
        ): TReservoirKindInfo; virtual;
        
      public

        constructor Create(
          Session: ISession;
          EmployeeRepository: IEmployeeRepository;
          ReservoirKindAccountingService: IReservoirKindAccountingService
        );

        function GetReservoirKindInfoForEmployee(
          const RequestingEmployeeId: Variant;
          const ReservoirKindId: Variant
        ): TReservoirKindInfo;

    end;

implementation

uses

  IDomainObjectBaseUnit,
  AuxVariantFunctions;

{ TStandardReservoirKindAccountingAppService }

constructor TStandardReservoirKindAccountingAppService.Create(
  Session: ISession;
  EmployeeRepository: IEmployeeRepository;
  ReservoirKindAccountingService: IReservoirKindAccountingService
);
begin

  inherited Create;

  FSession := Session;
  FEmployeeRepository := EmployeeRepository;
  FReservoirKindAccountingService := ReservoirKindAccountingService;

  FReservoirKindInfoMapper := TReservoirKindInfoMapper.Create;
  
end;

procedure TStandardReservoirKindAccountingAppService.EnsureReservoirKindIdValid(
  const ReservoirKindId: Variant);
begin

  if VarIsNullOrEmpty(ReservoirKindId) then begin

    raise TReservoirKindAccountingAppServiceException.Create(
      'Недействительный идентификатор ' +
      'типа резервуаров'
    );
    
  end;

end;

function TStandardReservoirKindAccountingAppService.GetEmployeeFromRepository(
  const EmployeeId: Variant): TEmployee;
begin

  if VarIsNullOrEmpty(EmployeeId) then begin

    raise TReservoirKindAccountingAppServiceException.Create(
      'Недействительный идентификатор сотрудника'
    );
    
  end;

  Result := FEmployeeRepository.FindEmployeeById(EmployeeId);

  if not Assigned(Result) then begin

    raise TReservoirKindAccountingAppServiceException.Create(
      'Информация о сотруднике, запросившем ' +
      'выполнение операции, не найдена'
    );
    
  end;

end;

function TStandardReservoirKindAccountingAppService.
  GetReservoirKindInfoForEmployee(
    const RequestingEmployeeId, ReservoirKindId: Variant
  ): TReservoirKindInfo;
var RequestingEmployee: TEmployee;
    ReservoirKind: IReservoirKind;
    ReservoirKindAccessRights: TReservoirKindAccessRights;

    FreeEmployee, FreeReservoirKindAccessRights: IDomainObjectBase;
begin

  EnsureReservoirKindIdValid(ReservoirKindId);

  RequestingEmployee := GetEmployeeFromRepository(RequestingEmployeeId);

  FreeEmployee := RequestingEmployee;

  FReservoirKindAccountingService.TakeReservoirKindAndAccessRights(
    RequestingEmployee,
    ReservoirKindId,
    ReservoirKind,
    ReservoirKindAccessRights
  );

  FreeReservoirKindAccessRights := ReservoirKindAccessRights;

  Result :=
    MapReservoirKindInfoFrom(
      TReservoirKind(ReservoirKind.Self),
      ReservoirKindAccessRights
    );
  
end;

function TStandardReservoirKindAccountingAppService.MapReservoirKindInfoFrom(
  ReservoirKind: TReservoirKind;
  ReservoirKindAccessRights: TReservoirKindAccessRights): TReservoirKindInfo;
begin

  Result :=
    FReservoirKindInfoMapper.MapReservoirKindInfoFrom(
      ReservoirKind, ReservoirKindAccessRights
    );
    
end;

end.
