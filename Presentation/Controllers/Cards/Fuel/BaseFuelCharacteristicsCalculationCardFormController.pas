unit BaseFuelCharacteristicsCalculationCardFormController;

interface

uses

  AbstractFormController,
  EventBus,
  Event,
  Controls,
  AbstractCardFormController,
  CardFormViewModel,
  AbstractReferenceFormControllerEvents,
  unFuelCharacteristicsCalculationCardForm,
  BaseEmployeesReferenceFormControllerEvents,
  FuelCharacteristicsCalculationCardFormViewModel,
  AbstractCardFormControllerEvents,
  FuelCharacteristicsAccountingReferenceRecordViewModel,
  FuelCharacteristicsAutomaticCalculationFormControllerEvents,
  FuelCharacteristicsAutomaticCalculationFormViewModel,
  EventHandler,
  Disposable,
  Forms,
  SysUtils,
  Classes;

type

  TBaseFuelCharacteristicsCalculationCardFormController =
    class (TAbstractCardFormController)

      protected

        procedure SubscribeOnEvents(EventBus: IEventBus); override;

        procedure HandleEmployeeChoosenEvent(
          Event: TEmployeeChoosenEvent
        ); virtual;

        procedure HandleCalculatedFuelCharacteristicsApplyingRequestedEvent(
          Event: TCalculatedFuelCharacteristicsApplyingRequestedEvent
        ); virtual;
        
      protected

        procedure SubscribeOnFormEvents(Form: TForm); override;

        function GetFormClass: TFormClass; override;

        procedure CustomizeForm(Form: TForm; FormData: TFormData); override;
        
      protected

        procedure OnFuelCharacteristicsCalculationRequestedEventHandler(
          Sender: TObject;
          var ViewModel: TFuelCharacteristicsCalculationCardFormViewModel;
          var Success: Boolean
        ); virtual;

        procedure OnPerformedCalculationEmployeeChooseRequestedEventHandler(
          Sender: TObject;
          var CurrentPerformerId: Variant;
          var CurrentPerformerName: String;
          var ChangeCurrentPerformerInfo: Boolean
        ); virtual;

      protected

        function GetCardCreatedEventClass: TCardCreatedEventClass; override;
        function GetCardModifiedEventClass: TCardModifiedEventClass; override;
        function GetCardRemovedEventClass: TCardRemovedEventClass; override;

      protected

        function GetAddingReferenceRecordRequestedEventClass: TAddingReferenceRecordRequestedEventClass; override;
        function GetChangingReferenceRecordRequestedEventClass: TChangingReferenceRecordRequestedEventClass; override;
        function GetRemovingReferenceRecordRequestedEventClass: TRemovingReferenceRecordRequestedEventClass; override;

      public

        procedure Handle(Event: TEvent); override;
        
    end;

implementation

uses

  AuxWindowsFunctionsUnit,
  BaseFuelCharacteristicsCalculationCardFormControllerEvents,
  BaseFuelCharacteristicsAccountingReferenceFormControllerEvents,
  Variants;

{ TBaseFuelCharacteristicsCalculationCardFormController }

procedure TBaseFuelCharacteristicsCalculationCardFormController.CustomizeForm(
  Form: TForm; FormData: TFormData);
var ViewModel: TCardFormViewModel;
begin

  inherited;

  ViewModel := (FormData as TCardFormData).ViewModel;

  if VarIsNull(ViewModel.Id.Value) then
    Form.Caption := 'Карточка для нового расчёта параметров топлива'

  else Form.Caption := 'Карточка расчёта параметров топлива';

end;

function TBaseFuelCharacteristicsCalculationCardFormController.GetAddingReferenceRecordRequestedEventClass: TAddingReferenceRecordRequestedEventClass;
begin

  Result := TAddingFuelCharacteristicsAccountingReferenceRecordRequestedEvent;
  
end;

function TBaseFuelCharacteristicsCalculationCardFormController.GetCardCreatedEventClass: TCardCreatedEventClass;
begin

  Result := TFuelCharacteristicsCalculationCardCreatedEvent;
  
end;

function TBaseFuelCharacteristicsCalculationCardFormController.GetCardModifiedEventClass: TCardModifiedEventClass;
begin

  Result := TFuelCharacteristicsCalculationCardModifiedEvent;
  
end;

function TBaseFuelCharacteristicsCalculationCardFormController.GetCardRemovedEventClass: TCardRemovedEventClass;
begin

  Result := TFuelCharacteristicsCalculationCardRemovedEvent;
  
end;

function TBaseFuelCharacteristicsCalculationCardFormController.GetChangingReferenceRecordRequestedEventClass: TChangingReferenceRecordRequestedEventClass;
begin

  Result := TChangingFuelCharacteristicsAccountingReferenceRecordRequestedEvent;
  
end;

function TBaseFuelCharacteristicsCalculationCardFormController.GetFormClass: TFormClass;
begin

  Result := TFuelCharacteristicsCalculationCardForm;
  
end;

function TBaseFuelCharacteristicsCalculationCardFormController.GetRemovingReferenceRecordRequestedEventClass: TRemovingReferenceRecordRequestedEventClass;
begin

  Result := TRemovingFuelCharacteristicsAccountingReferenceRecordRequestedEvent;
  
end;

procedure TBaseFuelCharacteristicsCalculationCardFormController.Handle(
  Event: TEvent);
begin

  if Event is TEmployeeChoosenEvent then begin

    HandleEmployeeChoosenEvent(TEmployeeChoosenEvent(Event));

  end

  else if Event is TCalculatedFuelCharacteristicsApplyingRequestedEvent then
  begin

    HandleCalculatedFuelCharacteristicsApplyingRequestedEvent(
      TCalculatedFuelCharacteristicsApplyingRequestedEvent(Event)
    );

  end

  else inherited;

end;

procedure TBaseFuelCharacteristicsCalculationCardFormController.
  HandleCalculatedFuelCharacteristicsApplyingRequestedEvent(
    Event: TCalculatedFuelCharacteristicsApplyingRequestedEvent
  );
var

  FuelCharacteristicsAutomaticCalculationFormViewModel:
    TFuelCharacteristicsAutomaticCalculationFormViewModel;
begin

  if not Assigned(CurrentForm) then
    Exit;
    
  FuelCharacteristicsAutomaticCalculationFormViewModel :=
    Event.FuelCharacteristicsAutomaticCalculationFormViewModel;

  with TFuelCharacteristicsCalculationCardForm(CurrentForm).ViewModel
  do begin

    FuelRiseLevel.Value :=
      FuelCharacteristicsAutomaticCalculationFormViewModel.FuelRiseLevel.Value;

    FuelTemperature.Value :=
      FuelCharacteristicsAutomaticCalculationFormViewModel.FuelTemperature.Value;

    FuelDensity.Value :=
      FuelCharacteristicsAutomaticCalculationFormViewModel.FuelDensity.Value;

    FuelMass.Value :=
      FuelCharacteristicsAutomaticCalculationFormViewModel.FuelMass.Value;
      
  end;

end;

procedure TBaseFuelCharacteristicsCalculationCardFormController.
  HandleEmployeeChoosenEvent(Event: TEmployeeChoosenEvent);
begin

  if not Assigned(CurrentForm) then Exit;

  with TFuelCharacteristicsCalculationCardForm(CurrentForm) do begin

    PerformedCalculationEmployeeId := Event.EmployeeRecordViewModel.Id;

    PerformedCalculationEmployeeName :=
      Event.EmployeeRecordViewModel.Surname + ' ' +
      Event.EmployeeRecordViewModel.Name + ' ' +
      Event.EmployeeRecordViewModel.Patronymic;
      
  end;
  
end;

procedure TBaseFuelCharacteristicsCalculationCardFormController.
  OnFuelCharacteristicsCalculationRequestedEventHandler(
    Sender: TObject;
    var ViewModel: TFuelCharacteristicsCalculationCardFormViewModel;
    var Success: Boolean
  );
var AutomaticCalculationRequestedEvent:
      TFuelCharacteristicsAutomaticCalculationRequestedEvent;
begin

  AutomaticCalculationRequestedEvent :=
    TFuelCharacteristicsAutomaticCalculationRequestedEvent.Create(ViewModel);

  try

    EventBus.RaiseEvent(AutomaticCalculationRequestedEvent);

    Success := False;
    
  finally

    FreeAndNil(AutomaticCalculationRequestedEvent);

  end;

end;

procedure TBaseFuelCharacteristicsCalculationCardFormController.
  OnPerformedCalculationEmployeeChooseRequestedEventHandler(
    Sender: TObject;
    var CurrentPerformerId: Variant;
    var CurrentPerformerName: String;
    var ChangeCurrentPerformerInfo: Boolean
  );
var EmployeeChooseRequestedEvent: TEmployeeChooseRequestedEvent;
begin

  EmployeeChooseRequestedEvent :=
    TEmployeeChooseRequestedEvent.Create(CurrentPerformerId);

  try

    EventBus.RaiseEvent(EmployeeChooseRequestedEvent);

    ChangeCurrentPerformerInfo := False;
    
  finally

    FreeAndNil(EmployeeChooseRequestedEvent);
    
  end;

end;

procedure TBaseFuelCharacteristicsCalculationCardFormController.SubscribeOnEvents(
  EventBus: IEventBus);
begin

  inherited;

  EventBus.RegisterEventHandler(TEmployeeChoosenEvent, Self);
  EventBus.RegisterEventHandler(TCalculatedFuelCharacteristicsApplyingRequestedEvent, Self);

end;

procedure TBaseFuelCharacteristicsCalculationCardFormController.
  SubscribeOnFormEvents(Form: TForm);
begin

  inherited;

  with Form as TFuelCharacteristicsCalculationCardForm do begin

    OnFuelCharacteristicsCalculationRequestedEventHandler :=
      Self.OnFuelCharacteristicsCalculationRequestedEventHandler;

    OnPerformedCalculationEmployeeChooseRequestedEventHandler :=
      Self.OnPerformedCalculationEmployeeChooseRequestedEventHandler;
      
  end;
  
end;

end.
