unit SpecialityAccountingAppService;

interface

uses

  SpecialityAccountingService,
  ApplicationService,
  Classes;

type

  TSpecialityAccountingAppServiceException = class (TApplicationServiceException)

  end;
  
  ISpecialityAccountingAppService = interface (IApplicationService)

    function GetAllSpecialities: TStrings;

  end;

implementation

end.
