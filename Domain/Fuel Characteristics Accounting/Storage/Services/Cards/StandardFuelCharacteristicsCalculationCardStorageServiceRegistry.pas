unit StandardFuelCharacteristicsCalculationCardStorageServiceRegistry;

interface

uses

  FuelCharacteristicsCalculationCardStorageServiceRegistry,
  FuelCharacteristicsCalculationCardDirectoryAccessService,
  FuelCharacteristicsCalculationCardDirectory,
  SysUtils;

type

  TFuelCharacteristicsCalculationCardStorageServiceRegistry =
    class (
      TInterfacedObject,
      IFuelCharacteristicsCalculationCardStorageServiceRegistry
    )

      private

        class var FInstance: IFuelCharacteristicsCalculationCardStorageServiceRegistry;

        class function GetInstance:
          IFuelCharacteristicsCalculationCardStorageServiceRegistry; static;

      private

        FFuelCharacteristicsCalculationCardDirectoryAccessService:
          IFuelCharacteristicsCalculationCardDirectoryAccessService;

        FFuelCharacteristicsCalculationCardDirectory:
          IFuelCharacteristicsCalculationCardDirectory;

      public

        procedure RegisterFuelCharacteristicsCalculationCardDirectory(
          FuelCharacteristicsCalculationCardDirectory:
            IFuelCharacteristicsCalculationCardDirectory
        );

        function GetFuelCharacteristicsCalculationCardDirectory:
          IFuelCharacteristicsCalculationCardDirectory;

      public

        procedure RegisterFuelCharacteristicsCalculationCardDirectoryAccessService(
          FuelCharacteristicsCalculationCardDirectoryAccessService:
            IFuelCharacteristicsCalculationCardDirectoryAccessService
        );

        function GetFuelCharacteristicsCalculationCardDirectoryAccessService:
          IFuelCharacteristicsCalculationCardDirectoryAccessService;

        procedure RegisterStandardFuelCharacteristicsCalculationCardDirectoryAccessService;

      public

        procedure Clear;

        class property Current: IFuelCharacteristicsCalculationCardStorageServiceRegistry
        read GetInstance write FInstance;
        
    end;

implementation

uses

  StandardFuelCharacteristicsCalculationCardDirectoryAccessService,
  StandardFuelCharacteristicsCalculationCardAccountingServiceRegistry;

{ TFuelCharacteristicsCalculationCardStorageServiceRegistry }

procedure TFuelCharacteristicsCalculationCardStorageServiceRegistry.Clear;
begin

  FFuelCharacteristicsCalculationCardDirectoryAccessService := nil;
  FFuelCharacteristicsCalculationCardDirectory := nil;
  
end;

function TFuelCharacteristicsCalculationCardStorageServiceRegistry.
  GetFuelCharacteristicsCalculationCardDirectory:
    IFuelCharacteristicsCalculationCardDirectory;
begin

  Result := FFuelCharacteristicsCalculationCardDirectory;
  
end;

function TFuelCharacteristicsCalculationCardStorageServiceRegistry.
  GetFuelCharacteristicsCalculationCardDirectoryAccessService:
    IFuelCharacteristicsCalculationCardDirectoryAccessService;
begin

  Result := FFuelCharacteristicsCalculationCardDirectoryAccessService;

end;

class function TFuelCharacteristicsCalculationCardStorageServiceRegistry.
  GetInstance: IFuelCharacteristicsCalculationCardStorageServiceRegistry;
begin

  if not Assigned(FInstance) then
    FInstance := TFuelCharacteristicsCalculationCardStorageServiceRegistry.Create;
    
  Result := FInstance;

end;

procedure TFuelCharacteristicsCalculationCardStorageServiceRegistry.
  RegisterFuelCharacteristicsCalculationCardDirectory(
    FuelCharacteristicsCalculationCardDirectory:
      IFuelCharacteristicsCalculationCardDirectory
  );
begin

  if
    Assigned(
      TFuelCharacteristicsCalculationCardAccountingServiceRegistry
        .Current
          .GetFuelCharacteristicsCalculationCardAccountingService
    )
  then begin

    raise
    TFuelCharacteristicsCalculationCardStorageServiceRegistryException.Create(
      'Неправильный порядок регистрации ' +
      'предметной службы'
    );

  end;

  FFuelCharacteristicsCalculationCardDirectory :=
    FuelCharacteristicsCalculationCardDirectory;

end;

procedure TFuelCharacteristicsCalculationCardStorageServiceRegistry.
  RegisterFuelCharacteristicsCalculationCardDirectoryAccessService(
    FuelCharacteristicsCalculationCardDirectoryAccessService:
      IFuelCharacteristicsCalculationCardDirectoryAccessService
  );
begin

  FFuelCharacteristicsCalculationCardDirectoryAccessService :=
    FuelCharacteristicsCalculationCardDirectoryAccessService;

end;

procedure TFuelCharacteristicsCalculationCardStorageServiceRegistry.
  RegisterStandardFuelCharacteristicsCalculationCardDirectoryAccessService;
begin

  FFuelCharacteristicsCalculationCardDirectoryAccessService :=
    TStandardFuelCharacteristicsCalculationCardDirectoryAccessService.Create;

end;

end.
