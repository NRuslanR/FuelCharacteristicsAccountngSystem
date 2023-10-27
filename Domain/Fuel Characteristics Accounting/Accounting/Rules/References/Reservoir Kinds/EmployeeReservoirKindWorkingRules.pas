unit EmployeeReservoirKindWorkingRules;

interface

uses

  ReservoirKindViewingRule,
  ReservoirKindEditingRule,
  ReservoirKindRemovingRule,
  SysUtils,
  Classes;

type

  TEmployeeReservoirKindWorkingRules = class

    private

      FReservoirKindViewingRule: IReservoirKindViewingRule;
      FReservoirKindEditingRule: IReservoirKindEditingRule;
      FReservoirKindRemovingRule: IReservoirKindRemovingRule;

    public

      constructor Create; overload;
      constructor Create(
        ReservoirKindViewingRule: IReservoirKindViewingRule;
        ReservoirKindEditingRule: IReservoirKindEditingRule;
        ReservoirKindRemovingRule: IReservoirKindRemovingRule
      ); overload;

      property ReservoirKindViewingRule: IReservoirKindViewingRule
      read FReservoirKindViewingRule write FReservoirKindViewingRule;
      
      property ReservoirKindEditingRule: IReservoirKindEditingRule
      read FReservoirKindEditingRule write FReservoirKindEditingRule;
      
      property ReservoirKindRemovingRule: IReservoirKindRemovingRule
      read FReservoirKindRemovingRule write FReservoirKindRemovingRule;

  end;
  
implementation

{ TEmployeeReservoirKindWorkingRules }

constructor TEmployeeReservoirKindWorkingRules.Create;
begin

  inherited;
  
end;

constructor TEmployeeReservoirKindWorkingRules.Create(
  ReservoirKindViewingRule: IReservoirKindViewingRule;
  ReservoirKindEditingRule: IReservoirKindEditingRule;
  ReservoirKindRemovingRule: IReservoirKindRemovingRule);
begin

  inherited Create;

  FReservoirKindViewingRule := ReservoirKindViewingRule;
  FReservoirKindEditingRule := ReservoirKindEditingRule;
  FReservoirKindRemovingRule := ReservoirKindRemovingRule;
  
end;

end.
