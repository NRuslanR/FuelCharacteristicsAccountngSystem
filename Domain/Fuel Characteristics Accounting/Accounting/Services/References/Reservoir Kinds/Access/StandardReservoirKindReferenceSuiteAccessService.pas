unit StandardReservoirKindReferenceSuiteAccessService;

interface

uses

  AbstractDomainService,
  ReservoirKindReferenceSuiteAccessService,
  Employee,
  ReservoirKindReferenceSuite,
  ReservoirKindReferenceSuiteAccessRights,
  SysUtils,
  Classes;

type

  TStandardReservoirKindReferenceSuiteAccessService =
    class (
      TAbstractStandardDomainService,
      IReservoirKindReferenceSuiteAccessService
    )

      public

        function GetReservoirKindReferenceSuiteAccessRightsForEmployee(
          ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
          Employee: TEmployee
        ): TReservoirKindReferenceSuiteAccessRights; virtual;

        function EnsureAndGetReservoirKindReferenceSuiteAccessRightsForEmployee(
          ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
          Employee: TEmployee
        ): TReservoirKindReferenceSuiteAccessRights; virtual;

        procedure EnsureReservoirKindReferenceSuiteAccessRightsForEmployee(
          ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
          Employee: TEmployee
        ); virtual;

    end;
  
implementation

uses

  IDomainObjectBaseUnit;
  
{ TStandardReservoirKindReferenceSuiteAccessService }

function TStandardReservoirKindReferenceSuiteAccessService.
  EnsureAndGetReservoirKindReferenceSuiteAccessRightsForEmployee(
    ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
    Employee: TEmployee
  ): TReservoirKindReferenceSuiteAccessRights;
begin

  Result :=
    GetReservoirKindReferenceSuiteAccessRightsForEmployee(
      ReservoirKindReferenceSuite, Employee
    );

  try

    if Result.AllAccessRightsAbsent then begin

      raise TReservoirKindReferenceSuiteAccessServiceException.CreateFmt(
        '” сотрудника "%s" отсутствуют права ' +
        'на доступ к справочным данным ' +
        'типа резервуаров "%s"',
        [
          Employee.FullName,
          ReservoirKindReferenceSuite.ReservoirKindName
        ]
      );
      
    end;

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;

    end;

  end;

end;

procedure TStandardReservoirKindReferenceSuiteAccessService.
  EnsureReservoirKindReferenceSuiteAccessRightsForEmployee(
    ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
    Employee: TEmployee
  );
var Free: IDomainObjectBase;
begin

  Free :=
    EnsureAndGetReservoirKindReferenceSuiteAccessRightsForEmployee(
      ReservoirKindReferenceSuite, Employee
    );

end;

function TStandardReservoirKindReferenceSuiteAccessService.
  GetReservoirKindReferenceSuiteAccessRightsForEmployee(
    ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
    Employee: TEmployee
  ): TReservoirKindReferenceSuiteAccessRights;
begin

  Result := TReservoirKindReferenceSuiteAccessRights.Create;

  try

    Result.CanBeViewed :=
      ReservoirKindReferenceSuite
        .WorkingRules
          .ReservoirKindReferenceSuiteViewingRule
            .MayEmployeeViewReservoirKindReferenceSuite(
              Employee, ReservoirKindReferenceSuite
            );

    Result.CanBeEdited :=
      ReservoirKindReferenceSuite
        .WorkingRules
          .ReservoirKindReferenceSuiteEditingRule
            .MayEmployeeEditReservoirKindReferenceSuite(
              Employee, ReservoirKindReferenceSuite
            );

    Result.CanBeRemoved :=
      ReservoirKindReferenceSuite
        .WorkingRules
          .ReservoirKindReferenceSuiteRemovingRule
            .MayEmployeeRemoveReservoirKindReferenceSuite(
              Employee, ReservoirKindReferenceSuite
            );

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

end.
