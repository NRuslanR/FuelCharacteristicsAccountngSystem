unit ReservoirKindStorageServiceRegistry;

interface

uses

  DomainException,
  ReservoirKindDirectoryAccessService,
  ReservoirKindDirectory,
  ReservoirKindReferenceSuiteDirectory,
  ReservoirKindReferenceSuiteDirectoryAccessService;

type

  TReservoirKindStorageServiceRegistryException = class (TDomainException)

  end;
  
  IReservoirKindStorageServiceRegistry = interface

    procedure Clear;
    
    procedure RegisterReservoirKindDirectory(
      ReservoirKindDirectory: IReservoirKindDirectory
    );

    function GetReservoirKindDirectory: IReservoirKindDirectory;


    procedure RegisterReservoirKindDirectoryAccessService(
      ReservoirKindDirectoryAccessService: IReservoirKindDirectoryAccessService
    );

    function GetReservoirKindDirectoryAccessService:
      IReservoirKindDirectoryAccessService;

    procedure RegisterStandardReservoirKindDirectoryAccessService;


    procedure RegisterReservoirKindReferenceSuiteDirectory(
      ReservoirKindReferenceSuiteDirectory:
        IReservoirKindReferenceSuiteDirectory
    );

    function GetReservoirKindReferenceSuiteDirectory:
      IReservoirKindReferenceSuiteDirectory;


    procedure RegisterReservoirKindReferenceSuiteDirectoryAccessService(
      ReservoirKindReferenceSuiteDirectoryAccessService:
        IReservoirKindReferenceSuiteDirectoryAccessService
    );

    function GetReservoirKindReferenceSuiteDirectoryAccessService:
      IReservoirKindReferenceSuiteDirectoryAccessService;

    procedure RegisterStandardReservoirKindReferenceSuiteDirectoryAccessService;
    
  end;
  
implementation

end.
