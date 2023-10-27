unit EmployeeFuelCharacteristicsCalculationCardWorkingRules;

interface

uses

  FuelCharacteristicsCalculationCardRemovingRule,
  FuelCharacteristicsCalculationCardFuelInfoEditingRule,
  FuelCharacteristicsCalculationCardContextInfoEditingRule,
  FuelCharacteristicsCalculationCardFuelInfoViewingRule,
  FuelCharacteristicsCalculationCardContextInfoViewingRule;

type

  TEmployeeFuelCharacteristicsCalculationCardWorkingRules =
    class

      private

        FRemovingRule: IFuelCharacteristicsCalculationCardRemovingRule;
        FFuelInfoViewingRule: IFuelCharacteristicsCalculationCardFuelInfoViewingRule;
        FFuelInfoEditingRule: IFuelCharacteristicsCalculationCardFuelInfoEditingRule;
        FContextInfoViewingRule: IFuelCharacteristicsCalculationCardContextInfoViewingRule;
        FContextInfoEditingRule: IFuelCharacteristicsCalculationCardContextInfoEditingRule;

      public

        constructor Create; overload;
        constructor Create(
          RemovingRule: IFuelCharacteristicsCalculationCardRemovingRule;
          FuelInfoViewingRule: IFuelCharacteristicsCalculationCardFuelInfoViewingRule;
          FuelInfoEditingRule: IFuelCharacteristicsCalculationCardFuelInfoEditingRule;
          ContextInfoViewingRule: IFuelCharacteristicsCalculationCardContextInfoViewingRule;
          ContextInfoEditingRule: IFuelCharacteristicsCalculationCardContextInfoEditingRule
        ); overload;

        property RemovingRule: IFuelCharacteristicsCalculationCardRemovingRule
        read FRemovingRule write FRemovingRule;
        
        property FuelInfoViewingRule: IFuelCharacteristicsCalculationCardFuelInfoViewingRule
        read FFuelInfoViewingRule write FFuelInfoViewingRule;
        
        property FuelInfoEditingRule: IFuelCharacteristicsCalculationCardFuelInfoEditingRule
        read FFuelInfoEditingRule write FFuelInfoEditingRule;
        
        property ContextInfoViewingRule: IFuelCharacteristicsCalculationCardContextInfoViewingRule
        read FContextInfoViewingRule write FContextInfoViewingRule;
        
        property ContextInfoEditingRule: IFuelCharacteristicsCalculationCardContextInfoEditingRule
        read FContextInfoEditingRule write FContextInfoEditingRule;

    end;
  
implementation

{ TFuelCharacteristicsCalculationCardWorkingRules }

constructor TEmployeeFuelCharacteristicsCalculationCardWorkingRules.Create;
begin

  inherited;
  
end;

constructor TEmployeeFuelCharacteristicsCalculationCardWorkingRules.Create(
  RemovingRule: IFuelCharacteristicsCalculationCardRemovingRule;
  FuelInfoViewingRule: IFuelCharacteristicsCalculationCardFuelInfoViewingRule;
  FuelInfoEditingRule: IFuelCharacteristicsCalculationCardFuelInfoEditingRule;
  ContextInfoViewingRule: IFuelCharacteristicsCalculationCardContextInfoViewingRule;
  ContextInfoEditingRule: IFuelCharacteristicsCalculationCardContextInfoEditingRule
);
begin

  inherited Create;

  FRemovingRule := RemovingRule;
  FFuelInfoViewingRule := FuelInfoViewingRule;
  FFuelInfoEditingRule := FuelInfoEditingRule;
  FContextInfoViewingRule := ContextInfoViewingRule;
  FContextInfoEditingRule := ContextInfoEditingRule;

end;

end.
