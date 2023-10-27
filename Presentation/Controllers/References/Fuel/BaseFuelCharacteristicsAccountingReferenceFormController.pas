unit BaseFuelCharacteristicsAccountingReferenceFormController;

interface

uses

  AbstractFormController,
  EventBus,
  Event,
  Forms,
  Controls,
  EventHandler,
  Disposable,
  ReferenceFormViewModel,
  AbstractReferenceFormController,
  unFuelCharacteristicsAccountingReferenceForm,
  FuelCharacteristicsAccountingMainFormControllerEvents,
  FuelCharacteristicsAccountingReferenceRecordViewModel,
  FuelCharacteristicsAccountingReferenceFormViewModel,
  AbstractCardFormControllerEvents,
  AbstractReferenceFormControllerEvents,
  FuelCharacteristicsAccountingReferenceDataSetHolder,
  FuelCharacteristicsAccountingReferenceRecordViewModelMapper,
  ReferenceFormRecordViewModel,
  SysUtils,
  Classes;

type

  TBaseFuelCharacteristicsAccountingReferenceFormController =
    class (TAbstractReferenceFormController)

      protected

        function GetFormClass: TFormClass; override;

      protected

        procedure SubscribeOnEvents(EventBus: IEventBus); override;
        
      protected

        procedure OnFuelCharacteristicsAccountingMainFormCreatedEventHandler(
          FuelCharacteristicsAccountingMainFormCreatedEvent:
            TFuelCharacteristicsAccountingMainFormCreatedEvent
        ); virtual;

        procedure InflateFuelCharacteristicsAccoutingReferenceFormToOtherForm(
          FuelCharacteristicsAccountingReferenceForm:
            TFuelCharacteristicsAccountingReferenceForm;
          OtherForm: TForm
        );

      protected

        function GetCurrentForm: TFuelCharacteristicsAccountingReferenceForm;

      protected

        function GetCardCreatedEventClass: TCardCreatedEventClass; override;
        function GetCardModifiedEventClass: TCardModifiedEventClass; override;
        function GetCardRemovedEventClass: TCardRemovedEventClass; override;

      protected

        function GetAddingReferenceRecordRequestedEventClass: TAddingReferenceRecordRequestedEventClass; override;
        function GetChangingReferenceRecordRequestedEventClass: TChangingReferenceRecordRequestedEventClass; override;
        function GetRemovingReferenceRecordRequestedEventClass: TRemovingReferenceRecordRequestedEventClass; override;

      protected

        function GetReferenceRecordChooseRequestedEventClass:
          TReferenceRecordChooseRequestedEventClass; override;

        function GetReferenceRecordChoosenEventClass:
          TReferenceRecordChoosenEventClass; override;

      public

        procedure Handle(Event: TEvent); override;
        
      public

        property CurrentForm: TFuelCharacteristicsAccountingReferenceForm
        read GetCurrentForm;

    end;

implementation

uses

  AbstractDataSetHolder,
  AuxWindowsFunctionsUnit,
  BaseFuelCharacteristicsCalculationCardFormControllerEvents,
  BaseFuelCharacteristicsAccountingReferenceFormControllerEvents,
  TestDataSetModule;

{ TBaseFuelCharacteristicsAccountingReferenceFormController }

function TBaseFuelCharacteristicsAccountingReferenceFormController.GetAddingReferenceRecordRequestedEventClass: TAddingReferenceRecordRequestedEventClass;
begin

  Result := TAddingFuelCharacteristicsAccountingReferenceRecordRequestedEvent;
  
end;

function TBaseFuelCharacteristicsAccountingReferenceFormController.GetCardCreatedEventClass: TCardCreatedEventClass;
begin

  Result := TFuelCharacteristicsCalculationCardCreatedEvent;
  
end;

function TBaseFuelCharacteristicsAccountingReferenceFormController.GetCardModifiedEventClass: TCardModifiedEventClass;
begin

  Result := TFuelCharacteristicsCalculationCardModifiedEvent;
  
end;

function TBaseFuelCharacteristicsAccountingReferenceFormController.GetCardRemovedEventClass: TCardRemovedEventClass;
begin

  Result := TFuelCharacteristicsCalculationCardRemovedEvent;
  
end;

function TBaseFuelCharacteristicsAccountingReferenceFormController.GetChangingReferenceRecordRequestedEventClass: TChangingReferenceRecordRequestedEventClass;
begin

  Result := TChangingFuelCharacteristicsAccountingReferenceRecordRequestedEvent;
  
end;

function TBaseFuelCharacteristicsAccountingReferenceFormController.GetCurrentForm: TFuelCharacteristicsAccountingReferenceForm;
begin

  Result := TFuelCharacteristicsAccountingReferenceForm(inherited CurrentForm);

end;

function TBaseFuelCharacteristicsAccountingReferenceFormController.GetFormClass: TFormClass;
begin

  Result := TFuelCharacteristicsAccountingReferenceForm;

end;

function TBaseFuelCharacteristicsAccountingReferenceFormController.
  GetReferenceRecordChoosenEventClass: TReferenceRecordChoosenEventClass;
begin

  Result := TFuelCharacteristicsAccountingReferenceRecordChoosenEvent;

end;

function TBaseFuelCharacteristicsAccountingReferenceFormController.
  GetReferenceRecordChooseRequestedEventClass:
    TReferenceRecordChooseRequestedEventClass;
begin

  Result := TFuelCharacteristicsAccountingReferenceRecordChooseRequestedEvent;
  
end;

function TBaseFuelCharacteristicsAccountingReferenceFormController.GetRemovingReferenceRecordRequestedEventClass: TRemovingReferenceRecordRequestedEventClass;
begin

  Result := TRemovingFuelCharacteristicsAccountingReferenceRecordRequestedEvent;
  
end;

procedure TBaseFuelCharacteristicsAccountingReferenceFormController.Handle(
  Event: TEvent);
begin

  if Event is TFuelCharacteristicsAccountingMainFormCreatedEvent then begin

    OnFuelCharacteristicsAccountingMainFormCreatedEventHandler(
      Event as TFuelCharacteristicsAccountingMainFormCreatedEvent
    );

  end

  else inherited;
  
end;

procedure TBaseFuelCharacteristicsAccountingReferenceFormController.
  OnFuelCharacteristicsAccountingMainFormCreatedEventHandler(
    FuelCharacteristicsAccountingMainFormCreatedEvent:
      TFuelCharacteristicsAccountingMainFormCreatedEvent
  );
var FuelCharacteristicsAccountingMainForm: TForm;
    FuelCharacteristicsAccountingReferenceForm: TFuelCharacteristicsAccountingReferenceForm;
begin

  FuelCharacteristicsAccountingMainForm :=
    FuelCharacteristicsAccountingMainFormCreatedEvent.
      FuelCharacteristicsAccountingMainForm;

  FuelCharacteristicsAccountingReferenceForm :=
    CreateForm(TFormData.Create(FuelCharacteristicsAccountingMainForm))
    as TFuelCharacteristicsAccountingReferenceForm;

  FuelCharacteristicsAccountingReferenceForm.DeleteOnClose := True;

  InflateFuelCharacteristicsAccoutingReferenceFormToOtherForm(
    FuelCharacteristicsAccountingReferenceForm,
    FuelCharacteristicsAccountingMainForm
  );

end;

procedure TBaseFuelCharacteristicsAccountingReferenceFormController.SubscribeOnEvents(
  EventBus: IEventBus);
begin

  inherited;

  EventBus.RegisterEventHandler(
    TFuelCharacteristicsAccountingMainFormCreatedEvent, Self
  );
  
end;

procedure TBaseFuelCharacteristicsAccountingReferenceFormController.
  InflateFuelCharacteristicsAccoutingReferenceFormToOtherForm(
    FuelCharacteristicsAccountingReferenceForm: TFuelCharacteristicsAccountingReferenceForm;
    OtherForm: TForm
  );
begin

  FuelCharacteristicsAccountingReferenceForm.Parent := OtherForm;
  FuelCharacteristicsAccountingReferenceForm.Align := alClient;
  FuelCharacteristicsAccountingReferenceForm.BorderStyle := bsNone;

  FuelCharacteristicsAccountingReferenceForm.Show;

end;

end.
