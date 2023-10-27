unit BaseFuelCharacteristicsAutomaticCalculationFormController;

interface

uses

  AbstractFormController,
  unFuelCharacteristicsAutomaticCalculationForm,
  FuelCharacteristicsAutomaticCalculationFormViewModel,
  FuelCharacteristicsAutomaticCalculationFormControllerEvents,
  ReservoirKindsFormControllerEvents,
  FuelCharacteristicsCalculationCardFormViewModel,
  EventBus,
  CardFormViewModel,
  Forms,
  Controls,
  Event,
  EventHandler,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAutomaticCalculationFormData = class (TFormData)

    public

      FuelCharacteristicsCalculationCardFormViewModel:
        TFuelCharacteristicsCalculationCardFormViewModel;

      constructor Create(
      
        FuelCharacteristicsCalculationCardFormViewModel:
          TFuelCharacteristicsCalculationCardFormViewModel;

        Owner: TComponent;
        Parent: TWinControl = nil
      );

  end;

  TBaseFuelCharacteristicsAutomaticCalculationFormController =
    class (TAbstractFormController, IEventHandler)

      protected

        function GetFormClass: TFormClass; override;

      protected

        procedure SubscribeOnFormEvents(Form: TForm); override;

        procedure CustomizeForm(Form: TForm; FormData: TFormData); override;
        
        procedure OnFuelCharacteristicsAutomaticCalculationRequestedEventHandler(
          Sender: TObject;
          var ViewModel: TFuelCharacteristicsAutomaticCalculationFormViewModel
        ); virtual; abstract;

        procedure OnReservoirKindNameChooseRequestedEventHandler(
          Sender: TObject;
          var CurrentReservoirKindName: String;
          var ChangeReservoirKindName: Boolean
        ); virtual;

        procedure OnCalculatedFuelCharacteristicsApplyingRequestedEventHandler(
          Sender: TObject;
          var ViewModel: TCardFormViewModel;
          var Success: Boolean
        ); virtual;
        
      protected

        function CreateFormViewModel(FormData: TFormData):
          TFuelCharacteristicsAutomaticCalculationFormViewModel; virtual;
          
      protected

        procedure SubscribeOnEvents(EventBus: IEventBus); override;
        
        procedure HandleFuelCharacteristicsAutomaticCalculationRequestedEvent(
          Event: TFuelCharacteristicsAutomaticCalculationRequestedEvent
        ); virtual;

        procedure HandleReservoirKindChoosenEvent(
          Event: TReservoirKindChoosenEvent
        ); virtual;

      public

        procedure Handle(Event: TEvent);

        function GetSelf: TObject;
        
   end;
    
implementation

{ TBaseFuelCharacteristicsAutomaticCalculationFormController }

function TBaseFuelCharacteristicsAutomaticCalculationFormController.
  CreateFormViewModel(FormData: TFormData):
    TFuelCharacteristicsAutomaticCalculationFormViewModel;
begin

  Result := TFuelCharacteristicsAutomaticCalculationFormViewModel.Create;

  if FormData is TFuelCharacteristicsAutomaticCalculationFormData then begin

    with TFuelCharacteristicsAutomaticCalculationFormData(FormData) do begin

      Result.FuelRiseLevel.Value :=
        FuelCharacteristicsCalculationCardFormViewModel.FuelRiseLevel.Value;

      Result.FuelTemperature.Value :=
        FuelCharacteristicsCalculationCardFormViewModel.FuelTemperature.Value;

      Result.FuelDensity.Value :=
        FuelCharacteristicsCalculationCardFormViewModel.FuelDensity.Value;
        
    end;

  end;

end;

procedure TBaseFuelCharacteristicsAutomaticCalculationFormController.
  CustomizeForm(Form: TForm; FormData: TFormData);
begin

  inherited;

  with Form as TFuelCharacteristicsAutomaticCalculationForm do
    ViewModel := CreateFormViewModel(FormData);

  Form.Caption := 'Расчёт массы топлива';
  
end;

function TBaseFuelCharacteristicsAutomaticCalculationFormController.
  GetFormClass: TFormClass;
begin

  Result := TFuelCharacteristicsAutomaticCalculationForm;
  
end;

function TBaseFuelCharacteristicsAutomaticCalculationFormController.
  GetSelf: TObject;
begin

  Result := Self;
  
end;

procedure TBaseFuelCharacteristicsAutomaticCalculationFormController.Handle(
  Event: TEvent);
begin

  if Event is TFuelCharacteristicsAutomaticCalculationRequestedEvent
  then begin

    HandleFuelCharacteristicsAutomaticCalculationRequestedEvent(
      TFuelCharacteristicsAutomaticCalculationRequestedEvent(Event)
    );

  end

  else if Event is TReservoirKindChoosenEvent then begin

    HandleReservoirKindChoosenEvent(
      TReservoirKindChoosenEvent(Event)
    );

  end

  else inherited;

end;

procedure TBaseFuelCharacteristicsAutomaticCalculationFormController.
  HandleFuelCharacteristicsAutomaticCalculationRequestedEvent(
    Event: TFuelCharacteristicsAutomaticCalculationRequestedEvent
  );
begin

  ShowFormAsModal(
    TFuelCharacteristicsAutomaticCalculationFormData.Create(
      Event.FuelCharacteristicsCalculationCardFormViewModel,
      Application
    )
  );
  
end;

procedure TBaseFuelCharacteristicsAutomaticCalculationFormController.
  HandleReservoirKindChoosenEvent(
    Event: TReservoirKindChoosenEvent
  );
begin

  if not Assigned(CurrentForm) then
    Exit;
  
  with CurrentForm as TFuelCharacteristicsAutomaticCalculationForm
  do begin

    ViewModel.ReservoirKindName.Value :=
      Event.ReservoirKindRecordViewModel.ReservoirKindName;
      
  end;

end;

procedure TBaseFuelCharacteristicsAutomaticCalculationFormController.
  OnCalculatedFuelCharacteristicsApplyingRequestedEventHandler(
    Sender: TObject;
    var ViewModel: TCardFormViewModel;
    var Success: Boolean
  );
var Event: TCalculatedFuelCharacteristicsApplyingRequestedEvent;
begin

  Event :=
    TCalculatedFuelCharacteristicsApplyingRequestedEvent.Create(
      TFuelCharacteristicsAutomaticCalculationFormViewModel(ViewModel)
    );

  try

    EventBus.RaiseEvent(Event);
    
  finally

    FreeAndNil(Event);
    
  end;
  
end;

procedure TBaseFuelCharacteristicsAutomaticCalculationFormController.
  OnReservoirKindNameChooseRequestedEventHandler(
    Sender: TObject;
    var CurrentReservoirKindName: String;
    var ChangeReservoirKindName: Boolean
  );
var ReservoirKindChooseRequestedEvent: TReservoirKindChooseRequestedEvent;
begin

  ReservoirKindChooseRequestedEvent :=
    TReservoirKindChooseRequestedEvent.Create(CurrentReservoirKindName);
    
  try

    EventBus.RaiseEvent(ReservoirKindChooseRequestedEvent);

    ChangeReservoirKindName := False;
    
  finally

    FreeAndNil(ReservoirKindChooseRequestedEvent);
    
  end;

end;

procedure TBaseFuelCharacteristicsAutomaticCalculationFormController.
  SubscribeOnEvents(
    EventBus: IEventBus
  );
begin

  inherited;

  EventBus.RegisterEventHandler(
    TFuelCharacteristicsAutomaticCalculationRequestedEvent, Self
  );

  EventBus.RegisterEventHandler(TReservoirKindChoosenEvent, Self);
  
end;

procedure TBaseFuelCharacteristicsAutomaticCalculationFormController.
  SubscribeOnFormEvents(
    Form: TForm
  );
begin

  inherited;

  with Form as TFuelCharacteristicsAutomaticCalculationForm do begin

    OnFuelCharacteristicsAutomaticCalculationRequestedEventHandler :=
      Self.OnFuelCharacteristicsAutomaticCalculationRequestedEventHandler;

    OnReservoirKindNameChooseRequestedEventHandler :=
      Self.OnReservoirKindNameChooseRequestedEventHandler;

    OnCardChangesApplyingRequestedEventHandler :=
      Self.OnCalculatedFuelCharacteristicsApplyingRequestedEventHandler;
  end;

end;

{ TFuelCharacteristicsAutomaticCalculationFormData }

constructor TFuelCharacteristicsAutomaticCalculationFormData.Create(

  FuelCharacteristicsCalculationCardFormViewModel:
    TFuelCharacteristicsCalculationCardFormViewModel;

  Owner: TComponent;
  Parent: TWinControl

);
begin

  inherited Create(Owner, Parent);

  Self.FuelCharacteristicsCalculationCardFormViewModel :=
    FuelCharacteristicsCalculationCardFormViewModel;
    
end;

end.
