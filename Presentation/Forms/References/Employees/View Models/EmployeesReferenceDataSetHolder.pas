unit EmployeesReferenceDataSetHolder;

interface

uses

  ReferenceFormDataSetHolder,
  SysUtils,
  Classes;

type

  TEmployeesReferenceDataSetFieldDefs = class (TReferenceFormDataSetFieldDefs)

    public

      NameFieldName: String;
      SurnameFieldName: String;
      PatronymicFieldName: String;
      BirthDateFieldName: String;
      SpecialityFieldName: String;
      
  end;

  TEmployeesReferenceDataSetFieldDefsClass = class of TEmployeesReferenceDataSetFieldDefs;

  TEmployeesReferenceDataSetHolder = class (TReferenceFormDataSetHolder)

    private

      function GetBirthDateFieldName: String;
      function GetBirthDateFieldValue: TDateTime;
      function GetEmployeesReferenceDataSetFieldDefs: TEmployeesReferenceDataSetFieldDefs;
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

      property FieldDefs: TEmployeesReferenceDataSetFieldDefs
      read GetEmployeesReferenceDataSetFieldDefs;

  end;

  TEmployeesReferenceDataSetHolderClass = class of TEmployeesReferenceDataSetHolder;
  
implementation

uses

  Variants;
  
{ TEmployeesReferenceDataSetHolder }

function TEmployeesReferenceDataSetHolder.GetBirthDateFieldName: String;
begin

  Result := FieldDefs.BirthDateFieldName;
  
end;

function TEmployeesReferenceDataSetHolder.GetBirthDateFieldValue: TDateTime;
begin

  Result := GetDataSetFieldValue(BirthDateFieldName, 0);
  
end;

function TEmployeesReferenceDataSetHolder.GetEmployeesReferenceDataSetFieldDefs: TEmployeesReferenceDataSetFieldDefs;
begin

  Result := TEmployeesReferenceDataSetFieldDefs(FFieldDefs);
  
end;

function TEmployeesReferenceDataSetHolder.GetNameFieldName: String;
begin

  Result := FieldDefs.NameFieldName;
  
end;

function TEmployeesReferenceDataSetHolder.GetNameFieldValue: String;
begin

  Result := GetDataSetFieldValue(NameFieldName, '');

end;

function TEmployeesReferenceDataSetHolder.GetPatronymicFieldName: String;
begin

  Result := FieldDefs.PatronymicFieldName;
  
end;

function TEmployeesReferenceDataSetHolder.GetPatronymicFieldValue: String;
begin

  Result := GetDataSetFieldValue(PatronymicFieldName, '');

end;

function TEmployeesReferenceDataSetHolder.GetSpecialityFieldName: String;
begin

  Result := FieldDefs.SpecialityFieldName;

end;

function TEmployeesReferenceDataSetHolder.GetSpecialityFieldValue: String;
begin

  Result := GetDataSetFieldValue(SpecialityFieldName, '');
  
end;

function TEmployeesReferenceDataSetHolder.GetSurnameFieldName: String;
begin

  Result := FieldDefs.SurnameFieldName;
  
end;

function TEmployeesReferenceDataSetHolder.GetSurnameFieldValue: String;
begin

  Result := GetDataSetFieldValue(SpecialityFieldName, '');

end;

procedure TEmployeesReferenceDataSetHolder.SetBirthDateFieldName(
  const Value: String);
begin

  FieldDefs.BirthDateFieldName := Value;

end;

procedure TEmployeesReferenceDataSetHolder.SetBirthDateFieldValue(
  const Value: TDateTime);
begin

  SetDataSetFieldValue(BirthDateFieldName, Value);

end;

procedure TEmployeesReferenceDataSetHolder.SetNameFieldName(
  const Value: String);
begin

  FieldDefs.NameFieldName := Value;
  
end;

procedure TEmployeesReferenceDataSetHolder.SetNameFieldValue(
  const Value: String);
begin

  SetDataSetFieldValue(NameFieldName, Value);
  
end;

procedure TEmployeesReferenceDataSetHolder.SetPatronymicFieldName(
  const Value: String);
begin

  FieldDefs.PatronymicFieldName := Value;

end;

procedure TEmployeesReferenceDataSetHolder.SetPatronymicFieldValue(
  const Value: String);
begin

  SetDataSetFieldValue(PatronymicFieldName, Value);
  
end;

procedure TEmployeesReferenceDataSetHolder.SetSpecialityFieldName(
  const Value: String);
begin

  FieldDefs.SpecialityFieldName := Value;
  
end;

procedure TEmployeesReferenceDataSetHolder.SetSpecialityFieldValue(
  const Value: String);
begin

  SetDataSetFieldValue(SpecialityFieldName, Value);

end;

procedure TEmployeesReferenceDataSetHolder.SetSurnameFieldName(
  const Value: String);
begin

  FieldDefs.SurnameFieldName := Value;
  
end;

procedure TEmployeesReferenceDataSetHolder.SetSurnameFieldValue(
  const Value: String);
begin

  SetDataSetFieldValue(SurnameFieldName, Value);

end;

end.
