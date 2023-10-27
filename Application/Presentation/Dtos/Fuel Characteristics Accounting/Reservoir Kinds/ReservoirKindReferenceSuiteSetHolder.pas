unit ReservoirKindReferenceSuiteSetHolder;

interface

uses

  EntitySetHolder,
  SysUtils;

type

  TReservoirKindReferenceSuiteSetFieldDefs = class (TEntitySetFieldDefs)

    private

      function GetReservoirKindNameFieldName: String;
      procedure SetReservoirKindNameFieldName(const Value: String);
      
    public

      AltitudinalConstantStencilFieldName: String;
      CalibrationChartLocationFieldName: String;

      property ReservoirKindNameFieldName: String
      read GetReservoirKindNameFieldName
      write SetReservoirKindNameFieldName;

  end;

  TReservoirKindReferenceSuiteSetHolder = class (TEntitySetHolder)

    private

      function GetAltitudinalConstantStencilFieldName: String;
      function GetAltitudinalConstantStencilFieldValue: Single;
      function GetCalibrationChartLocationFieldName: String;
      function GetCalibrationChartLocationFieldValue: String;
      function GetReservoirKindNameFieldName: String;
      function GetReservoirKindNameFieldValue: String;
      
      function GetReservoirKindReferenceSuiteSetFieldDefs:
        TReservoirKindReferenceSuiteSetFieldDefs;

      procedure SetAltitudinalConstantStencilFieldName(const Value: String);
      procedure SetAltitudinalConstantStencilFieldValue(const Value: Single);
      procedure SetCalibrationChartLocationFieldName(const Value: String);
      procedure SetCalibrationChartLocationFieldValue(const Value: String);
      procedure SetReservoirKindNameFieldName(const Value: String);
      procedure SetReservoirKindNameFieldValue(const Value: String);

      procedure SetReservoirKindReferenceSuiteSetFieldDefs(
        const Value: TReservoirKindReferenceSuiteSetFieldDefs
      );

    public

      property AltitudinalConstantStencilFieldName: String
      read GetAltitudinalConstantStencilFieldName
      write SetAltitudinalConstantStencilFieldName;

      property CalibrationChartLocationFieldName: String
      read GetCalibrationChartLocationFieldName
      write SetCalibrationChartLocationFieldName;

      property ReservoirKindNameFieldName: String
      read GetReservoirKindNameFieldName
      write SetReservoirKindNameFieldName;

    public

      property AltitudinalConstantStencilFieldValue: Single
      read GetAltitudinalConstantStencilFieldValue
      write SetAltitudinalConstantStencilFieldValue;

      property CalibrationChartLocationFieldValue: String
      read GetCalibrationChartLocationFieldValue
      write SetCalibrationChartLocationFieldValue;

      property ReservoirKindNameFieldValue: String
      read GetReservoirKindNameFieldValue
      write SetReservoirKindNameFieldValue;

    public

      property FieldDefs: TReservoirKindReferenceSuiteSetFieldDefs
      read GetReservoirKindReferenceSuiteSetFieldDefs
      write SetReservoirKindReferenceSuiteSetFieldDefs;

  end;

implementation

{ TReservoirKindReferenceSuiteSetFieldDefs }

function TReservoirKindReferenceSuiteSetFieldDefs.
  GetReservoirKindNameFieldName: String;
begin

  Result := RecordIdFieldName;

end;

procedure TReservoirKindReferenceSuiteSetFieldDefs.
  SetReservoirKindNameFieldName(
    const Value: String
  );
begin

  RecordIdFieldName := Value;
  
end;

{ TReservoirKindReferenceSuiteSetHolder }

function TReservoirKindReferenceSuiteSetHolder.
  GetAltitudinalConstantStencilFieldName: String;
begin

  Result := FieldDefs.AltitudinalConstantStencilFieldName;

end;

function TReservoirKindReferenceSuiteSetHolder.
  GetAltitudinalConstantStencilFieldValue: Single;
begin

  Result := GetDataSetFieldValue(AltitudinalConstantStencilFieldName, 0);
  
end;

function TReservoirKindReferenceSuiteSetHolder.
  GetCalibrationChartLocationFieldName: String;
begin

  Result := FieldDefs.CalibrationChartLocationFieldName;

end;

function TReservoirKindReferenceSuiteSetHolder.
  GetCalibrationChartLocationFieldValue: String;
begin

  Result := GetDataSetFieldValue(CalibrationChartLocationFieldName, '');
  
end;

function TReservoirKindReferenceSuiteSetHolder.
  GetReservoirKindNameFieldName: String;
begin

  Result := FieldDefs.ReservoirKindNameFieldName;
  
end;

function TReservoirKindReferenceSuiteSetHolder.
  GetReservoirKindNameFieldValue: String;
begin

  Result := GetDataSetFieldValue(ReservoirKindNameFieldName, '');

end;

function TReservoirKindReferenceSuiteSetHolder.
  GetReservoirKindReferenceSuiteSetFieldDefs:
    TReservoirKindReferenceSuiteSetFieldDefs;
begin

  Result := TReservoirKindReferenceSuiteSetFieldDefs(inherited FieldDefs);
  
end;

procedure TReservoirKindReferenceSuiteSetHolder.
  SetAltitudinalConstantStencilFieldName(
    const Value: String
  );
begin

  FieldDefs.AltitudinalConstantStencilFieldName := Value;

end;

procedure TReservoirKindReferenceSuiteSetHolder.
  SetAltitudinalConstantStencilFieldValue(
    const Value: Single
  );
begin

  SetDataSetFieldValue(AltitudinalConstantStencilFieldName, Value);

end;

procedure TReservoirKindReferenceSuiteSetHolder.
  SetCalibrationChartLocationFieldName(
    const Value: String
  );
begin

  FieldDefs.CalibrationChartLocationFieldName := Value;

end;

procedure TReservoirKindReferenceSuiteSetHolder.
  SetCalibrationChartLocationFieldValue(
    const Value: String
  );
begin

  SetDataSetFieldValue(CalibrationChartLocationFieldName, Value);

end;

procedure TReservoirKindReferenceSuiteSetHolder.
  SetReservoirKindNameFieldName(
    const Value: String
  );
begin

  FieldDefs.ReservoirKindNameFieldName := Value;

end;

procedure TReservoirKindReferenceSuiteSetHolder.
  SetReservoirKindNameFieldValue(
    const Value: String
  );
begin

  SetDataSetFieldValue(ReservoirKindNameFieldName, Value);
  
end;

procedure TReservoirKindReferenceSuiteSetHolder.
  SetReservoirKindReferenceSuiteSetFieldDefs(
    const Value: TReservoirKindReferenceSuiteSetFieldDefs
  );
begin

  SetFieldDefs(Value);
  
end;

end.
