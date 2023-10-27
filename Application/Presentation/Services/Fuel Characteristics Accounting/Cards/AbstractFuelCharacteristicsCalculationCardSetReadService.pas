unit AbstractFuelCharacteristicsCalculationCardSetReadService;

interface

uses

  FuelCharacteristicsCalculationCardSetReadService,
  FuelCharacteristicsCalculationCardDirectoryAccessService,
  FuelCharacteristicsCalculationCardDirectoryAccessRights,
  FuelCharacteristicsCalculationCardSetHolder,
  EmployeeRepository,
  VariantListUnit,
  DB,
  SysUtils,
  Classes;

type

  TAbstractFuelCharacteristicsCalculationCardSetReadService =
    class abstract (
      TInterfacedObject,
      IFuelCharacteristicsCalculationCardSetReadService
    )

      protected

        FEmployeeRepository: IEmployeeRepository;
        
        FFuelCharacteristicsCalculationCardDirectoryAccessService:
          IFuelCharacteristicsCalculationCardDirectoryAccessService;

      protected

        procedure EnsureEmployeeIdValid(const EmployeeId: Variant);
        
        function
          GetFuelCharacteristicsCalculationCardDirectoryAccessRightsForEmployee(
            const EmployeeId: Variant
          ): TFuelCharacteristicsCalculationCardDirectoryAccessRights; virtual;
          
        function InternalGetFuelCharacteristicsCalculationCardSetForEmployee(
          const AllowedPerformerIdentities: TVariantList
        ): TFuelCharacteristicsCalculationCardSetHolder; virtual; abstract;
        
      public

        constructor Create(
          EmployeeRepository: IEmployeeRepository;

          FuelCharacteristicsCalculationCardDirectoryAccessService:
            IFuelCharacteristicsCalculationCardDirectoryAccessService
        );

        function GetFuelCharacteristicsCalculationCardSetForEmployee(
          const EmployeeId: Variant
        ): TFuelCharacteristicsCalculationCardSetHolder; virtual;
        
    end;
  
implementation

uses

  Employee,
  Variants,
  AuxDataSetFunctionsUnit,
  IDomainObjectBaseUnit;

{ TAbstractFuelCharacteristicsCalculationCardSetReadService }

constructor TAbstractFuelCharacteristicsCalculationCardSetReadService.Create(
  EmployeeRepository: IEmployeeRepository;
  FuelCharacteristicsCalculationCardDirectoryAccessService:
    IFuelCharacteristicsCalculationCardDirectoryAccessService
  );
begin

  inherited Create;

  FEmployeeRepository := EmployeeRepository;
  FFuelCharacteristicsCalculationCardDirectoryAccessService :=
    FuelCharacteristicsCalculationCardDirectoryAccessService;
    
end;

procedure TAbstractFuelCharacteristicsCalculationCardSetReadService.
  EnsureEmployeeIdValid(
    const EmployeeId: Variant);
begin

  if VarIsNull(EmployeeId) or VarIsEmpty(EmployeeId) then begin

    raise TFuelCharacteristicsCalculationCardSetReadServiceException.Create(
      'Некорректный идентификатор сотрудника ' +
      'обнаружен при попытке получения карточек ' +
      'расчёта показателей топлива'
    );
    
  end;

end;

function TAbstractFuelCharacteristicsCalculationCardSetReadService.
  GetFuelCharacteristicsCalculationCardDirectoryAccessRightsForEmployee(
    const EmployeeId: Variant
  ): TFuelCharacteristicsCalculationCardDirectoryAccessRights;
var Employee: TEmployee;
    Free: IDomainObjectBase;
begin

  Employee := FEmployeeRepository.FindEmployeeById(EmployeeId);

  if not Assigned(Employee) then begin

    raise TFuelCharacteristicsCalculationCardSetReadServiceException.Create(
      'Информация о сотруднике для ' +
      'получения карточек расчёта показателей ' +
      'топлива не найдена'
    );
    
  end;

  Free := Employee;

  Result :=
    FFuelCharacteristicsCalculationCardDirectoryAccessService
      .EnsureAndGetFuelCharacteristicsCalculationCardDirectoryAccessRightsForEmployee(
        Employee
      );

end;

function TAbstractFuelCharacteristicsCalculationCardSetReadService.
  GetFuelCharacteristicsCalculationCardSetForEmployee(
    const EmployeeId: Variant
  ): TFuelCharacteristicsCalculationCardSetHolder;
var FuelCharacteristicsCalculationCardDirectoryAccessRights:
      TFuelCharacteristicsCalculationCardDirectoryAccessRights;
    Free: IDomainObjectBase;
begin

  EnsureEmployeeIdValid(EmployeeId);
  
  FuelCharacteristicsCalculationCardDirectoryAccessRights :=
    GetFuelCharacteristicsCalculationCardDirectoryAccessRightsForEmployee(
      EmployeeId
    );

  Free := FuelCharacteristicsCalculationCardDirectoryAccessRights;
  
  Result :=
    InternalGetFuelCharacteristicsCalculationCardSetForEmployee(
      FuelCharacteristicsCalculationCardDirectoryAccessRights
        .AllowedPerformerIdentities
    );
  
  Result.ViewAllowed :=
    FuelCharacteristicsCalculationCardDirectoryAccessRights.ViewAllowed;

  Result.AddingAllowed :=
    FuelCharacteristicsCalculationCardDirectoryAccessRights.InPlacingAllowed;

  Result.ModificationAllowed :=
    FuelCharacteristicsCalculationCardDirectoryAccessRights.AlterationAllowed;

  Result.RemovingAllowed :=
    FuelCharacteristicsCalculationCardDirectoryAccessRights.RemovingAllowed;
    
end;

end.
