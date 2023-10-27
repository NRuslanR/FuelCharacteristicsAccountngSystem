unit AbstractFuelCharacteristicsCalculationCardAccessingRule;

interface

uses

  AbstractEmployeeFuelCharacteristicsCalculationCardWorkingRule,
  FuelCharacteristicsCalculationCardOwningRule,
  Employee,
  unIFuelCharacteristicsCalculationCard,
  WorkingTimeConditionsDirectory,
  SysUtils,
  Classes;

type

  TAbstractFuelCharacteristicsCalculationCardAccessingRule =
    class abstract (
      TAbstractEmployeeFuelCharacteristicsCalculationCardWorkingRule
    )

      protected

        FFuelCharacteristicsCalculationCardOwningRule:
          IFuelCharacteristicsCalculationCardOwningRule;

        procedure EnsureFuelCharacteristicsCalculationCardMayBeAccessedInWorkingDayTimeByEmployee(
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard;
          Employee: TEmployee
        ); override;
        
      public

        constructor Create(
          WorkingTimeConditionsDirectory: IWorkingTimeConditionsDirectory;
          
          FuelCharacteristicsCalculationCardOwningRule:
            IFuelCharacteristicsCalculationCardOwningRule
        );
        
    end;

implementation

{ TAbstractFuelCharacteristicsCalculationCardAccessingRule }

constructor TAbstractFuelCharacteristicsCalculationCardAccessingRule.
  Create(

    WorkingTimeConditionsDirectory: IWorkingTimeConditionsDirectory;
    
    FuelCharacteristicsCalculationCardOwningRule:
      IFuelCharacteristicsCalculationCardOwningRule
  );
begin

  inherited Create(WorkingTimeConditionsDirectory);

  FFuelCharacteristicsCalculationCardOwningRule :=
    FuelCharacteristicsCalculationCardOwningRule;

end;

procedure TAbstractFuelCharacteristicsCalculationCardAccessingRule.
  EnsureFuelCharacteristicsCalculationCardMayBeAccessedInWorkingDayTimeByEmployee(
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard;
    Employee: TEmployee
  );
begin

  if Employee.IsAircraftTechnician then
    inherited;

end;

end.
