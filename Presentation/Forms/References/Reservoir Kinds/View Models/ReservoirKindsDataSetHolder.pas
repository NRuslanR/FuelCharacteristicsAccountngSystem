unit ReservoirKindsDataSetHolder;

interface

uses

  ReferenceFormDataSetHolder,
  SysUtils;

type

  TReservoirKindsDataSetFieldDefs = class (TReferenceFormDataSetFieldDefs)

    private
    
      function GetReservoirKindNameFieldName: string;
      procedure SetReservoirKindNameFieldName(const Value: string);

    public

      property ReservoirKindNameFieldName: string
      read GetReservoirKindNameFieldName
      write SetReservoirKindNameFieldName;
      
  end;

  TReservoirKindsDataSetHolder = class (TReferenceFormDataSetHolder)

    private

      function GetReservoirKindNameFieldName: string;
      function GetReservoirKindNameFieldValue: string;

      procedure SetReservoirKindNameFieldName(const Value: string);
      procedure SetReservoirKindNameFieldValue(const Value: string);

      function GetReservoirKindsDataSetFieldDefs:
        TReservoirKindsDataSetFieldDefs;

      procedure SetReservoirKindsDataSetFieldDefs(
        const Value: TReservoirKindsDataSetFieldDefs
      );
      
    public

      property ReservoirKindNameFieldName: string
      read GetReservoirKindNameFieldName
      write SetReservoirKindNameFieldName;

      property ReservoirKindNameFieldValue: string
      read GetReservoirKindNameFieldValue
      write SetReservoirKindNameFieldValue;

      property FieldDefs: TReservoirKindsDataSetFieldDefs
      read GetReservoirKindsDataSetFieldDefs
      write SetReservoirKindsDataSetFieldDefs;
      
  end;
  
implementation

{ TReservoirKindsDataSetFieldDefs }

function TReservoirKindsDataSetFieldDefs.GetReservoirKindNameFieldName: string;
begin

  Result := RecordIdFieldName;
  
end;

procedure TReservoirKindsDataSetFieldDefs.SetReservoirKindNameFieldName(
  const Value: string);
begin

  RecordIdFieldName := Value;
  
end;

{ TReservoirKindsDataSetHolder }

function TReservoirKindsDataSetHolder.GetReservoirKindNameFieldName: string;
begin

  Result := FieldDefs.ReservoirKindNameFieldName;

end;

function TReservoirKindsDataSetHolder.GetReservoirKindNameFieldValue: string;
begin

  Result := GetDataSetFieldValue(ReservoirKindNameFieldName, '');
  
end;

function TReservoirKindsDataSetHolder.
  GetReservoirKindsDataSetFieldDefs: TReservoirKindsDataSetFieldDefs;
begin

  Result := inherited FieldDefs as TReservoirKindsDataSetFieldDefs;
  
end;

procedure TReservoirKindsDataSetHolder.SetReservoirKindNameFieldName(
  const Value: string);
begin

  FieldDefs.ReservoirKindNameFieldName := Value;
  
end;

procedure TReservoirKindsDataSetHolder.SetReservoirKindNameFieldValue(
  const Value: string);
begin

  SetDataSetFieldValue(ReservoirKindNameFieldName, Value);
  
end;

procedure TReservoirKindsDataSetHolder.SetReservoirKindsDataSetFieldDefs(
  const Value: TReservoirKindsDataSetFieldDefs);
begin

  SetFieldDefs(Value);

end;

end.
