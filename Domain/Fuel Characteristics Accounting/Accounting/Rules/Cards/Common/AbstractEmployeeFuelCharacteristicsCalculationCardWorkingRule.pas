unit AbstractEmployeeFuelCharacteristicsCalculationCardWorkingRule;

interface

uses

  EmployeeFuelCharacteristicsCalculationCardWorkingRule,
  Employee,
  unIFuelCharacteristicsCalculationCard,
  unIWorkingTimeConditions,
  WorkingTimeConditionsDirectory,
  SysUtils,
  Classes;


type

  TAbstractEmployeeFuelCharacteristicsCalculationCardWorkingRule =
    class abstract (
      TInterfacedObject,
      IEmployeeFuelCharacteristicsCalculationCardWorkingRule
    )

      protected

        FWorkingTimeConditionsDirectory: IWorkingTimeConditionsDirectory;

        procedure EnsureFuelCharacteristicsCalculationCardMayBeAccessedInWorkingDayTimeByEmployee(
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard;
          Employee: TEmployee
        ); virtual;
        
      public

        constructor Create(
          WorkingTimeConditionsDirectory: IWorkingTimeConditionsDirectory
        );

        function IsSatisfiedBy(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ): Boolean; virtual;

        procedure EnsureSatisfiedBy(
          Employee: TEmployee;
          FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
        ); virtual; abstract;

    end;

implementation

uses

  DateUtils,
  AuxVariantFunctions;

{ TAbstractEmployeeFuelCharacteristicsCalculationCardWorkingRule }

constructor TAbstractEmployeeFuelCharacteristicsCalculationCardWorkingRule.Create(
  WorkingTimeConditionsDirectory: IWorkingTimeConditionsDirectory
);
begin

  inherited Create;

  FWorkingTimeConditionsDirectory := WorkingTimeConditionsDirectory;
  
end;

procedure TAbstractEmployeeFuelCharacteristicsCalculationCardWorkingRule.
  EnsureFuelCharacteristicsCalculationCardMayBeAccessedInWorkingDayTimeByEmployee(
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard;
    Employee: TEmployee
  );
var WorkingTimeConditions: IWorkingTimeConditions;
begin

  WorkingTimeConditions :=
    FWorkingTimeConditionsDirectory.FindActiveWorkingTimeConditions;

  if not Assigned(WorkingTimeConditions) then begin

    raise
    TEmployeeFuelCharacteristicsCalculationCardWorkingRuleException.Create(
      'Не найдена информация об активном ' +
      'режиме рабочего времени для проверки ' +
      'возможности работы сотрудником с ' +
      'карточкой параметров топлива'
    );

  end;

  if
    (VarIsNullOrEmpty(FuelCharacteristicsCalculationCard.Identity) and
     not WorkingTimeConditions.IsCurrenTimeLessOrEqualWorkingDayTime)

    or (
      not VarIsNullOrEmpty(FuelCharacteristicsCalculationCard.Identity) and
      not WorkingTimeConditions.IsTimeLessOrEqualWorkingDayTime(
        DateOf(FuelCharacteristicsCalculationCard.CalculationPerformingDateTime)
        +
        TimeOf(Now)
      )
    )
  then begin

    raise
    TEmployeeFuelCharacteristicsCalculationCardWorkingRuleException.Create(
      'Извините, но время работы с карточкой параметров ' +
      'топлива истекло'
    );

  end;

end;

function TAbstractEmployeeFuelCharacteristicsCalculationCardWorkingRule.
  IsSatisfiedBy(
    Employee: TEmployee;
    FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
  ): Boolean;
begin

  try

    EnsureSatisfiedBy(Employee, FuelCharacteristicsCalculationCard);

    Result := True;
    
  except

    on e: TEmployeeFuelCharacteristicsCalculationCardWorkingRuleException
    do Result := False;

  end;

end;

end.
