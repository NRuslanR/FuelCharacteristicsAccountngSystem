unit BaseReservoirKindsFormController;

interface

uses

  AbstractReferenceFormController,
  EventHandler,
  ReferenceFormViewModel,
  ReferenceFormViewModelMapper,
  ReferenceFormRecordViewModel,
  ReferenceFormRecordViewModelMapper,
  ReservoirKindsFormViewModel,
  ReservoirKindRecordViewModel,
  AbstractCardFormControllerEvents,
  AbstractReferenceFormControllerEvents,
  ReservoirKindsFormControllerEvents,
  unReservoirKindsForm,
  unReferenceForm,
  Event,
  Controls,
  EventBus,
  Forms,
  SysUtils,
  Classes;

type

  TBaseReservoirKindsFormController = class (TAbstractReferenceFormController)

    protected

      function GetFormClass: TFormClass; override;

    protected

      procedure SubscribeOnEvents(EventBus: IEventBus); override;

    protected

      procedure SubscribeOnCardStateChangesEvents; override;

      procedure SubscribeOnReferenceFormRecordsEvents(
        ReferenceForm: TReferenceForm
      ); override;

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
      
  end;
  

implementation

{ TBaseReservoirKindsFormController }

function TBaseReservoirKindsFormController.
  GetAddingReferenceRecordRequestedEventClass:
    TAddingReferenceRecordRequestedEventClass;
begin

  raise Exception.Create(
    'TBaseReservoirKindsFormController.' +
    'GetAddingReferenceRecordRequestedEventClass not implemented'
  );
  
end;

function TBaseReservoirKindsFormController.
  GetCardCreatedEventClass: TCardCreatedEventClass;
begin

  raise Exception.Create(
    'TBaseReservoirKindsFormController.' +
    'GetCardCreatedEventClass not implemented'
  );

end;

function TBaseReservoirKindsFormController.
  GetCardModifiedEventClass: TCardModifiedEventClass;
begin

  raise Exception.Create(
    'TBaseReservoirKindsFormController.' +
    'GetCardModifiedEventClass not implemented'
  );
  
end;

function TBaseReservoirKindsFormController.
  GetCardRemovedEventClass: TCardRemovedEventClass;
begin

  raise Exception.Create(
    'TBaseReservoirKindsFormController.' +
    'GetCardRemovedEventClass not implemented'
  );
  
end;

function TBaseReservoirKindsFormController.
  GetChangingReferenceRecordRequestedEventClass:
    TChangingReferenceRecordRequestedEventClass;
begin

  raise Exception.Create(
    'TBaseReservoirKindsFormController.' +
    'GetChangingReferenceRecordRequestedEventClass not implemented'
  );
  
end;

function TBaseReservoirKindsFormController.GetFormClass: TFormClass;
begin

  Result := TReservoirKindsForm;
  
end;

function TBaseReservoirKindsFormController.
  GetReferenceRecordChoosenEventClass: TReferenceRecordChoosenEventClass;
begin

  Result := TReservoirKindChoosenEvent;

end;

function TBaseReservoirKindsFormController.
  GetReferenceRecordChooseRequestedEventClass:
    TReferenceRecordChooseRequestedEventClass;
begin

  Result := TReservoirKindChooseRequestedEvent;
  
end;

function TBaseReservoirKindsFormController.
  GetRemovingReferenceRecordRequestedEventClass:
    TRemovingReferenceRecordRequestedEventClass;
begin

  raise Exception.Create(
    'TBaseReservoirKindsFormController.' +
    'GetRemovingReferenceRecordRequestedEventClass not implemented'
  );

end;

procedure TBaseReservoirKindsFormController.Handle(Event: TEvent);
begin

  if Event is TReservoirKindChooseRequestedEvent then begin

    HandleReferenceRecordChooseRequestedEvent(
      TReservoirKindChooseRequestedEvent(Event)
    );

  end

  //else inherited;

end;

procedure TBaseReservoirKindsFormController.SubscribeOnCardStateChangesEvents;
begin

end;

procedure TBaseReservoirKindsFormController.SubscribeOnEvents(
  EventBus: IEventBus);
begin

  inherited;

  EventBus.RegisterEventHandler(TReservoirKindChooseRequestedEvent, Self);
  
end;

procedure TBaseReservoirKindsFormController.SubscribeOnReferenceFormRecordsEvents(
  ReferenceForm: TReferenceForm);
begin

  ReferenceForm.OnRecordsRefreshRequestedEventHandler :=
    OnRecordsRefreshRequestedEventHandler;

end;

end.
