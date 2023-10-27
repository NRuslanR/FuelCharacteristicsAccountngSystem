unit EmployeesAdministrationPrivilegeServices;

interface

uses

  SystemAdministrationPrivilegeServices,
  EmployeeAccountReferenceService,
  SysUtils,
  Classes;

type

  TEmployeesAdministrationPrivilegeServices =
    class (TSystemAdministrationPrivilegeServices)

      public

        EmployeeAccountReferenceService: IEmployeeAccountReferenceService;

        constructor Create(
          const PrivilegeId: Variant;
          EmployeeAccountReferenceService: IEmployeeAccountReferenceService
        );

    end;

implementation

{ TEmployeesAdministrationPrivilegeServices }

constructor TEmployeesAdministrationPrivilegeServices.Create(
  const PrivilegeId: Variant;
  EmployeeAccountReferenceService: IEmployeeAccountReferenceService
);
begin

  inherited Create(PrivilegeId);

  Self.EmployeeAccountReferenceService := EmployeeAccountReferenceService;
  
end;

end.
