unit EmployeeAccountSetReadService;

interface

uses

  ApplicationService,
  EmployeeAccountSetHolder;

type

  IEmployeeAccountSetReadService = interface (IApplicationService)

    function GetAllEmployeeAccountSet: TEmployeeAccountSetHolder;
    
  end;

implementation

end.
