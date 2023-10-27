unit EmployeeSetHolder;

interface

uses

  EntitySetHolder,
  SysUtils,
  Classes;

type

  TEmployeeSetFieldDefs = class (TEntitySetFieldDefs)

    public

      NameFieldName: String;
      SurnameFieldName: String;
      PatronymicFieldName: String;
      BirthDateFieldName: String;
      SpecialityFieldName: String;
      
  end;

  TEmployeeSetHolder = class (TEntitySetHolder)

    private

      function GetBirthDateFieldName: String;
      function GetBirthDateFieldValue: TDateTime;
      function GetEmployeeSetFieldDefs: TEmployeeSetFieldDefs;
      function GetNameFieldName: String;
      function GetNameFieldValue: String;
      function GetPatronymicFieldName: String;
      function GetPatronymicFieldValue: String;
      function GetSpecialityFieldName: String;
      function GetSpecialityFieldValue: String;
      function GetSurnameFieldName: String;
      function GetSurnameFieldValue: String;
      
      procedure SetBirthDateFieldName(const Value: String);
      procedure SetBirthDateFieldValue(const Value: TDateTime);
      procedure SetNameFieldName(const Value: String);
      procedure SetNameFieldValue(const Value: String);
      procedure SetPatronymicFieldName(const Value: String);
      procedure SetPatronymicFieldValue(const Value: String);
      procedure SetSpecialityFieldName(const Value: String);
      procedure SetSpecialityFieldValue(const Value: String);
      procedure SetSurnameFieldName(const Value: String);
      procedure SetSurnameFieldValue(const Value: String);
      procedure SetEmployeeSetFieldDefs(const Value: TEmployeeSetFieldDefs);

    public

      property NameFieldName: String
      read GetNameFieldName write SetNameFieldName;

      property SurnameFieldName: String
      read GetSurnameFieldName write SetSurnameFieldName;

      property PatronymicFieldName: String
      read GetPatronymicFieldName write SetPatronymicFieldName;

      property BirthDateFieldName: String
      read GetBirthDateFieldName write SetBirthDateFieldName;

      property SpecialityFieldName: String
      read GetSpecialityFieldName write SetSpecialityFieldName;

    public

      property NameFieldValue: String
      read GetNameFieldValue write SetNameFieldValue;

      property SurnameFieldValue: String
      read GetSurnameFieldValue write SetSurnameFieldValue;

      property PatronymicFieldValue: String
      read GetPatronymicFieldValue write SetPatronymicFieldValue;

      property BirthDateFieldValue: TDateTime
      read GetBirthDateFieldValue write SetBirthDateFieldValue;

      property SpecialityFieldValue: String
      read GetSpecialityFieldValue write SetSpecialityFieldValue;
      
    public

      property FieldDefs: TEmployeeSetFieldDefs
      read GetEmployeeSetFieldDefs
      write SetEmployeeSetFieldDefs;

  end;
  
implementation

uses

  Variants;
  
{ TEmployeeSetHolder }

function TEmployeeSetHolder.GetBirthDateFieldName: String;
begin

  Result := FieldDefs.BirthDateFieldName;
  
end;

function TEmployeeSetHolder.GetBirthDateFieldValue: TDateTime;
begin

  Result := GetDataSetFieldValue(BirthDateFieldName, 0);
  
end;

function TEmployeeSetHolder.GetEmployeeSetFieldDefs: TEmployeeSetFieldDefs;
begin

  Result := TEmployeeSetFieldDefs(FFieldDefs);
  
end;

function TEmployeeSetHolder.GetNameFieldName: String;
begin

  Result := FieldDefs.NameFieldName;
  
end;

function TEmployeeSetHolder.GetNameFieldValue: String;
begin

  Result := GetDataSetFieldValue(NameFieldName, '');

end;

function TEmployeeSetHolder.GetPatronymicFieldName: String;
begin

  Result := FieldDefs.PatronymicFieldName;
  
end;

function TEmployeeSetHolder.GetPatronymicFieldValue: String;
begin

  Result := GetDataSetFieldValue(PatronymicFieldName, '');

end;

function TEmployeeSetHolder.GetSpecialityFieldName: String;
begin

  Result := FieldDefs.SpecialityFieldName;

end;

function TEmployeeSetHolder.GetSpecialityFieldValue: String;
begin

  Result := GetDataSetFieldValue(SpecialityFieldName, '');
  
end;

function TEmployeeSetHolder.GetSurnameFieldName: String;
begin

  Result := FieldDefs.SurnameFieldName;
  
end;

function TEmployeeSetHolder.GetSurnameFieldValue: String;
begin

  Result := GetDataSetFieldValue(SpecialityFieldName, '');

end;

procedure TEmployeeSetHolder.SetBirthDateFieldName(
  const Value: String);
begin

  FieldDefs.BirthDateFieldName := Value;

end;

procedure TEmployeeSetHolder.SetBirthDateFieldValue(
  const Value: TDateTime);
begin

  SetDataSetFieldValue(BirthDateFieldName, Value);

end;

procedure TEmployeeSetHolder.SetEmployeeSetFieldDefs(
  const Value: TEmployeeSetFieldDefs);
begin

  SetEntitySetFieldDefs(Value);
  
end;

procedure TEmployeeSetHolder.SetNameFieldName(
  const Value: String);
begin

  FieldDefs.NameFieldName := Value;
  
end;

procedure TEmployeeSetHolder.SetNameFieldValue(
  const Value: String);
begin

  SetDataSetFieldValue(NameFieldName, Value);
  
end;

procedure TEmployeeSetHolder.SetPatronymicFieldName(
  const Value: String);
begin

  FieldDefs.PatronymicFieldName := Value;

end;

procedure TEmployeeSetHolder.SetPatronymicFieldValue(
  const Value: String);
begin

  SetDataSetFieldValue(PatronymicFieldName, Value);
  
end;

procedure TEmployeeSetHolder.SetSpecialityFieldName(
  const Value: String);
begin

  FieldDefs.SpecialityFieldName := Value;
  
end;

procedure TEmployeeSetHolder.SetSpecialityFieldValue(
  const Value: String);
begin

  SetDataSetFieldValue(SpecialityFieldName, Value);

end;

procedure TEmployeeSetHolder.SetSurnameFieldName(
  const Value: String);
begin

  FieldDefs.SurnameFieldName := Value;
  
end;

procedure TEmployeeSetHolder.SetSurnameFieldValue(
  const Value: String);
begin

  SetDataSetFieldValue(SurnameFieldName, Value);

end;

end.
