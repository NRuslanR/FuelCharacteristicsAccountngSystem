unit StandardSpecialityAccountingService;

interface

uses

  AbstractDomainService,
  SpecialityAccountingService,
  SysUtils,
  Classes;

type

  TStandardSpecialityAccountingService =
    class (TAbstractStandardDomainService, ISpecialityAccountingService)

      public

        function GetAllSpecialities: TStrings; virtual;
      
    end;

implementation

uses

  Role;
  
{ TStandardSpecialityAccountingService }

function TStandardSpecialityAccountingService.GetAllSpecialities: TStrings;
begin

  Result := TStringList.Create;

  Result.Add(AIRCRAFT_TECHNICIAN_ROLE_DISPLAY_NAME);
  Result.Add(ACCOUNTANT_ROLE_DISPLAY_NAME);
  Result.Add(WAREHOUSE_HEAD_ROLE_DISPLAY_NAME);

end;

end.
