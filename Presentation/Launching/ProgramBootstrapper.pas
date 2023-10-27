unit ProgramBootstrapper;

interface

uses

  PresentationLauncher,
  PresentationConfigurator,
  FuelCharacteristicsAccountingApplicationBuilder,
  SimpleEventBus,
  SysUtils,
  Classes;

type

  TProgramBootstrapper = class

    private

    public

      procedure Start;

  end;

implementation

uses

  GlobalErrorHandler,
  EventHandler;
  
{ TProgramBootstrapper }

procedure TProgramBootstrapper.Start;
var PresentationLauncher: TPresentationLauncher;
    PresentationConfigurator: TPresentationConfigurator;
    FreePresentationConfigurator: IEventHandler;
begin

  TGlobalErrorHandler.Current.Activate;
  
  PresentationConfigurator :=
    TPresentationConfigurator.Create(
      TFuelCharacteristicsAccountingApplicationBuilder.Create,
      TSimpleEventBus.Create
    );

  FreePresentationConfigurator := PresentationConfigurator;
      
  PresentationLauncher :=
    TPresentationLauncher.Create(PresentationConfigurator);

  try

    PresentationLauncher.Launch;

  finally

    FreeAndNil(PresentationLauncher);

  end;

end;

end.
