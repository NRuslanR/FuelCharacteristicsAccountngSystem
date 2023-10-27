unit SpecialityAccountingService;

interface

uses

  DomainService,
  Classes;

type

  ISpecialityAccountingService = interface (IDomainService)

    function GetAllSpecialities: TStrings;

  end;
  
implementation

end.
