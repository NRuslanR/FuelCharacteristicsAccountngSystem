unit StandardReservoirKindAccessService;

interface

uses

  ReservoirKind,
  Employee,
  AbstractDomainService,
  ReservoirKindAccessService,
  ReservoirKindAccessRights,
  SysUtils,
  Classes;

type

  TStandardReservoirKindAccessService =
    class (TAbstractStandardDomainService, IReservoirKindAccessService)

      public

        function GetReservoirKindAccessRightsForEmployee(
          ReservoirKind: TReservoirKind;
          Employee: TEmployee
        ): TReservoirKindAccessRights; virtual;

        function EnsureAndGetReservoirKindAccessRightsForEmployee(
          ReservoirKind: TReservoirKind;
          Employee: TEmployee
        ): TReservoirKindAccessRights; virtual;

        procedure EnsureReservoirKindAccessRightsForEmployee(
          ReservoirKind: TReservoirKind;
          Employee: TEmployee
        ); virtual;

    end;
    
implementation

uses

  IDomainObjectBaseUnit;

{ TStandardReservoirKindAccessService }

function TStandardReservoirKindAccessService.
  EnsureAndGetReservoirKindAccessRightsForEmployee(
    ReservoirKind: TReservoirKind;
    Employee: TEmployee
  ): TReservoirKindAccessRights;
begin

  Result := GetReservoirKindAccessRightsForEmployee(ReservoirKind, Employee);

  try

    if Result.AllAccessRightsAbsent then begin

      raise TReservoirKindAccessServiceException.CreateFmt(
        'У сотрудника "%s" отсутствуют права ' +
        'на доступ к информации ' +
        'о типе резервуаров "%s"',
        [
          Employee.FullName,
          ReservoirKind.Name
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

procedure TStandardReservoirKindAccessService.
  EnsureReservoirKindAccessRightsForEmployee(
    ReservoirKind: TReservoirKind;
    Employee: TEmployee
  );
var Free: IDomainObjectBase;
begin

  Free :=
    EnsureAndGetReservoirKindAccessRightsForEmployee(
      ReservoirKind, Employee
    );

end;

function TStandardReservoirKindAccessService.
  GetReservoirKindAccessRightsForEmployee(
    ReservoirKind: TReservoirKind;
    Employee: TEmployee
  ): TReservoirKindAccessRights;
begin

  Result := TReservoirKindAccessRights.Create;

  try

    Result.CanBeViewed :=
      ReservoirKind
        .WorkingRules
          .ReservoirKindViewingRule
            .MayEmployeeViewReservoirKind(
              Employee, ReservoirKind
            );

    Result.CanBeEdited :=
      ReservoirKind
        .WorkingRules
          .ReservoirKindEditingRule
            .MayEmployeeEditReservoirKind(
              Employee, ReservoirKind
            );

    Result.CanBeRemoved :=
      ReservoirKind
        .WorkingRules
          .ReservoirKindRemovingRule
            .MayEmployeeRemoveReservoirKind(
              Employee, ReservoirKind
            );
            
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

end.
