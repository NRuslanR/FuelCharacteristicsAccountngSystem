unit ReservoirKindAccountingService;

interface

uses

  DomainService,
  DomainException,
  Employee,
  unIReservoirKind,
  ReservoirKindAccessRights;

type

  TReservoirKindAccountingServiceException = class (TDomainException)

  end;
  
  IReservoirKindAccountingService = interface (IDomainService)

    function TakeReservoirKindAccessRights(
      RequestingEmployee: TEmployee;
      const ReservoirKindName: String
    ): TReservoirKindAccessRights;

    procedure TakeNewReservoirKindAndAccessRights(
      RequestingEmployee: TEmployee;
      var ReservoirKind: IReservoirKind;
      var AccessRights: TReservoirKindAccessRights
    );
    
    procedure TakeReservoirKindAndAccessRights(
      RequestingEmployee: TEmployee;
      const ReservoirKindName: String;
      var ReservoirKind: IReservoirKind;
      var AccessRights: TReservoirKindAccessRights
    );

    procedure PerformNewReservoirKindAccounting(
      RequestingEmployee: TEmployee;
      ReservoirKind: IReservoirKind
    );

    procedure PerformChangedReservoirKindAccounting(
      RequestingEmployee: TEmployee;
      ReservoirKind: IReservoirKind
    );

    procedure RemoveReservoirKind(
      RequestingEmployee: TEmployee;
      const ReservoirKindName: String
    );
    
  end;
  
implementation

end.
