unit EmployeeAccountsAccessRightsInfo;

interface

type

  TEmployeeAccountsAccessRightsInfo = class

    public

      ViewEmployeesInfoAllowed: Boolean;
      AddingEmployeesInfoAllowed: Boolean;
      ChangingEmployeesInfoAllowed: Boolean;
      RemovingEmployeesInfoAllowed: Boolean;

      function AllAccessRightsAbsent: Boolean;

  end;

implementation

{ TEmployeeAccountsAccessRightsInfo }

function TEmployeeAccountsAccessRightsInfo.AllAccessRightsAbsent: Boolean;
begin

  Result :=
    not (
      ViewEmployeesInfoAllowed or
      AddingEmployeesInfoAllowed or
      ChangingEmployeesInfoAllowed or
      RemovingEmployeesInfoAllowed
    );
    
end;

end.
