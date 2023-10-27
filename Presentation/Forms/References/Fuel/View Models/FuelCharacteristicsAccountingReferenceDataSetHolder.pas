unit FuelCharacteristicsAccountingReferenceDataSetHolder;

interface

uses

  ReferenceFormDataSetHolder,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingReferenceDataSetFieldDefs =
    class (TReferenceFormDataSetFieldDefs)

      TemperatureFieldName: String;
      DensityFieldName: String;
      FuelRiseLevelFieldName: String;
      FuelMassFieldName: String;
      FuelKindFieldName: String;
      ReservoirNumberFieldName: String;
      PerformedCalculationEmployeeIdFieldName: String;
      PerformedCalculationEmployeeNameFieldName: String;
      CalculationPerformingDateTimeFieldName: String;

    end;

  TFuelCharacteristicsAccountingReferenceDataSetHolder =
    class (TReferenceFormDataSetHolder)

      private

        function GetCalculationPerformingDateTimeFieldName: String;
        function GetCalculationPerformingDateTimeFieldValue: TDateTime;
        function GetDensityFieldName: String;
        function GetDensityFieldValue: Single;
        function GetFuelCharacteristicsAccountingReferenceDataSetFieldDefs: TFuelCharacteristicsAccountingReferenceDataSetFieldDefs;
        function GetFuelRiseLevelFieldName: String;
        function GetFuelRiseLevelFieldValue: Single;
        function GetFuelMassFieldName: String;
        function GetFuelMassFieldValue: Single;
        function GetTemperatureFieldName: String;
        function GetTemperatureFieldValue: Single;
        function GetPerformedCalculationEmployeeNameFieldName: String;
        function GetPerformedCalculationEmployeeNameFieldValue: String;

        procedure SetCalculationPerformingDateTimeFieldName(const Value: String);

        procedure SetCalculationPerformingDateTimeFieldValue(
          const Value: TDateTime);

        procedure SetDensityFieldName(const Value: String);
        procedure SetDensityFieldValue(const Value: Single);

        procedure SetFuelCharacteristicsAccountingReferenceDataSet(
          const Value: TFuelCharacteristicsAccountingReferenceDataSetFieldDefs);

        procedure SetFuelRiseLevelFieldName(const Value: String);
        procedure SetFuelRiseLevelFieldValue(const Value: Single);
        procedure SetFuelMassFieldName(const Value: String);
        procedure SetFuelMassFieldValue(const Value: Single);
        procedure SetTemperatureFieldName(const Value: String);
        procedure SetTemperatureFieldValue(const Value: Single);
        procedure SetPerformedCalculationEmployeeNameFieldName(const Value: String);
        procedure SetPerformedCalculationEmployeeNameFieldValue(const Value: String);

        function GetFuelKindFieldName: String;
        function GetFuelKindFieldValue: String;
        function GetReservoirNumberFieldName: String;
        function GetReservoirNumberFieldValue: Integer;
        
        procedure SetFuelKindFieldName(const Value: String);
        procedure SetFuelKindFieldValue(const Value: String);
        procedure SetReservoirNumberFieldName(const Value: String);
        procedure SetReservoirNumberFieldValue(const Value: Integer);

        function GetPerformedCalculationEmployeeIdFieldName: String;
        function GetPerformedCalculationEmployeeIdFieldValue: Variant;

        procedure SetPerformedCalculationEmployeeIdFieldName(const Value: String);
        procedure SetPerformedCalculationEmployeeIdFieldValue(const Value: Variant);

      public

        property TemperatureFieldName: String
        read GetTemperatureFieldName write SetTemperatureFieldName;

        property DensityFieldName: String
        read GetDensityFieldName write SetDensityFieldName;

        property FuelRiseLevelFieldName: String
        read GetFuelRiseLevelFieldName write SetFuelRiseLevelFieldName;

        property FuelMassFieldName: String
        read GetFuelMassFieldName write SetFuelMassFieldName;

        property FuelKindFieldName: String
        read GetFuelKindFieldName write SetFuelKindFieldName;

        property ReservoirNumberFieldName: String
        read GetReservoirNumberFieldName write SetReservoirNumberFieldName;

        property PerformedCalculationEmployeeIdFieldName: String
        read GetPerformedCalculationEmployeeIdFieldName
        write SetPerformedCalculationEmployeeIdFieldName;
        
        property PerformedCalculationEmployeeNameFieldName: String
        read GetPerformedCalculationEmployeeNameFieldName
        write SetPerformedCalculationEmployeeNameFieldName;

        property CalculationPerformingDateTimeFieldName: String
        read GetCalculationPerformingDateTimeFieldName
        write SetCalculationPerformingDateTimeFieldName;

      public

        property TemperatureFieldValue: Single
        read GetTemperatureFieldValue write SetTemperatureFieldValue;

        property DensityFieldValue: Single
        read GetDensityFieldValue write SetDensityFieldValue;

        property FuelRiseLevelFieldValue: Single
        read GetFuelRiseLevelFieldValue write SetFuelRiseLevelFieldValue;

        property FuelMassFieldValue: Single
        read GetFuelMassFieldValue write SetFuelMassFieldValue;

        property FuelKindFieldValue: String
        read GetFuelKindFieldValue write SetFuelKindFieldValue;

        property ReservoirNumberFieldValue: Integer
        read GetReservoirNumberFieldValue write SetReservoirNumberFieldValue;

        property PerformedCalculationEmployeeIdFieldValue: Variant
        read GetPerformedCalculationEmployeeIdFieldValue
        write SetPerformedCalculationEmployeeIdFieldValue;
        
        property PerformedCalculationEmployeeNameFieldValue: String
        read GetPerformedCalculationEmployeeNameFieldValue
        write SetPerformedCalculationEmployeeNameFieldValue;

        property CalculationPerformingDateTimeFieldValue: TDateTime
        read GetCalculationPerformingDateTimeFieldValue
        write SetCalculationPerformingDateTimeFieldValue;

      public

        property FieldDefs: TFuelCharacteristicsAccountingReferenceDataSetFieldDefs
        read GetFuelCharacteristicsAccountingReferenceDataSetFieldDefs
        write SetFuelCharacteristicsAccountingReferenceDataSet;

    end;

implementation

uses

  Variants;
  
{ TFuelCharacteristicsAccountingReferenceDataSetHolder }

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetCalculationPerformingDateTimeFieldName: String;
begin

  Result := FieldDefs.CalculationPerformingDateTimeFieldName;

end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetCalculationPerformingDateTimeFieldValue: TDateTime;
begin

  Result := GetDataSetFieldValue(TemperatureFieldName, 0);

end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetDensityFieldName: String;
begin

  Result := FieldDefs.DensityFieldName;

end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetDensityFieldValue: Single;
begin

  Result := GetDataSetFieldValue(DensityFieldName, 0);

end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetFuelCharacteristicsAccountingReferenceDataSetFieldDefs: TFuelCharacteristicsAccountingReferenceDataSetFieldDefs;
begin

  Result := FFieldDefs as TFuelCharacteristicsAccountingReferenceDataSetFieldDefs;

end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.GetFuelKindFieldName: String;
begin

  Result := FieldDefs.FuelKindFieldName;
  
end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.GetFuelKindFieldValue: String;
begin

  Result := GetDataSetFieldValue(FuelKindFieldName, '');
  
end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetFuelRiseLevelFieldName: String;
begin

  Result := FieldDefs.FuelRiseLevelFieldName;

end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetFuelRiseLevelFieldValue: Single;
begin

  Result := GetDataSetFieldValue(FuelRiseLevelFieldName, 0);

end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetFuelMassFieldName: String;
begin

  Result := FieldDefs.FuelMassFieldName;

end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetFuelMassFieldValue: Single;
begin

  Result := GetDataSetFieldValue(FuelMassFieldName, 0);

end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.GetReservoirNumberFieldName: String;
begin

  Result := FieldDefs.ReservoirNumberFieldName;
  
end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetReservoirNumberFieldValue: Integer;
begin

  Result := GetDataSetFieldValue(ReservoirNumberFieldName, 0);
  
end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetTemperatureFieldName: String;
begin

  Result := FieldDefs.TemperatureFieldName;

end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetTemperatureFieldValue: Single;
begin

  Result := GetDataSetFieldValue(TemperatureFieldName, 0);

end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetPerformedCalculationEmployeeIdFieldName: String;
begin

  Result := FieldDefs.PerformedCalculationEmployeeIdFieldName;
  
end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetPerformedCalculationEmployeeIdFieldValue: Variant;
begin

  Result := GetDataSetFieldValue(PerformedCalculationEmployeeIdFieldName, Null);

end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetPerformedCalculationEmployeeNameFieldName: String;
begin

  Result := FieldDefs.PerformedCalculationEmployeeNameFieldName;

end;

function TFuelCharacteristicsAccountingReferenceDataSetHolder.
  GetPerformedCalculationEmployeeNameFieldValue: String;
begin

  Result := GetDataSetFieldValue(PerformedCalculationEmployeeNameFieldName, '');

end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.
  SetCalculationPerformingDateTimeFieldName(
  const Value: String);
begin

  FieldDefs.CalculationPerformingDateTimeFieldName := Value;

end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.
SetCalculationPerformingDateTimeFieldValue(
  const Value: TDateTime);
begin

  SetDataSetFieldValue(CalculationPerformingDateTimeFieldName, Value);

end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.
SetDensityFieldName(
  const Value: String);
begin

  FieldDefs.DensityFieldName := Value;

end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.
SetDensityFieldValue(
  const Value: Single);
begin

  SetDataSetFieldValue(DensityFieldName, Value);

end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.
SetFuelCharacteristicsAccountingReferenceDataSet(
  const Value: TFuelCharacteristicsAccountingReferenceDataSetFieldDefs);
begin

  SetFieldDefs(Value);

end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.SetFuelKindFieldName(
  const Value: String);
begin

  FieldDefs.FuelKindFieldName := Value;
  
end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.SetFuelKindFieldValue(
  const Value: String);
begin

  SetDataSetFieldValue(FuelKindFieldName, Value);
  
end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.
SetFuelRiseLevelFieldName(
  const Value: String);
begin

  FieldDefs.FuelRiseLevelFieldName := Value;

end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.
  SetFuelRiseLevelFieldValue(
  const Value: Single);
begin

  SetDataSetFieldValue(FuelRiseLevelFieldName, Value);

end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.
SetFuelMassFieldName(
  const Value: String);
begin

  FieldDefs.FuelMassFieldName := Value;

end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.
SetFuelMassFieldValue(
  const Value: Single);
begin

  SetDataSetFieldValue(FuelMassFieldName, Value);

end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.SetReservoirNumberFieldName(
  const Value: String);
begin

  FieldDefs.ReservoirNumberFieldName := Value;
  
end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.
SetReservoirNumberFieldValue(
  const Value: Integer);
begin

  SetDataSetFieldValue(ReservoirNumberFieldName, Value);
  
end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.
SetTemperatureFieldName(
  const Value: String);
begin

  FieldDefs.TemperatureFieldName := Value;

end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.
SetTemperatureFieldValue(
  const Value: Single);
begin

  SetDataSetFieldValue(TemperatureFieldName, Value);

end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.
  SetPerformedCalculationEmployeeIdFieldName(
    const Value: String);
begin

  FieldDefs.PerformedCalculationEmployeeIdFieldName := Value;
  
end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.
  SetPerformedCalculationEmployeeIdFieldValue(
    const Value: Variant);
begin

  SetDataSetFieldValue(PerformedCalculationEmployeeIdFieldName, Value);
  
end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.SetPerformedCalculationEmployeeNameFieldName(
  const Value: String);
begin

  FieldDefs.PerformedCalculationEmployeeNameFieldName := Value;

end;

procedure TFuelCharacteristicsAccountingReferenceDataSetHolder.
SetPerformedCalculationEmployeeNameFieldValue(
  const Value: String);
begin

  SetDataSetFieldValue(PerformedCalculationEmployeeNameFieldName, Value);

end;

end.
