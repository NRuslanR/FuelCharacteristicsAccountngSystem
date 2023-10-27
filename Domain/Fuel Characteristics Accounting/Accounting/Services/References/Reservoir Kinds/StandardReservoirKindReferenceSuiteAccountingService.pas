unit StandardReservoirKindReferenceSuiteAccountingService;

interface

uses

  Employee,
  AbstractDomainService,
  unIReservoirKindReferenceSuite,
  ReservoirKindReferenceSuiteAccessRights,
  ReservoirKindReferenceSuiteAccountingService,
  ReservoirKindReferenceSuiteDirectory,
  ReservoirKindAccountingService,
  ReservoirKindReferenceSuiteAccessService,
  ReservoirKind,
  ReservoirKindAccessRights,
  ReservoirCalibrationChartRegistry,
  unIReservoirKind,
  SysUtils,
  Classes;

type

  TStandardReservoirKindReferenceSuiteAccountingService =
    class (
      TAbstractStandardDomainService,
      IReservoirKindReferenceSuiteAccountingService
    )

      protected

        FReservoirKindReferenceSuiteDirectory:
          IReservoirKindReferenceSuiteDirectory;

        FReservoirKindReferenceSuiteAccessService:
          IReservoirKindReferenceSuiteAccessService;

        FReservoirKindAccountingService: IReservoirKindAccountingService;

        FReservoirCalibrationChartRegistry: IReservoirCalibrationChartRegistry;

        procedure EnsureReservoirCalibrationChartValid(
          const CalibrationChartLocation: Variant
        );
        
      public

        constructor Create(
          ReservoirKindReferenceSuiteDirectory:
            IReservoirKindReferenceSuiteDirectory;

          ReservoirKindReferenceSuiteAccessService:
            IReservoirKindReferenceSuiteAccessService;

          ReservoirKindAccountingService: IReservoirKindAccountingService;
          ReservoirCalibrationChartRegistry: IReservoirCalibrationChartRegistry
        );

        function TakeReservoirKindReferenceSuiteAccessRights(
          RequestingEmployee: TEmployee;
          const ReservoirKindName: String
        ): TReservoirKindReferenceSuiteAccessRights; virtual;

        procedure TakeNewReservoirKindReferenceSuiteAndAccessRights(
          RequestingEmployee: TEmployee;
          var ReservoirKindReferenceSuite: IReservoirKindReferenceSuite;
          var AccessRights: TReservoirKindReferenceSuiteAccessRights
        ); virtual;

        procedure TakeReservoirKindReferenceSuiteAndAccessRights(
          RequestingEmployee: TEmployee;
          const ReservoirKindName: String;
          var ReservoirKindReferenceSuite: IReservoirKindReferenceSuite;
          var AccessRights: TReservoirKindReferenceSuiteAccessRights
        ); virtual;

        procedure PerformNewReservoirKindReferenceSuiteAccounting(
          RequestingEmployee: TEmployee;
          ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
        ); virtual;

        procedure PerformChangedReservoirKindReferenceSuiteAccounting(
          RequestingEmployee: TEmployee;
          ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
        ); virtual;

        procedure RemoveReservoirKindReferenceSuite(
          RequestingEmployee: TEmployee;
          const ReservoirKindName: String
        ); virtual;

    end;
      
implementation

uses

  IDomainObjectBaseUnit,
  ReservoirKindReferenceSuite,
  StandardEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry;
  
{ TStandardReservoirKindReferenceSuiteAccountingService }

constructor TStandardReservoirKindReferenceSuiteAccountingService.Create(
  ReservoirKindReferenceSuiteDirectory: IReservoirKindReferenceSuiteDirectory;
  ReservoirKindReferenceSuiteAccessService: IReservoirKindReferenceSuiteAccessService;
  ReservoirKindAccountingService: IReservoirKindAccountingService;
  ReservoirCalibrationChartRegistry: IReservoirCalibrationChartRegistry
);
begin

  inherited Create;

  FReservoirKindReferenceSuiteDirectory :=
    ReservoirKindReferenceSuiteDirectory;

  FReservoirKindReferenceSuiteAccessService :=
    ReservoirKindReferenceSuiteAccessService;

  FReservoirKindAccountingService := ReservoirKindAccountingService;

  FReservoirCalibrationChartRegistry := ReservoirCalibrationChartRegistry;
    
end;

procedure TStandardReservoirKindReferenceSuiteAccountingService.
  EnsureReservoirCalibrationChartValid(
    const CalibrationChartLocation: Variant
  );
begin

  FReservoirCalibrationChartRegistry
    .GetReservoirCalibrationChart(CalibrationChartLocation);

end;

procedure TStandardReservoirKindReferenceSuiteAccountingService.
  PerformChangedReservoirKindReferenceSuiteAccounting(
    RequestingEmployee: TEmployee;
    ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
  );
var ConcreteReferenceSuite: TReservoirKindReferenceSuite;
begin

  ConcreteReferenceSuite :=
    TReservoirKindReferenceSuite(ReservoirKindReferenceSuite.Self);
    
  ConcreteReferenceSuite
    .WorkingRules
      .ReservoirKindReferenceSuiteEditingRule
        .EnsureEmployeeMayEditReservoirKindReferenceSuite(
          RequestingEmployee, ReservoirKindReferenceSuite
        );

  EnsureReservoirCalibrationChartValid(
    ReservoirKindReferenceSuite.CalibrationChartLocation
  );
  
  FReservoirKindReferenceSuiteDirectory.ModifyReservoirKindReferenceSuite(
    ConcreteReferenceSuite
  );
  
end;

procedure TStandardReservoirKindReferenceSuiteAccountingService.
  PerformNewReservoirKindReferenceSuiteAccounting(
    RequestingEmployee: TEmployee;
    ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
  );
var ConcreteReferenceSuite: TReservoirKindReferenceSuite;
    ConcreteReservoirKind: TReservoirKind;
    ReservoirKind: IReservoirKind;
    AccessRights: TReservoirKindAccessRights;

    FreeAccessRights: IDomainObjectBase;
begin

  ConcreteReferenceSuite :=
    TReservoirKindReferenceSuite(ReservoirKindReferenceSuite.Self);

  ConcreteReferenceSuite
    .WorkingRules
      .ReservoirKindReferenceSuiteEditingRule
        .EnsureEmployeeMayEditReservoirKindReferenceSuite(
          RequestingEmployee, ReservoirKindReferenceSuite
        );

  FReservoirKindAccountingService
    .TakeNewReservoirKindAndAccessRights(
      RequestingEmployee, ReservoirKind, AccessRights
    );

  FreeAccessRights := AccessRights;

  EnsureReservoirCalibrationChartValid(
    ReservoirKindReferenceSuite.CalibrationChartLocation
  );

  ConcreteReservoirKind := TReservoirKind(ReservoirKind.Self);
  
  ConcreteReservoirKind.Name := ConcreteReferenceSuite.ReservoirKindName;

  FReservoirKindAccountingService.PerformNewReservoirKindAccounting(
    RequestingEmployee, ReservoirKind
  );
  
  FReservoirKindReferenceSuiteDirectory.PutReservoirKindReferenceSuite(
    ConcreteReferenceSuite
  );
  
end;

procedure TStandardReservoirKindReferenceSuiteAccountingService.
  RemoveReservoirKindReferenceSuite(
    RequestingEmployee: TEmployee;
    const ReservoirKindName: String
  );
var ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
    Free: IDomainObjectBase;
begin

  ReservoirKindReferenceSuite :=
    FReservoirKindReferenceSuiteDirectory.FindReservoirKindReferenceSuite(
      ReservoirKindName
    );

  Free := ReservoirKindReferenceSuite;

  ReservoirKindReferenceSuite
    .WorkingRules
      .ReservoirKindReferenceSuiteRemovingRule
        .EnsureEmployeeMayRemoveReservoirKindReferenceSuite(
          RequestingEmployee, ReservoirKindReferenceSuite
        );

  FReservoirKindReferenceSuiteDirectory.RemoveReservoirKindReferenceSuite(
    ReservoirKindReferenceSuite
  );
  
  FReservoirKindAccountingService.RemoveReservoirKind(
    RequestingEmployee, ReservoirKindName
  );

end;

procedure TStandardReservoirKindReferenceSuiteAccountingService.
  TakeNewReservoirKindReferenceSuiteAndAccessRights(
    RequestingEmployee: TEmployee;
    var ReservoirKindReferenceSuite: IReservoirKindReferenceSuite;
    var AccessRights: TReservoirKindReferenceSuiteAccessRights
  );
var ConcreteReferenceSuite: TReservoirKindReferenceSuite;
begin

  ConcreteReferenceSuite := TReservoirKindReferenceSuite.Create;

  ReservoirKindReferenceSuite := ConcreteReferenceSuite;
  
  try

    ConcreteReferenceSuite.WorkingRules :=
      TEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry
        .Current
          .GetEmployeeReservoirKindReferenceSuiteWorkingRules;

    AccessRights :=
      FReservoirKindReferenceSuiteAccessService
        .EnsureAndGetReservoirKindReferenceSuiteAccessRightsForEmployee(
          ConcreteReferenceSuite, RequestingEmployee
        );

    if AccessRights.CanBeEdited then
      ConcreteReferenceSuite.EditingEmployee := RequestingEmployee;
    
  except

    on e: Exception do begin

      FreeAndNil(ReservoirKindReferenceSuite);

      raise;
      
    end;

  end;

end;

function TStandardReservoirKindReferenceSuiteAccountingService.
  TakeReservoirKindReferenceSuiteAccessRights(
    RequestingEmployee: TEmployee;
    const ReservoirKindName: String
  ): TReservoirKindReferenceSuiteAccessRights;
var ReferenceSuite: TReservoirKindReferenceSuite;
    Free: IDomainObjectBase;
begin

  ReferenceSuite :=
    FReservoirKindReferenceSuiteDirectory
      .FindReservoirKindReferenceSuite(ReservoirKindName);

  Free := ReferenceSuite;

  Result :=
    FReservoirKindReferenceSuiteAccessService
      .EnsureAndGetReservoirKindReferenceSuiteAccessRightsForEmployee(
        ReferenceSuite,
        RequestingEmployee
      );

end;

procedure TStandardReservoirKindReferenceSuiteAccountingService.
  TakeReservoirKindReferenceSuiteAndAccessRights(
    RequestingEmployee: TEmployee;
    const ReservoirKindName: String;
    var ReservoirKindReferenceSuite: IReservoirKindReferenceSuite;
    var AccessRights: TReservoirKindReferenceSuiteAccessRights
  );
begin

  ReservoirKindReferenceSuite :=
    FReservoirKindReferenceSuiteDirectory.FindReservoirKindReferenceSuite(
      ReservoirKindName
    );

  AccessRights :=
    FReservoirKindReferenceSuiteAccessService.
      EnsureAndGetReservoirKindReferenceSuiteAccessRightsForEmployee(
        TReservoirKindReferenceSuite(ReservoirKindReferenceSuite.Self),
        RequestingEmployee
      );
        
  try

    if AccessRights.CanBeEdited then
      ReservoirKindReferenceSuite.EditingEmployee := RequestingEmployee;
      
  except

    on e: Exception do begin

      FreeAndNil(AccessRights);

      raise;
      
    end;

  end;

end;

end.
