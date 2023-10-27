unit StandardEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry;

interface

uses

  EmployeeReservoirKindReferenceSuiteWorkingRules,
  EmployeeReservoirKindReferenceSuiteWorkingRuleRegistry,
  SysUtils,
  Classes;

type

  TEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry =
    class (
      TInterfacedObject,
      IEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry
    )

      private

        FAreWorkingRulesStandard: Boolean;
        
        FWorkingRules: TEmployeeReservoirKindReferenceSuiteWorkingRules;
        
      private

        class var FInstance: IEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry;

        class function GetCurrent:
          IEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry; static;

        class procedure SetCurrent(
          const Value: IEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry
        ); static;
        
      public

        procedure RegisterEmployeeReservoirKindReferenceSuiteWorkingRules(
          EmployeeReservoirKindReferenceSuiteWorkingRules:
            TEmployeeReservoirKindReferenceSuiteWorkingRules
        ); virtual;

        function GetEmployeeReservoirKindReferenceSuiteWorkingRules:
          TEmployeeReservoirKindReferenceSuiteWorkingRules; virtual;

        procedure RegisterStandardEmployeeReservoirKindReferenceSuiteWorkingRules; virtual;

      public

        destructor Destroy; override;
        
        class property Current: IEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry
        read GetCurrent write SetCurrent;
        
    end;
    
implementation

uses

  StandardReservoirKindReferenceSuiteViewingRule,
  StandardReservoirKindReferenceSuiteEditingRule,
  StandardReservoirKindReferenceSuiteRemovingRule;

{ TEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry }

destructor TEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry.Destroy;
begin

  inherited;

end;

class function TEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry.
  GetCurrent: IEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry;
begin

  if not Assigned(FInstance) then
    FInstance := TEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry.Create;

  Result := FInstance;
  
end;

function TEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry.
  GetEmployeeReservoirKindReferenceSuiteWorkingRules:
    TEmployeeReservoirKindReferenceSuiteWorkingRules;
begin

  Result := FWorkingRules;
  
end;

procedure TEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry.
  RegisterEmployeeReservoirKindReferenceSuiteWorkingRules(
    EmployeeReservoirKindReferenceSuiteWorkingRules:
      TEmployeeReservoirKindReferenceSuiteWorkingRules
  );
begin

  if FAreWorkingRulesStandard then
    FreeAndNil(FWorkingRules);
    
  FWorkingRules := EmployeeReservoirKindReferenceSuiteWorkingRules;
  
end;

procedure TEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry.
  RegisterStandardEmployeeReservoirKindReferenceSuiteWorkingRules;
var StandardWorkingRules: TEmployeeReservoirKindReferenceSuiteWorkingRules;
begin

  StandardWorkingRules := TEmployeeReservoirKindReferenceSuiteWorkingRules.Create;

  try

    StandardWorkingRules.ReservoirKindReferenceSuiteViewingRule :=
      TStandardReservoirKindReferenceSuiteViewingRule.Create;

    StandardWorkingRules.ReservoirKindReferenceSuiteEditingRule :=
      TStandardReservoirKindReferenceSuiteEditingRule.Create;

    StandardWorkingRules.ReservoirKindReferenceSuiteRemovingRule :=
      TStandardReservoirKindReferenceSuiteRemovingRule.Create;
    
  except

    on e: Exception do begin

      FreeAndNil(StandardWorkingRules);

      raise;

    end;

  end;

  FWorkingRules := StandardWorkingRules;
    
  FAreWorkingRulesStandard := True;

end;

class procedure TEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry.
  SetCurrent(
    const Value: IEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry
  );
begin

  FInstance := Value;

end;

end.
