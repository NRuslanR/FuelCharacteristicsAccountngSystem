unit FuelCharacteristicsAccountingDomainBuildingOptions;

interface

uses

  IGetSelfUnit,
  MockRandomCalculationElectronicMetroshtok,
  MockReservoirCalibrationChartRegistry,
  MockRandomReservoirCalibrationChart,
  SysUtils,
  Classes;

type

  IFuelCharacteristicsAccountingDomainBuildingOption = interface (IGetSelf)

    procedure Apply(Builder: TObject);

  end;

  IFuelCharacteristicsAccountingDomainBuildingOptionsEnumerator = interface

    function GetCurrentFuelCharacteristicsAccountingDomainBuildingOption:
      IFuelCharacteristicsAccountingDomainBuildingOption;

    function MoveNext: Boolean;
    
    property Current: IFuelCharacteristicsAccountingDomainBuildingOption
    read GetCurrentFuelCharacteristicsAccountingDomainBuildingOption;

  end;

  IFuelCharacteristicsAccountingDomainBuildingOptions = interface

    function Contains(OptionClass: TClass): Boolean;
    
    function GetFuelCharacteristicsAccountingDomainBuildingOptionByIndex(
      Index: Integer
    ): IFuelCharacteristicsAccountingDomainBuildingOption;

    procedure SetFuelCharacteristicsAccountingDomainBuildingOptionByIndex(
      Index: Integer;
      Option: IFuelCharacteristicsAccountingDomainBuildingOption
    );

    function Add(Option: IFuelCharacteristicsAccountingDomainBuildingOption): Integer;

    function GetEnumerator:
      IFuelCharacteristicsAccountingDomainBuildingOptionsEnumerator;

    property Items[Index: Integer]: IFuelCharacteristicsAccountingDomainBuildingOption
    read GetFuelCharacteristicsAccountingDomainBuildingOptionByIndex
    write SetFuelCharacteristicsAccountingDomainBuildingOptionByIndex;

  end;

  TAbstractFuelCharacteristicsAccountingDomainBuildingOption =
    class abstract
      (TInterfacedObject, IFuelCharacteristicsAccountingDomainBuildingOption)

      public

        function GetSelf: TObject;

        procedure Apply(Builder: TObject); virtual; abstract;

    end;

  TUseAbstractDirectoriesOption =
    class (TAbstractFuelCharacteristicsAccountingDomainBuildingOption)

    end;
    
  TUseDirectoriesBasedOnRepositoriesOption =
    class (TUseAbstractDirectoriesOption)

      public

        procedure Apply(Builder: TObject); override;
        
    end;

  TUseAbstractElectronicMetroshtokOption =
    class (TAbstractFuelCharacteristicsAccountingDomainBuildingOption)

    end;
    
  TUseMockRandomCalculationElectronicMetroshtokOption =
    class (TUseAbstractElectronicMetroshtokOption)

      private

        FFuelTemperatureRange: TFuelCharacteristicFloatValueRange;
        FFuelRiseLevelRange: TFuelCharacteristicFloatValueRange;
        FFuelDensityRange: TFuelCharacteristicFloatValueRange;
        FBottomWaterLevelRange: TFuelCharacteristicFloatValueRange;

      public

        constructor Create(
          FuelTemperatureRange: TFuelCharacteristicFloatValueRange;
          FuelRiseLevelRange: TFuelCharacteristicFloatValueRange;
          FuelDensityRange: TFuelCharacteristicFloatValueRange;
          BottomWaterLevelRange: TFuelCharacteristicFloatValueRange
        );

        procedure Apply(Builder: TObject); override;
        
    end;

  TUseAbstractReservoirCalibrationChartRegistryOption =
    class (TAbstractFuelCharacteristicsAccountingDomainBuildingOption)

    end;
    
  TUseMockReservoirCalibrationChartRegistryOption =
    class (TUseAbstractReservoirCalibrationChartRegistryOption)

      private

        FVolumeRange: TVolumeRange;

      public

        constructor Create(VolumeRange: TVolumeRange);

        procedure Apply(Builder: TObject); override;
        
    end;

  TUseReservoirCalibrationChartElectronicFileRegistryOption =
    class (TUseAbstractReservoirCalibrationChartRegistryOption)

      public

        procedure Apply(Builder: TObject); override;
        
    end;

  TFuelCharacteristicsAccountingDomainBuildingOptions =
    class (TInterfacedObject, IFuelCharacteristicsAccountingDomainBuildingOptions)

      private

        type

          TOptionHolder = class

            private

              Option: IFuelCharacteristicsAccountingDomainBuildingOption;

              constructor Create(
                Option: IFuelCharacteristicsAccountingDomainBuildingOption
              );

          end;
          
      private

        FOptionList: TList;

        function FindOptionHolderByClass(OptionClass: TClass): TOptionHolder;
         
      public

        destructor Destroy; override;

        constructor Create;

        function GetFuelCharacteristicsAccountingDomainBuildingOptionByIndex(
          Index: Integer
        ): IFuelCharacteristicsAccountingDomainBuildingOption;

        procedure SetFuelCharacteristicsAccountingDomainBuildingOptionByIndex(
          Index: Integer;
          Option: IFuelCharacteristicsAccountingDomainBuildingOption
        );

        function Contains(OptionClass: TClass): Boolean;
        
        function Add(Option: IFuelCharacteristicsAccountingDomainBuildingOption): Integer;

        function GetEnumerator:
          IFuelCharacteristicsAccountingDomainBuildingOptionsEnumerator;

        property Items[Index: Integer]: IFuelCharacteristicsAccountingDomainBuildingOption
        read GetFuelCharacteristicsAccountingDomainBuildingOptionByIndex
        write SetFuelCharacteristicsAccountingDomainBuildingOptionByIndex;

    end;

    TFuelCharacteristicsAccountingDomainBuildingOptionsEnumerator =
      class (
        TInterfacedObject,
        IFuelCharacteristicsAccountingDomainBuildingOptionsEnumerator
      )

        private

          FOptionListEnumerator: TListEnumerator;

        public

          constructor Create(
            Options: TFuelCharacteristicsAccountingDomainBuildingOptions
          );

          function GetCurrentFuelCharacteristicsAccountingDomainBuildingOption:
            IFuelCharacteristicsAccountingDomainBuildingOption;

          function MoveNext: Boolean;
          
          property Current: IFuelCharacteristicsAccountingDomainBuildingOption
          read GetCurrentFuelCharacteristicsAccountingDomainBuildingOption;

      end;
  
implementation

uses

  AuxDebugFunctionsUnit,
  AuxCollectionFunctionsUnit,
  FuelCharacteristicsAccountingDomainBuilder;

{ TUseDirectoriesBasedOnRepositoriesOption }

procedure TUseDirectoriesBasedOnRepositoriesOption.Apply(Builder: TObject);
begin

  with Builder as TFuelCharacteristicsAccountingDomainBuilder do begin

    UseDirectoriesBasedOnRepositories;
    
  end;

end;

{ TFuelCharacteristicsAccountingDomainBuildingOptions.TOptionHolder }

constructor TFuelCharacteristicsAccountingDomainBuildingOptions.TOptionHolder.Create(
  Option: IFuelCharacteristicsAccountingDomainBuildingOption);
begin

  inherited Create;

  Self.Option := Option;
  
end;

{ TFuelCharacteristicsAccountingDomainBuildingOptions }

function TFuelCharacteristicsAccountingDomainBuildingOptions.Add(
  Option: IFuelCharacteristicsAccountingDomainBuildingOption): Integer;
begin

  if Contains(Option.Self.ClassType) then begin

    raise Exception.CreateFmt(
      'Опция построения модели предметной ' +
      'области "%s" уже существует',
      [
        Option.Self.ClassName
      ]
    );

  end;

  Result := FOptionList.Add(TOptionHolder.Create(Option));
  
end;

function TFuelCharacteristicsAccountingDomainBuildingOptions.Contains(
  OptionClass: TClass): Boolean;
begin

  Result := Assigned(FindOptionHolderByClass(OptionClass));
  
end;

constructor TFuelCharacteristicsAccountingDomainBuildingOptions.Create;
begin

  inherited Create;

  FOptionList := TList.Create;
  
end;

destructor TFuelCharacteristicsAccountingDomainBuildingOptions.Destroy;
begin

  FreeListWithItems(FOptionList);
  
  inherited;

end;

function TFuelCharacteristicsAccountingDomainBuildingOptions.FindOptionHolderByClass(
  OptionClass: TClass): TOptionHolder;
var OptionHolderPointer: Pointer;
begin

  for OptionHolderPointer in FOptionList do begin

    Result := TOptionHolder(OptionHolderPointer);

    if Result.Option.Self.ClassType.InheritsFrom(OptionClass) then
      Exit;

  end;

  Result := nil;

end;

function TFuelCharacteristicsAccountingDomainBuildingOptions.
  GetEnumerator: IFuelCharacteristicsAccountingDomainBuildingOptionsEnumerator;
begin

  Result :=
    TFuelCharacteristicsAccountingDomainBuildingOptionsEnumerator.Create(Self);
    
end;

function TFuelCharacteristicsAccountingDomainBuildingOptions.
  GetFuelCharacteristicsAccountingDomainBuildingOptionByIndex(
    Index: Integer
  ): IFuelCharacteristicsAccountingDomainBuildingOption;
begin

  Result := TOptionHolder(FOptionList[Index]).Option;
  
end;

procedure TFuelCharacteristicsAccountingDomainBuildingOptions.
  SetFuelCharacteristicsAccountingDomainBuildingOptionByIndex(
    Index: Integer;
    Option: IFuelCharacteristicsAccountingDomainBuildingOption
  );
begin

  TOptionHolder(FOptionList[Index]).Option := Option;

end;

{ TFuelCharacteristicsAccountingDomainBuildingOptionsEnumerator }

constructor TFuelCharacteristicsAccountingDomainBuildingOptionsEnumerator.Create(
  Options: TFuelCharacteristicsAccountingDomainBuildingOptions);
begin

  inherited Create;

  FOptionListEnumerator := TListEnumerator.Create(Options.FOptionList);
                   
end;

function TFuelCharacteristicsAccountingDomainBuildingOptionsEnumerator.
  GetCurrentFuelCharacteristicsAccountingDomainBuildingOption:
    IFuelCharacteristicsAccountingDomainBuildingOption;
begin

  Result :=
    TFuelCharacteristicsAccountingDomainBuildingOptions.TOptionHolder(
      FOptionListEnumerator.GetCurrent
    ).Option;
    
end;

function TFuelCharacteristicsAccountingDomainBuildingOptionsEnumerator.
  MoveNext: Boolean;
begin

  Result := FOptionListEnumerator.MoveNext;
  
end;

{ TUseMockRandomCalculationElectronicMetroshtokOption }

procedure TUseMockRandomCalculationElectronicMetroshtokOption.Apply(
  Builder: TObject);
begin

  with Builder as TFuelCharacteristicsAccountingDomainBuilder
  do begin

    UseMockRandomCalculationElectronicMetroshtok(
      FFuelTemperatureRange,
      FFuelRiseLevelRange,
      FFuelDensityRange,
      FBottomWaterLevelRange
    );

  end;
  
end;

constructor TUseMockRandomCalculationElectronicMetroshtokOption.Create(
  FuelTemperatureRange, FuelRiseLevelRange, FuelDensityRange,
  BottomWaterLevelRange: TFuelCharacteristicFloatValueRange);
begin

  inherited Create;

  FFuelTemperatureRange := FuelTemperatureRange;
  FFuelRiseLevelRange := FuelRiseLevelRange;
  FFuelDensityRange := FuelDensityRange;
  FBottomWaterLevelRange := BottomWaterLevelRange;

end;

{ TUseMockReservoirCalibrationChartRegistryOption }

procedure TUseMockReservoirCalibrationChartRegistryOption.Apply(
  Builder: TObject);
begin

  with Builder as TFuelCharacteristicsAccountingDomainBuilder
  do UseMockReservoirCalibrationChartRegistry(FVolumeRange);

end;

constructor TUseMockReservoirCalibrationChartRegistryOption.Create(
  VolumeRange: TVolumeRange);
begin

  inherited Create;

  FVolumeRange := VolumeRange;
  
end;

{ TAbstractFuelCharacteristicsAccountingDomainBuildingOption }

function TAbstractFuelCharacteristicsAccountingDomainBuildingOption.
  GetSelf: TObject;
begin

  Result := Self;

end;

{ TUseReservoirCalibrationChartElectronicFileRegistryOption }

procedure TUseReservoirCalibrationChartElectronicFileRegistryOption.Apply(
  Builder: TObject);
begin

  with Builder as TFuelCharacteristicsAccountingDomainBuilder do begin

    UseReservoirCalibrationChartElectronicFileRegistry;

  end;
  
end;

end.
