unit StandardReservoirKindReferenceSuiteAccountingAppService;

interface

uses

  ReservoirKindReferenceSuiteAccountingAppService,
  ReservoirKindReferenceSuite,
  ReservoirKindReferenceSuiteInfo,
  ReservoirKindReferenceSuiteDto,
  ReservoirKindReferenceSuiteAccessRights,
  ReservoirKindReferenceSuiteMapper,
  ReservoirKindReferenceSuiteInfoMapper,
  unIReservoirKindReferenceSuite,
  ReservoirKindReferenceSuiteAccountingService,
  ReservoirKindReferenceSuiteAccessRightsDto,
  EmployeeRepository,
  Employee,
  ISessionUnit,
  SysUtils,
  Classes;

type

  TStandardReservoirKindReferenceSuiteAccountingAppService =
    class (TInterfacedObject, IReservoirKindReferenceSuiteAccountingAppService)

      private

        FReservoirKindReferenceSuiteMapper:
          TReservoirKindReferenceSuiteMapper;

        FReservoirKindReferenceSuiteInfoMapper:
          TReservoirKindReferenceSuiteInfoMapper;

      protected

        FSession: ISession;
        FEmployeeRepository: IEmployeeRepository;

        FReservoirKindReferenceSuiteAccountingService:
          IReservoirKindReferenceSuiteAccountingService;

        procedure EnsureReservoirKindReferenceSuiteIdValid(
          const ReferenceSuiteId: Variant
        );

        function GetEmployeeFromRepository(
          const EmployeeId: Variant
        ): TEmployee;

      protected

        function MapReservoirKindReferenceSuiteInfoFrom(
          ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
          ReservoirKindReferenceSuiteAccessRights: TReservoirKindReferenceSuiteAccessRights
        ): TReservoirKindReferenceSuiteInfo; virtual;

        procedure FillReservoirKindReferenceSuiteFromDto(
          ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
          ReservoirKindReferenceSuiteDto: TReservoirKindReferenceSuiteDto
        ); virtual;
        
      public

        constructor Create(
          Session: ISession;
          EmployeeRepository: IEmployeeRepository;

          ReservoirKindReferenceSuiteAccountingService:
            IReservoirKindReferenceSuiteAccountingService
        );

        function GetReservoirKindReferenceSuiteAccessRights(
          const RequestingEmployeeId: Variant;
          const ReferenceSuiteId: Variant
        ): TReservoirKindReferenceSuiteAccessRightsDto;

        function GetReservoirKindReferenceSuiteInfo(
          const RequestingEmployeeId: Variant;
          const ReferenceSuiteId: Variant
        ): TReservoirKindReferenceSuiteInfo;

        function AccountNewReservoirKindReferenceSuite(
          const RequestingEmployeeId: Variant;
          const ReservoirKindReferenceSuiteDto: TReservoirKindReferenceSuiteDto
        ): Variant;

        procedure AccountExistingReservoirKindReferenceSuite(
          const RequestingEmployeeId: Variant;
          const ReservoirKindReferenceSuiteDto: TReservoirKindReferenceSuiteDto
        );

        procedure RemoveReservoirKindReferenceSuite(
          const RequestingEmployeeId: Variant;
          const ReferenceSuiteId: Variant
        );

    end;

implementation

uses

  IDomainObjectBaseUnit,
  AuxVariantFunctions;
  
{ TStandardReservoirKindReferenceSuiteAccountingAppService }

constructor TStandardReservoirKindReferenceSuiteAccountingAppService.Create(
  Session: ISession;
  EmployeeRepository: IEmployeeRepository;

  ReservoirKindReferenceSuiteAccountingService:
    IReservoirKindReferenceSuiteAccountingService
);
begin

  inherited Create;

  FSession := Session;
  FEmployeeRepository := EmployeeRepository;

  FReservoirKindReferenceSuiteAccountingService :=
    ReservoirKindReferenceSuiteAccountingService;

  FReservoirKindReferenceSuiteMapper :=
    TReservoirKindReferenceSuiteMapper.Create;

  FReservoirKindReferenceSuiteInfoMapper :=
    TReservoirKindReferenceSuiteInfoMapper.Create(
      FReservoirKindReferenceSuiteMapper
    );

end;

procedure TStandardReservoirKindReferenceSuiteAccountingAppService.
  AccountExistingReservoirKindReferenceSuite(
    const RequestingEmployeeId: Variant;
    const ReservoirKindReferenceSuiteDto: TReservoirKindReferenceSuiteDto
  );
var RequestingEmployee: TEmployee;
    ReferenceSuite: IReservoirKindReferenceSuite;
    ConcreteReferenceSuite: TReservoirKindReferenceSuite;
    AccessRights: TReservoirKindReferenceSuiteAccessRights;

    FreeEmployee, FreeAccessRights: IDomainObjectBase;
begin

  EnsureReservoirKindReferenceSuiteIdValid(ReservoirKindReferenceSuiteDto.Id);

  FSession.Start;

  try

    RequestingEmployee := GetEmployeeFromRepository(RequestingEmployeeId);

    FreeEmployee := RequestingEmployee;

    FReservoirKindReferenceSuiteAccountingService
      .TakeReservoirKindReferenceSuiteAndAccessRights(
        RequestingEmployee,
        ReservoirKindReferenceSuiteDto.Id,
        ReferenceSuite,
        AccessRights
      );

    ConcreteReferenceSuite := TReservoirKindReferenceSuite(ReferenceSuite.Self);
    
    FreeAccessRights := AccessRights;

    FillReservoirKindReferenceSuiteFromDto(
      ConcreteReferenceSuite, ReservoirKindReferenceSuiteDto
    );

    FReservoirKindReferenceSuiteAccountingService
      .PerformChangedReservoirKindReferenceSuiteAccounting(
        RequestingEmployee, ConcreteReferenceSuite
      );
      
    FSession.Commit;

  except

    on e: Exception do begin

      FSession.Rollback;

      raise;

    end;

  end;

end;

function TStandardReservoirKindReferenceSuiteAccountingAppService.
  AccountNewReservoirKindReferenceSuite(
    const RequestingEmployeeId: Variant;
    const ReservoirKindReferenceSuiteDto: TReservoirKindReferenceSuiteDto
  ): Variant;
var RequestingEmployee: TEmployee;
    ReferenceSuite: IReservoirKindReferenceSuite;
    ConcreteReferenceSuite: TReservoirKindReferenceSuite;
    AccessRights: TReservoirKindReferenceSuiteAccessRights;

    FreeEmployee, FreeAccessRights: IDomainObjectBase;
begin

  FSession.Start;

  try

    RequestingEmployee := GetEmployeeFromRepository(RequestingEmployeeId);

    FreeEmployee := RequestingEmployee;

    FReservoirKindReferenceSuiteAccountingService
      .TakeNewReservoirKindReferenceSuiteAndAccessRights(
        RequestingEmployee, ReferenceSuite, AccessRights
      );

    ConcreteReferenceSuite := TReservoirKindReferenceSuite(ReferenceSuite.Self);
    
    FreeAccessRights := AccessRights;

    FillReservoirKindReferenceSuiteFromDto(
      ConcreteReferenceSuite, ReservoirKindReferenceSuiteDto
    );

    FReservoirKindReferenceSuiteAccountingService
      .PerformNewReservoirKindReferenceSuiteAccounting(
        RequestingEmployee, ConcreteReferenceSuite
      );

    FSession.Commit;

    Result := ConcreteReferenceSuite.Identity;
    
  except

    on e: Exception do begin

      FSession.Rollback;

      raise;
      
    end;

  end;

end;

function TStandardReservoirKindReferenceSuiteAccountingAppService.
  GetReservoirKindReferenceSuiteAccessRights(
    const RequestingEmployeeId, ReferenceSuiteId: Variant
  ): TReservoirKindReferenceSuiteAccessRightsDto;
var RequestingEmployee: TEmployee;
    AccessRights: TReservoirKindReferenceSuiteAccessRights;

    FreeEmployee, FreeAccessRights: IDomainObjectBase;
begin

  EnsureReservoirKindReferenceSuiteIdValid(ReferenceSuiteId);

  RequestingEmployee := GetEmployeeFromRepository(RequestingEmployeeId);

  AccessRights :=
    FReservoirKindReferenceSuiteAccountingService
      .TakeReservoirKindReferenceSuiteAccessRights(
        RequestingEmployee, ReferenceSuiteId
      );

  FreeAccessRights := AccessRights;

  Result :=
    FReservoirKindReferenceSuiteInfoMapper
      .MapReservoirKindReferenceSuiteAcessRightsDtoFrom(AccessRights);

end;

function TStandardReservoirKindReferenceSuiteAccountingAppService.
  GetReservoirKindReferenceSuiteInfo(
    const RequestingEmployeeId,
    ReferenceSuiteId: Variant
  ): TReservoirKindReferenceSuiteInfo;
var RequestingEmployee: TEmployee;
    ReferenceSuite: IReservoirKindReferenceSuite;
    AccessRights: TReservoirKindReferenceSuiteAccessRights;

    FreeEmployee, FreeAccessRights: IDomainObjectBase;
begin

  EnsureReservoirKindReferenceSuiteIdValid(ReferenceSuiteId);

  RequestingEmployee := GetEmployeeFromRepository(RequestingEmployeeId);

  FreeEmployee := RequestingEmployee;

  FReservoirKindReferenceSuiteAccountingService
    .TakeReservoirKindReferenceSuiteAndAccessRights(
      RequestingEmployee,
      ReferenceSuiteId,
      ReferenceSuite,
      AccessRights
    );

  FreeAccessRights := AccessRights;

  Result :=
    MapReservoirKindReferenceSuiteInfoFrom(
      TReservoirKindReferenceSuite(ReferenceSuite.Self),
      AccessRights
    );
  
end;

function TStandardReservoirKindReferenceSuiteAccountingAppService.
  MapReservoirKindReferenceSuiteInfoFrom(
    ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
    ReservoirKindReferenceSuiteAccessRights: TReservoirKindReferenceSuiteAccessRights
  ): TReservoirKindReferenceSuiteInfo;
begin

  Result :=
    FReservoirKindReferenceSuiteInfoMapper
      .MapReservoirKindReferenceSuiteInfoFrom(
        ReservoirKindReferenceSuite,
        ReservoirKindReferenceSuiteAccessRights
      );
      
end;

procedure TStandardReservoirKindReferenceSuiteAccountingAppService.
  RemoveReservoirKindReferenceSuite(
    const RequestingEmployeeId, ReferenceSuiteId: Variant
  );
var RequestingEmployee: TEmployee;
    FreeEmployee: IDomainObjectBase;
begin

  EnsureReservoirKindReferenceSuiteIdValid(ReferenceSuiteId);

  FSession.Start;

  try

    RequestingEmployee := GetEmployeeFromRepository(RequestingEmployeeId);

    FreeEmployee := RequestingEmployee;

    FReservoirKindReferenceSuiteAccountingService
      .RemoveReservoirKindReferenceSuite(
        RequestingEmployee, ReferenceSuiteId
      );

    FSession.Commit;

  except

    on e: Exception do begin

      FSession.Rollback;

      raise;
      
    end;

  end;

end;

procedure TStandardReservoirKindReferenceSuiteAccountingAppService.
  EnsureReservoirKindReferenceSuiteIdValid(
    const ReferenceSuiteId: Variant
  );
begin

  if VarIsNullOrEmpty(ReferenceSuiteId) then begin

    raise
    TReservoirKindReferenceSuiteAccountingAppServiceException.Create(
      'Недействительный идентификатор ' +
      'справочных данных типа резервуаров'
    );
    
  end;

end;

procedure TStandardReservoirKindReferenceSuiteAccountingAppService.
  FillReservoirKindReferenceSuiteFromDto(
    ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
    ReservoirKindReferenceSuiteDto: TReservoirKindReferenceSuiteDto
  );
begin

  FReservoirKindReferenceSuiteMapper.FillEntityFromDto(
    ReservoirKindReferenceSuite, ReservoirKindReferenceSuiteDto
  );

end;

function TStandardReservoirKindReferenceSuiteAccountingAppService.
  GetEmployeeFromRepository(
    const EmployeeId: Variant
  ): TEmployee;
begin

  if VarIsNullOrEmpty(EmployeeId) then begin

    raise
    TReservoirKindReferenceSuiteAccountingAppServiceException.Create(
      'Недействительный идентификатор сотрудника'
    );

  end;

  Result := FEmployeeRepository.FindEmployeeById(EmployeeId);

  if not Assigned(Result) then begin

    raise
    TReservoirKindReferenceSuiteAccountingAppServiceException.Create(
      'Информация о сотруднике, запросившем ' +
      'выполнение операции, не найдена'
    );
    
  end;

end;

end.
