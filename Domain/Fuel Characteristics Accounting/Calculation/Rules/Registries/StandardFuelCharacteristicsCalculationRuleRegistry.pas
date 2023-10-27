unit StandardFuelCharacteristicsCalculationRuleRegistry;

interface

uses

  FuelCharacteristicsCalculationAccessRule,
  FuelCharacteristicsCalculationRuleRegistry,
  StandardFuelCharacteristicsCalculationAccessRule,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsCalculationRuleRegistry =
    class (TInterfacedObject, IFuelCharacteristicsCalculationRuleRegistry)

      private

        FFuelCharacteristicsCalculationAccessRule:
          IFuelCharacteristicsCalculationAccessRule;
        
      private

        class var FInstance: IFuelCharacteristicsCalculationRuleRegistry;

        class function GetInstance:
          IFuelCharacteristicsCalculationRuleRegistry; static;
        
      public

        procedure RegisterFuelCharacteristicsCalculationAccessRule(
          FuelCharacteristicsCalculationAccessRule:
            IFuelCharacteristicsCalculationAccessRule
        ); virtual;

        function GetFuelCharacteristicsCalculationAccessRule:
          IFuelCharacteristicsCalculationAccessRule; virtual;

        procedure RegisterStandardFuelCharacteristicsCalculationAccessRule; virtual;

      public

        class property Current: IFuelCharacteristicsCalculationRuleRegistry
        read GetInstance write FInstance;
        
    end;
    
implementation

{ TFuelCharacteristicsCalculationRuleRegistry }

function TFuelCharacteristicsCalculationRuleRegistry.
  GetFuelCharacteristicsCalculationAccessRule:
    IFuelCharacteristicsCalculationAccessRule;
begin

  Result := FFuelCharacteristicsCalculationAccessRule;
  
end;

class function TFuelCharacteristicsCalculationRuleRegistry.
  GetInstance: IFuelCharacteristicsCalculationRuleRegistry;
begin

  if not Assigned(FInstance) then
    FInstance := TFuelCharacteristicsCalculationRuleRegistry.Create;

  Result := FInstance;
  
end;

procedure TFuelCharacteristicsCalculationRuleRegistry.
  RegisterFuelCharacteristicsCalculationAccessRule(
    FuelCharacteristicsCalculationAccessRule:
      IFuelCharacteristicsCalculationAccessRule
    );
begin

  FFuelCharacteristicsCalculationAccessRule :=
    FuelCharacteristicsCalculationAccessRule;
  

end;

procedure TFuelCharacteristicsCalculationRuleRegistry.
  RegisterStandardFuelCharacteristicsCalculationAccessRule;
begin

  FFuelCharacteristicsCalculationAccessRule :=
    TStandardFuelCharacteristicsCalculationAccessRule.Create;
    
end;

end.
