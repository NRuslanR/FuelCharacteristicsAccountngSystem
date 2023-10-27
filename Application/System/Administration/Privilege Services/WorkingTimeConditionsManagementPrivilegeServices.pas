unit WorkingTimeConditionsManagementPrivilegeServices;

interface

uses

  SystemAdministrationPrivilegeServices,
  WorkingTimeConditionsAccountingAppService,
  SysUtils,
  Classes;

type

  TWorkingTimeConditionsManagementPrivilegeServices =
    class (TSystemAdministrationPrivilegeServices)

      public

        WorkingTimeConditionsAccountingAppService:
          IWorkingTimeConditionsAccountingAppService;

        constructor Create(

          const PrivilegeId: Variant;

          WorkingTimeConditionsAccountingAppService:
            IWorkingTimeConditionsAccountingAppService
        );

    end;

implementation

{ TWorkingTimeConditionsManagementPrivilegeServices }

constructor TWorkingTimeConditionsManagementPrivilegeServices.Create(
  const PrivilegeId: Variant;

  WorkingTimeConditionsAccountingAppService:
    IWorkingTimeConditionsAccountingAppService

);
begin

  inherited Create(PrivilegeId);

  Self.WorkingTimeConditionsAccountingAppService :=
    WorkingTimeConditionsAccountingAppService;
    
end;

end.
