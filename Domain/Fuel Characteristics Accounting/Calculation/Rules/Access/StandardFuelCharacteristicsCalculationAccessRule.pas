unit StandardFuelCharacteristicsCalculationAccessRule;

interface

uses

  FuelCharacteristicsCalculationAccessRule,
  Employee,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsCalculationAccessRule =
    class (TInterfacedObject, IFuelCharacteristicsCalculationAccessRule)

      public

        procedure EnsureEmployeeHasFuelCharacteristicsCalculationAccess(
          Employee: TEmployee
        ); virtual;

        function HasEmployeeFuelCharacteristicsCalculationAccess(
          Employee: TEmployee
        ): Boolean; virtual;

    end;
  
implementation

{ TStandardFuelCharacteristicsCalculationAccessRule }

procedure TStandardFuelCharacteristicsCalculationAccessRule.
  EnsureEmployeeHasFuelCharacteristicsCalculationAccess(
    Employee: TEmployee
  );
begin

  if not (Employee.IsAircraftTechnician or Employee.IsWarehouseHead)
  then begin

    raise TFuelCharacteristicsCalculationAccessRuleException.CreateFmt(
      '” сотрудника "%s" отсутствуют права ' +
      'на выполнение расчЄта показателей топлива',
      [
        Employee.FullName
      ]
    );
    
  end;
  
end;

function TStandardFuelCharacteristicsCalculationAccessRule.
  HasEmployeeFuelCharacteristicsCalculationAccess(
    Employee: TEmployee
  ): Boolean;
begin

  try

    EnsureEmployeeHasFuelCharacteristicsCalculationAccess(Employee);

    Result := True;
    
  except

    on e: TFuelCharacteristicsCalculationAccessRuleException
    do Result := False;

  end;
  
end;

end.
