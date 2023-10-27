unit WorkingTimeConditionsStorageServiceRegistry;

interface

uses

  DomainException,
  WorkingTimeConditionsDirectory,
  SysUtils;

type

  TWorkingTimeConditionsStorageServiceRegistryException =
    class (TDomainException)

    end;
    
  IWorkingTimeConditionsStorageServiceRegistry = interface

    procedure Clear;
    
    procedure RegisterWorkingTimeConditionsDirectory(
      WorkingTimeConditionsDirectory: IWorkingTimeConditionsDirectory
    );

    function GetWorkingTimeConditionsDirectory:
      IWorkingTimeConditionsDirectory;

  end;

implementation

end.
