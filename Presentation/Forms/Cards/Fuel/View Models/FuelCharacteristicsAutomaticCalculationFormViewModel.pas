unit FuelCharacteristicsAutomaticCalculationFormViewModel;

interface

uses

  CardFormViewModel,
  SysUtils,
  Classes;

type

  TSubLayerKind = (skBottomWater, skIce, skUnknown);

  TSubLayerKindsProperty = class (TCardFormViewModelProperty)

    private

      function GetSubLayerKinds: TStrings;
      procedure SetSubLayerKinds(const Value: TStrings);

    protected

      function AreValuesEquals(
        PropertyValue, AssignableValue: Variant
      ): Boolean; override;

      procedure AssignOtherValue(OtherValue: Variant); override;

      function CloneValue(Value: Variant): Variant; override;

    public

      destructor Destroy; override;
      
      property Value: TStrings
      read GetSubLayerKinds write SetSubLayerKinds;

  end;
  
  TFuelCharacteristicsAutomaticCalculationFormViewModel =
    class (TCardFormViewModel)

      private

        FReservoirKindName: TCardFormViewModelProperty;

        FSubLayerKind: TCardFormViewModelProperty;
        FSubLayerKinds: TSubLayerKindsProperty;

        FReservoirSubLayerCalculationCharacteristicValue:
          TCardFormViewModelProperty;

        FFuelRiseLevel: TCardFormViewModelProperty;
        FFuelTemperature: TCardFormViewModelProperty;
        FFuelDensity: TCardFormViewModelProperty;
        FFuelMass: TCardFormViewModelProperty;

        function GetSubLayerKinds: TStrings;
        procedure SetSubLayerKinds(const Value: TStrings);

        function GetSubLayerKindValue: TSubLayerKind;
        procedure SetSubLayerKindValue(const Value: TSubLayerKind);

      protected

        procedure RestoreProperties; override;
        
      public

        destructor Destroy; override;
        
        constructor Create; override;

        property ReservoirKindName: TCardFormViewModelProperty
        read FReservoirKindName;

        property SubLayerKind: TCardFormViewModelProperty
        read FSubLayerKind;

        property SubLayerKindValue: TSubLayerKind
        read GetSubLayerKindValue write SetSubLayerKindValue; 
        
        property SubLayerKinds: TStrings
        read GetSubLayerKinds write SetSubLayerKinds;
        
        property ReservoirSubLayerCalculationCharacteristicValue: TCardFormViewModelProperty
        read FReservoirSubLayerCalculationCharacteristicValue;

        property FuelRiseLevel: TCardFormViewModelProperty
        read FFuelRiseLevel;
        
        property FuelTemperature: TCardFormViewModelProperty
        read FFuelTemperature;
        
        property FuelDensity: TCardFormViewModelProperty
        read FFuelDensity;
        
        property FuelMass: TCardFormViewModelProperty
        read FFuelMass;
                                                     
    end;

implementation

uses

  Variants,
  AuxDebugFunctionsUnit,
  AuxVariantFunctions;
  
{ TFuelCharacteristicsAutomaticCalculationFormViewModel }

constructor TFuelCharacteristicsAutomaticCalculationFormViewModel.Create;
begin

  inherited;

  FReservoirKindName := AddProperty('ReservoirKindName');
  FSubLayerKind := AddProperty('SubLayerKind');

  FSubLayerKinds := TSubLayerKindsProperty.Create('SubLayerKinds');

  AddProperty(FSubLayerKinds);
  
  FReservoirSubLayerCalculationCharacteristicValue := AddProperty('ReservoirSubLayerCalculationCharacteristicValue');
  FFuelRiseLevel := AddProperty('FuelRiseLevel');
  FFuelTemperature := AddProperty('FuelTemperature');
  FFuelDensity := AddProperty('FuelDensity');
  FFuelMass := AddProperty('FuelMass');
  
end;

destructor TFuelCharacteristicsAutomaticCalculationFormViewModel.Destroy;
var SubLayerKindStrings: TStrings;
begin

  inherited;

end;

function TFuelCharacteristicsAutomaticCalculationFormViewModel.
  GetSubLayerKinds: TStrings;
begin

  Result := FSubLayerKinds.Value;
  
end;

function TFuelCharacteristicsAutomaticCalculationFormViewModel.
  GetSubLayerKindValue: TSubLayerKind;
begin

  if VarIsNullOrEmpty(SubLayerKind.Value) then
    Result := skUnknown

  else Result := TSubLayerKind(SubLayerKind.Value);

end;

procedure TFuelCharacteristicsAutomaticCalculationFormViewModel.RestoreProperties;
begin

  inherited;

  FReservoirKindName := FindProperty('ReservoirKindName');
  FSubLayerKind := FindProperty('SubLayerKind');

  FSubLayerKinds := TSubLayerKindsProperty(FindProperty('SubLayerKinds'));
  
  FReservoirSubLayerCalculationCharacteristicValue :=
    FindProperty('ReservoirSubLayerCalculationCharacteristicValue');
  
  FFuelRiseLevel := FindProperty('FuelRiseLevel');
  FFuelTemperature := FindProperty('FuelTemperature');
  FFuelDensity := FindProperty('FuelDensity');
  FFuelMass := FindProperty('FuelMass');

end;

procedure TFuelCharacteristicsAutomaticCalculationFormViewModel.SetSubLayerKinds(
  const Value: TStrings);
begin

  FSubLayerKinds.Value := Value;

end;

procedure TFuelCharacteristicsAutomaticCalculationFormViewModel.SetSubLayerKindValue(
  const Value: TSubLayerKind);
begin

  SubLayerKind.Value := Value;
  
end;

{ TSubLayerKindsProperty }

function TSubLayerKindsProperty.AreValuesEquals(
  PropertyValue,  AssignableValue: Variant
): Boolean;
begin

  Result :=
    TVarData(PropertyValue).VPointer = TVarData(AssignableValue).VPointer;
  
end;

procedure TSubLayerKindsProperty.AssignOtherValue(OtherValue: Variant);
var PreviousSubLayerKinds: TStrings;
begin

  PreviousSubLayerKinds := Value;

  PreviousSubLayerKinds.Free;

  inherited;

end;

function TSubLayerKindsProperty.CloneValue(Value: Variant): Variant;
var SubLayerKindStrings: TStrings;
    OtherSubLayerKindStrings: TStrings;
begin

  SubLayerKindStrings := TStringList.Create;

  OtherSubLayerKindStrings := TStrings(TVarData(Value).VPointer);

  SubLayerKindStrings.Assign(OtherSubLayerKindStrings);

  TVarData(Result).VType := varByRef;
  TVarData(Result).VPointer := SubLayerKindStrings;
  
end;

destructor TSubLayerKindsProperty.Destroy;
var SubLayerKindStrings: TStrings;
begin

  SubLayerKindStrings := Value;

  FreeAndNil(SubLayerKindStrings);

  inherited;

end;

function TSubLayerKindsProperty.GetSubLayerKinds: TStrings;
begin

  if VarIsNull(inherited Value) then
    Result := nil

  else Result := TStrings(TVarData(inherited Value).VPointer);

end;

procedure TSubLayerKindsProperty.SetSubLayerKinds(const Value: TStrings);
var SubLayerKindsVariant: Variant;
begin

  TVarData(SubLayerKindsVariant).VType := varByRef;
  TVarData(SubLayerKindsVariant).VPointer := Value;
  
  SetValue(SubLayerKindsVariant);

end;

end.
