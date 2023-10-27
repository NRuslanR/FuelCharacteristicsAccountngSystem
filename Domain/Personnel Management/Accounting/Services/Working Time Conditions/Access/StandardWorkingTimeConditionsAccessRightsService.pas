unit StandardWorkingTimeConditionsAccessRightsService;

interface

uses

  WorkingTimeConditions,
  Employee,
  AbstractDomainService,
  WorkingTimeConditionsAccessRights,
  WorkingTimeConditionsAccessRightsService,
  SysUtils,
  Classes;

type

  TStandardWorkingTimeConditionsAccessRightsService =
    class (
      TAbstractStandardDomainService,
      IWorkingTimeConditionsAccessRightsService
    )

      public

        function EnsureAndGetWorkingTimeConditionsAccessRightsForEmployee(
          WorkingTimeConditions: TWorkingTimeConditions;
          Employee: TEmployee
        ): TWorkingTimeConditionsAccessRights; virtual;

    end;


implementation

{ TStandardWorkingTimeConditionsAccessRightsService }

function TStandardWorkingTimeConditionsAccessRightsService.
  EnsureAndGetWorkingTimeConditionsAccessRightsForEmployee(
    WorkingTimeConditions: TWorkingTimeConditions;
    Employee: TEmployee
  ): TWorkingTimeConditionsAccessRights;

begin

  Result := TWorkingTimeConditionsAccessRights.Create;

  try

    with WorkingTimeConditions.Rules do begin

      Result.CanBeViewed :=
        AccessingRule.MayWorkingTimeConditionsBeAccessedByEmployee(
          WorkingTimeConditions, Employee
        );

      Result.CanBeEdited := Result.CanBeViewed;
      Result.CanBeRemoved := Result.CanBeViewed;
      
    end;

    if Result.AllAccessRightsAbsent then begin

      raise TWorkingTimeConditionsAccessRightsServiceException.CreateFmt(
        '” сотрудника "%s" отсутствуют какие-либо ' +
        'права на информацию о режиме рабочего времени',
        [Employee.FullName]
      );
  
    end;

  except

    on E: Exception do begin

      FreeAndNil(Result);

      raise;

    end;

  end;

end;

end.
