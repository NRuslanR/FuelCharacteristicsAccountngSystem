unit StandardFuelCharacteristicsCalculationCardAccountingService;

interface

uses

  FuelCharacteristicsCalculationCardAccountingService,
  Employee,
  unIFuelCharacteristicsCalculationCard,
  FuelCharacteristicsCalculationCardDirectory,
  AbstractDomainService,
  FuelCharacteristicsCalculationCardAccessRights,
  FuelCharacteristicsCalculationCardAccessService,
  FuelCharacteristicsCalculationCardCreatingService,
  FuelCharacteristicsCalculationCardContextInfoAssigningService,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsCalculationCardAccountingService =
    class (
      TAbstractStandardDomainService,
      IFuelCharacteristicsCalculationCardAccountingService
    )

      protected

        FFuelCharacteristicsCalculationCardContextInfoAssigningService:
          IFuelCharacteristicsCalculationCardContextInfoAssigningService;

        FFuelCharacteristicsCalculationCardAccessService:
          IFuelCharacteristicsCalculationCardAccessService;
          
        FFuelCharacteristicsCalculationCardDirectory:
          IFuelCharacteristicsCalculationCardDirectory;

        FFuelCharacteristicsCalculationCardCreatingService:
          IFuelCharacteristicsCalculationCardCreatingService;
          
      public

        constructor Create(
          FuelCharacteristicsCalculationCardContextInfoAssigningService:
            IFuelCharacteristicsCalculationCardContextInfoAssigningService;

          FuelCharacteristicsCalculationCardAccessService:
            IFuelCharacteristicsCalculationCardAccessService;

          FuelCharacteristicsCalculationCardDirectory:
            IFuelCharacteristicsCalculationCardDirectory;

          FuelCharacteristicsCalculationCardCreatingService:
            IFuelCharacteristicsCalculationCardCreatingService
        );

        function TakeFuelCharacteristicsCalculationCardAccessRights(
          RequestingEmployee: TEmployee;
          CardIdentity: Variant
        ): TFuelCharacteristicsCalculationCardAccessRights;

        procedure TakeNewFuelCharacteristicsCalculationCardAndAccessRights(
          RequestingEmployee: TEmployee;
          var Card: IFuelCharacteristicsCalculationCard;
          var CardAccessRights: TFuelCharacteristicsCalculationCardAccessRights
        ); virtual;

        procedure TakeFuelCharacteristicsCalculationCardAndAccessRights(
          RequestingEmployee: TEmployee;
          CardIdentity: Variant;
          var Card: IFuelCharacteristicsCalculationCard;
          var CardAccessRights: TFuelCharacteristicsCalculationCardAccessRights
        ); virtual;

        procedure PerformNewFuelCharacteristicsCalculationCardAccounting(
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard;
          RequestingEmployee: TEmployee
        ); virtual;

        procedure PerformExistingFuelCharacteristicsCalculationCardAccounting(
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard;
          RequestingEmployee: TEmployee
        ); virtual;

        procedure RemoveFuelCharacteristicsCalculationCard(
          RequestingEmployee: TEmployee;
          CardIdentity: Variant
        ); virtual;

    end;

implementation

uses

  IDomainObjectBaseUnit,
  FuelCharacteristicsCalculationCard;
  
{ TStandardFuelCharacteristicsCalculationCardAccountingService }

constructor TStandardFuelCharacteristicsCalculationCardAccountingService.Create(
  FuelCharacteristicsCalculationCardContextInfoAssigningService:
    IFuelCharacteristicsCalculationCardContextInfoAssigningService;

  FuelCharacteristicsCalculationCardAccessService:
    IFuelCharacteristicsCalculationCardAccessService;

  FuelCharacteristicsCalculationCardDirectory:
    IFuelCharacteristicsCalculationCardDirectory;

  FuelCharacteristicsCalculationCardCreatingService:
    IFuelCharacteristicsCalculationCardCreatingService
);
begin

  inherited Create;
  
  FFuelCharacteristicsCalculationCardContextInfoAssigningService :=
    FuelCharacteristicsCalculationCardContextInfoAssigningService;

  FFuelCharacteristicsCalculationCardAccessService :=
    FuelCharacteristicsCalculationCardAccessService;

  FFuelCharacteristicsCalculationCardDirectory :=
    FuelCharacteristicsCalculationCardDirectory;

  FFuelCharacteristicsCalculationCardCreatingService :=
    FuelCharacteristicsCalculationCardCreatingService;
    
end;

procedure TStandardFuelCharacteristicsCalculationCardAccountingService.
  PerformExistingFuelCharacteristicsCalculationCardAccounting(
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard;
    RequestingEmployee: TEmployee
  );
var ConcreteCard: TFuelCharacteristicsCalculationCard;
begin

  ConcreteCard :=
    TFuelCharacteristicsCalculationCard(
      FuelCharacteristicsCalculationCard.Self
    );

  ConcreteCard
    .WorkingRules
    .FuelInfoEditingRule
    .EnsureEmployeeMayEditFuelCharacteristicsCalculationCardFuelInfo(
      RequestingEmployee, FuelCharacteristicsCalculationCard
    );
    
  if
    not
    FFuelCharacteristicsCalculationCardContextInfoAssigningService.
      IsCalculationContextInfoAssignedToFuelCharacteristicsCalculationCard(
        ConcreteCard, RequestingEmployee
      )
  then begin

    FFuelCharacteristicsCalculationCardContextInfoAssigningService.
      AssignCalculationContextInfoToFuelCharacteristicsCalculationCard(
        ConcreteCard, RequestingEmployee
      );
      
  end;

  FFuelCharacteristicsCalculationCardDirectory.
    ModifyFuelCharacteristicsCalculationCard(
      ConcreteCard
    );

end;

procedure TStandardFuelCharacteristicsCalculationCardAccountingService.
  PerformNewFuelCharacteristicsCalculationCardAccounting(
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard;
    RequestingEmployee: TEmployee
  );
var ConcreteCard: TFuelCharacteristicsCalculationCard;
begin

  ConcreteCard :=
    TFuelCharacteristicsCalculationCard(
      FuelCharacteristicsCalculationCard.Self
    );

  ConcreteCard
    .WorkingRules
    .FuelInfoEditingRule
    .EnsureEmployeeMayEditFuelCharacteristicsCalculationCardFuelInfo(
      RequestingEmployee, FuelCharacteristicsCalculationCard
    );

  if  
    not
    FFuelCharacteristicsCalculationCardContextInfoAssigningService.
      IsCalculationContextInfoAssignedToFuelCharacteristicsCalculationCard(
        ConcreteCard, RequestingEmployee
      )
  then begin

    FFuelCharacteristicsCalculationCardContextInfoAssigningService.
      AssignCalculationContextInfoToFuelCharacteristicsCalculationCard(
        ConcreteCard, RequestingEmployee
      );

  end;

  FFuelCharacteristicsCalculationCardDirectory.
    PutFuelCharacteristicsCalculationCard(ConcreteCard);
  
end;

procedure TStandardFuelCharacteristicsCalculationCardAccountingService.
  RemoveFuelCharacteristicsCalculationCard(
    RequestingEmployee: TEmployee;
    CardIdentity: Variant
  );
var Card: TFuelCharacteristicsCalculationCard;
    Free: IDomainObjectBase;
begin

  Card :=
    FFuelCharacteristicsCalculationCardDirectory.
      FindFuelCharacteristicsCalculationCard(
        CardIdentity
      );

  Free := Card;

  Card
    .WorkingRules
    .RemovingRule
    .EnsureEmployeeMayRemoveFuelCharacteristicsCalculationCard(
      RequestingEmployee, Card
    );

  FFuelCharacteristicsCalculationCardDirectory.
    RemoveFuelCharacteristicsCalculationCard(Card);

end; 

function TStandardFuelCharacteristicsCalculationCardAccountingService.
  TakeFuelCharacteristicsCalculationCardAccessRights(
    RequestingEmployee: TEmployee;
    CardIdentity: Variant
  ): TFuelCharacteristicsCalculationCardAccessRights;
var Card: TFuelCharacteristicsCalculationCard;
    Free: IDomainObjectBase;
begin

  Card :=
    FFuelCharacteristicsCalculationCardDirectory
      .FindFuelCharacteristicsCalculationCard(CardIdentity);

  Free := Card;

  Result :=
    FFuelCharacteristicsCalculationCardAccessService
      .GetFuelCharacteristicsCalculationCardAccessRightsForEmployee(
        Card, RequestingEmployee
      );

end;

procedure TStandardFuelCharacteristicsCalculationCardAccountingService.
  TakeFuelCharacteristicsCalculationCardAndAccessRights(
    RequestingEmployee: TEmployee;
    CardIdentity: Variant;
    var Card: IFuelCharacteristicsCalculationCard;
    var CardAccessRights: TFuelCharacteristicsCalculationCardAccessRights
  );
begin

  Card :=
    FFuelCharacteristicsCalculationCardDirectory.
      FindFuelCharacteristicsCalculationCard(
        CardIdentity
      );

  try

    CardAccessRights :=
      FFuelCharacteristicsCalculationCardAccessService.
        EnsureAndGetFuelCharacteristicsCalculationCardAccessRightsForEmployee(
          TFuelCharacteristicsCalculationCard(Card.Self), RequestingEmployee
        );

    if CardAccessRights.CalculationContextInfoCanBeEdited then
      Card.CalculationContextInfoEditingEmployee := RequestingEmployee;

    if CardAccessRights.FuelInfoCanBeEdited then
      Card.FuelCharacteristicsInfoEditingEmployee := RequestingEmployee;

  except

    on e: Exception do begin

      FreeAndNil(Card);

      raise;
      
    end;

  end;

end;

procedure TStandardFuelCharacteristicsCalculationCardAccountingService.
  TakeNewFuelCharacteristicsCalculationCardAndAccessRights(
    RequestingEmployee: TEmployee;
    var Card: IFuelCharacteristicsCalculationCard;
    var CardAccessRights: TFuelCharacteristicsCalculationCardAccessRights
  );
begin

  FFuelCharacteristicsCalculationCardCreatingService
    .CreateFuelCharacteristicsCalculationCardForEmployee(
      RequestingEmployee,
      Card,
      CardAccessRights
    );

end;

end.
