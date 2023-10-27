unit StubEmployeeAccountsAccessRightsService;

interface

uses

  EmployeeAccountsAccessRightsInfo,
  EmployeeAccountsAccessRightsService;

type

  TStubEmployeeAccountsAccessRightsService =
    class (TInterfacedObject, IEmployeeAccountsAccessRightsService)

      public

        function GetEmployeeAccountsAccessRightsInfoFor(
          const ClientIdentity: Variant
        ): TEmployeeAccountsAccessRightsInfo;

        procedure EnsureClientHasAccessRightsForEmployeeAccounts(
          const ClientIdentity: Variant
        );
      
    end;

implementation

{ TStubEmployeeAccountsAccessRightsService }

procedure TStubEmployeeAccountsAccessRightsService.EnsureClientHasAccessRightsForEmployeeAccounts(
  const ClientIdentity: Variant);
begin

end;

function TStubEmployeeAccountsAccessRightsService.GetEmployeeAccountsAccessRightsInfoFor(
  const ClientIdentity: Variant): TEmployeeAccountsAccessRightsInfo;
begin

  Result := TEmployeeAccountsAccessRightsInfo.Create;

  Result.ViewEmployeesInfoAllowed := True;
  Result.AddingEmployeesInfoAllowed := True;
  Result.ChangingEmployeesInfoAllowed := True;
  Result.RemovingEmployeesInfoAllowed := True;
  
end;

end.
