unit FuelCharacteristicsAccountingDomainBuilder;

interface

uses

  StandardFuelCharacteristicsCalculationRuleRegistry,
  FuelCharacteristicsCalculationAccessRule,
  EmployeeFuelCharacteristicsCalculationCardWorkingRules,
  EmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry,
  EmployeeReservoirKindWorkingRuleRegistry,
  FuelCharacteristicsCalculationRuleRegistry,
  EmployeeReservoirKindReferenceSuiteWorkingRuleRegistry,
  StandardEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry,
  StandardEmployeeReservoirKindWorkingRuleRegistry,
  EmployeeReservoirKindWorkingRules,
  EmployeeReservoirKindReferenceSuiteWorkingRules,
  FuelCharacteristicsCalculationCardAccountingServiceRegistry,
  StandardEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry,
  ReservoirKindAccountingServiceRegistry,
  FuelCharacteristicsCalculationServiceRegistry,
  FuelCharacteristicsCalculationCardStorageServiceRegistry,
  MockRandomReservoirCalibrationChart,
  MockRandomCalculationElectronicMetroshtok,
  MockReservoirCalibrationChartRegistry,
  ReservoirKindStorageServiceRegistry,
  ReservoirCalibrationChartElectronicFileRegistry,
  WorkingTimeConditionsRules,
  FuelCharacteristicsAccountingDomainBuildingOptions,
  WorkingTimeConditionsAccountingServiceRegistry,
  WorkingTimeConditionsStorageServiceRegistry,
  WorkingTimeConditionsRuleRegistry,
  SysUtils,
  Classes;
  
type

  TFuelCharacteristicsAccountingDomainBuilder = class

    private

      function ClearDomainServices: TFuelCharacteristicsAccountingDomainBuilder;
      
    public

      function UseStandardEmployeeFuelCharacteristicsCalculationCardWorkingRules:
        TFuelCharacteristicsAccountingDomainBuilder;

      function UseEmployeeFuelCharacteristicsCalculationCardWorkingRules(
        WorkingRules: TEmployeeFuelCharacteristicsCalculationCardWorkingRules
      ): TFuelCharacteristicsAccountingDomainBuilder;

    public

      function UseStandardFuelCharacteristicsCalculationAccessRule:
        TFuelCharacteristicsAccountingDomainBuilder;

      function UseFuelCharacteristicsCalculationAccessRule(
        FuelCharacteristicsCalculationAccessRule:
          IFuelCharacteristicsCalculationAccessRule
      ): TFuelCharacteristicsAccountingDomainBuilder;

    public

      function UseStandardEmployeeReservoirKindWorkingRules:
        TFuelCharacteristicsAccountingDomainBuilder;

      function UseEmployeeReservoirKindWorkingRules(
        WorkingRules: TEmployeeReservoirKindWorkingRules
      ): TFuelCharacteristicsAccountingDomainBuilder;

    public

      function UseStandardEmployeeReservoirKindReferenceSuiteWorkingRules:
        TFuelCharacteristicsAccountingDomainBuilder;

      function UseEmployeeReservoirKindReferenceSuiteWorkingRules(
        EmployeeReservoirKindReferenceSuiteWorkingRules:
          TEmployeeReservoirKindReferenceSuiteWorkingRules
      ): TFuelCharacteristicsAccountingDomainBuilder;

    public

      function UseStandardWorkingTimeConditionsRules:
        TFuelCharacteristicsAccountingDomainBuilder;

      function UseWorkingTimeConditionsRules(
        WorkingTimeConditionsRules: TWorkingTimeConditionsRules
      ): TFuelCharacteristicsAccountingDomainBuilder;
      
    public

      function GetEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry:
        IEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry;

      function GetEmployeeReservoirKindWorkingRuleRegistry:
        IEmployeeReservoirKindWorkingRuleRegistry;

      function GetEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry:
        IEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry;

      function GetFuelCharacteristicsCalculationRuleRegistry:
        IFuelCharacteristicsCalculationRuleRegistry;

      function GetWorkingTimeConditionsRuleRegistry:
        IWorkingTimeConditionsRuleRegistry;
        
      function UseStandardDomainWorkingRules:
        TFuelCharacteristicsAccountingDomainBuilder;

    public

      function UseDirectoriesBasedOnRepositories:
        TFuelCharacteristicsAccountingDomainBuilder;

    public

      function UseMockRandomCalculationElectronicMetroshtok(
        FuelTemperatureRange: TFuelCharacteristicFloatValueRange;
        FuelRiseLevelRange: TFuelCharacteristicFloatValueRange;
        FuelDensityRange: TFuelCharacteristicFloatValueRange;
        BottomWaterLevelRange: TFuelCharacteristicFloatValueRange
      ): TFuelCharacteristicsAccountingDomainBuilder;

      function UseMockReservoirCalibrationChartRegistry(
        MockRandomReservoirCalibrationChartVolumeRange: TVolumeRange
      ): TFuelCharacteristicsAccountingDomainBuilder;

      function UseReservoirCalibrationChartElectronicFileRegistry:
        TFuelCharacteristicsAccountingDomainBuilder;
        
    public

      function UseStandardFuelCharacteristicsCalculationCardAccountingServices:
        TFuelCharacteristicsAccountingDomainBuilder;

      function UseStandardFuelCharacteristicsCalculationCardStorageServices:
        TFuelCharacteristicsAccountingDomainBuilder;

      function UseStandardFuelCharacteristicsCalculationServices:
        TFuelCharacteristicsAccountingDomainBuilder;
        
    public

      function UseStandardReservoirKindAccountingServices:
        TFuelCharacteristicsAccountingDomainBuilder;
        
      function UseStandardReservoirKindStorageServices:
        TFuelCharacteristicsAccountingDomainBuilder;

    public

      function UseStandardEmployeeQualificationServices:
        TFuelCharacteristicsAccountingDomainBuilder;

    public

      function UseStandardWorkingTimeConditionsAccountingServices:
        TFuelCharacteristicsAccountingDomainBuilder;

    public
        
      function UseStandardDomainServices:
        TFuelCharacteristicsAccountingDomainBuilder;

    public
    
      function GetFuelCharacteristicsCalculationCardAccountingServiceRegistry:
        IFuelCharacteristicsCalculationCardAccountingServiceRegistry;

      function GetFuelCharacteristicsCalculationCardStorageServiceRegistry:
        IFuelCharacteristicsCalculationCardStorageServiceRegistry;

      function GetFuelCharacteristicsCalculationServiceRegistry:
        IFuelCharacteristicsCalculationServiceRegistry;
        
    public
    
      function GetReservoirKindAccountingServiceRegistry:
        IReservoirKindAccountingServiceRegistry;

      function GetReservoirKindStorageServiceRegistry:
        IReservoirKindStorageServiceRegistry;

    public

      function GetWorkingTimeConditionsAccountingServiceRegistry:
        IWorkingTimeConditionsAccountingServiceRegistry;

      function GetWorkingTimeConditionsStorageServiceRegistry:
        IWorkingTimeConditionsStorageServiceRegistry;

    private

      procedure EnsureNecessaryOptionsAssigned(
        Options: IFuelCharacteristicsAccountingDomainBuildingOptions
      );

    public

      destructor Destroy; override;

      constructor Create;
      
      procedure BuildStandardDomain(
        BuildingOptions: IFuelCharacteristicsAccountingDomainBuildingOptions
      );

      function ClearDomain: TFuelCharacteristicsAccountingDomainBuilder;
      
  end;

implementation

uses

  AuxDebugFunctionsUnit,
  FuelCharacteristicsAccountingRepositoryRegistry,
  StandardEmployeeQualificationServiceRegistry,
  StandardFuelCharacteristicsCalculationCardAccountingServiceRegistry,
  StandardReservoirKindAccountingServiceRegistry,
  StandardFuelCharacteristicsCalculationServiceRegistry,
  StandardFuelCharacteristicsAccountingRepositoryRegistry,
  StandardWorkingTimeConditionsAccountingServiceRegistry,
  StandardFuelCharacteristicsCalculationCardStorageServiceRegistry,
  StandardWorkingTimeConditionsStorageServiceRegistry,
  StandardReservoirKindStorageServiceRegistry,
  StandardWorkingTimeConditionsRuleRegistry,
  BasedOnRepositoryReservoirKindDirectory,
  BasedOnRepositoryFuelCharacteristicsCalculationCardDirectory,
  BasedOnRepositoryReservoirKindReferenceSuiteDirectory,
  BasedOnRepositoryWorkingTimeConditionsDirectory;

{ TFuelCharacteristicsAccountingDomainBuilder }

procedure TFuelCharacteristicsAccountingDomainBuilder.BuildStandardDomain(
  BuildingOptions: IFuelCharacteristicsAccountingDomainBuildingOptions
);
var Option: IFuelCharacteristicsAccountingDomainBuildingOption;
begin

  EnsureNecessaryOptionsAssigned(BuildingOptions);

  for Option in BuildingOptions do
    Option.Apply(Self);
    
  UseStandardDomainWorkingRules;
  UseStandardDomainServices;

end;

function TFuelCharacteristicsAccountingDomainBuilder.ClearDomain:
  TFuelCharacteristicsAccountingDomainBuilder;
begin

  Result := ClearDomainServices;

end;

function TFuelCharacteristicsAccountingDomainBuilder.
  ClearDomainServices: TFuelCharacteristicsAccountingDomainBuilder;
begin

  TFuelCharacteristicsCalculationCardAccountingServiceRegistry
    .Current
      .Clear;

  TReservoirKindAccountingServiceRegistry
    .Current
      .Clear;

  TFuelCharacteristicsCalculationServiceRegistry
    .Current
      .Clear;

  TFuelCharacteristicsCalculationCardStorageServiceRegistry
    .Current
      .Clear;
      
  TReservoirKindStorageServiceRegistry
    .Current
      .Clear;

  TWorkingTimeConditionsAccountingServiceRegistry
    .Current
      .Clear;
      
  TWorkingTimeConditionsStorageServiceRegistry
    .Current
      .Clear;

  Result := Self;

end;

constructor TFuelCharacteristicsAccountingDomainBuilder.Create;
begin

  inherited;

end;

destructor TFuelCharacteristicsAccountingDomainBuilder.Destroy;
begin

  inherited;

end;

procedure TFuelCharacteristicsAccountingDomainBuilder.
  EnsureNecessaryOptionsAssigned(
    Options: IFuelCharacteristicsAccountingDomainBuildingOptions
  );
begin

  if not Options.Contains(TUseAbstractDirectoriesOption) then begin

    raise Exception.Create(
      'Программня ошибка. Не найдена ' +
      'опция создания каталогов ' +
      'модели предметной области'
    );
    
  end;

  if not Options.Contains(TUseAbstractElectronicMetroshtokOption)
  then begin

    raise Exception.Create(
      'Программня ошибка. Не найдена ' +
      'опция создания программной модели ' +
      'электронного метроштока'
    );
    
  end;

  if not Options.Contains(TUseAbstractReservoirCalibrationChartRegistryOption)
  then begin

    raise Exception.Create(
      'Программня ошибка. Не найдена ' +
      'опция создания реестра ' +
      'градуировочных таблиц для ' +
      'типов резервуаров'
    );
    
  end;

end;

function TFuelCharacteristicsAccountingDomainBuilder.
  GetEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry:
    IEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry;
begin

  Result :=
    TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry
      .Current;

end;

function TFuelCharacteristicsAccountingDomainBuilder.
  GetEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry:
    IEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry;
begin

  Result :=
    TEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry.Current;
    
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  GetEmployeeReservoirKindWorkingRuleRegistry:
    IEmployeeReservoirKindWorkingRuleRegistry;
begin

  Result := TEmployeeReservoirKindWorkingRuleRegistry.Current;
    
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  GetFuelCharacteristicsCalculationCardAccountingServiceRegistry:
    IFuelCharacteristicsCalculationCardAccountingServiceRegistry;
begin

  Result :=
    TFuelCharacteristicsCalculationCardAccountingServiceRegistry.Current;

end;

function TFuelCharacteristicsAccountingDomainBuilder.
  GetFuelCharacteristicsCalculationCardStorageServiceRegistry:
    IFuelCharacteristicsCalculationCardStorageServiceRegistry;
begin

  Result := TFuelCharacteristicsCalculationCardStorageServiceRegistry.Current;

end;

function TFuelCharacteristicsAccountingDomainBuilder.
  GetFuelCharacteristicsCalculationRuleRegistry:
    IFuelCharacteristicsCalculationRuleRegistry;
begin

  Result := TFuelCharacteristicsCalculationRuleRegistry.Current;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  GetFuelCharacteristicsCalculationServiceRegistry:
    IFuelCharacteristicsCalculationServiceRegistry;
begin

  Result := TFuelCharacteristicsCalculationServiceRegistry.Current;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  GetReservoirKindAccountingServiceRegistry:
    IReservoirKindAccountingServiceRegistry;
begin

  Result := TReservoirKindAccountingServiceRegistry.Current;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  GetReservoirKindStorageServiceRegistry: IReservoirKindStorageServiceRegistry;
begin

  Result := TReservoirKindStorageServiceRegistry.Current;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  GetWorkingTimeConditionsAccountingServiceRegistry:
    IWorkingTimeConditionsAccountingServiceRegistry;
begin

  Result := TWorkingTimeConditionsAccountingServiceRegistry.Current;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  GetWorkingTimeConditionsRuleRegistry: IWorkingTimeConditionsRuleRegistry;
begin

  Result := TWorkingTimeConditionsRuleRegistry.Current;

end;

function TFuelCharacteristicsAccountingDomainBuilder.
  GetWorkingTimeConditionsStorageServiceRegistry:
    IWorkingTimeConditionsStorageServiceRegistry;
begin

  Result := TWorkingTimeConditionsStorageServiceRegistry.Current;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseDirectoriesBasedOnRepositories:
    TFuelCharacteristicsAccountingDomainBuilder;
begin

  TFuelCharacteristicsCalculationCardStorageServiceRegistry
    .Current
      .RegisterFuelCharacteristicsCalculationCardDirectory(

        TBasedOnRepositoryFuelCharacteristicsCalculationCardDirectory.Create(

          TFuelCharacteristicsAccountingRepositoryRegistry
            .Current
              .GetFuelCharacteristicsCalculationCardRepository

        )
      );

  TReservoirKindStorageServiceRegistry
    .Current
      .RegisterReservoirKindDirectory(

        TBasedOnRepositoryReservoirKindDirectory.Create(

          TFuelCharacteristicsAccountingRepositoryRegistry
            .Current
              .GetReservoirKindRepository
        )

      );

  TReservoirKindStorageServiceRegistry
    .Current
      .RegisterReservoirKindReferenceSuiteDirectory(

        TBasedOnRepositoryReservoirKindReferenceSuiteDirectory.Create(

          TFuelCharacteristicsAccountingRepositoryRegistry
            .Current
              .GetReservoirKindReferenceSuiteRepository
        )
      );

  TWorkingTimeConditionsStorageServiceRegistry
    .Current
      .RegisterWorkingTimeConditionsDirectory(

        TBasedOnRepositoryWorkingTimeConditionsDirectory.Create(

          TFuelCharacteristicsAccountingRepositoryRegistry
            .Current
              .GetWorkingTimeConditionsRepository
        )
      );

  Result := Self;

end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseEmployeeFuelCharacteristicsCalculationCardWorkingRules(
    WorkingRules: TEmployeeFuelCharacteristicsCalculationCardWorkingRules
  ): TFuelCharacteristicsAccountingDomainBuilder;
begin

  TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry
    .Current
      .RegisterEmployeeFuelCharacteristicsCalculationCardWorkingRules(
        WorkingRules
      );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseEmployeeReservoirKindReferenceSuiteWorkingRules(
    EmployeeReservoirKindReferenceSuiteWorkingRules:
      TEmployeeReservoirKindReferenceSuiteWorkingRules
  ): TFuelCharacteristicsAccountingDomainBuilder;
begin

  TEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry
    .Current
      .RegisterEmployeeReservoirKindReferenceSuiteWorkingRules(
        EmployeeReservoirKindReferenceSuiteWorkingRules
      );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseEmployeeReservoirKindWorkingRules(
    WorkingRules: TEmployeeReservoirKindWorkingRules
  ): TFuelCharacteristicsAccountingDomainBuilder;
begin

  TEmployeeReservoirKindWorkingRuleRegistry
    .Current
      .RegisterEmployeeReservoirKindWorkingRules(
        WorkingRules
      );
      
  Result := Self;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseFuelCharacteristicsCalculationAccessRule(
    FuelCharacteristicsCalculationAccessRule:
      IFuelCharacteristicsCalculationAccessRule
  ): TFuelCharacteristicsAccountingDomainBuilder;
begin

  TFuelCharacteristicsCalculationRuleRegistry
    .Current
      .RegisterFuelCharacteristicsCalculationAccessRule(
        FuelCharacteristicsCalculationAccessRule
      );

  Result := Self;

end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseMockRandomCalculationElectronicMetroshtok(
    FuelTemperatureRange,
    FuelRiseLevelRange,
    FuelDensityRange,
    BottomWaterLevelRange: TFuelCharacteristicFloatValueRange
  ): TFuelCharacteristicsAccountingDomainBuilder;
begin

  TFuelCharacteristicsCalculationServiceRegistry
    .Current
      .RegisterElectronicMetroshtok(
        TMockRandomCalculationElectronicMetroshtok.Create(
          FuelTemperatureRange,
          FuelRiseLevelRange,
          FuelDensityRange,
          BottomWaterLevelRange
        )
      );
      
  Result := Self;

end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseMockReservoirCalibrationChartRegistry(
    MockRandomReservoirCalibrationChartVolumeRange: TVolumeRange
  ): TFuelCharacteristicsAccountingDomainBuilder;
begin

  TReservoirKindAccountingServiceRegistry
    .Current
      .RegisterReservoirCalibrationChartRegistry(
        TMockReservoirCalibrationChartRegistry.Create(
          MockRandomReservoirCalibrationChartVolumeRange
        )
      );

  Result := Self;

end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseReservoirCalibrationChartElectronicFileRegistry:
    TFuelCharacteristicsAccountingDomainBuilder;
begin

  TReservoirKindAccountingServiceRegistry
    .Current
      .RegisterReservoirCalibrationChartRegistry(
        TReservoirCalibrationChartElectronicFileRegistry.Create
      );
      
  Result := Self;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseStandardDomainServices: TFuelCharacteristicsAccountingDomainBuilder;
begin

  UseStandardFuelCharacteristicsCalculationCardAccountingServices;
  UseStandardReservoirKindAccountingServices;
  
  UseStandardFuelCharacteristicsCalculationServices;

  UseStandardFuelCharacteristicsCalculationCardStorageServices;
  UseStandardReservoirKindStorageServices;

  UseStandardEmployeeQualificationServices;
  UseStandardWorkingTimeConditionsAccountingServices;
  
  Result := Self;

end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseStandardDomainWorkingRules: TFuelCharacteristicsAccountingDomainBuilder;
begin

  UseStandardEmployeeFuelCharacteristicsCalculationCardWorkingRules;
  UseStandardFuelCharacteristicsCalculationAccessRule;
  UseStandardEmployeeReservoirKindWorkingRules;
  UseStandardEmployeeReservoirKindReferenceSuiteWorkingRules;
  UseStandardWorkingTimeConditionsRules;
  
  Result := Self;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseStandardEmployeeFuelCharacteristicsCalculationCardWorkingRules:
    TFuelCharacteristicsAccountingDomainBuilder;
begin

  TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry.
    Current.
      RegisterStandardEmployeeFuelCharacteristicsCalculationCardWorkingRules;

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseStandardEmployeeQualificationServices:
    TFuelCharacteristicsAccountingDomainBuilder;
begin

  TEmployeeQualificationServiceRegistry
    .Current
      .RegisterStandardSpecialityAccountingService;
      
  Result := Self;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseStandardEmployeeReservoirKindReferenceSuiteWorkingRules:
    TFuelCharacteristicsAccountingDomainBuilder;
begin

  TEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry
    .Current
      .RegisterStandardEmployeeReservoirKindReferenceSuiteWorkingRules;

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseStandardEmployeeReservoirKindWorkingRules:
    TFuelCharacteristicsAccountingDomainBuilder;
begin

  TEmployeeReservoirKindWorkingRuleRegistry
    .Current
      .RegisterStandardEmployeeReservoirKindWorkingRules;

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseStandardFuelCharacteristicsCalculationAccessRule:
    TFuelCharacteristicsAccountingDomainBuilder;
begin

  TFuelCharacteristicsCalculationRuleRegistry
    .Current
      .RegisterStandardFuelCharacteristicsCalculationAccessRule;

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseStandardFuelCharacteristicsCalculationCardAccountingServices:
    TFuelCharacteristicsAccountingDomainBuilder;
begin

  TFuelCharacteristicsCalculationCardAccountingServiceRegistry
    .Current
      .RegisterStandardFuelCharacteristicsCalculationCardAccountingServices;

  Result := Self;

end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseStandardFuelCharacteristicsCalculationCardStorageServices:
    TFuelCharacteristicsAccountingDomainBuilder;
begin

  TFuelCharacteristicsCalculationCardStorageServiceRegistry
    .Current
      .RegisterStandardFuelCharacteristicsCalculationCardDirectoryAccessService;
      
  Result := Self;

end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseStandardFuelCharacteristicsCalculationServices:
    TFuelCharacteristicsAccountingDomainBuilder;
begin

  TFuelCharacteristicsCalculationServiceRegistry
    .Current
      .RegisterStandardFuelCharacteristicsCalculationService;

  Result := Self;

end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseStandardReservoirKindAccountingServices:
    TFuelCharacteristicsAccountingDomainBuilder;
begin

  TReservoirKindAccountingServiceRegistry
    .Current
      .RegisterStandardReservoirKindAccountingServices;

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseStandardReservoirKindStorageServices:
    TFuelCharacteristicsAccountingDomainBuilder;
begin

  TReservoirKindStorageServiceRegistry
    .Current
      .RegisterStandardReservoirKindDirectoryAccessService;

  TReservoirKindStorageServiceRegistry
    .Current
      .RegisterStandardReservoirKindReferenceSuiteDirectoryAccessService;

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseStandardWorkingTimeConditionsAccountingServices:
    TFuelCharacteristicsAccountingDomainBuilder;
begin

  TWorkingTimeConditionsAccountingServiceRegistry
    .Current
      .RegisterStandardWorkingTimeConditionsAccountingService;
      
  Result := Self;

end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseStandardWorkingTimeConditionsRules: TFuelCharacteristicsAccountingDomainBuilder;
begin

  TWorkingTimeConditionsRuleRegistry
    .Current
      .RegisterStandardWorkingTimeConditionsRules;

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingDomainBuilder.
  UseWorkingTimeConditionsRules(
    WorkingTimeConditionsRules: TWorkingTimeConditionsRules
  ): TFuelCharacteristicsAccountingDomainBuilder;
begin

  TWorkingTimeConditionsRuleRegistry
    .Current
      .RegisterWorkingTimeConditionsRules(WorkingTimeConditionsRules);

  Result := Self;

end;

end.
