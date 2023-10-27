unit StandardFuelCharacteristicsCalculationCardRemovingRule;

interface

uses

  EmployeeFuelCharacteristicsCalculationCardWorkingRule,
  FuelCharacteristicsCalculationCardRemovingRule,
  AbstractFuelCharacteristicsCalculationCardAccessingRule,
  Employee,
  unIFuelCharacteristicsCalculationCard,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsCalculationCardRemovingRule =
    class (
      TAbstractFuelCharacteristicsCalculationCardAccessingRule,
      IFuelCharacteristicsCalculationCardRemovingRule
    )

      public

        procedure EnsureSatisfiedBy(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ); override;

      public

        procedure EnsureEmployeeMayRemoveFuelCharacteristicsCalculationCard(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ); virtual;

        function MayEmployeeRemoveFuelCharacteristicsCalculationCard(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ): Boolean; virtual;
        
    end;
  
implementation

{ TStandardFuelCharacteristicsCalculationCardRemovingRule }

procedure TStandardFuelCharacteristicsCalculationCardRemovingRule.
  EnsureEmployeeMayRemoveFuelCharacteristicsCalculationCard(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  );
begin

  EnsureSatisfiedBy(Employee, FuelCharacteristicsCalculationCard);
  
end;

procedure TStandardFuelCharacteristicsCalculationCardRemovingRule.
  EnsureSatisfiedBy(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  );
begin

  if Employee.IsWarehouseHead then
    Exit;

  if
    not
    FFuelCharacteristicsCalculationCardOwningRule.
      IsEmployeeFuelCharacteristicsCalculationCardOwner(
        Employee, FuelCharacteristicsCalculationCard
      )
  then begin

    raise
    TEmployeeFuelCharacteristicsCalculationCardWorkingRuleException.CreateFmt(
      'У сотрудника "%s" отсутствуют права ' +
      'на удаление карточки',
      [
        Employee.FullName
      ]
    );
    
  end;

  EnsureFuelCharacteristicsCalculationCardMayBeAccessedInWorkingDayTimeByEmployee(
    FuelCharacteristicsCalculationCard, Employee
  );

end;

function TStandardFuelCharacteristicsCalculationCardRemovingRule.
  MayEmployeeRemoveFuelCharacteristicsCalculationCard(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  ): Boolean;
begin

  Result := IsSatisfiedBy(Employee, FuelCharacteristicsCalculationCard);
  
end;

end.
