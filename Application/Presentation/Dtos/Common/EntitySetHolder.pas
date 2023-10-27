unit EntitySetHolder;

interface

uses

  AbstractDataSetHolder,
  SysUtils,
  Classes;

type

  TEntitySetFieldDefs = class (TAbstractDataSetFieldDefs)

  end;

  TEntitySetHolder = class (TAbstractDataSetHolder)

    private

      function GetEntitySetFieldDefs: TEntitySetFieldDefs;
      function GetIdFieldName: String;
      function GetIdFieldValue: Variant;

      procedure SetIdFieldName(const Value: String);
      procedure SetIdFieldValue(const Value: Variant);

    protected

      procedure SetEntitySetFieldDefs(const Value: TEntitySetFieldDefs);
      
    public

      ViewAllowed: Boolean;
      AddingAllowed: Boolean;
      ModificationAllowed: Boolean;
      RemovingAllowed: Boolean;

      constructor Create;

    public

      property IdFieldName: String
      read GetIdFieldName write SetIdFieldName;

    public

      property IdFieldValue: Variant
      read GetIdFieldValue write SetIdFieldValue;

    public

      property FieldDefs: TEntitySetFieldDefs
      read GetEntitySetFieldDefs write SetEntitySetFieldDefs;
      
  end;
  
implementation

uses

  Variants;

{ TEntitySetHolder }

constructor TEntitySetHolder.Create;
begin

  inherited;

  ViewAllowed := True;
  AddingAllowed := True;
  ModificationAllowed := True;
  RemovingAllowed := True;
  
end;

function TEntitySetHolder.GetEntitySetFieldDefs: TEntitySetFieldDefs;
begin

  Result := TEntitySetFieldDefs(FFieldDefs);
  
end;

function TEntitySetHolder.GetIdFieldName: String;
begin

  Result := FieldDefs.RecordIdFieldName;
  
end;

function TEntitySetHolder.GetIdFieldValue: Variant;
begin

  Result := GetDataSetFieldValue(IdFieldName, Null);
end;

procedure TEntitySetHolder.SetEntitySetFieldDefs(
  const Value: TEntitySetFieldDefs);
begin

  SetFieldDefs(Value);
  
end;

procedure TEntitySetHolder.SetIdFieldName(const Value: String);
begin

  FieldDefs.RecordIdFieldName := Value;
  
end;

procedure TEntitySetHolder.SetIdFieldValue(const Value: Variant);
begin

  SetDataSetFieldValue(IdFieldName, Value);
  
end;

end.
