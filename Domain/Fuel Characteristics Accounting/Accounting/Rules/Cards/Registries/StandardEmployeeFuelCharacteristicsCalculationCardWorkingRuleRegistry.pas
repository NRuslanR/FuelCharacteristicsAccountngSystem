unit StandardEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry;

interface

uses

  EmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry,
  EmployeeFuelCharacteristicsCalculationCardWorkingRules,
  SysUtils,
  Classes;

type

  TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry =
    class (
      TInterfacedObject,
      IEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry
    )

      private

        FIsStandardEmployeeFuelCharacteristicsCalculationCardWorkingRulesRegistered: Boolean;
        
        FEmployeeFuelCharacteristicsCalculationCardWorkingRules:
          TEmployeeFuelCharacteristicsCalculationCardWorkingRules;
          
        class var FInstance:
          IEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry;

        class function GetInstance:
          IEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry; static;

      public

        procedure RegisterEmployeeFuelCharacteristicsCalculationCardWorkingRules(
          EmployeeFuelCharacteristicsCalculationCardWorkingRules:
            TEmployeeFuelCharacteristicsCalculationCardWorkingRules
        ); virtual;

        procedure RegisterStandardEmployeeFuelCharacteristicsCalculationCardWorkingRules; virtual;

        function GetEmployeeFuelCharacteristicsCalculationCardWorkingRules:
          TEmployeeFuelCharacteristicsCalculationCardWorkingRules; virtual;

      public

        class property Current:
          IEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry
        read GetInstance write FInstance;

    end;
  
implementation

uses

  WorkingTimeConditionsDirectory,
  FuelCharacteristicsCalculationCardOwningRule,
  StandardFuelCharacteristicsCalculationCardRemovingRule,
  StandardFuelCharacteristicsCalculationCardOwningRule,
  StandardFuelCharacteristicsCalculationCardFuelInfoEditingRule,
  StandardFuelCharacteristicsCalculationCardFuelInfoViewingRule,
  StandardFuelCharacteristicsCalculationCardContextInfoEditingRule,
  StandardFuelCharacteristicsCalculationCardContextInfoViewingRule,
  StandardWorkingTimeConditionsStorageServiceRegistry;

{ TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry }

function TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry.
  GetEmployeeFuelCharacteristicsCalculationCardWorkingRules:
    TEmployeeFuelCharacteristicsCalculationCardWorkingRules;
begin

  Result := FEmployeeFuelCharacteristicsCalculationCardWorkingRules;
  
end;

class function TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry.
  GetInstance: IEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry;
begin

  if not Assigned(FInstance) then begin

    FInstance :=
      TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry.Create;

  end;
  
  Result := FInstance;

end;

procedure TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry.
  RegisterEmployeeFuelCharacteristicsCalculationCardWorkingRules(
    EmployeeFuelCharacteristicsCalculationCardWorkingRules:
      TEmployeeFuelCharacteristicsCalculationCardWorkingRules
  );
begin

  if FIsStandardEmployeeFuelCharacteristicsCalculationCardWorkingRulesRegistered
  then begin

    FreeAndNil(FEmployeeFuelCharacteristicsCalculationCardWorkingRules);
    
  end;

  FEmployeeFuelCharacteristicsCalculationCardWorkingRules :=
    EmployeeFuelCharacteristicsCalculationCardWorkingRules;
    
end;

procedure TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry.
  RegisterStandardEmployeeFuelCharacteristicsCalculationCardWorkingRules;
var StandardWorkingRules: TEmployeeFuelCharacteristicsCalculationCardWorkingRules;
    CardOwningRule: IFuelCharacteristicsCalculationCardOwningRule;
    WorkingTimeConditionsDirectory: IWorkingTimeConditionsDirectory;
begin

  WorkingTimeConditionsDirectory :=
    TWorkingTimeConditionsStorageServiceRegistry
      .Current
        .GetWorkingTimeConditionsDirectory;

  CardOwningRule :=
    TStandardEmployeeFuelCharacteristicsCalculationCardOwningRule.Create(
      WorkingTimeConditionsDirectory
    );

  StandardWorkingRules :=
    TEmployeeFuelCharacteristicsCalculationCardWorkingRules.Create;

  try

    with StandardWorkingRules do begin

      RemovingRule :=
        TStandardFuelCharacteristicsCalculationCardRemovingRule.Create(
          WorkingTimeConditionsDirectory,
          CardOwningRule
        );

      FuelInfoEditingRule :=
        TStandardFuelCharacteristicsCalculationCardFuelInfoEditingRule.Create(
          WorkingTimeConditionsDirectory,
          CardOwningRule
        );

      FuelInfoViewingRule :=
        TStandardFuelCharacteristicsCalculationCardFuelInfoViewingRule.Create(
          WorkingTimeConditionsDirectory,
          CardOwningRule
        );

      ContextInfoEditingRule :=
        TStandardFuelCharacteristicsCalculationCardContextInfoEditingRule.
          Create(
            WorkingTimeConditionsDirectory,
            CardOwningRule
          );

      ContextInfoViewingRule :=
        TStandardFuelCharacteristicsCalculationCardContextInfoViewingRule.
          Create(
            WorkingTimeConditionsDirectory,
            CardOwningRule
          );

    end;

    FEmployeeFuelCharacteristicsCalculationCardWorkingRules :=
      StandardWorkingRules;
      
    FIsStandardEmployeeFuelCharacteristicsCalculationCardWorkingRulesRegistered
      := True;

  except

    on e: Exception do begin

      FreeAndNil(StandardWorkingRules);

      raise;
      
    end;

  end;

end;

end.
