unit StandardFuelCharacteristicsCalculationCardFuelInfoViewingRule;

interface

uses

  EmployeeFuelCharacteristicsCalculationCardWorkingRule,
  FuelCharacteristicsCalculationCardFuelInfoViewingRule,
  AbstractFuelCharacteristicsCalculationCardAccessingRule,
  Employee,
  unIFuelCharacteristicsCalculationCard,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsCalculationCardFuelInfoViewingRule =
    class (
      TAbstractFuelCharacteristicsCalculationCardAccessingRule,
      IFuelCharacteristicsCalculationCardFuelInfoViewingRule
    )

      public

        procedure EnsureSatisfiedBy(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ); override;

      public

        procedure EnsureEmployeeMayViewFuelCharacteristicsCalculationCardFuelInfo(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ); virtual;

        function MayEmployeeViewFuelCharacteristicsCalculationCardFuelInfo(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ): Boolean; virtual;
      
    end;
  
implementation

{ TStandardFuelCharacteristicsCalculationCardFuelInfoViewingRule }

procedure TStandardFuelCharacteristicsCalculationCardFuelInfoViewingRule.
  EnsureEmployeeMayViewFuelCharacteristicsCalculationCardFuelInfo(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  );
begin

  EnsureSatisfiedBy(Employee, FuelCharacteristicsCalculationCard);
  
end;

procedure TStandardFuelCharacteristicsCalculationCardFuelInfoViewingRule.
  EnsureSatisfiedBy(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  );
begin

  if Employee.IsWarehouseHead or Employee.IsAccountant then
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
      '” сотрудника "%s" отсутствуют права ' +
      'на просмотр в карточке информации о топливе',
      [
        Employee.FullName
      ]
    );

  end;

end;

function TStandardFuelCharacteristicsCalculationCardFuelInfoViewingRule.
  MayEmployeeViewFuelCharacteristicsCalculationCardFuelInfo(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  ): Boolean;
begin

  Result := IsSatisfiedBy(Employee, FuelCharacteristicsCalculationCard);
  
end;

end.
