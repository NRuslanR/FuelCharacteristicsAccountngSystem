unit AbstractEmployeeReservoirKindWorkingRule;

interface

uses

  EmployeeReservoirKindWorkingRule,
  Employee,
  unIReservoirKind,
  SysUtils,
  Classes;

type

  TAbstractEmployeeReservoirKindWorkingRule =
    class abstract (TInterfacedObject, IEmployeeReservoirKindWorkingRule)

      public

        procedure EnsureSatisfiedBy(
          Employee: TEmployee;
          ReservoirKind: IReservoirKind
        ); virtual; abstract;

        function IsSatisfiedBy(
          Employee: TEmployee;
          ReservoirKind: IReservoirKind
        ): Boolean; virtual;

    end;
  
implementation

{ TAbstractEmployeeReservoirKindWorkingRule }

function TAbstractEmployeeReservoirKindWorkingRule.IsSatisfiedBy(
  Employee: TEmployee; ReservoirKind: IReservoirKind): Boolean;
begin

  try

    EnsureSatisfiedBy(Employee, ReservoirKind);

    Result := True;
    
  except

    on e: TEmployeeReservoirKindWorkingRuleException
    do Result := False;

  end;

end;

end.
