unit EmployeeLogOnInfoService;

interface

uses

  LogOnInfoDto,
  ApplicationService;

type

  TEmployeeLogOnInfoServiceException = class (TApplicationServiceException)

  end;
  
  IEmployeeLogOnInfoService = interface (IApplicationService)

    function GetEmployeeLogOnInfo(
      const ClientIdentity: Variant;
      const EmployeeId: Variant
    ): TLogOnInfoDto;

    function GetEmployeeLogOnInfoByLogin(
      const ClientIdentity: Variant;
      const Login: String
    ): TLogOnInfoDto;

    procedure AddEmployeeLogOnInfo(
      const ClientIdentity: Variant;
      const EmployeeId: Variant;
      const LogOnInfoDto: TLogOnInfoDto
    );

    procedure ChangeEmployeeLogOnInfo(
      const ClientIdentity: Variant;
      const EmployeeId: Variant;
      const LogOnInfoDto: TLogOnInfoDto
    );

    procedure RemoveEmployeeLogOnInfo(
      const ClientIdentity: Variant;
      const EmployeeId: Variant
    );
    
  end;

implementation

end.
