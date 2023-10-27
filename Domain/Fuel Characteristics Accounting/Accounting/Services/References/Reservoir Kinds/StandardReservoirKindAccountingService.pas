unit StandardReservoirKindAccountingService;

interface

uses

  Employee,
  AbstractDomainService,
  unIReservoirKind,
  ReservoirKindAccessRights,
  ReservoirKindAccountingService,
  ReservoirKindDirectory,
  ReservoirKindAccessService,
  SysUtils,
  Classes;

type

  TStandardReservoirKindAccountingService =
    class (
      TAbstractStandardDomainService,
      IReservoirKindAccountingService
    )

      protected

        FReservoirKindDirectory:
          IReservoirKindDirectory;

        FReservoirKindAccessService:
          IReservoirKindAccessService;

      public

        constructor Create(
          ReservoirKindDirectory:
            IReservoirKindDirectory;

          ReservoirKindAccessService:
            IReservoirKindAccessService
        );

        procedure TakeNewReservoirKindAndAccessRights(
          RequestingEmployee: TEmployee;
          var ReservoirKind: IReservoirKind;
          var AccessRights: TReservoirKindAccessRights
        );

        function TakeReservoirKindAccessRights(
          RequestingEmployee: TEmployee;
          const ReservoirKindName: String
        ): TReservoirKindAccessRights; virtual;

        procedure TakeReservoirKindAndAccessRights(
          RequestingEmployee: TEmployee;
          const ReservoirKindName: String;
          var ReservoirKind: IReservoirKind;
          var AccessRights: TReservoirKindAccessRights
        ); virtual;

        procedure PerformNewReservoirKindAccounting(
          RequestingEmployee: TEmployee;
          ReservoirKind: IReservoirKind
        ); virtual;

        procedure PerformChangedReservoirKindAccounting(
          RequestingEmployee: TEmployee;
          ReservoirKind: IReservoirKind
        ); virtual;

        procedure RemoveReservoirKind(
          RequestingEmployee: TEmployee;
          const ReservoirKindName: String
        ); virtual;

    end;
      
implementation

uses

  ReservoirKind,
  IDomainObjectBaseUnit,
  StandardEmployeeReservoirKindWorkingRuleRegistry;
  
{ TStandardReservoirKindAccountingService }

constructor TStandardReservoirKindAccountingService.Create(
  ReservoirKindDirectory: IReservoirKindDirectory;
  ReservoirKindAccessService: IReservoirKindAccessService);
begin

  inherited Create;

  FReservoirKindDirectory :=
    ReservoirKindDirectory;

  FReservoirKindAccessService :=
    ReservoirKindAccessService;
    
end;

procedure TStandardReservoirKindAccountingService.
  PerformChangedReservoirKindAccounting(
    RequestingEmployee: TEmployee;
    ReservoirKind: IReservoirKind
  );
var ConcreteReservoirKind: TReservoirKind;
begin

  ConcreteReservoirKind := TReservoirKind(ReservoirKind.Self);
  
  ConcreteReservoirKind
    .WorkingRules
      .ReservoirKindEditingRule
        .EnsureEmployeeMayEditReservoirKind(
          RequestingEmployee, ReservoirKind
        );

  FReservoirKindDirectory.ModifyReservoirKind(
    ConcreteReservoirKind
  );
  
end;

procedure TStandardReservoirKindAccountingService.
  PerformNewReservoirKindAccounting(
    RequestingEmployee: TEmployee;
    ReservoirKind: IReservoirKind
  );
var ConcreteReservoirKind: TReservoirKind;
begin

  ConcreteReservoirKind := TReservoirKind(ReservoirKind.Self);

  ConcreteReservoirKind
    .WorkingRules
      .ReservoirKindEditingRule
        .EnsureEmployeeMayEditReservoirKind(
          RequestingEmployee, ReservoirKind
        );

  FReservoirKindDirectory.PutReservoirKind(
    ConcreteReservoirKind
  );
  
end;

procedure TStandardReservoirKindAccountingService.
  RemoveReservoirKind(
    RequestingEmployee: TEmployee;
    const ReservoirKindName: String
  );
var ReservoirKind: TReservoirKind;
    Free: IDomainObjectBase;
begin

  ReservoirKind :=
    FReservoirKindDirectory.FindReservoirKind(
      ReservoirKindName
    );

  Free := ReservoirKind;

  ReservoirKind
    .WorkingRules
      .ReservoirKindRemovingRule
        .EnsureEmployeeMayRemoveReservoirKind(
          RequestingEmployee, ReservoirKind
        );

  FReservoirKindDirectory.RemoveReservoirKind(
    ReservoirKind
  );

end;

procedure TStandardReservoirKindAccountingService.
  TakeNewReservoirKindAndAccessRights(
    RequestingEmployee: TEmployee;
    var ReservoirKind: IReservoirKind;
    var AccessRights: TReservoirKindAccessRights
  );
var ConcreteReservoirKind: TReservoirKind;
begin

  ConcreteReservoirKind := TReservoirKind.Create;

  ReservoirKind := ConcreteReservoirKind;

  try

    ConcreteReservoirKind.WorkingRules :=
      TEmployeeReservoirKindWorkingRuleRegistry
        .Current
          .GetEmployeeReservoirKindWorkingRules;
        
    AccessRights :=
      FReservoirKindAccessService
        .EnsureAndGetReservoirKindAccessRightsForEmployee(
          ConcreteReservoirKind, RequestingEmployee
        );

    if AccessRights.CanBeEdited then
      ReservoirKind.EditingEmployee := RequestingEmployee;

  except

    on e: Exception do begin

      FreeAndNil(ReservoirKind);

      raise;
      
    end;

  end;

end;

function TStandardReservoirKindAccountingService.
  TakeReservoirKindAccessRights(
    RequestingEmployee: TEmployee;
    const ReservoirKindName: String
  ): TReservoirKindAccessRights;
var ReservoirKind: TReservoirKind;
    Free: IDomainObjectBase;
begin

  ReservoirKind :=
    FReservoirKindDirectory.FindReservoirKind(ReservoirKindName);

  Free := ReservoirKind;

  Result :=
    FReservoirKindAccessService
      .EnsureAndGetReservoirKindAccessRightsForEmployee(
        ReservoirKind, RequestingEmployee
      );
      
end;

procedure TStandardReservoirKindAccountingService.
  TakeReservoirKindAndAccessRights(
    RequestingEmployee: TEmployee;
    const ReservoirKindName: String;
    var ReservoirKind: IReservoirKind;
    var AccessRights: TReservoirKindAccessRights
  );
begin

  ReservoirKind :=
    FReservoirKindDirectory.FindReservoirKind(
      ReservoirKindName
    );

  try

    AccessRights :=
      FReservoirKindAccessService.
        EnsureAndGetReservoirKindAccessRightsForEmployee(
          TReservoirKind(ReservoirKind.Self),
          RequestingEmployee
        );

    if AccessRights.CanBeEdited then
      ReservoirKind.EditingEmployee := RequestingEmployee;

  except

    on e: Exception do begin

      FreeAndNil(ReservoirKind);

      raise;
      
    end;

  end;

end;

end.

