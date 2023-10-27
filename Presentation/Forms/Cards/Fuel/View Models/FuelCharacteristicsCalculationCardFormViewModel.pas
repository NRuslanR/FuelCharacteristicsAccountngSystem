unit FuelCharacteristicsCalculationCardFormViewModel;

interface

uses

  CardFormViewModel,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsCalculationCardFormViewModel = class (TCardFormViewModel)

    private

      FFuelTemperature: TCardFormViewModelProperty;
      FFuelDensity: TCardFormViewModelProperty;
      FFuelRiseLevel: TCardFormViewModelProperty;
      FFuelMass: TCardFormViewModelProperty;
      FFuelKind: TCardFormViewModelProperty;
      FReservoirNumber: TCardFormViewModelProperty;

      FPerformedCalculationEmployeeId: TCardFormViewModelProperty;
      FPerformedCalculationEmployeeName: TCardFormViewModelProperty;
      FCalculationPerformingDateTime: TCardFormViewModelProperty;

      FCalculationPerformingDateTimeChangingEnabled: Boolean;

      procedure SetCalculationPerformingDateTimeChangingEnabled(
        const Value: Boolean
      );
      
    protected

      procedure RestoreProperties; override;
      
    public

      destructor Destroy; override;
      constructor Create; override;

      property FuelTemperature: TCardFormViewModelProperty
      read FFuelTemperature;

      property FuelDensity: TCardFormViewModelProperty
      read FFuelDensity;

      property FuelRiseLevel: TCardFormViewModelProperty
      read FFuelRiseLevel;

      property FuelMass: TCardFormViewModelProperty
      read FFuelMass;

      property FuelKind: TCardFormViewModelProperty
      read FFuelKind;
      
      property ReservoirNumber: TCardFormViewModelProperty
      read FReservoirNumber;

      property PerformedCalculationEmployeeId: TCardFormViewModelProperty
      read FPerformedCalculationEmployeeId;
      
      property PerformedCalculationEmployeeName: TCardFormViewModelProperty
      read FPerformedCalculationEmployeeName;

      property CalculationPerformingDateTime: TCardFormViewModelProperty
      read FCalculationPerformingDateTime;

      property CalculationPerformingDateTimeChangingEnabled: Boolean
      read FCalculationPerformingDateTimeChangingEnabled
      write SetCalculationPerformingDateTimeChangingEnabled;

  end;

implementation

uses

  Variants;

{ TFuelCharacteristicsCalculationCardFormViewModel }

constructor TFuelCharacteristicsCalculationCardFormViewModel.Create;
begin

  inherited;

  FFuelTemperature := AddProperty('FuelTemperature');
  FFuelDensity := AddProperty('FuelDensity');
  FFuelRiseLevel := AddProperty('FuelRiseLevel');
  FFuelMass := AddProperty('FuelMass');
  FFuelKind := AddProperty('FuelKind');
  FReservoirNumber := AddProperty('ReservoirNumber');

  FPerformedCalculationEmployeeId := AddProperty('PerformedCalculationEmployeeId');
  FPerformedCalculationEmployeeName := AddProperty('PerformedCalculationEmployeeName');
  FCalculationPerformingDateTime := AddProperty('CalculationPerformingDateTime');

end;

destructor TFuelCharacteristicsCalculationCardFormViewModel.Destroy;
begin

  inherited;

end;

procedure TFuelCharacteristicsCalculationCardFormViewModel.RestoreProperties;
begin

  inherited;

  FFuelTemperature := FindProperty('FuelTemperature');
  FFuelDensity := FindProperty('FuelDensity');
  FFuelRiseLevel := FindProperty('FuelRiseLevel');
  FFuelMass := FindProperty('FuelMass');
  FFuelKind := FindProperty('FuelKind');
  FReservoirNumber := FindProperty('ReservoirNumber');

  FPerformedCalculationEmployeeId := FindProperty('PerformedCalculationEmployeeId');
  FPerformedCalculationEmployeeName := FindProperty('PerformedCalculationEmployeeName');
  FCalculationPerformingDateTime := FindProperty('CalculationPerformingDateTime');
  
end;

procedure TFuelCharacteristicsCalculationCardFormViewModel.
  SetCalculationPerformingDateTimeChangingEnabled(
    const Value: Boolean
  );
begin

  FCalculationPerformingDateTimeChangingEnabled := Value;

end;

end.
