unit EmployeeAccountsAccessRightsService;

interface

uses

  ApplicationService,
  EmployeeAccountsAccessRightsInfo;

type

  TEmployeeAccountsAccessRightsServiceException =
    class (TApplicationServiceException)

    end;

  IEmployeeAccountsAccessRightsService = interface (IApplicationService)

    function GetEmployeeAccountsAccessRightsInfoFor(
      const ClientIdentity: Variant
    ): TEmployeeAccountsAccessRightsInfo;

    procedure EnsureClientHasAccessRightsForEmployeeAccounts(
      const ClientIdentity: Variant
    );
    
  end;

implementation

end.
