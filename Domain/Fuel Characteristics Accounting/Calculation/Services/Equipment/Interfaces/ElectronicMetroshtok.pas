unit ElectronicMetroshtok;

interface

uses

  DomainException,
  DomainService,
  ElectronicMetroshtokCalculationResult;

type

  TElectronicMetroshtokException = class (TDomainException)

  end;
  
  IElectronicMetroshtok = interface (IDomainService)

    function PerformCalculation: TElectronicMetroshtokCalculationResult;
    
  end;

implementation

end.
