unit EmployeeAccountingAppService;

interface

uses

  ApplicationService,
  EmployeeDto,
  RoleDto;

type

  IEmployeeAccountingAppService = interface (IApplicationService)

    function GetEmployeeInfo(const EmployeeId: Variant): TEmployeeDto;

    function AddEmployeeInfo(EmployeeDto: TEmployeeDto): Variant;

    procedure ChangeEmployeeInfo(EmployeeDto: TEmployeeDto);

    procedure RemoveEmployeeInfo(const EmployeeId: Variant);

  end;

implementation

end.
