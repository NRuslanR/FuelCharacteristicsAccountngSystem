unit StandardFuelCharacteristicsCalculationCardFuelInfoEditingRule;

interface

uses

  AbstractFuelCharacteristicsCalculationCardAccessingRule,
  FuelCharacteristicsCalculationCardFuelInfoEditingRule,
  EmployeeFuelCharacteristicsCalculationCardWorkingRule,
  Employee,
  unIFuelCharacteristicsCalculationCard,
  WorkingTimeConditionsDirectory,
  unIWorkingTimeConditions,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsCalculationCardFuelInfoEditingRule =
    class (
      TAbstractFuelCharacteristicsCalculationCardAccessingRule,
      IFuelCharacteristicsCalculationCardFuelInfoEditingRule
    )

      public

        procedure EnsureSatisfiedBy(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ); override;

      public

        procedure EnsureEmployeeMayEditFuelCharacteristicsCalculationCardFuelInfo(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ); virtual;

        function MayEmployeeEditFuelCharacteristicsCalculationCardFuelInfo(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ): Boolean; virtual;
        
    end;

implementation

{ TStandardFuelCharacteristicsCalculationCardFuelInfoEditingRule }

procedure TStandardFuelCharacteristicsCalculationCardFuelInfoEditingRule.
  EnsureEmployeeMayEditFuelCharacteristicsCalculationCardFuelInfo(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  );
begin

  EnsureSatisfiedBy(Employee, FuelCharacteristicsCalculationCard);

end;

procedure TStandardFuelCharacteristicsCalculationCardFuelInfoEditingRule.
  EnsureSatisfiedBy(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  );
var WorkingTimeConditions: IWorkingTimeConditions;
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
      '” сотрудника "%s" отсутствуют права на ' +
      'редактирование в карточке ' +
      'информации о топливе',
      [
        Employee.FullName
      ]
    );
    
  end;

  EnsureFuelCharacteristicsCalculationCardMayBeAccessedInWorkingDayTimeByEmployee(
    FuelCharacteristicsCalculationCard, Employee
  );

end;

function TStandardFuelCharacteristicsCalculationCardFuelInfoEditingRule.
  MayEmployeeEditFuelCharacteristicsCalculationCardFuelInfo(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  ): Boolean;
begin

  Result := IsSatisfiedBy(Employee, FuelCharacteristicsCalculationCard);
  
end;

end.
