unit BaseFuelCharacteristicsAccountingMainFormController;

interface

uses

  AbstractFormController,
  Forms,
  Dialogs,
  unFuelCharacteristicsAccountingMainForm,
  FuelCharacteristicsAccountingMainFormControllerEvents,
  ReservoirKindReferenceSuitesFormControllerEvents,
  SysUtils,
  Classes;

type

  TBaseFuelCharacteristicsAccountingMainFormController =
    class (TAbstractFormController)

      protected

        procedure SubscribeOnFormEvents(Form: TForm); override;

        function GetFormClass: TFormClass; override;

      protected

        procedure OnExitProgramHandler(Sender: TObject); virtual;
        procedure OnAdministrationHandler(Sender: TObject); virtual;
        procedure OnFontSettingsHandler(Sender: TObject); virtual;
        procedure OnChangeUserAccountHandler(Sender: TObject); virtual;
        procedure OnReservoirKindsReferenceDataHandler(Sender: TObject); virtual;
        
      protected

        procedure OnAfterFormCreated(Form: TForm); override;

      public

        destructor Destroy; override;

    end;

implementation

uses

  SystemAuthentificationFormControllerEvents,
  AuxWindowsFunctionsUnit;

{ TBaseFuelCharacteristicsAccountingMainFormController }

destructor TBaseFuelCharacteristicsAccountingMainFormController.Destroy;
begin

  inherited;

end;

function TBaseFuelCharacteristicsAccountingMainFormController.GetFormClass: TFormClass;
begin

  Result := TFuelCharacteristicsAccountingMainForm;

end;

procedure TBaseFuelCharacteristicsAccountingMainFormController.
  OnAdministrationHandler(
    Sender: TObject
  );
var AdministrationRequestedEvent: TFuelCharacteristicsAccountingAdministrationFormRequestedEvent;
begin

  AdministrationRequestedEvent :=
    TFuelCharacteristicsAccountingAdministrationFormRequestedEvent.Create;

  try

    EventBus.RaiseEvent(AdministrationRequestedEvent);
    
  finally

    FreeAndNil(AdministrationRequestedEvent);

  end;

end;

procedure TBaseFuelCharacteristicsAccountingMainFormController.OnAfterFormCreated(
  Form: TForm);
var FormCreatedEvent: TFuelCharacteristicsAccountingMainFormCreatedEvent;
begin

  FormCreatedEvent :=
    TFuelCharacteristicsAccountingMainFormCreatedEvent.Create(
      Form as TFuelCharacteristicsAccountingMainForm
    );

  try

    EventBus.RaiseEvent(FormCreatedEvent);

  finally

    FreeAndNil(FormCreatedEvent);

  end;

end;

procedure TBaseFuelCharacteristicsAccountingMainFormController.
  OnChangeUserAccountHandler(
    Sender: TObject
  );
var UserAccountChangingRequestedEvent: TLogOnRequestedEvent;
begin

  UserAccountChangingRequestedEvent :=
    TLogOnRequestedEvent.Create;

  try

    EventBus.RaiseEvent(UserAccountChangingRequestedEvent);
    
  finally

    FreeAndNil(UserAccountChangingRequestedEvent);

  end;

end;

procedure TBaseFuelCharacteristicsAccountingMainFormController.OnExitProgramHandler(
  Sender: TObject);
begin

  CurrentForm.Close;

end;

procedure TBaseFuelCharacteristicsAccountingMainFormController.OnFontSettingsHandler(
  Sender: TObject);
begin

  with TFontDialog.Create(CurrentForm) do begin

    try

      Execute;

      CurrentForm.Font := Font;

    finally

      Free;

    end;

  end;

end;

procedure TBaseFuelCharacteristicsAccountingMainFormController.
  OnReservoirKindsReferenceDataHandler(
    Sender: TObject
  );
var ReservoirKindReferenceSuitesReferenceRequestedEvent:
      TReservoirKindReferenceSuitesReferenceRequestedEvent;
begin

  ReservoirKindReferenceSuitesReferenceRequestedEvent :=
    TReservoirKindReferenceSuitesReferenceRequestedEvent.Create;

  try

    EventBus.RaiseEvent(ReservoirKindReferenceSuitesReferenceRequestedEvent);

  finally

    FreeAndNil(ReservoirKindReferenceSuitesReferenceRequestedEvent);

  end;
  
end;

procedure TBaseFuelCharacteristicsAccountingMainFormController.SubscribeOnFormEvents(
  Form: TForm);
begin

  with Form as TFuelCharacteristicsAccountingMainForm do begin

    actExitProgram.OnExecute := OnExitProgramHandler;
    actAdministration.OnExecute := OnAdministrationHandler;
    actFontSettings.OnExecute := OnFontSettingsHandler;
    actChangeUserAccount.OnExecute := OnChangeUserAccountHandler;
    actReservoirKindsReferenceData.OnExecute := OnReservoirKindsReferenceDataHandler;
    
  end;

end;

end.
