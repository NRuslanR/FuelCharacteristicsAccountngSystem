unit StandardEmployeeQualificationServiceRegistry;

interface

uses

  EmployeeQualificationServiceRegistry,
  SpecialityAccountingService,
  SysUtils,
  Classes;

type

  TEmployeeQualificationServiceRegistry =
    class (TInterfacedObject, IEmployeeQualificationServiceRegistry)

      private

        class var FInstance: IEmployeeQualificationServiceRegistry;
        
      private

        FSpecialityAccountingService: ISpecialityAccountingService;
        
        class function GetCurrent: IEmployeeQualificationServiceRegistry; static;

      public

        procedure Clear;
        
        procedure RegisterSpecialityAccountingService(
          SpecialityAccountingService: ISpecialityAccountingService
        );

        function GetSpecialityAccountingService: ISpecialityAccountingService;

        procedure RegisterStandardSpecialityAccountingService;

      public

        class property Current: IEmployeeQualificationServiceRegistry
        read GetCurrent write FInstance;
        
    end;

implementation

uses

  StandardSpecialityAccountingService;

{ TEmployeeQualificationServiceRegistry }

procedure TEmployeeQualificationServiceRegistry.Clear;
begin

  FSpecialityAccountingService := nil;

end;

class function TEmployeeQualificationServiceRegistry.
  GetCurrent: IEmployeeQualificationServiceRegistry;
begin

  if not Assigned(FInstance) then
    FInstance := TEmployeeQualificationServiceRegistry.Create;
    
  Result := FInstance;

end;

function TEmployeeQualificationServiceRegistry.
  GetSpecialityAccountingService: ISpecialityAccountingService;
begin

  Result := FSpecialityAccountingService;

end;

procedure TEmployeeQualificationServiceRegistry.RegisterSpecialityAccountingService(
  SpecialityAccountingService: ISpecialityAccountingService);
begin

  FSpecialityAccountingService := SpecialityAccountingService;

end;

procedure TEmployeeQualificationServiceRegistry.
  RegisterStandardSpecialityAccountingService;
begin

  FSpecialityAccountingService :=
    TStandardSpecialityAccountingService.Create;

end;

end.
