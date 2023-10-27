unit StandardFuelCharacteristicsCalculationCardCreatingService;

interface

uses

  FuelCharacteristicsCalculationCardCreatingService,
  FuelCharacteristicsCalculationCardAccessService,
  FuelCharacteristicsCalculationCardAccessRights,
  Employee,
  AbstractDomainService,
  FuelCharacteristicsCalculationCard,
  unIFuelCharacteristicsCalculationCard,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsCalculationCardCreatingService =
    class (
      TAbstractStandardDomainService,
      IFuelCharacteristicsCalculationCardCreatingService
    )

      protected

        FCardAccessService: IFuelCharacteristicsCalculationCardAccessService;
        
      public

        constructor Create(
          CardAccessService: IFuelCharacteristicsCalculationCardAccessService
        );

        procedure CreateFuelCharacteristicsCalculationCardForEmployee(
          Employee: TEmployee;
          var Card: IFuelCharacteristicsCalculationCard;
          var CardAccessRights: TFuelCharacteristicsCalculationCardAccessRights
        ); virtual;
        
    end;
  
implementation

uses

  IDomainObjectBaseUnit,
  StandardEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry;

{ TStandardFuelCharacteristicsCalculationCardCreatingService }

constructor TStandardFuelCharacteristicsCalculationCardCreatingService.Create(
  CardAccessService: IFuelCharacteristicsCalculationCardAccessService);
begin

  inherited Create;

  FCardAccessService := CardAccessService;
  
end;

procedure TStandardFuelCharacteristicsCalculationCardCreatingService.
  CreateFuelCharacteristicsCalculationCardForEmployee(
    Employee: TEmployee;
    var Card: IFuelCharacteristicsCalculationCard;
    var CardAccessRights: TFuelCharacteristicsCalculationCardAccessRights
  );
var ConcreteCard: TFuelCharacteristicsCalculationCard;
begin

  ConcreteCard :=
    TNewFuelCharacteristicsCalculationCard.CreateFor(

      TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry
        .Current
        .GetEmployeeFuelCharacteristicsCalculationCardWorkingRules,

      Employee
    );

  Card := ConcreteCard;
  
  try

    CardAccessRights :=
      FCardAccessService
        .EnsureAndGetFuelCharacteristicsCalculationCardAccessRightsForEmployee(
          ConcreteCard, Employee
        );

    if CardAccessRights.CalculationContextInfoCanBeEdited then
      ConcreteCard.CalculationContextInfoEditingEmployee := Employee;

    if CardAccessRights.FuelInfoCanBeEdited then
      ConcreteCard.FuelCharacteristicsInfoEditingEmployee := Employee;

    if not CardAccessRights.FuelInfoCanBeEdited then begin

      ConcreteCard
        .WorkingRules
          .FuelInfoEditingRule
            .EnsureEmployeeMayEditFuelCharacteristicsCalculationCardFuelInfo(
              Employee, Card
            );
            
    end;

  except

    on e: Exception do begin

      if e is TFuelCharacteristicsCalculationCardAccessServiceException
      then begin

        raise
        TFuelCharacteristicsCalculationCardCreatingServiceException.CreateFmt(
          '” сотрудника "%s" отсутствуют права ' +
          'на создание новой карточки расчЄта ' +
          'показателей топлива',
          [
            Employee.FullName
          ]
        );
        
      end;

      raise;
      
    end;

  end;

end;

end.
