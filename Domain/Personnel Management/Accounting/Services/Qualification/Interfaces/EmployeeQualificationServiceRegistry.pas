unit EmployeeQualificationServiceRegistry;

interface

uses

  SpecialityAccountingService;

type

  IEmployeeQualificationServiceRegistry = interface

    procedure Clear;
    
    procedure RegisterSpecialityAccountingService(
      SpecialityAccountingService: ISpecialityAccountingService
    );

    function GetSpecialityAccountingService: ISpecialityAccountingService;

    procedure RegisterStandardSpecialityAccountingService;
    
  end;

implementation

end.
