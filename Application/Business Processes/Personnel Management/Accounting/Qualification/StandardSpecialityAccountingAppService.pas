unit StandardSpecialityAccountingAppService;

interface

uses

  SpecialityAccountingAppService,
  SpecialityAccountingService,
  SysUtils,
  Classes;

type

  TStandardSpecialityAccountingAppService =
    class (TInterfacedObject, ISpecialityAccountingAppService)

      private

        FSpecialityAccountingService: ISpecialityAccountingService;
        
      public

        constructor Create(
          SpecialityAccountingService: ISpecialityAccountingService
        );

        function GetAllSpecialities: TStrings; 
        
    end;

implementation

{ TStandardSpecialityAccountingAppService }

constructor TStandardSpecialityAccountingAppService.Create(
  SpecialityAccountingService: ISpecialityAccountingService);
begin

  inherited Create;

  FSpecialityAccountingService := SpecialityAccountingService;

end;

function TStandardSpecialityAccountingAppService.GetAllSpecialities: TStrings;
begin

  Result := FSpecialityAccountingService.GetAllSpecialities;
  
end;

end.
