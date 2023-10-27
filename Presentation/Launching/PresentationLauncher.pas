unit PresentationLauncher;

interface

uses

  Forms,
  PresentationConfigurator,
  SysUtils,
  Classes;

type

  TPresentationLauncher = class

    private

      FPresentationConfigurator: TPresentationConfigurator;

      procedure Initialize;
      procedure Configure;
      procedure Run;

    private

      procedure OnApplicationMainFormChangeRequestedEventHandler(
        Sender: TObject;
        ApplicationMainForm: TForm
      );

    public

      destructor Destroy; override;

      constructor Create(PresentationConfigurator: TPresentationConfigurator);

      procedure Launch;

  end;

implementation

uses

  Controls,
  AbstractFormController,
  AuxWindowsFunctionsUnit,
  BaseFuelCharacteristicsAccountingMainFormController;

{ TPresentationLauncher }

procedure TPresentationLauncher.Configure;
begin

  FPresentationConfigurator.Configure;

end;

constructor TPresentationLauncher.Create(
  PresentationConfigurator: TPresentationConfigurator);
begin

  inherited Create;

  FPresentationConfigurator := PresentationConfigurator;

  FPresentationConfigurator.OnApplicationMainFormChangeRequestedEventHandler :=
    OnApplicationMainFormChangeRequestedEventHandler;
    
end;

destructor TPresentationLauncher.Destroy;
begin

  inherited;

end;

procedure TPresentationLauncher.Initialize;
begin

  Application.Initialize;

end;

procedure TPresentationLauncher.Launch;
begin

  try

    Initialize;
    Configure;
    Run;

  except

    on e: Exception do begin

      ShowErrorMessage(Application.Handle, e.Message, 'Ошибка');

      Application.Terminate;

    end;

  end;

end;

procedure TPresentationLauncher.
  OnApplicationMainFormChangeRequestedEventHandler(
    Sender: TObject;
    ApplicationMainForm: TForm
  );
begin

  Application.MainFormOnTaskBar := False;

  Pointer((@Application.MainForm)^) := ApplicationMainForm;

  ApplicationMainForm.Show;
  
  Application.MainFormOnTaskBar := True;
  
end;

procedure TPresentationLauncher.Run;
var ApplicationMainFormController: TAbstractFormController;
    ApplicationMainForm: TForm;
begin

  Application.Run;
  
end;

end.
