unit FuelCharacteristicsAccountingSystemAdministrationPrivileges;

interface

uses

  SystemAdministrationPrivileges,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingSystemAdministrationPrivileges =
    class (TSystemAdministrationPrivileges)

      private

        FEmployeesAdministrationPrivilege: TSystemAdministrationPrivilege;
        FWorkingTimeConditionsManagementPrivilege: TSystemAdministrationPrivilege;
        
        procedure SetEmployeesAdministrationPrivilege(
          const Value: TSystemAdministrationPrivilege
        );

        procedure SetWorkingTimeConditionsManagementPrivilege(
          const Value: TSystemAdministrationPrivilege
        );

        procedure AssignPrivilegeToProperty(
          Privilege: TSystemAdministrationPrivilege;
          var PrivilegeProperty: TSystemAdministrationPrivilege
        );

      public

        property EmployeesAdministrationPrivilege:
          TSystemAdministrationPrivilege
        read FEmployeesAdministrationPrivilege
        write SetEmployeesAdministrationPrivilege;

        property WorkingTimeConditionsManagementPrivilege:
          TSystemAdministrationPrivilege
        read FWorkingTimeConditionsManagementPrivilege
        write SetWorkingTimeConditionsManagementPrivilege;
      
    end;
    
implementation

{ TFuelCharacteristicsAccountingSystemAdministrationPrivileges }

procedure TFuelCharacteristicsAccountingSystemAdministrationPrivileges.AssignPrivilegeToProperty(
  Privilege: TSystemAdministrationPrivilege;
  var PrivilegeProperty: TSystemAdministrationPrivilege);
begin

  if PrivilegeProperty = Privilege then Exit;

  if not Assigned(Privilege) and
     Assigned(EmployeesAdministrationPrivilege)
  then begin

    Remove(PrivilegeProperty);

    PrivilegeProperty := nil;

  end;

  PrivilegeProperty := Privilege;

  if Assigned(PrivilegeProperty) then
    Add(PrivilegeProperty);

end;

procedure TFuelCharacteristicsAccountingSystemAdministrationPrivileges.SetEmployeesAdministrationPrivilege(
  const Value: TSystemAdministrationPrivilege);
begin

  AssignPrivilegeToProperty(
    Value, FEmployeesAdministrationPrivilege
  );
  
end;

procedure TFuelCharacteristicsAccountingSystemAdministrationPrivileges.SetWorkingTimeConditionsManagementPrivilege(
  const Value: TSystemAdministrationPrivilege);
begin

  AssignPrivilegeToProperty(
    Value, FWorkingTimeConditionsManagementPrivilege
  );

end;

end.
