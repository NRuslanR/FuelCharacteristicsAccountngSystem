unit StandardFuelCharacteristicsCalculationCardOwningRule;

interface

uses

  EmployeeFuelCharacteristicsCalculationCardWorkingRule,
  FuelCharacteristicsCalculationCardOwningRule,
  AbstractEmployeeFuelCharacteristicsCalculationCardWorkingRule,
  Employee,
  unIFuelCharacteristicsCalculationCard,
  SysUtils,
  Classes;

type

  TStandardEmployeeFuelCharacteristicsCalculationCardOwningRule =
    class (
      TAbstractEmployeeFuelCharacteristicsCalculationCardWorkingRule,
      IFuelCharacteristicsCalculationCardOwningRule
    )

      public

        procedure EnsureSatisfiedBy(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ); override;

      public

        procedure EnsureEmployeeIsFuelCharacteristicsCalculationCardOwner(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ); virtual;

        function IsEmployeeFuelCharacteristicsCalculationCardOwner(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ): Boolean; virtual;

    end;

implementation

{ TStandardEmployeeFuelCharacteristicsCalculationCardOwningRule }

procedure TStandardEmployeeFuelCharacteristicsCalculationCardOwningRule.
  EnsureEmployeeIsFuelCharacteristicsCalculationCardOwner(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  );
begin

  EnsureSatisfiedBy(Employee, FuelCharacteristicsCalculationCard);
  
end;

procedure TStandardEmployeeFuelCharacteristicsCalculationCardOwningRule.
  EnsureSatisfiedBy(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  );
var EmployeePerformedCalculation: Boolean;
    EmployeeHasValidRole: Boolean;
begin

  EmployeePerformedCalculation :=
    Employee.Identity =
    FuelCharacteristicsCalculationCard.PerformedCalculationEmployeeId;

  EmployeeHasValidRole :=
    Employee.IsAircraftTechnician or Employee.IsWarehouseHead;
    
  if not (EmployeePerformedCalculation and EmployeeHasValidRole)
  then begin

    raise
    TEmployeeFuelCharacteristicsCalculationCardWorkingRuleException.CreateFmt(
      'Сотрудник "%s" не является ' +
      'владельцем карточки',
      [
        Employee.FullName
      ]
    );
    
  end;
  
end;

function TStandardEmployeeFuelCharacteristicsCalculationCardOwningRule.
  IsEmployeeFuelCharacteristicsCalculationCardOwner(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  ): Boolean;
begin

  Result := IsSatisfiedBy(Employee, FuelCharacteristicsCalculationCard);
  
end;

end.
