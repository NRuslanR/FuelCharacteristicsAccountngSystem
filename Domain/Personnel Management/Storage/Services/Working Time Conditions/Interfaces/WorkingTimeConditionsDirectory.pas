unit WorkingTimeConditionsDirectory;

interface

uses

  DomainService,
  DomainException,
  WorkingTimeConditions,
  SysUtils;

type

  TWorkingTimeConditionsDirectoryException = class (TDomainException)

  end;

  IWorkingTimeConditionsDirectory = interface (IDomainService)

    function FindActiveWorkingTimeConditions: TWorkingTimeConditions;

    function FindWorkingTimeConditions(
      const WorkingTimeConditionsId: Variant
    ): TWorkingTimeConditions;

    procedure PutWorkingTimeConditions(
      WorkingTimeConditions: TWorkingTimeConditions
    );

    procedure ModifyWorkingTimeConditions(
      WorkingTimeConditions: TWorkingTimeConditions
    );

    procedure RemoveWorkingTimeConditions(
      WorkingTimeConditions: TWorkingTimeConditions
    );
    
  end;

implementation

end.
