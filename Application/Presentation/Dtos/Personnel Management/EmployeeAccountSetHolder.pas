unit EmployeeAccountSetHolder;

interface

uses

  EmployeeSetHolder,
  SysUtils,
  Classes;

type

  TEmployeeAccountSetFieldDefs = class (TEmployeeSetFieldDefs)

    public

      RoleIdFieldName: String;
      RoleNameFieldName: String;
      LoginFieldName: String;
      
  end;
  
  TEmployeeAccountSetHolder = class (TEmployeeSetHolder)

    private

      function GetEmployeeAccountSetFieldDefs: TEmployeeAccountSetFieldDefs;
      function GetLoginFieldName: String;
      function GetLoginFieldValue: String;
      function GetRoleNameFieldName: String;
      function GetRoleNameFieldValue: String;
      function GetRoleIdFieldName: String;
      function GetRoleIdFieldValue: Variant;

      procedure SetEmployeeAccountSetFieldDefs(
        const Value: TEmployeeAccountSetFieldDefs
      );

      procedure SetLoginFieldName(const Value: String);
      procedure SetLoginFieldValue(const Value: String);
      procedure SetRoleNameFieldName(const Value: String);
      procedure SetRoleNameFieldValue(const Value: String);
      procedure SetRoleIdFieldName(const Value: String);
      procedure SetRoleIdFieldValue(const Value: Variant);

    public

      property RoleIdFieldName: String
      read GetRoleIdFieldName write SetRoleIdFieldName;
      
      property RoleNameFieldName: String
      read GetRoleNameFieldName write SetRoleNameFieldName;
      
      property LoginFieldName: String
      read GetLoginFieldName write SetLoginFieldName;

    public

      property RoleIdFieldValue: Variant
      read GetRoleIdFieldValue write SetRoleIdFieldValue;
      
      property RoleNameFieldValue: String
      read GetRoleNameFieldValue write SetRoleNameFieldValue;
      
      property LoginFieldValue: String
      read GetLoginFieldValue write SetLoginFieldValue;

    public

      property FieldDefs: TEmployeeAccountSetFieldDefs
      read GetEmployeeAccountSetFieldDefs write SetEmployeeAccountSetFieldDefs;
      
  end;

implementation

uses

  Variants;
  
{ TEmployeeAccountSetHolder }

function TEmployeeAccountSetHolder.GetEmployeeAccountSetFieldDefs: TEmployeeAccountSetFieldDefs;
begin

  Result := TEmployeeAccountSetFieldDefs(FFieldDefs);

end;

function TEmployeeAccountSetHolder.GetLoginFieldName: String;
begin

  Result := FieldDefs.LoginFieldName;
  
end;

function TEmployeeAccountSetHolder.GetLoginFieldValue: String;
begin

  Result := GetDataSetFieldValue(LoginFieldName, '');

end;

function TEmployeeAccountSetHolder.GetRoleIdFieldName: String;
begin

  Result := FieldDefs.RoleIdFieldName;
  
end;

function TEmployeeAccountSetHolder.GetRoleIdFieldValue: Variant;
begin

  Result := GetDataSetFieldValue(RoleIdFieldName, Null);

end;

function TEmployeeAccountSetHolder.GetRoleNameFieldName: String;
begin

  Result := FieldDefs.RoleNameFieldName;
  
end;

function TEmployeeAccountSetHolder.GetRoleNameFieldValue: String;
begin

  Result := GetDataSetFieldValue(RoleNameFieldName, '');
  
end;

procedure TEmployeeAccountSetHolder.SetEmployeeAccountSetFieldDefs(
  const Value: TEmployeeAccountSetFieldDefs);
begin

  SetFieldDefs(Value);
  
end;

procedure TEmployeeAccountSetHolder.SetLoginFieldName(const Value: String);
begin

  FieldDefs.LoginFieldName := Value;

end;

procedure TEmployeeAccountSetHolder.SetLoginFieldValue(const Value: String);
begin

  SetDataSetFieldValue(LoginFieldName, Value);
  
end;

procedure TEmployeeAccountSetHolder.SetRoleIdFieldName(const Value: String);
begin

  FieldDefs.RoleIdFieldName := Value;

end;

procedure TEmployeeAccountSetHolder.SetRoleIdFieldValue(const Value: Variant);
begin

  SetDataSetFieldValue(RoleIdFieldName, Value);
  
end;

procedure TEmployeeAccountSetHolder.SetRoleNameFieldName(const Value: String);
begin

  FieldDefs.RoleNameFieldName := Value;
  
end;

procedure TEmployeeAccountSetHolder.SetRoleNameFieldValue(const Value: String);
begin

  SetDataSetFieldValue(RoleNameFieldName, Value);
  
end;

end.
