unit ReservoirKindReferenceSuitesDataSetHolder;

interface

uses

  ReferenceFormDataSetHolder,
  SysUtils;

type

  TReservoirKindReferenceSuitesDataSetFieldDefs =
    class (TReferenceFormDataSetFieldDefs)

      private
      
        function GetReservoirKindNameFieldName: String;
        procedure SetReservoirKindNameFieldName(const Value: String);
        
      public

        HSCValueFieldName: String;
        CalibrationChartLocationFieldName: String;
        
      public

        property ReservoirKindNameFieldName: String
        read GetReservoirKindNameFieldName
        write SetReservoirKindNameFieldName;
        
    end;
    
  TReservoirKindReferenceSuitesDataSetHolder =
    class (TReferenceFormDataSetHolder)

      private

        function GetCalibrationChartLocationFieldName: String;
        function GetCalibrationChartLocationFieldValue: Variant;
        function GetHSCValueFieldName: String;
        function GetHSCValueFieldValue: Single;
        function GetReservoirKindNameFieldName: String;
        function GetReservoirKindNameFieldValue: String;

        function GetReservoirKindReferenceSuitesDataSetFieldDefs:
          TReservoirKindReferenceSuitesDataSetFieldDefs;

        procedure SetCalibrationChartLocationFieldName(const Value: String);
        procedure SetCalibrationChartLocationFieldValue(const Value: Variant);
        procedure SetHSCValueFieldName(const Value: String);
        procedure SetHSCValueFieldValue(const Value: Single);
        procedure SetReservoirKindNameFieldName(const Value: String);
        procedure SetReservoirKindNameFieldValue(const Value: String);

        procedure SetReservoirKindReferenceSuitesDataSetFieldDefs(
          const Value: TReservoirKindReferenceSuitesDataSetFieldDefs
        );

      public

        property HSCValueFieldName: String
        read GetHSCValueFieldName write SetHSCValueFieldName;

        property CalibrationChartLocationFieldName: String
        read GetCalibrationChartLocationFieldName
        write SetCalibrationChartLocationFieldName;

        property ReservoirKindNameFieldName: String
        read GetReservoirKindNameFieldName
        write SetReservoirKindNameFieldName;

      public

        property HSCValueFieldValue: Single
        read GetHSCValueFieldValue write SetHSCValueFieldValue;

        property CalibrationChartLocationFieldValue: Variant
        read GetCalibrationChartLocationFieldValue
        write SetCalibrationChartLocationFieldValue;

        property ReservoirKindNameFieldValue: String
        read GetReservoirKindNameFieldValue
        write SetReservoirKindNameFieldValue;

      public

        property FieldDefs: TReservoirKindReferenceSuitesDataSetFieldDefs
        read GetReservoirKindReferenceSuitesDataSetFieldDefs
        write SetReservoirKindReferenceSuitesDataSetFieldDefs;
        
    end;
    
implementation

uses

  Variants;
  
{ TReservoirKindReferenceSuitesDataSetFieldDefs }

function TReservoirKindReferenceSuitesDataSetFieldDefs.
  GetReservoirKindNameFieldName: String;
begin

  Result := RecordIdFieldName;

end;

procedure TReservoirKindReferenceSuitesDataSetFieldDefs.
  SetReservoirKindNameFieldName(
    const Value: String
  );
begin

  RecordIdFieldName := Value;

end;

{ TReservoirKindReferenceSuitesDataSetHolder }

function TReservoirKindReferenceSuitesDataSetHolder.
  GetCalibrationChartLocationFieldName: String;
begin

  Result := FieldDefs.CalibrationChartLocationFieldName;
  
end;

function TReservoirKindReferenceSuitesDataSetHolder.
  GetCalibrationChartLocationFieldValue: Variant;
begin

  Result := GetDataSetFieldValue(CalibrationChartLocationFieldName, Null);
  
end;

function TReservoirKindReferenceSuitesDataSetHolder.
  GetHSCValueFieldName: String;
begin

  Result := FieldDefs.HSCValueFieldName;

end;

function TReservoirKindReferenceSuitesDataSetHolder.
  GetHSCValueFieldValue: Single;
begin

  Result := GetDataSetFieldValue(HSCValueFieldName, 0);
  
end;

function TReservoirKindReferenceSuitesDataSetHolder.
  GetReservoirKindNameFieldName: String;
begin

  Result := FieldDefs.ReservoirKindNameFieldName;
  
end;

function TReservoirKindReferenceSuitesDataSetHolder.
  GetReservoirKindNameFieldValue: String;
begin

  Result := GetDataSetFieldValue(ReservoirKindNameFieldName, '');
  
end;

function TReservoirKindReferenceSuitesDataSetHolder.
  GetReservoirKindReferenceSuitesDataSetFieldDefs:
    TReservoirKindReferenceSuitesDataSetFieldDefs;
begin

  Result := TReservoirKindReferenceSuitesDataSetFieldDefs(inherited FieldDefs);
  
end;

procedure TReservoirKindReferenceSuitesDataSetHolder.
SetCalibrationChartLocationFieldName(
  const Value: String);
begin

  FieldDefs.CalibrationChartLocationFieldName := Value;
  
end;

procedure TReservoirKindReferenceSuitesDataSetHolder.
SetCalibrationChartLocationFieldValue(
  const Value: Variant);
begin

  SetDataSetFieldValue(CalibrationChartLocationFieldName, Value);

end;

procedure TReservoirKindReferenceSuitesDataSetHolder.SetHSCValueFieldName(
  const Value: String);
begin

  FieldDefs.HSCValueFieldName := Value;
  
end;

procedure TReservoirKindReferenceSuitesDataSetHolder.SetHSCValueFieldValue(
  const Value: Single);
begin

  SetDataSetFieldValue(HSCValueFieldName, Value);

end;

procedure TReservoirKindReferenceSuitesDataSetHolder.SetReservoirKindNameFieldName(
  const Value: String);
begin

  FieldDefs.ReservoirKindNameFieldName := Value;
  
end;

procedure TReservoirKindReferenceSuitesDataSetHolder.SetReservoirKindNameFieldValue(
  const Value: String);
begin

  SetDataSetFieldValue(ReservoirKindNameFieldName, Value);
  
end;

procedure TReservoirKindReferenceSuitesDataSetHolder.
SetReservoirKindReferenceSuitesDataSetFieldDefs(
  const Value: TReservoirKindReferenceSuitesDataSetFieldDefs);
begin

  SetFieldDefs(Value);

end;

end.
