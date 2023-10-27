unit StandardReservoirKindStorageServiceRegistry;

interface

uses

  ReservoirKindStorageServiceRegistry,
  ReservoirKindDirectoryAccessService,
  ReservoirKindDirectory,
  ReservoirKindReferenceSuiteDirectory,
  ReservoirKindReferenceSuiteDirectoryAccessService;

type

  TReservoirKindStorageServiceRegistry =
    class (TInterfacedObject, IReservoirKindStorageServiceRegistry)

      private

        FReservoirKindDirectoryAccessService:
          IReservoirKindDirectoryAccessService;

        FReservoirKindDirectory: IReservoirKindDirectory;

        FReservoirKindReferenceSuiteDirectory:
          IReservoirKindReferenceSuiteDirectory;

        FReservoirKindReferenceSuiteDirectoryAccessService:
          IReservoirKindReferenceSuiteDirectoryAccessService;

      private

        class var FInstance: IReservoirKindStorageServiceRegistry;
        class function GetInstacne: IReservoirKindStorageServiceRegistry; static;

      public

        procedure RegisterReservoirKindDirectory(
          ReservoirKindDirectory: IReservoirKindDirectory
        );

        function GetReservoirKindDirectory: IReservoirKindDirectory;

      public

        procedure RegisterReservoirKindDirectoryAccessService(
          ReservoirKindDirectoryAccessService: IReservoirKindDirectoryAccessService
        );

        function GetReservoirKindDirectoryAccessService:
          IReservoirKindDirectoryAccessService;

        procedure RegisterStandardReservoirKindDirectoryAccessService;

      public

        procedure RegisterReservoirKindReferenceSuiteDirectory(
          ReservoirKindReferenceSuiteDirectory:
            IReservoirKindReferenceSuiteDirectory
        );

        function GetReservoirKindReferenceSuiteDirectory:
          IReservoirKindReferenceSuiteDirectory;

      public

        procedure RegisterReservoirKindReferenceSuiteDirectoryAccessService(
          ReservoirKindReferenceSuiteDirectoryAccessService:
            IReservoirKindReferenceSuiteDirectoryAccessService
        );

        function GetReservoirKindReferenceSuiteDirectoryAccessService:
          IReservoirKindReferenceSuiteDirectoryAccessService;

        procedure RegisterStandardReservoirKindReferenceSuiteDirectoryAccessService;

        procedure Clear;
        
      public

        class property Current: IReservoirKindStorageServiceRegistry
        read GetInstacne write FInstance;

    end;


implementation

uses

  StandardReservoirKindDirectoryAccessService,
  StandardReservoirKindAccountingServiceRegistry,
  StandardFuelCharacteristicsCalculationServiceRegistry,
  StandardReservoirKindReferenceSuiteDirectoryAccessService;

{ TReservoirKindStorageServiceRegistry }

procedure TReservoirKindStorageServiceRegistry.Clear;
begin

  FReservoirKindDirectoryAccessService := nil;
  FReservoirKindDirectory := nil;
  FReservoirKindReferenceSuiteDirectory := nil;
  FReservoirKindReferenceSuiteDirectoryAccessService := nil;
  
end;

class function TReservoirKindStorageServiceRegistry.
  GetInstacne: IReservoirKindStorageServiceRegistry;
begin

  if not Assigned(FInstance) then
    FInstance := TReservoirKindStorageServiceRegistry.Create;

  Result := FInstance;

end;

function TReservoirKindStorageServiceRegistry.
  GetReservoirKindDirectory: IReservoirKindDirectory;
begin

  Result := FReservoirKindDirectory;
  
end;

function TReservoirKindStorageServiceRegistry.
  GetReservoirKindDirectoryAccessService: IReservoirKindDirectoryAccessService;
begin

  Result := FReservoirKindDirectoryAccessService;

end;

function TReservoirKindStorageServiceRegistry.
  GetReservoirKindReferenceSuiteDirectory: IReservoirKindReferenceSuiteDirectory;
begin

  Result := FReservoirKindReferenceSuiteDirectory;

end;

function TReservoirKindStorageServiceRegistry.
  GetReservoirKindReferenceSuiteDirectoryAccessService:
    IReservoirKindReferenceSuiteDirectoryAccessService;
begin

  Result := FReservoirKindReferenceSuiteDirectoryAccessService;

end;

procedure TReservoirKindStorageServiceRegistry.RegisterReservoirKindDirectory(
  ReservoirKindDirectory: IReservoirKindDirectory);
begin

  if
    Assigned(
      TReservoirKindAccountingServiceRegistry
        .Current
          .GetReservoirKindAccountingService
    )
  then begin

    raise TReservoirKindStorageServiceRegistryException.Create(
      'Неправильный порядок регистрации ' +
      'предметной службы'
    );

  end;

  FReservoirKindDirectory := ReservoirKindDirectory;
  
end;

procedure TReservoirKindStorageServiceRegistry.
  RegisterReservoirKindDirectoryAccessService(
    ReservoirKindDirectoryAccessService: IReservoirKindDirectoryAccessService
  );
begin

  FReservoirKindDirectoryAccessService := ReservoirKindDirectoryAccessService;
  
end;

procedure TReservoirKindStorageServiceRegistry.
  RegisterReservoirKindReferenceSuiteDirectory(
    ReservoirKindReferenceSuiteDirectory: IReservoirKindReferenceSuiteDirectory
  );
begin

  if
    Assigned(
      TReservoirKindAccountingServiceRegistry
        .Current
          .GetReservoirKindReferenceSuiteAccountingService
    )
    or
    Assigned(
      TFuelCharacteristicsCalculationServiceRegistry
        .Current
          .GetFuelCharacteristicsCalculationService
    )
  then begin

    raise TReservoirKindStorageServiceRegistryException.Create(
      'Неправильный порядок регистрации ' +
      'предметной службы'
    );
    
  end;

  FReservoirKindReferenceSuiteDirectory := ReservoirKindReferenceSuiteDirectory;
  
end;

procedure TReservoirKindStorageServiceRegistry.
  RegisterReservoirKindReferenceSuiteDirectoryAccessService(
    ReservoirKindReferenceSuiteDirectoryAccessService:
      IReservoirKindReferenceSuiteDirectoryAccessService
  );
begin

  FReservoirKindReferenceSuiteDirectoryAccessService :=
    ReservoirKindReferenceSuiteDirectoryAccessService;
    
end;

procedure TReservoirKindStorageServiceRegistry.
  RegisterStandardReservoirKindDirectoryAccessService;
begin

  FReservoirKindDirectoryAccessService :=
    TStandardReservoirKindDirectoryAccessService.Create;

end;

procedure TReservoirKindStorageServiceRegistry.
  RegisterStandardReservoirKindReferenceSuiteDirectoryAccessService;
begin

  FReservoirKindReferenceSuiteDirectoryAccessService :=
    TStandardReservoirKindReferenceSuiteDirectoryAccessService.Create;

end;

end.
