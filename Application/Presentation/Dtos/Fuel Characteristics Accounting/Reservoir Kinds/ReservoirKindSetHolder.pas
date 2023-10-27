unit ReservoirKindSetHolder;

interface

uses

  EntitySetHolder,
  SysUtils,
  Classes;

type

  TReservoirKindSetFieldDefs = class (TEntitySetFieldDefs)

    private

      function GetReservoirKindNameFieldName: String;
      procedure SetReservoirKindNameFieldName(const Value: String);
      
    public

      property ReservoirKindNameFieldName: String
      read GetReservoirKindNameFieldName
      write SetReservoirKindNameFieldName;

  end;

  TReservoirKindSetHolder = class (TEntitySetHolder)

    private

      function GetReservoirKindNameFieldName: String;
      function GetReservoirKindNameFieldValue: String;
      function GetReservoirKindSetFieldDefs: TReservoirKindSetFieldDefs;

      procedure SetReservoirKindNameFieldName(const Value: String);
      procedure SetReservoirKindNameFieldValue(const Value: String);

      procedure SetReservoirKindSetFieldDefs(
        const Value: TReservoirKindSetFieldDefs
      );

    public

      property ReservoirKindNameFieldName: String
      read GetReservoirKindNameFieldName
      write SetReservoirKindNameFieldName;

    public

      property ReservoirKindNameFieldValue: String
      read GetReservoirKindNameFieldValue
      write SetReservoirKindNameFieldValue;

    public

      property FieldDefs: TReservoirKindSetFieldDefs
      read GetReservoirKindSetFieldDefs
      write SetReservoirKindSetFieldDefs;
      
  end;

implementation

{ TReservoirKindSetFieldDefs }

function TReservoirKindSetFieldDefs.GetReservoirKindNameFieldName: String;
begin

  Result := RecordIdFieldName;

end;

procedure TReservoirKindSetFieldDefs.SetReservoirKindNameFieldName(
  const Value: String);
begin

  RecordIdFieldName := Value;
  
end;

{ TReservoirKindSetHolder }

function TReservoirKindSetHolder.GetReservoirKindNameFieldName: String;
begin

  Result := FieldDefs.ReservoirKindNameFieldName;

end;

function TReservoirKindSetHolder.GetReservoirKindNameFieldValue: String;
begin

  Result := GetDataSetFieldValue(ReservoirKindNameFieldName, '');

end;

function TReservoirKindSetHolder.
  GetReservoirKindSetFieldDefs: TReservoirKindSetFieldDefs;
begin

  Result := TReservoirKindSetFieldDefs(inherited FieldDefs);
  
end;

procedure TReservoirKindSetHolder.SetReservoirKindNameFieldName(
  const Value: String);
begin

  FieldDefs.ReservoirKindNameFieldName := Value;
  
end;

procedure TReservoirKindSetHolder.SetReservoirKindNameFieldValue(
  const Value: String);
begin

  SetDataSetFieldValue(ReservoirKindNameFieldName, Value);
  
end;

procedure TReservoirKindSetHolder.SetReservoirKindSetFieldDefs(
  const Value: TReservoirKindSetFieldDefs);
begin

  SetFieldDefs(Value);
  
end;

end.
