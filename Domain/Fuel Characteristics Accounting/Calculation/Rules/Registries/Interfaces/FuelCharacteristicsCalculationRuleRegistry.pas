unit FuelCharacteristicsCalculationRuleRegistry;

interface

uses

  FuelCharacteristicsCalculationAccessRule;

type

  IFuelCharacteristicsCalculationRuleRegistry = interface

    procedure RegisterFuelCharacteristicsCalculationAccessRule(
      FuelCharacteristicsCalculationAccessRule:
        IFuelCharacteristicsCalculationAccessRule
    );

    function GetFuelCharacteristicsCalculationAccessRule:
      IFuelCharacteristicsCalculationAccessRule;

    procedure RegisterStandardFuelCharacteristicsCalculationAccessRule;
    
  end;
  
implementation

end.
