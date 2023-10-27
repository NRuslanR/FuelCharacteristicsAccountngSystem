unit PresentationConfigurator;

interface

uses

  FuelCharacteristicsAccountingApplicationBuilder,
  ApplicationBuilder,
  EmployeeFormControllersConfigurator,
  FuelCharacteristicsAccountingFormControllersConfigurator,
  SystemAuthentificationFormControllersConfigurator,
  FuelCharacteristicsAccountingApplication,
  SystemAuthentificationFormControllerEvents,
  ReservoirKindFormControllersConfigurator,
  EventBus,
  AbstractFormController,
  Event,
  Forms,
  Controls,
  EventHandler,
  ClientAccount,
  AuthentificationData,
  ServiceInfo,
  SysUtils,
  Classes;

type

  TOnApplicationMainFormChangeRequestedEventHandler =
    procedure (
      Sender: TObject;
      ApplicationMainForm: TForm
    ) of object;

  TPresentationConfigurator = class (TInterfacedObject, IEventHandler)

    private

      FEventBus: IEventBus;
      FApplicationBuilder: TFuelCharacteristicsAccountingApplicationBuilder;
      FFreeApplicationBuilder: IApplicationBuilder;

    private

      FOnApplicationMainFormChangeRequestedEventHandler: TOnApplicationMainFormChangeRequestedEventHandler;

    private

      FEmployeeFormControllersConfigurator: TEmployeeFormControllersConfigurator;
      FFuelCharacteristicsAccountingFormControllersConfigurator: TFuelCharacteristicsAccountingFormControllersConfigurator;
      FSystemAuthentificationFormControllersConfigurator: TSystemAuthentificationFormControllersConfigurator;
      FReservoirKindFormControllersConfigurator: TReservoirKindFormControllersConfigurator;

      procedure SubscribeOnEvents(EventBus: IEventBus);
 
    private

      function CreateApplicationForAuthentificatedUser(
        UserAccount: TUserRoleAccount;
        ClientServiceAuthentificationData: TClientServiceAuthentificationData
      ): IFuelCharacteristicsAccountingApplication;
      
      procedure ConfigureSystemAuthentificationFormControllers(
        Application: IFuelCharacteristicsAccountingApplication
      );

      procedure ConfigureApplicationFormControllers(
        Application: IFuelCharacteristicsAccountingApplication
      );

      procedure RunApplicationFormControllers;

      procedure RunSystemAuthentificationFormControllers;
      
    public

      procedure Handle(Event: TEvent);
      procedure HandleClientAuthentificatedEvent(
        Event: TClientAuthentificatedEvent
      );

      function GetSelf: TObject;
    
    public

      destructor Destroy; override;

      constructor Create(
        ApplicationBuilder: TFuelCharacteristicsAccountingApplicationBuilder;
        EventBus: IEventBus
      );

      procedure Configure;

    public

      property OnApplicationMainFormChangeRequestedEventHandler:
        TOnApplicationMainFormChangeRequestedEventHandler
      read FOnApplicationMainFormChangeRequestedEventHandler
      write FOnApplicationMainFormChangeRequestedEventHandler;
      
  end;

implementation

uses

  FuelCharacteristicsAccountingDomainBuildingOptions;
  
{ TPresentationConfigurator }

procedure TPresentationConfigurator.Configure;
var Application: IFuelCharacteristicsAccountingApplication;
begin

  Application :=
    FApplicationBuilder
      .UseBasedOnZeosPostgresRoleAuthentificationServiceOnly
      .BuildFuelCharacteristicsAccountingApplication;

  Forms.Application.Title := 'Учёт показателей топлива';
  
  ConfigureSystemAuthentificationFormControllers(Application);

  RunSystemAuthentificationFormControllers;

end;

procedure TPresentationConfigurator.
  ConfigureApplicationFormControllers(
    Application: IFuelCharacteristicsAccountingApplication
  );
begin

  FFuelCharacteristicsAccountingFormControllersConfigurator
    .Configure(Application);

  FReservoirKindFormControllersConfigurator.Configure(Application);
  
  FEmployeeFormControllersConfigurator.Configure(Application);

end;

procedure TPresentationConfigurator.
  ConfigureSystemAuthentificationFormControllers(
    Application: IFuelCharacteristicsAccountingApplication
  );
begin

  FSystemAuthentificationFormControllersConfigurator.Configure(Application);
  
end;

constructor TPresentationConfigurator.Create(
  ApplicationBuilder: TFuelCharacteristicsAccountingApplicationBuilder;
  EventBus: IEventBus
);
begin

  inherited Create;

  FEventBus := EventBus;
  FApplicationBuilder := ApplicationBuilder;
  FFreeApplicationBuilder := FApplicationBuilder;
  
  FEmployeeFormControllersConfigurator :=
    TEmployeeFormControllersConfigurator.Create(FEventBus);

  FFuelCharacteristicsAccountingFormControllersConfigurator :=
    TFuelCharacteristicsAccountingFormControllersConfigurator.Create(FEventBus);

  FSystemAuthentificationFormControllersConfigurator :=
    TSystemAuthentificationFormControllersConfigurator.Create(FEventBus);

  FReservoirKindFormControllersConfigurator :=
    TReservoirKindFormControllersConfigurator.Create(FEventBus);

  SubscribeOnEvents(FEventBus);
  
end;

function TPresentationConfigurator.CreateApplicationForAuthentificatedUser(
  UserAccount: TUserRoleAccount;
  ClientServiceAuthentificationData: TClientServiceAuthentificationData
): IFuelCharacteristicsAccountingApplication;
var

    DomainBuildingOptions:
      IFuelCharacteristicsAccountingDomainBuildingOptions;

    UseReservoirCalibrationChartElectronicFileOption:
      IFuelCharacteristicsAccountingDomainBuildingOption;
begin

  UseReservoirCalibrationChartElectronicFileOption :=
    TUseReservoirCalibrationChartElectronicFileRegistryOption.Create;
    
  DomainBuildingOptions :=
    TFuelCharacteristicsAccountingDomainBuildingOptions.Create;

  DomainBuildingOptions.Add(UseReservoirCalibrationChartElectronicFileOption);
  
  Result :=
    FApplicationBuilder
      .Clear
      .UseZeosPostgresConnection(
        ClientServiceAuthentificationData
        as TUserDatabaseServerAuthentificationData
      )
      .UseBasedOnZeosPostgresDefaultRepositoryRegistry
      .UseStandardDomain(DomainBuildingOptions)
      .UseBasedOnZeosPostgresDefaultPresentationServices
      .UseStandardBusinessServices
      .UseBasedOnZeosPostgresRoleDefaultAuthentificationService
      .UseBasedOnZeosPostgresRoleDefaultLogOnInfoService
      .UseStandardSystemServices
      .BuildFuelCharacteristicsAccountingApplication;

  Result.UserRoleAccount := UserAccount;
  
end;

destructor TPresentationConfigurator.Destroy;
begin

  FreeAndNil(FSystemAuthentificationFormControllersConfigurator);
  FreeAndNil(FEmployeeFormControllersConfigurator);
  FreeAndNil(FFuelCharacteristicsAccountingFormControllersConfigurator);
  FreeAndNil(FReservoirKindFormControllersConfigurator);
  
  inherited;

end;

function TPresentationConfigurator.GetSelf: TObject;
begin

  Result := Self;

end;

procedure TPresentationConfigurator.Handle(Event: TEvent);
begin

  if not (Event is TClientAuthentificatedEvent) then
    Exit;

  HandleClientAuthentificatedEvent(Event as TClientAuthentificatedEvent);

end;                           

procedure TPresentationConfigurator.HandleClientAuthentificatedEvent(
  Event: TClientAuthentificatedEvent);
var Application: IFuelCharacteristicsAccountingApplication;
begin

  try

    Screen.Cursor := crHourGlass;
    
    Application :=
      CreateApplicationForAuthentificatedUser(
        Event.ClientAccount as TUserRoleAccount,
        Event.ClientServiceAuthentificationData
      );

    ConfigureApplicationFormControllers(Application);

  finally

    Screen.Cursor := crDefault;

  end;

  RunApplicationFormControllers;

end;

procedure TPresentationConfigurator.RunApplicationFormControllers;
var ApplicationMainForm: TForm;
begin

  if not Assigned(FOnApplicationMainFormChangeRequestedEventHandler) then
    Exit;

  ApplicationMainForm :=
    FFuelCharacteristicsAccountingFormControllersConfigurator
      .EntryFormController
        .CreateForm(Application);

  FOnApplicationMainFormChangeRequestedEventHandler(
    Self, ApplicationMainForm
  );

end;

procedure TPresentationConfigurator.RunSystemAuthentificationFormControllers;
var SystemAuthentificationForm: TForm;
begin

  if not Assigned(FOnApplicationMainFormChangeRequestedEventHandler) then
    Exit;

  SystemAuthentificationForm :=
    FSystemAuthentificationFormControllersConfigurator
      .EntryFormController
        .CreateForm(Application);

  FOnApplicationMainFormChangeRequestedEventHandler(
    Self, SystemAuthentificationForm
  );

end;

procedure TPresentationConfigurator.SubscribeOnEvents(EventBus: IEventBus);
begin

  EventBus.RegisterEventHandler(TClientAuthentificatedEvent, Self);
  
end;

end.
