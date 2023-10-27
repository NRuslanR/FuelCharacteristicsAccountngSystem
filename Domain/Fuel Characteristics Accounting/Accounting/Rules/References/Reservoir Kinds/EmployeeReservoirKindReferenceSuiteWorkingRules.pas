unit EmployeeReservoirKindReferenceSuiteWorkingRules;

interface

uses

  ReservoirKindReferenceSuiteViewingRule,
  ReservoirKindReferenceSuiteEditingRule,
  ReservoirKindReferenceSuiteRemovingRule,
  SysUtils,
  Classes;

type

  TEmployeeReservoirKindReferenceSuiteWorkingRules = class

    private

      FReservoirKindReferenceSuiteViewingRule: IReservoirKindReferenceSuiteViewingRule;
      FReservoirKindReferenceSuiteEditingRule: IReservoirKindReferenceSuiteEditingRule;
      FReservoirKindReferenceSuiteRemovingRule: IReservoirKindReferenceSuiteRemovingRule;

    public

      constructor Create; overload;
      constructor Create(
        ReservoirKindReferenceSuiteViewingRule: IReservoirKindReferenceSuiteViewingRule;
        ReservoirKindReferenceSuiteEditingRule: IReservoirKindReferenceSuiteEditingRule;
        ReservoirKindReferenceSuiteRemovingRule: IReservoirKindReferenceSuiteRemovingRule
      ); overload;

      property ReservoirKindReferenceSuiteViewingRule:
        IReservoirKindReferenceSuiteViewingRule
      read FReservoirKindReferenceSuiteViewingRule
      write FReservoirKindReferenceSuiteViewingRule;

      property ReservoirKindReferenceSuiteEditingRule:
        IReservoirKindReferenceSuiteEditingRule
      read FReservoirKindReferenceSuiteEditingRule
      write FReservoirKindReferenceSuiteEditingRule;

      property ReservoirKindReferenceSuiteRemovingRule:
        IReservoirKindReferenceSuiteRemovingRule
      read FReservoirKindReferenceSuiteRemovingRule
      write FReservoirKindReferenceSuiteRemovingRule;
      
  end;
  
implementation

{ TEmployeeReservoirKindReferenceSuiteWorkingRules }

constructor TEmployeeReservoirKindReferenceSuiteWorkingRules.Create;
begin

  inherited;
  
end;

constructor TEmployeeReservoirKindReferenceSuiteWorkingRules.Create(
  ReservoirKindReferenceSuiteViewingRule: IReservoirKindReferenceSuiteViewingRule;
  ReservoirKindReferenceSuiteEditingRule: IReservoirKindReferenceSuiteEditingRule;
  ReservoirKindReferenceSuiteRemovingRule: IReservoirKindReferenceSuiteRemovingRule);
begin

  inherited Create;

  FReservoirKindReferenceSuiteViewingRule := ReservoirKindReferenceSuiteViewingRule;
  FReservoirKindReferenceSuiteEditingRule := ReservoirKindReferenceSuiteEditingRule;
  FReservoirKindReferenceSuiteRemovingRule := ReservoirKindReferenceSuiteRemovingRule;
  
end;

end.
