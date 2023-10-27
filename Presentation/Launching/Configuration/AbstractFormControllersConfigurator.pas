unit AbstractFormControllersConfigurator;

interface

uses

  EventBus,
  EventHandler,
  AbstractFormController,
  FuelCharacteristicsAccountingApplication,
  Hashes,
  SysUtils,
  Classes;
  
type

  TAbstractFormControllersConfiguratorException = class (Exception)

  end;
  
  TAbstractFormControllersConfigurator = class abstract

    private

      procedure ConfigureControllers(
        Application: IFuelCharacteristicsAccountingApplication;
        EventBus: IEventBus
      );
      
    protected

      FControllers: TObjectHash;
      FEventBus: IEventBus;

      procedure InternalConfigureControllers(
        Application: IFuelCharacteristicsAccountingApplication;
        EventBus: IEventBus
      ); virtual; abstract;

      function GetEntryFormController: TAbstractFormController; virtual; abstract;
      
      procedure ConfigureEventBus(EventBus: IEventBus); virtual;

      procedure UnregisterAndClearControllers;
      procedure UnregisterControllers; virtual;
      procedure ClearControllers;

      procedure FreeControllers;
      
    public

      destructor Destroy; override;
      constructor Create(EventBus: IEventBus);
      
      procedure Configure(
        Application: IFuelCharacteristicsAccountingApplication
      ); virtual;

    public

      property EntryFormController: TAbstractFormController
      read GetEntryFormController;

  end;
  
implementation

{ TAbstractFormControllersConfigurator }

procedure TAbstractFormControllersConfigurator.ClearControllers;
begin

  FControllers.Clear;
  
end;

procedure TAbstractFormControllersConfigurator.Configure(
  Application: IFuelCharacteristicsAccountingApplication
);
begin

  ConfigureControllers(Application, FEventBus);
  ConfigureEventBus(FEventBus);

end;

procedure TAbstractFormControllersConfigurator.ConfigureControllers(
  Application: IFuelCharacteristicsAccountingApplication;
  EventBus: IEventBus
);
begin

  UnregisterAndClearControllers;

  InternalConfigureControllers(Application, EventBus);
  
end;

procedure TAbstractFormControllersConfigurator.ConfigureEventBus(
  EventBus: IEventBus);
begin

end;

constructor TAbstractFormControllersConfigurator.Create(EventBus: IEventBus);
begin

  inherited Create;

  FEventBus := EventBus;

  FControllers := TObjectHash.Create(False);
  
end;

destructor TAbstractFormControllersConfigurator.Destroy;
begin

  UnregisterControllers;
  FreeControllers;
  
  inherited;

end;

procedure TAbstractFormControllersConfigurator.FreeControllers;
begin

  ClearControllers;

  FreeAndNil(FControllers);

end;

procedure TAbstractFormControllersConfigurator.UnregisterAndClearControllers;
begin

  UnregisterControllers;
  ClearControllers;
  
end;

procedure TAbstractFormControllersConfigurator.UnregisterControllers;
var Controller: TAbstractFormController;
    ControllerAsEventHandler: IEventHandler;
    UnregisteredControllerNames: TStrings;
    UnregisteredControllerName: String;
begin

  UnregisteredControllerNames := nil;

  FControllers.Restart;

  try

    while FControllers.Next do begin

      Controller := TAbstractFormController(FControllers[FControllers.CurrentKey]);

      if not Supports(Controller, IEventHandler, ControllerAsEventHandler)
      then Continue;

      FEventBus.UnregisterEventHandlerFromAllEvents(ControllerAsEventHandler);

      if not Assigned(UnregisteredControllerNames) then
        UnregisteredControllerNames := TStringList.Create;

      UnregisteredControllerNames.Add(FControllers.CurrentKey);

    end;

    if not Assigned(UnregisteredControllerNames) then Exit;

    for UnregisteredControllerName in UnregisteredControllerNames do
      FControllers.Delete(UnregisteredControllerName);

  finally

    FreeAndNil(UnregisteredControllerNames);
    
  end;

end;

end.
