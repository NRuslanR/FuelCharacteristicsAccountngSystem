unit EmployeeAccountReferenceService;

interface

uses

  ApplicationService,
  EmployeeAccountSetHolder;

type

  IEmployeeAccountReferenceService = interface (IApplicationService)

    function GetEmployeeAccountsFor(const ClientIdentity: Variant): TEmployeeAccountSetHolder;

  end;

implementation

end.
