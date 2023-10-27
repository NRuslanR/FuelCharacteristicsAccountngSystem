unit StandardEmployeeAccountReferenceService;

interface

uses

  EmployeeAccountReferenceService,
  EmployeeAccountsAccessRightsService,
  EmployeeAccountSetReadService,
  EmployeeAccountsAccessRightsInfo,
  EmployeeAccountSetHolder,
  SysUtils,
  Classes;

type

  TStandardEmployeeAccountReferenceService = class (TInterfacedObject, IEmployeeAccountReferenceService)

    protected

      FEmployeeAccountsAccessRightsService: IEmployeeAccountsAccessRightsService;
      FEmployeeAccountSetReadService: IEmployeeAccountSetReadService;
      
    public

      constructor Create(
        EmployeeAccountsAccessRightsService: IEmployeeAccountsAccessRightsService;
        EmployeeAccountSetReadService: IEmployeeAccountSetReadService
      );

      function GetEmployeeAccountsFor(
        const ClientIdentity: Variant
      ): TEmployeeAccountSetHolder; virtual;

  end;
  
implementation

{ TStandardEmployeeAccountReferenceService }

constructor TStandardEmployeeAccountReferenceService.Create(
  EmployeeAccountsAccessRightsService: IEmployeeAccountsAccessRightsService;
  EmployeeAccountSetReadService: IEmployeeAccountSetReadService);
begin

  inherited Create;

  FEmployeeAccountsAccessRightsService := EmployeeAccountsAccessRightsService;
  FEmployeeAccountSetReadService := EmployeeAccountSetReadService;
  
end;

function TStandardEmployeeAccountReferenceService.GetEmployeeAccountsFor(
  const ClientIdentity: Variant): TEmployeeAccountSetHolder;
var EmployeeAccountsAccessRightsInfo: TEmployeeAccountsAccessRightsInfo;
begin

  EmployeeAccountsAccessRightsInfo :=
    FEmployeeAccountsAccessRightsService.
      GetEmployeeAccountsAccessRightsInfoFor(
        ClientIdentity
      );

  Result := FEmployeeAccountSetReadService.GetAllEmployeeAccountSet;

  Result.ViewAllowed := EmployeeAccountsAccessRightsInfo.ViewEmployeesInfoAllowed;
  Result.AddingAllowed := EmployeeAccountsAccessRightsInfo.AddingEmployeesInfoAllowed;
  Result.ModificationAllowed := EmployeeAccountsAccessRightsInfo.ChangingEmployeesInfoAllowed;
  Result.RemovingAllowed := EmployeeAccountsAccessRightsInfo.RemovingEmployeesInfoAllowed;

end;

end.
