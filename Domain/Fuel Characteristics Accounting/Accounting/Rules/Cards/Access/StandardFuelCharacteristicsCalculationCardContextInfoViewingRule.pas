unit StandardFuelCharacteristicsCalculationCardContextInfoViewingRule;

interface

uses

  EmployeeFuelCharacteristicsCalculationCardWorkingRule,
  FuelCharacteristicsCalculationCardContextInfoViewingRule,
  AbstractFuelCharacteristicsCalculationCardAccessingRule,
  Employee,
  unIFuelCharacteristicsCalculationCard,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsCalculationCardContextInfoViewingRule =
    class (
      TAbstractFuelCharacteristicsCalculationCardAccessingRule,
      IFuelCharacteristicsCalculationCardContextInfoViewingRule
    )

      public

        procedure EnsureSatisfiedBy(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ); override;

      public

        procedure EnsureEmployeeMayViewFuelCharacteristicsCalculationCardContextInfo(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ); virtual;

        function MayEmployeeViewFuelCharacteristicsCalculationCardContextInfo(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ): Boolean; virtual;
      
    end;

implementation

{ TStandardFuelCharacteristicsCalculationCardContextInfoViewingRule }

procedure TStandardFuelCharacteristicsCalculationCardContextInfoViewingRule.
  EnsureEmployeeMayViewFuelCharacteristicsCalculationCardContextInfo(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  );
begin

  EnsureSatisfiedBy(Employee, FuelCharacteristicsCalculationCard);
  
end;

procedure TStandardFuelCharacteristicsCalculationCardContextInfoViewingRule.
  EnsureSatisfiedBy(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  );
begin

  if Employee.IsAccountant or Employee.IsWarehouseHead then
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
      'на просмотр ' +
      'служебной информации карточки',
      [
        Employee.FullName
      ]
    );
    
  end;

end;

function TStandardFuelCharacteristicsCalculationCardContextInfoViewingRule.
  MayEmployeeViewFuelCharacteristicsCalculationCardContextInfo(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  ): Boolean;
begin

  Result := IsSatisfiedBy(Employee, FuelCharacteristicsCalculationCard);
  
end;

end.
