unit StandardEmployeeReservoirKindWorkingRuleRegistry;

interface

uses

  EmployeeReservoirKindWorkingRuleRegistry,
  EmployeeReservoirKindWorkingRules,
  SysUtils,
  Classes;

type

  TEmployeeReservoirKindWorkingRuleRegistry =
    class (TInterfacedObject, IEmployeeReservoirKindWorkingRuleRegistry)

      private

        FAreWorkingRulesStandard: Boolean;

        FWorkingRules: TEmployeeReservoirKindWorkingRules;
        
        class var FInstance: IEmployeeReservoirKindWorkingRuleRegistry;

        class function GetInstance:
          IEmployeeReservoirKindWorkingRuleRegistry; static;
        
      public

        procedure RegisterEmployeeReservoirKindWorkingRules(
          EmployeeReservoirKindWorkingRules: TEmployeeReservoirKindWorkingRules
        );

        function GetEmployeeReservoirKindWorkingRules:
          TEmployeeReservoirKindWorkingRules;

        procedure RegisterStandardEmployeeReservoirKindWorkingRules;

      public
      
        class property Current: IEmployeeReservoirKindWorkingRuleRegistry
        read GetInstance write FInstance;
        
    end;
    
implementation

uses

  StandardReservoirKindViewingRule,
  StandardReservoirKindEditingRule,
  StandardReservoirKindRemovingRule;
  
{ TEmployeeReservoirKindWorkingRuleRegistry }

function TEmployeeReservoirKindWorkingRuleRegistry.
  GetEmployeeReservoirKindWorkingRules: TEmployeeReservoirKindWorkingRules;
begin

  Result := FWorkingRules;
  
end;

class function TEmployeeReservoirKindWorkingRuleRegistry.
  GetInstance: IEmployeeReservoirKindWorkingRuleRegistry;
begin

  if not Assigned(FInstance) then
    FInstance := TEmployeeReservoirKindWorkingRuleRegistry.Create;
    
  Result := FInstance;

end;

procedure TEmployeeReservoirKindWorkingRuleRegistry.
  RegisterEmployeeReservoirKindWorkingRules(
    EmployeeReservoirKindWorkingRules: TEmployeeReservoirKindWorkingRules
  );
begin

  if FAreWorkingRulesStandard then
    FreeAndNil(FWorkingRules);

  FWorkingRules := EmployeeReservoirKindWorkingRules;

end;

procedure TEmployeeReservoirKindWorkingRuleRegistry.
  RegisterStandardEmployeeReservoirKindWorkingRules;
var StandardWorkingRules: TEmployeeReservoirKindWorkingRules;
begin

  StandardWorkingRules := TEmployeeReservoirKindWorkingRules.Create;
  
  try

    StandardWorkingRules.ReservoirKindViewingRule :=
      TStandardReservoirKindViewingRule.Create;

    StandardWorkingRules.ReservoirKindEditingRule :=
      TStandardReservoirKindEditingRule.Create;

    StandardWorkingRules.ReservoirKindRemovingRule :=
      TStandardReservoirKindRemovingRule.Create;

  except

    on e: Exception do begin

      FreeAndNil(StandardWorkingRules);

      raise;
      
    end;

  end;

  FWorkingRules := StandardWorkingRules;

  FAreWorkingRulesStandard := True;

end;

end.
