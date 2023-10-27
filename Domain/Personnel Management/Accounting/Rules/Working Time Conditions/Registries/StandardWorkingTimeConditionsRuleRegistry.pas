unit StandardWorkingTimeConditionsRuleRegistry;

interface

uses

  WorkingTimeConditionsRuleRegistry,
  WorkingTimeConditionsRules,
  SysUtils,
  Classes;

type

  TWorkingTimeConditionsRuleRegistry =
    class (TInterfacedObject, IWorkingTimeConditionsRuleRegistry)

      private

        class var FInstance: IWorkingTimeConditionsRuleRegistry;

        class function GetInstance: IWorkingTimeConditionsRuleRegistry; static;
        
      private

        function IsStandardWorkingTimeConditionsRulesRegistered: Boolean;
        
      private

        FWorkingTimeConditionsRules: TWorkingTimeConditionsRules;
        
      public

        procedure RegisterWorkingTimeConditionsRules(
          WorkingTimeConditionsRules: TWorkingTimeConditionsRules
        );

        function GetWorkingTimeConditionsRules:
          TWorkingTimeConditionsRules;

        procedure RegisterStandardWorkingTimeConditionsRules;

      public

        class property Current: IWorkingTimeConditionsRuleRegistry
        read GetInstance write FInstance;
        
    end;
    
implementation

uses

  StandardWorkingTimeConditionsAccessingRule;

{ TWorkingTimeConditionsRuleRegistry }

class function TWorkingTimeConditionsRuleRegistry.
  GetInstance: IWorkingTimeConditionsRuleRegistry;
begin

  if not Assigned(FInstance) then
    FInstance := TWorkingTimeConditionsRuleRegistry.Create;
    
  Result := FInstance;

end;

function TWorkingTimeConditionsRuleRegistry.
  GetWorkingTimeConditionsRules: TWorkingTimeConditionsRules;
begin

  Result := FWorkingTimeConditionsRules;
  
end;

function TWorkingTimeConditionsRuleRegistry.
  IsStandardWorkingTimeConditionsRulesRegistered: Boolean;
begin

  Result :=

    Assigned(FWorkingTimeConditionsRules) and
    (FWorkingTimeConditionsRules
      .AccessingRule
        .Self
          .ClassType = TStandardWorkingTimeConditionsAccessingRule);

end;

procedure TWorkingTimeConditionsRuleRegistry.
  RegisterStandardWorkingTimeConditionsRules;
begin

  if IsStandardWorkingTimeConditionsRulesRegistered then
    Exit;

  FWorkingTimeConditionsRules := TWorkingTimeConditionsRules.Create;

  try

    FWorkingTimeConditionsRules.AccessingRule :=
      TStandardWorkingTimeConditionsAccessingRule.Create;
      
  except

    on E: Exception do begin

      FreeAndNil(FWorkingTimeConditionsRules);

      raise;
      
    end;

  end;

end;

procedure TWorkingTimeConditionsRuleRegistry.
  RegisterWorkingTimeConditionsRules(
    WorkingTimeConditionsRules: TWorkingTimeConditionsRules
  );
begin

  if IsStandardWorkingTimeConditionsRulesRegistered then
    FreeAndNil(FWorkingTimeConditionsRules);

  FWorkingTimeConditionsRules := WorkingTimeConditionsRules;
  
end;

end.
