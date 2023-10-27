unit StandardFuelCharacteristicsCalculationCardContextInfoEditingRule;

interface

uses

  AbstractFuelCharacteristicsCalculationCardAccessingRule,
  FuelCharacteristicsCalculationCardContextInfoEditingRule,
  EmployeeFuelCharacteristicsCalculationCardWorkingRule,
  Employee,
  unIFuelCharacteristicsCalculationCard,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsCalculationCardContextInfoEditingRule =
    class (
      TAbstractFuelCharacteristicsCalculationCardAccessingRule,
      IFuelCharacteristicsCalculationCardContextInfoEditingRule
    )

      public

        procedure EnsureSatisfiedBy(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ); override;

      public

        procedure EnsureEmployeeMayEditFuelCharacteristicsCalculationCardContextInfo(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ); virtual;

        function MayEmployeeEditFuelCharacteristicsCalculationCardContextInfo(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ): Boolean; virtual;

    end;

implementation

{ TStandardFuelCharacteristicsCalculationCardContextInfoEditingRule }

procedure TStandardFuelCharacteristicsCalculationCardContextInfoEditingRule.
  EnsureEmployeeMayEditFuelCharacteristicsCalculationCardContextInfo(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  );
begin

  EnsureSatisfiedBy(Employee, FuelCharacteristicsCalculationCard);
  
end;

procedure TStandardFuelCharacteristicsCalculationCardContextInfoEditingRule.
  EnsureSatisfiedBy(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  );
begin

  if not Employee.IsWarehouseHead then begin

    raise
    TEmployeeFuelCharacteristicsCalculationCardWorkingRuleException.CreateFmt(
      '” сотрудника "%s" отсутствуют права ' +
      'на редактирование служебной информации ' +
      'в карточке',
      [
        Employee.FullName
      ]
    );
    
  end;

end;

function TStandardFuelCharacteristicsCalculationCardContextInfoEditingRule.
  MayEmployeeEditFuelCharacteristicsCalculationCardContextInfo(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  ): Boolean;
begin

  Result := IsSatisfiedBy(Employee, FuelCharacteristicsCalculationCard);

end;

end.
