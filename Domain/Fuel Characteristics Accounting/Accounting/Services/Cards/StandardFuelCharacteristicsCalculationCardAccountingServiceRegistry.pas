unit StandardFuelCharacteristicsCalculationCardAccountingServiceRegistry;

interface

uses

  FuelCharacteristicsCalculationCardAccountingServiceRegistry,
  FuelCharacteristicsCalculationCardAccountingService,
  FuelCharacteristicsCalculationCardAccessService,
  FuelCharacteristicsCalculationCardContextInfoAssigningService,
  FuelCharacteristicsCalculationCardCreatingService,
  SysUtils;

type

  TFuelCharacteristicsCalculationCardAccountingServiceRegistry =
    class (
      TInterfacedObject,
      IFuelCharacteristicsCalculationCardAccountingServiceRegistry
    )
    
      private

        FFuelCharacteristicsCalculationCardAccessService:
          IFuelCharacteristicsCalculationCardAccessService;

        FFuelCharacteristicsCalculationCardAccountingService:
          IFuelCharacteristicsCalculationCardAccountingService;

        FFuelCharacteristicsCalculationCardContextInfoAssigningService:
          IFuelCharacteristicsCalculationCardContextInfoAssigningService;

        FFuelCharacteristicsCalculationCardCreatingService:
          IFuelCharacteristicsCalculationCardCreatingService;
          
      private

        class var FInstance: IFuelCharacteristicsCalculationCardAccountingServiceRegistry;

        class function GetCurrent:
          IFuelCharacteristicsCalculationCardAccountingServiceRegistry; static;

      private

        procedure RaiseExceptionIfFuelCharacteristicsCalculationCardAccessServiceRegistrationOrderIsNotValid;
        procedure RaiseExceptionIfFuelCharacteristicsCalculationCardContextInfoAssigningServiceRegistrationOrderIsNotValid;
        procedure RaiseExceptionIfFuelCharacteristicsCalculationCardCreatingServiceRegistrationOrderIsNotValid;
        procedure RaiseExceptionIfFuelCharacteristicsCalculationCardAccountingServiceRegistrationOrderIsNotValid;

      public

        procedure RegisterFuelCharacteristicsCalculationCardAccountingService(
          FuelCharacteristicsCalculationCardAccountingService:
            IFuelCharacteristicsCalculationCardAccountingService
        );

        function GetFuelCharacteristicsCalculationCardAccountingService:
          IFuelCharacteristicsCalculationCardAccountingService;

        procedure RegisterStandardFuelCharacteristicsCalculationCardAccountingService;

      public

        procedure RegisterFuelCharacteristicsCalculationCardAccessService(
          FuelCharacteristicsCalculationCardAccessService:
            IFuelCharacteristicsCalculationCardAccessService
        );

        function GetFuelCharacteristicsCalculationCardAccessService:
          IFuelCharacteristicsCalculationCardAccessService;

        procedure RegisterStandardFuelCharacteristicsCalculationCardAccessService;

      public

        procedure RegisterFuelCharacteristicsCalculationCardContextInfoAssigningService(
          FuelCharacteristicsCalculationCardContextInfoAssigningService:
            IFuelCharacteristicsCalculationCardContextInfoAssigningService
        );

        function GetFuelCharacteristicsCalculationCardContextInfoAssigningService:
          IFuelCharacteristicsCalculationCardContextInfoAssigningService;

        procedure RegisterStandardFuelCharacteristicsCalculationCardContextInfoAssigningService;

      public

        procedure RegisterFuelCharacteristicsCalculationCardCreatingService(
          FuelCharacteristicsCalculationCardCreatingService:
            IFuelCharacteristicsCalculationCardCreatingService
        );

        function GetFuelCharacteristicsCalculationCardCreatingService:
          IFuelCharacteristicsCalculationCardCreatingService;

        procedure RegisterStandardFuelCharacteristicsCalculationCardCreatingService;

      public

        procedure Clear;
        
        procedure RegisterStandardFuelCharacteristicsCalculationCardAccountingServices;

      public

        class property Current: IFuelCharacteristicsCalculationCardAccountingServiceRegistry
        read GetCurrent write FInstance;
        
    end;

implementation

uses

  StandardFuelCharacteristicsCalculationCardCreatingService,
  StandardFuelCharacteristicsCalculationCardAccessService,
  StandardFuelCharacteristicsCalculationCardContextInfoAssigningService,
  StandardFuelCharacteristicsCalculationCardAccountingService,
  StandardFuelCharacteristicsCalculationCardStorageServiceRegistry;
  
{ TFuelCharacteristicsCalculationCardAccountingServiceRegistry }

procedure TFuelCharacteristicsCalculationCardAccountingServiceRegistry.Clear;
begin

  FFuelCharacteristicsCalculationCardAccessService := nil;
  FFuelCharacteristicsCalculationCardAccountingService := nil;
  FFuelCharacteristicsCalculationCardContextInfoAssigningService := nil;
  FFuelCharacteristicsCalculationCardCreatingService := nil;

end;

class function TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  GetCurrent: IFuelCharacteristicsCalculationCardAccountingServiceRegistry;
begin

  if not Assigned(FInstance) then
    FInstance := TFuelCharacteristicsCalculationCardAccountingServiceRegistry.Create;

  Result := FInstance;

end;

function TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  GetFuelCharacteristicsCalculationCardAccessService:
    IFuelCharacteristicsCalculationCardAccessService;
begin

  Result := FFuelCharacteristicsCalculationCardAccessService;

end;

function TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  GetFuelCharacteristicsCalculationCardAccountingService:
    IFuelCharacteristicsCalculationCardAccountingService;
begin

  Result := FFuelCharacteristicsCalculationCardAccountingService;

end;

function TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  GetFuelCharacteristicsCalculationCardContextInfoAssigningService:
    IFuelCharacteristicsCalculationCardContextInfoAssigningService;
begin

  Result := FFuelCharacteristicsCalculationCardContextInfoAssigningService;
  
end;

function TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  GetFuelCharacteristicsCalculationCardCreatingService:
    IFuelCharacteristicsCalculationCardCreatingService;
begin

  Result := FFuelCharacteristicsCalculationCardCreatingService;
  
end;

procedure TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  RaiseExceptionIfFuelCharacteristicsCalculationCardAccessServiceRegistrationOrderIsNotValid;
begin

  if
    Assigned(FFuelCharacteristicsCalculationCardCreatingService) or
    Assigned(FFuelCharacteristicsCalculationCardAccountingService)
  then begin

    raise
    TFuelCharacteristicsCalculationCardAccountingServiceRegistryException.Create(
      'Неправильный порядок ' +
      'регистрации предметной службы'
    );

  end;
  
end;

procedure TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  RaiseExceptionIfFuelCharacteristicsCalculationCardAccountingServiceRegistrationOrderIsNotValid;
begin

  if
    not Assigned(FFuelCharacteristicsCalculationCardAccessService) or
    not Assigned(FFuelCharacteristicsCalculationCardContextInfoAssigningService) or
    not Assigned(
      TFuelCharacteristicsCalculationCardStorageServiceRegistry
        .Current
          .GetFuelCharacteristicsCalculationCardDirectory
    ) or
    not Assigned(FFuelCharacteristicsCalculationCardCreatingService)
  then begin

    raise
    TFuelCharacteristicsCalculationCardAccountingServiceRegistryException.Create(
      'Неправильный порядок ' +
      'регистрации предметной службы'
    );

  end;
  
end;

procedure TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  RaiseExceptionIfFuelCharacteristicsCalculationCardContextInfoAssigningServiceRegistrationOrderIsNotValid;
begin

  if Assigned(FFuelCharacteristicsCalculationCardAccountingService)
  then begin

    raise
    TFuelCharacteristicsCalculationCardAccountingServiceRegistryException.Create(
      'Неправильный порядок ' +
      'регистрации предметной службы'
    );

  end;
  
end;

procedure TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  RaiseExceptionIfFuelCharacteristicsCalculationCardCreatingServiceRegistrationOrderIsNotValid;
begin

  if not Assigned(FFuelCharacteristicsCalculationCardAccessService) or
     Assigned(FFuelCharacteristicsCalculationCardAccountingService)
  then begin

    raise
    TFuelCharacteristicsCalculationCardAccountingServiceRegistryException.Create(
      'Неправильный порядок ' +
      'регистрации предметной службы'
    );

  end;
  
end;

procedure TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  RegisterFuelCharacteristicsCalculationCardAccessService(
    FuelCharacteristicsCalculationCardAccessService:
      IFuelCharacteristicsCalculationCardAccessService
  );
begin


  RaiseExceptionIfFuelCharacteristicsCalculationCardAccessServiceRegistrationOrderIsNotValid;

  FFuelCharacteristicsCalculationCardAccessService :=
    FuelCharacteristicsCalculationCardAccessService;

end;

procedure TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  RegisterFuelCharacteristicsCalculationCardAccountingService(
    FuelCharacteristicsCalculationCardAccountingService:
      IFuelCharacteristicsCalculationCardAccountingService
  );
begin

  RaiseExceptionIfFuelCharacteristicsCalculationCardAccountingServiceRegistrationOrderIsNotValid;

  FFuelCharacteristicsCalculationCardAccountingService :=
    FuelCharacteristicsCalculationCardAccountingService;

end;

procedure TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  RegisterFuelCharacteristicsCalculationCardContextInfoAssigningService(
    FuelCharacteristicsCalculationCardContextInfoAssigningService:
      IFuelCharacteristicsCalculationCardContextInfoAssigningService
  );
begin

  RaiseExceptionIfFuelCharacteristicsCalculationCardContextInfoAssigningServiceRegistrationOrderIsNotValid;

  FFuelCharacteristicsCalculationCardContextInfoAssigningService :=
    FuelCharacteristicsCalculationCardContextInfoAssigningService;
    
end;

procedure TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  RegisterFuelCharacteristicsCalculationCardCreatingService(
    FuelCharacteristicsCalculationCardCreatingService:
      IFuelCharacteristicsCalculationCardCreatingService
  );
begin

  RaiseExceptionIfFuelCharacteristicsCalculationCardCreatingServiceRegistrationOrderIsNotValid;

  FFuelCharacteristicsCalculationCardCreatingService :=
    FuelCharacteristicsCalculationCardCreatingService;
    
end;

procedure TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  RegisterStandardFuelCharacteristicsCalculationCardAccessService;
begin

  RaiseExceptionIfFuelCharacteristicsCalculationCardAccessServiceRegistrationOrderIsNotValid;

  FFuelCharacteristicsCalculationCardAccessService :=
    TStandardFuelCharacteristicsCalculationCardAccessService.Create;

end;

procedure TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  RegisterStandardFuelCharacteristicsCalculationCardAccountingService;
begin

  if
    not
    Assigned(FFuelCharacteristicsCalculationCardContextInfoAssigningService)
  then RegisterStandardFuelCharacteristicsCalculationCardContextInfoAssigningService;

  if not Assigned(FFuelCharacteristicsCalculationCardAccessService)
  then RegisterStandardFuelCharacteristicsCalculationCardAccessService;

  if not Assigned(FFuelCharacteristicsCalculationCardCreatingService)
  then RegisterStandardFuelCharacteristicsCalculationCardCreatingService;
  
  FFuelCharacteristicsCalculationCardAccountingService :=
    TStandardFuelCharacteristicsCalculationCardAccountingService.Create(
    
      FFuelCharacteristicsCalculationCardContextInfoAssigningService,
      FFuelCharacteristicsCalculationCardAccessService,
      
      TFuelCharacteristicsCalculationCardStorageServiceRegistry
        .Current
          .GetFuelCharacteristicsCalculationCardDirectory,

      FFuelCharacteristicsCalculationCardCreatingService
    );

end;

procedure TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  RegisterStandardFuelCharacteristicsCalculationCardContextInfoAssigningService;
begin

  RaiseExceptionIfFuelCharacteristicsCalculationCardContextInfoAssigningServiceRegistrationOrderIsNotValid;

  FFuelCharacteristicsCalculationCardContextInfoAssigningService :=
    TStandardFuelCharacteristicsCalculationCardContextInfoAssigningService
      .Create;

end;

procedure TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  RegisterStandardFuelCharacteristicsCalculationCardCreatingService;
begin

  RaiseExceptionIfFuelCharacteristicsCalculationCardCreatingServiceRegistrationOrderIsNotValid;

  if not Assigned(FFuelCharacteristicsCalculationCardAccessService)
  then RegisterStandardFuelCharacteristicsCalculationCardAccessService;

  FFuelCharacteristicsCalculationCardCreatingService :=
    TStandardFuelCharacteristicsCalculationCardCreatingService.Create(
      FFuelCharacteristicsCalculationCardAccessService
    );

end;

procedure TFuelCharacteristicsCalculationCardAccountingServiceRegistry.
  RegisterStandardFuelCharacteristicsCalculationCardAccountingServices;
begin

  RegisterStandardFuelCharacteristicsCalculationCardAccessService;
  RegisterStandardFuelCharacteristicsCalculationCardContextInfoAssigningService;
  RegisterStandardFuelCharacteristicsCalculationCardCreatingService;
  RegisterStandardFuelCharacteristicsCalculationCardAccountingService;
  
end;

end.
