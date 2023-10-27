unit ReservoirKindReferenceSuiteAccountingService;

interface

uses

  DomainService,
  DomainException,
  unIReservoirKindReferenceSuite,
  ReservoirKindReferenceSuiteAccessRights,
  Employee;

type

  TReservoirKindReferenceSuiteAccountingServiceException =
    class (TDomainException)

    end;
    
  IReservoirKindReferenceSuiteAccountingService = interface (IDomainService)

    function TakeReservoirKindReferenceSuiteAccessRights(
      RequestingEmployee: TEmployee;
      const ReservoirKindName: String
    ): TReservoirKindReferenceSuiteAccessRights;
    
    procedure TakeNewReservoirKindReferenceSuiteAndAccessRights(
      RequestingEmployee: TEmployee;
      var ReservoirKindReferenceSuite: IReservoirKindReferenceSuite;
      var AccessRights: TReservoirKindReferenceSuiteAccessRights
    );

    procedure TakeReservoirKindReferenceSuiteAndAccessRights(
      RequestingEmployee: TEmployee;
      const ReservoirKindName: String;
      var ReservoirKindReferenceSuite: IReservoirKindReferenceSuite;
      var AccessRights: TReservoirKindReferenceSuiteAccessRights
    );

    procedure PerformNewReservoirKindReferenceSuiteAccounting(
      RequestingEmployee: TEmployee;
      ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
    );

    procedure PerformChangedReservoirKindReferenceSuiteAccounting(
      RequestingEmployee: TEmployee;
      ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
    );

    procedure RemoveReservoirKindReferenceSuite(
      RequestingEmployee: TEmployee;
      const ReservoirKindName: String
    );
    
  end;
  
implementation

end.
