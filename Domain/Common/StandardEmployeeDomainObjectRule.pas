unit StandardEmployeeDomainObjectRule;

interface

uses

  EmployeeDomainObjectRule,
  Employee,
  DomainObjectUnit,
  SysUtils,
  Classes;

type

  TStandardEmployeeDomainObjectRule =
    class (TInterfacedObject, IEmployeeDomainObjectRule)

      public

        function GetSelf: TObject;
        
        procedure EnsureSatisfiedBy(
          DomainObject: TDomainObject; Employee: TEmployee
        ); virtual;  abstract;

        function IsSatisfiedBy(
          DomainObject: TDomainObject; Employee: TEmployee
        ): Boolean; virtual;

    end;


implementation

{ TStandardEmployeeDomainObjectRule }

function TStandardEmployeeDomainObjectRule.GetSelf: TObject;
begin

  Result := Self;
  
end;

function TStandardEmployeeDomainObjectRule.IsSatisfiedBy(
  DomainObject: TDomainObject;
  Employee: TEmployee
): Boolean;
begin

  try

    EnsureSatisfiedBy(DomainObject, Employee);

    Result := True;
    
  except

    on E: TEmployeeDomainObjectRuleException
    do Result := False;

  end;

end;

end.
