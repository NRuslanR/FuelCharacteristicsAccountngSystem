unit FuelCharacteristicsCalculationCardSetHolder;

interface

uses

  EntitySetHolder,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsCalculationCardSetFieldDefs = class (TEntitySetFieldDefs)

    public

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

  TFuelCharacteristicsCalculationCardSetHolder = class (TEntitySetHolder)

    private

      function GetCalculationPerformingDateTimeFieldName: String;
      function GetCalculationPerformingDateTimeFieldValue: TDateTime;
      function GetDensityFieldName: String;
      function GetDensityFieldValue: Single;
      function GetFuelCharacteristicsCalculationCardSetFieldDefs: TFuelCharacteristicsCalculationCardSetFieldDefs;
      function GetFuelKindFieldName: String;
      function GetFuelKindFieldValue: String;
      function GetFuelRiseLevelFieldName: String;
      function GetFuelRiseLevelFieldValue: Single;
      function GetFuelMassFieldName: String;
      function GetFuelMassFieldValue: Single;
      function GetPerformedCalculationEmployeeIdFieldName: String;
      function GetPerformedCalculationEmployeeIdFieldValue: Variant;
      function GetPerformedCalculationEmployeeNameFieldName: String;
      function GetPerformedCalculationEmployeeNameFieldValue: String;
      function GetReservoirNumberFieldName: String;
      function GetReservoirNumberFieldValue: Integer;
      function GetTemperatureFieldName: String;
      function GetTemperatureFieldValue: Single;

      procedure SetCalculationPerformingDateTimeFieldName(const Value: String);

      procedure SetCalculationPerformingDateTimeFieldValue(
        const Value: TDateTime);

      procedure SetDensityFieldName(const Value: String);
      procedure SetDensityFieldValue(const Value: Single);

      procedure SetFuelCharacteristicsCalculationCardSetFieldDefs(
        const Value: TFuelCharacteristicsCalculationCardSetFieldDefs);

      procedure SetFuelKindFieldName(const Value: String);
      procedure SetFuelKindFieldValue(const Value: String);
      procedure SetFuelRiseLevelFieldName(const Value: String);
      procedure SetFuelRiseLevelFieldValue(const Value: Single);
      procedure SetFuelMassFieldName(const Value: String);
      procedure SetFuelMassFieldValue(const Value: Single);
      procedure SetPerformedCalculationEmployeeIdFieldName(const Value: String);
      procedure SetPerformedCalculationEmployeeIdFieldValue(const Value: Variant);
      procedure SetPerformedCalculationEmployeeNameFieldName(const Value: String);

      procedure SetPerformedCalculationEmployeeNameFieldValue(
        const Value: String);
        
      procedure SetReservoirNumberFieldName(const Value: String);
      procedure SetReservoirNumberFieldValue(const Value: Integer);
      procedure SetTemperatureFieldName(const Value: String);
      procedure SetTemperatureFieldValue(const Value: Single);

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

      property FieldDefs: TFuelCharacteristicsCalculationCardSetFieldDefs
      read GetFuelCharacteristicsCalculationCardSetFieldDefs
      write SetFuelCharacteristicsCalculationCardSetFieldDefs;

  end;

implementation

uses

  Variants;
  
{ TFuelCharacteristicsCalculationCardSetHolder }

function TFuelCharacteristicsCalculationCardSetHolder.
  GetCalculationPerformingDateTimeFieldName: String;
begin

  Result := FieldDefs.CalculationPerformingDateTimeFieldName;

end;

function TFuelCharacteristicsCalculationCardSetHolder.
  GetCalculationPerformingDateTimeFieldValue: TDateTime;
begin

  Result := GetDataSetFieldValue(CalculationPerformingDateTimeFieldName, 0);

end;

function TFuelCharacteristicsCalculationCardSetHolder.GetDensityFieldName: String;
begin

  Result := FieldDefs.DensityFieldName;

end;

function TFuelCharacteristicsCalculationCardSetHolder.GetDensityFieldValue: Single;
begin

  Result := GetDataSetFieldValue(DensityFieldName, 0);

end;

function TFuelCharacteristicsCalculationCardSetHolder.
  GetFuelCharacteristicsCalculationCardSetFieldDefs:
    TFuelCharacteristicsCalculationCardSetFieldDefs;
begin

  Result := TFuelCharacteristicsCalculationCardSetFieldDefs(inherited FieldDefs);
  
end;

function TFuelCharacteristicsCalculationCardSetHolder.GetFuelKindFieldName: String;
begin

  Result := FieldDefs.FuelKindFieldName;

end;

function TFuelCharacteristicsCalculationCardSetHolder.GetFuelKindFieldValue: String;
begin

  Result := GetDataSetFieldValue(FuelKindFieldName, '');

end;

function TFuelCharacteristicsCalculationCardSetHolder.GetFuelRiseLevelFieldName: String;
begin

  Result := FieldDefs.FuelRiseLevelFieldName;

end;

function TFuelCharacteristicsCalculationCardSetHolder.GetFuelRiseLevelFieldValue: Single;
begin

  Result := GetDataSetFieldValue(FuelRiseLevelFieldName, 0);
  
end;

function TFuelCharacteristicsCalculationCardSetHolder.GetFuelMassFieldName: String;
begin

  Result := FieldDefs.FuelMassFieldName;
  
end;

function TFuelCharacteristicsCalculationCardSetHolder.GetFuelMassFieldValue: Single;
begin

  Result := GetDataSetFieldValue(FuelMassFieldName, 0);
  
end;

function TFuelCharacteristicsCalculationCardSetHolder.
  GetPerformedCalculationEmployeeIdFieldName: String;
begin

  Result := FieldDefs.PerformedCalculationEmployeeIdFieldName;

end;

function TFuelCharacteristicsCalculationCardSetHolder.
  GetPerformedCalculationEmployeeIdFieldValue: Variant;
begin

  Result := GetDataSetFieldValue(PerformedCalculationEmployeeIdFieldName, Null);
  
end;

function TFuelCharacteristicsCalculationCardSetHolder.
  GetPerformedCalculationEmployeeNameFieldName: String;
begin

  Result := FieldDefs.PerformedCalculationEmployeeNameFieldName;

end;

function TFuelCharacteristicsCalculationCardSetHolder.
  GetPerformedCalculationEmployeeNameFieldValue: String;
begin

  Result := GetDataSetFieldValue(PerformedCalculationEmployeeNameFieldName, '');
  
end;

function TFuelCharacteristicsCalculationCardSetHolder.GetReservoirNumberFieldName: String;
begin

  Result := FieldDefs.ReservoirNumberFieldName;
  
end;

function TFuelCharacteristicsCalculationCardSetHolder.GetReservoirNumberFieldValue: Integer;
begin

  Result := GetDataSetFieldValue(ReservoirNumberFieldName, 0);
  
end;

function TFuelCharacteristicsCalculationCardSetHolder.GetTemperatureFieldName: String;
begin

  Result := FieldDefs.TemperatureFieldName;
  
end;

function TFuelCharacteristicsCalculationCardSetHolder.GetTemperatureFieldValue: Single;
begin

  Result := GetDataSetFieldValue(TemperatureFieldName, 0);
  
end;

procedure TFuelCharacteristicsCalculationCardSetHolder.
  SetCalculationPerformingDateTimeFieldName(
    const Value: String);
begin

  FieldDefs.CalculationPerformingDateTimeFieldName := Value;

end;

procedure TFuelCharacteristicsCalculationCardSetHolder.
SetCalculationPerformingDateTimeFieldValue(
  const Value: TDateTime);
begin

  SetDataSetFieldValue(CalculationPerformingDateTimeFieldName, Value);

end;

procedure TFuelCharacteristicsCalculationCardSetHolder.SetDensityFieldName(
  const Value: String);
begin

  FieldDefs.DensityFieldName := Value;

end;

procedure TFuelCharacteristicsCalculationCardSetHolder.SetDensityFieldValue(
  const Value: Single);
begin

  SetDataSetFieldValue(DensityFieldName, Value);

end;

procedure TFuelCharacteristicsCalculationCardSetHolder.
SetFuelCharacteristicsCalculationCardSetFieldDefs(
  const Value: TFuelCharacteristicsCalculationCardSetFieldDefs);
begin

  SetFieldDefs(Value);

end;

procedure TFuelCharacteristicsCalculationCardSetHolder.SetFuelKindFieldName(
  const Value: String);
begin

  FieldDefs.FuelKindFieldName := Value;

end;

procedure TFuelCharacteristicsCalculationCardSetHolder.SetFuelKindFieldValue(
  const Value: String);
begin

  SetDataSetFieldValue(FuelKindFieldName, Value);

end;

procedure TFuelCharacteristicsCalculationCardSetHolder.SetFuelRiseLevelFieldName(
  const Value: String);
begin

  FieldDefs.FuelRiseLevelFieldName := Value;

end;

procedure TFuelCharacteristicsCalculationCardSetHolder.SetFuelRiseLevelFieldValue(
  const Value: Single);
begin

  SetDataSetFieldValue(FuelRiseLevelFieldName, Value);
  
end;

procedure TFuelCharacteristicsCalculationCardSetHolder.SetFuelMassFieldName(
  const Value: String);
begin

  FieldDefs.FuelMassFieldName := Value;

end;

procedure TFuelCharacteristicsCalculationCardSetHolder.SetFuelMassFieldValue(
  const Value: Single);
begin

  SetDataSetFieldValue(FuelMassFieldName, Value);

end;

procedure TFuelCharacteristicsCalculationCardSetHolder.
SetPerformedCalculationEmployeeIdFieldName(
  const Value: String);
begin

  FieldDefs.PerformedCalculationEmployeeIdFieldName := Value;

end;

procedure TFuelCharacteristicsCalculationCardSetHolder.
SetPerformedCalculationEmployeeIdFieldValue(
  const Value: Variant);
begin

  SetDataSetFieldValue(PerformedCalculationEmployeeIdFieldName, Value);
  
end;

procedure TFuelCharacteristicsCalculationCardSetHolder.
  SetPerformedCalculationEmployeeNameFieldName(
    const Value: String);
begin

  FieldDefs.PerformedCalculationEmployeeNameFieldName := Value;

end;

procedure TFuelCharacteristicsCalculationCardSetHolder.
  SetPerformedCalculationEmployeeNameFieldValue(
    const Value: String);
begin

  SetDataSetFieldValue(PerformedCalculationEmployeeNameFieldName, Value);
  
end;

procedure TFuelCharacteristicsCalculationCardSetHolder.SetReservoirNumberFieldName(
  const Value: String);
begin

  FieldDefs.ReservoirNumberFieldName := Value;

end;

procedure TFuelCharacteristicsCalculationCardSetHolder.SetReservoirNumberFieldValue(
  const Value: Integer);
begin

  SetDataSetFieldValue(ReservoirNumberFieldName, Value);

end;

procedure TFuelCharacteristicsCalculationCardSetHolder.SetTemperatureFieldName(
  const Value: String);
begin

  FieldDefs.TemperatureFieldName := Value;
  
end;

procedure TFuelCharacteristicsCalculationCardSetHolder.SetTemperatureFieldValue(
  const Value: Single);
begin

  SetDataSetFieldValue(TemperatureFieldName, Value);

end;

end.
