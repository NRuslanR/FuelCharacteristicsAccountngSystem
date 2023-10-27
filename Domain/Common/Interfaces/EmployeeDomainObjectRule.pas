unit EmployeeDomainObjectRule;

interface

uses

  Employee,
  DomainException,
  IGetSelfUnit,
  DomainObjectUnit,
  SysUtils;

type

  TEmployeeDomainObjectRuleException = class (TDomainException)

  end;

  IEmployeeDomainObjectRule = interface (IGetSelf)

    procedure EnsureSatisfiedBy(
      DomainObject: TDomainObject; Employee: TEmployee
    );

    function IsSatisfiedBy(
      DomainObject: TDomainObject; Employee: TEmployee
    ): Boolean;

  end;

implementation

end.
