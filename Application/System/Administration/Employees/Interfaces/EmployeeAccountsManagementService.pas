unit EmployeeAccountsManagementService;

interface

uses

  EmployeeAccountDto,
  ApplicationService;

type

  TEmployeeAccountsManagementServiceExceptino =
    class (TApplicationServiceException)

    end;

  IEmployeeAccountsManagementService = interface (IApplicationService)

    function GetEmployeeAccount(
      const ClientIdentity: Variant;
      const EmployeeAccountId: Variant
    ): TEmployeeAccountDto;

    function AddEmployeeAccount(
      const ClientIdentity: Variant;
      const EmployeeAccountDto: TEmployeeAccountDto
    ): Variant;

    procedure ChangeEmployeeAccount(
      const ClientIdentity: Variant;
      const EmployeeAccountDto: TEmployeeAccountDto
    );

    procedure RemoveEmployeeAccount(
      const ClientIdentity: Variant;
      const EmployeeAccountId: Variant
    );
    
  end;


implementation

end.
