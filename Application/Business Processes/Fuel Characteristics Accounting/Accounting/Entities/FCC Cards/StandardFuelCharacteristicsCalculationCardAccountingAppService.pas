unit StandardFuelCharacteristicsCalculationCardAccountingAppService;

interface

uses

  FuelCharacteristicsCalculationCardAccountingAppService,
  FuelCharacteristicsCalculationCardDto,
  FuelCharacteristicsCalculationCardAccessRightsDto,
  FuelCharacteristicsCalculationCardInfo,
  EmployeeRepository,
  FuelCharacteristicsCalculationCardAccountingService,
  Employee,
  FuelCharacteristicsCalculationCard,
  FuelCharacteristicsCalculationCardMapper,
  FuelCharacteristicsCalculationCardInfoMapper,
  unIFuelCharacteristicsCalculationCard,
  FuelCharacteristicsCalculationCardAccessRights,
  EmployeeMapper,
  ISessionUnit,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsCalculationCardAccountingAppService =
    class (
      TInterfacedObject,
      IFuelCharacteristicsCalculationCardAccountingAppService
    )

      protected

        FSession: ISession;
        FEmployeeRepository: IEmployeeRepository;

        FFuelCharacteristicsCalculationCardAccountingService:
          IFuelCharacteristicsCalculationCardAccountingService;

        FFuelCharacteristicsCalculationCardInfoMapper:
          TFuelCharacteristicsCalculationCardInfoMapper;
          
        FFuelCharacteristicsCalculationCardMapper:
          TFuelCharacteristicsCalculationCardMapper;

        FEmployeeMapper: TEmployeeMapper;

        procedure EnsureFuelCharacteristicsCalculationCardIdValid(
          const CardId: Variant
        );
        
        function GetEmployeeFromRepository(const EmployeeId: Variant): TEmployee;

      public

        destructor Destroy; override;
        
        constructor Create(
          Session: ISession;
          EmployeeRepository: IEmployeeRepository;

          FuelCharacteristicsCalculationCardAccountingService:
            IFuelCharacteristicsCalculationCardAccountingService
        );

        function GetNewFuelCharacteristicsCalculationCardInfo(
          const RequestingEmployeeId: Variant
        ): TFuelCharacteristicsCalculationCardInfo;

        function GetFuelCharacteristicsCalculationCardInfo(
          const RequestingEmployeeId: Variant;
          const CardId: Variant
        ): TFuelCharacteristicsCalculationCardInfo;

        function GetFuelCharacteristicsCalculationCardAccessRights(
          const RequestingEmployeeId: Variant;
          const CardId: Variant
        ): TFuelCharacteristicsCalculationCardAccessRightsDto;

        function AccountNewFuelCharacteristicsCalculationCard(
          const RequestingEmployeeId: Variant;

          const FuelCharacteristicsCalculationCardDto:
            TFuelCharacteristicsCalculationCardDto

        ): TFuelCharacteristicsCalculationCardDto;

        function AccountExistingFuelCharacteristicsCalculationCard(
          const RequestingEmployeeId: Variant;

          const FuelCharacteristicsCalculationCardDto:
            TFuelCharacteristicsCalculationCardDto

        ): TFuelCharacteristicsCalculationCardDto;

        procedure RemoveFuelCharacteristicsCalculationCard(
          const RequestingEmployeeId: Variant;
          const CardId: Variant
        );

    end;

implementation

uses

  IDomainObjectBaseUnit,
  AuxVariantFunctions;

{ TStandardFuelCharacteristicsCalculationCardAccountingAppService }

constructor TStandardFuelCharacteristicsCalculationCardAccountingAppService.
  Create(
    Session: ISession;
    EmployeeRepository: IEmployeeRepository;

    FuelCharacteristicsCalculationCardAccountingService:
      IFuelCharacteristicsCalculationCardAccountingService
  );
begin

  inherited Create;

  FSession := Session;
  FEmployeeRepository := EmployeeRepository;
  
  FFuelCharacteristicsCalculationCardAccountingService :=
    FuelCharacteristicsCalculationCardAccountingService;

  FEmployeeMapper := TEmployeeMapper.Create;
  
  FFuelCharacteristicsCalculationCardMapper :=
    TFuelCharacteristicsCalculationCardMapper.Create(
      EmployeeRepository
    );

  FFuelCharacteristicsCalculationCardInfoMapper :=
    TFuelCharacteristicsCalculationCardInfoMapper.Create(
      FFuelCharacteristicsCalculationCardMapper
    );

end;

destructor TStandardFuelCharacteristicsCalculationCardAccountingAppService.
  Destroy;
begin

  FreeAndNil(FEmployeeMapper);
  FreeAndNil(FFuelCharacteristicsCalculationCardInfoMapper);
  
  inherited;

end;

procedure TStandardFuelCharacteristicsCalculationCardAccountingAppService.
  EnsureFuelCharacteristicsCalculationCardIdValid(
    const CardId: Variant
  );
begin

  if VarIsNullOrEmpty(CardId) then begin

    raise
    TFuelCharacteristicsCalculationCardAccountingAppServiceException.Create(
      'Обнаружен недействительный ' +
      'идентификатор карточки ' +
      'расчёта показателей топлива'
    );

  end;

end;

function TStandardFuelCharacteristicsCalculationCardAccountingAppService.
  AccountExistingFuelCharacteristicsCalculationCard(
    const RequestingEmployeeId: Variant;

    const FuelCharacteristicsCalculationCardDto:
      TFuelCharacteristicsCalculationCardDto
      
  ): TFuelCharacteristicsCalculationCardDto;

var RequestingEmployee: TEmployee;
    Card: IFuelCharacteristicsCalculationCard;
    ConcreteCard: TFuelCharacteristicsCalculationCard;
    CardAccessRights: TFuelCharacteristicsCalculationCardAccessRights;

    FreeEmployee, FreeCardAccessRights: IDomainObjectBase;
begin

  EnsureFuelCharacteristicsCalculationCardIdValid(
    FuelCharacteristicsCalculationCardDto.Id
  );

  FSession.Start;

  try

    RequestingEmployee := GetEmployeeFromRepository(RequestingEmployeeId);

    FreeEmployee := RequestingEmployee;

    FFuelCharacteristicsCalculationCardAccountingService
      .TakeFuelCharacteristicsCalculationCardAndAccessRights(
        RequestingEmployee,
        FuelCharacteristicsCalculationCardDto.Id,
        Card,
        CardAccessRights
      );

    ConcreteCard := TFuelCharacteristicsCalculationCard(Card.Self);
    
    FreeCardAccessRights := CardAccessRights;

    FFuelCharacteristicsCalculationCardMapper
      .FillEntityFromDto(ConcreteCard, FuelCharacteristicsCalculationCardDto);

    FFuelCharacteristicsCalculationCardAccountingService
      .PerformExistingFuelCharacteristicsCalculationCardAccounting(
        ConcreteCard, RequestingEmployee
      );

    FSession.Commit;

    Result := FFuelCharacteristicsCalculationCardMapper.ToDto(ConcreteCard);
    
  except

    on e: Exception do begin

      FSession.Rollback;

      raise;
      
    end;

  end;

end;

function TStandardFuelCharacteristicsCalculationCardAccountingAppService.
  AccountNewFuelCharacteristicsCalculationCard(
    const RequestingEmployeeId: Variant;

    const FuelCharacteristicsCalculationCardDto:
      TFuelCharacteristicsCalculationCardDto
      
  ): TFuelCharacteristicsCalculationCardDto;

var RequestingEmployee: TEmployee;
    Card: IFuelCharacteristicsCalculationCard;
    ConcreteCard: TFuelCharacteristicsCalculationCard;
    CardAccessRights: TFuelCharacteristicsCalculationCardAccessRights;

    FreeEmployee, FreeCardAccessRights: IDomainObjectBase;
begin

  FSession.Start;

  try

    RequestingEmployee := GetEmployeeFromRepository(RequestingEmployeeId);

    FreeEmployee := RequestingEmployee;
    
    FFuelCharacteristicsCalculationCardAccountingService
      .TakeNewFuelCharacteristicsCalculationCardAndAccessRights(
        RequestingEmployee, Card, CardAccessRights
      );

    ConcreteCard := TFuelCharacteristicsCalculationCard(Card.Self);
    
    FreeCardAccessRights := CardAccessRights;

    FFuelCharacteristicsCalculationCardMapper
      .FillEntityFromDto(ConcreteCard, FuelCharacteristicsCalculationCardDto);

    FFuelCharacteristicsCalculationCardAccountingService
      .PerformNewFuelCharacteristicsCalculationCardAccounting(
        ConcreteCard, RequestingEmployee
      );

    FSession.Commit;

    Result := FFuelCharacteristicsCalculationCardMapper.ToDto(ConcreteCard);
    
  except

    on e: Exception do begin

      FSession.Rollback;

      raise;
      
    end;

  end;
  
end;

function TStandardFuelCharacteristicsCalculationCardAccountingAppService.
  GetFuelCharacteristicsCalculationCardAccessRights(
    const RequestingEmployeeId,
    CardId: Variant
  ): TFuelCharacteristicsCalculationCardAccessRightsDto;
var RequestingEmployee: TEmployee;
    AccessRights: TFuelCharacteristicsCalculationCardAccessRights;

    FreeEmployee, FreeAccessRights: IDomainObjectBase;
begin

  EnsureFuelCharacteristicsCalculationCardIdValid(CardId);

  RequestingEmployee := GetEmployeeFromRepository(RequestingEmployeeId);

  AccessRights :=
    FFuelCharacteristicsCalculationCardAccountingService
      .TakeFuelCharacteristicsCalculationCardAccessRights(
        RequestingEmployee, CardId
      );

  FreeAccessRights := AccessRights;

  Result :=
    FFuelCharacteristicsCalculationCardInfoMapper
      .MapFuelCharacteristicsCalculationCardAccessRightsDtoFrom(
        AccessRights
      );
      
end;

function TStandardFuelCharacteristicsCalculationCardAccountingAppService.
  GetFuelCharacteristicsCalculationCardInfo(
    const RequestingEmployeeId, CardId: Variant
  ): TFuelCharacteristicsCalculationCardInfo;
var RequestingEmployee: TEmployee;
    Card: IFuelCharacteristicsCalculationCard;
    CardAccessRights: TFuelCharacteristicsCalculationCardAccessRights;
    
    FreeEmployee, FreeCardAccessRights: IDomainObjectBase;
begin

  EnsureFuelCharacteristicsCalculationCardIdValid(CardId);

  RequestingEmployee := GetEmployeeFromRepository(RequestingEmployeeId);

  FreeEmployee := RequestingEmployee;
  
  FFuelCharacteristicsCalculationCardAccountingService.
    TakeFuelCharacteristicsCalculationCardAndAccessRights(
      RequestingEmployee, CardId, Card, CardAccessRights
    );

  FreeCardAccessRights := CardAccessRights;

  Result :=
    FFuelCharacteristicsCalculationCardInfoMapper
      .MapFuelCharacteristicsCalculationCardInfoFrom(
        TFuelCharacteristicsCalculationCard(Card.Self),
        CardAccessRights
      );
      
end;

function TStandardFuelCharacteristicsCalculationCardAccountingAppService.
  GetNewFuelCharacteristicsCalculationCardInfo(
    const RequestingEmployeeId: Variant
  ): TFuelCharacteristicsCalculationCardInfo;
var RequestingEmployee: TEmployee;
    Card: IFuelCharacteristicsCalculationCard;
    CardAccessRights: TFuelCharacteristicsCalculationCardAccessRights;

    FreeEmployee, FreeCardAccessRights: IDomainObjectBase;
begin

  RequestingEmployee := GetEmployeeFromRepository(RequestingEmployeeId);

  FreeEmployee := RequestingEmployee;

  FFuelCharacteristicsCalculationCardAccountingService
    .TakeNewFuelCharacteristicsCalculationCardAndAccessRights(
      RequestingEmployee, Card, CardAccessRights
    );

  FreeCardAccessRights := CardAccessRights;

  Result :=
    FFuelCharacteristicsCalculationCardInfoMapper
      .MapFuelCharacteristicsCalculationCardInfoFrom(
        TFuelCharacteristicsCalculationCard(Card.Self),
        CardAccessRights
      );

  with Result.FuelCharacteristicsCalculationCardDto do begin

    if VarIsNullOrEmpty(CalculationPerformingDateTime) then
      CalculationPerformingDateTime := Now;

    if VarIsNullOrEmpty(PerformedCalculationEmployeeDto.Id) then
      PerformedCalculationEmployeeDto := FEmployeeMapper.ToDto(RequestingEmployee);

  end;

end;

procedure TStandardFuelCharacteristicsCalculationCardAccountingAppService.
  RemoveFuelCharacteristicsCalculationCard(
    const RequestingEmployeeId, CardId: Variant
  );
var RequestingEmployee: TEmployee;
    Free: IDomainObjectBase;
begin

  EnsureFuelCharacteristicsCalculationCardIdValid(CardId);
  
  FSession.Start;

  try

    RequestingEmployee := GetEmployeeFromRepository(RequestingEmployeeId);

    Free := RequestingEmployee;

    FFuelCharacteristicsCalculationCardAccountingService
      .RemoveFuelCharacteristicsCalculationCard(
        RequestingEmployee, CardId
      );

    FSession.Commit;
    
  except

    on e: Exception do begin

      FSession.Rollback;

      raise;

    end;

  end;

end;

function TStandardFuelCharacteristicsCalculationCardAccountingAppService.
  GetEmployeeFromRepository(
    const EmployeeId: Variant
  ): TEmployee;
begin

  if VarIsNullOrEmpty(EmployeeId) then begin

    raise
    TFuelCharacteristicsCalculationCardAccountingAppServiceException.Create(
      'Недействительный идентификатор сотрудника'
    );

  end;

  Result := FEmployeeRepository.FindEmployeeById(EmployeeId);

  if not Assigned(Result) then begin

    raise
    TFuelCharacteristicsCalculationCardAccountingAppServiceException.Create(
      'Информация о сотруднике, запросившем ' +
      'выполнение операции, не найдена'
    );
    
  end;

end;

end.
