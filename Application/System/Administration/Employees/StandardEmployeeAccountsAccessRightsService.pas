unit StandardEmployeeAccountsAccessRightsService;

interface

uses

  EmployeeAccountsAccessRightsService,
  EmployeeAccountsAccessRightsInfo,
  FuelCharacteristicsAccountingSystemAuthorizationService,
  EmployeeRepository,
  Employee,
  SysUtils,
  Classes;

type

  TStandardEmployeeAccountsAccessRightsService =
    class (TInterfacedObject, IEmployeeAccountsAccessRightsService)

      private

        FSystemAuthorizationService:
          IFuelCharacteristicsAccountingSystemAuthorizationService;

      public

        constructor Create(
          SystemAuthorizationService:
            IFuelCharacteristicsAccountingSystemAuthorizationService
        );
      
        function GetEmployeeAccountsAccessRightsInfoFor(
          const ClientIdentity: Variant
        ): TEmployeeAccountsAccessRightsInfo;

        procedure EnsureClientHasAccessRightsForEmployeeAccounts(
          const ClientIdentity: Variant
        );

    end;

implementation

uses

  IDomainObjectBaseUnit,
  Variants;

{ TStandardEmployeeAccountsAccessRightsService }

constructor TStandardEmployeeAccountsAccessRightsService.Create(
  SystemAuthorizationService:
    IFuelCharacteristicsAccountingSystemAuthorizationService
);
begin

  inherited Create;

  FSystemAuthorizationService := SystemAuthorizationService;
  
end;

procedure TStandardEmployeeAccountsAccessRightsService.
  EnsureClientHasAccessRightsForEmployeeAccounts(
    const ClientIdentity: Variant
  );
var AccessRights: TEmployeeAccountsAccessRightsInfo;
begin

  AccessRights := GetEmployeeAccountsAccessRightsInfoFor(ClientIdentity);

  AccessRights.Free;

end;

function TStandardEmployeeAccountsAccessRightsService.
  GetEmployeeAccountsAccessRightsInfoFor(
    const ClientIdentity: Variant
  ): TEmployeeAccountsAccessRightsInfo;
var Employee: TEmployee;
    Free: IDomainObjectBase;
begin

  if FSystemAuthorizationService.IsClientAdmin(ClientIdentity)
  then begin

    Result :=
      TEmployeeAccountsAccessRightsInfo.Create;

    Result.ViewEmployeesInfoAllowed := True;
    Result.AddingEmployeesInfoAllowed := True;
    Result.ChangingEmployeesInfoAllowed := True;
    Result.RemovingEmployeesInfoAllowed := True;

  end

  else begin

    raise TEmployeeAccountsAccessRightsServiceException.CreateFmt(
      '” сотрудника отсутствуют права ' +
      'доступа к управлению учЄтными запис€ми ' +
      'сотрудников',
      [
        Employee.FullName
      ]
    );

  end;

end;

end.
