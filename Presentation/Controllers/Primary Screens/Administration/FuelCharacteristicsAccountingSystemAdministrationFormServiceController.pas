unit FuelCharacteristicsAccountingSystemAdministrationFormServiceController;

interface

uses

  BaseSystemAdministrationFormController,
  unFuelCharacteristicsAccountingAdministrationForm,
  FuelCharacteristicsAccountingMainFormControllerEvents,
  Forms,
  AbstractFormController,
  EventBus,
  Event,
  SysUtils,
  Classes;


type

  TFuelCharacteristicsAccountingSystemAdministrationFormServiceController =
    class (TBaseSystemAdministrationFormController)

      protected

        function GetFormClass: TFormClass; override;

        procedure CustomizeForm(Form: TForm; FormData: TFormData); override;
        
      protected

        procedure SubscribeOnEvents(EventBus: IEventBus); override;

      protected

        procedure OnFuelCharacteristicsAccountingAdministrationFormRequestedEventHandler(
          Event: TFuelCharacteristicsAccountingAdministrationFormRequestedEvent
        );

      public

        procedure Handle(Event: TEvent); override;
        
    end;
  
implementation

uses

  AuxWindowsFunctionsUnit;
  
{ TFuelCharacteristicsAccountingSystemAdministrationFormServiceController }

procedure TFuelCharacteristicsAccountingSystemAdministrationFormServiceController.CustomizeForm(
  Form: TForm; FormData: TFormData);
begin

  inherited;

  SetControlSizeByRatio(Form, Screen.Width, Screen.Height, 6 / 7, 6 / 7);
  
end;

function TFuelCharacteristicsAccountingSystemAdministrationFormServiceController.GetFormClass: TFormClass;
begin

  Result := TFuelCharacteristicsAccountingAdministrationForm;
  
end;

procedure TFuelCharacteristicsAccountingSystemAdministrationFormServiceController.Handle(
  Event: TEvent);
begin

  if Event is TFuelCharacteristicsAccountingAdministrationFormRequestedEvent
  then begin

    OnFuelCharacteristicsAccountingAdministrationFormRequestedEventHandler(
      Event as TFuelCharacteristicsAccountingAdministrationFormRequestedEvent
    );
    
  end

  else inherited;

end;

procedure TFuelCharacteristicsAccountingSystemAdministrationFormServiceController.
  OnFuelCharacteristicsAccountingAdministrationFormRequestedEventHandler(
    Event: TFuelCharacteristicsAccountingAdministrationFormRequestedEvent
  );
begin

  ShowFormAsModal(TFormData.Create(Application));

end;

procedure TFuelCharacteristicsAccountingSystemAdministrationFormServiceController.SubscribeOnEvents(
  EventBus: IEventBus);
begin

  inherited;

  EventBus.RegisterEventHandler(
    TFuelCharacteristicsAccountingAdministrationFormRequestedEvent,
    Self
  );
  
end;

end.
