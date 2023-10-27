unit BaseReservoirKindReferenceSuitesFormController;

interface

uses

  AbstractReferenceFormController,
  Forms,
  Event,
  EventHandler,
  ReferenceFormViewModel,
  unReservoirKindReferenceSuitesForm,
  ReservoirKindReferenceSuiteRecordViewModel,
  unReferenceForm,
  AbstractCardFormControllerEvents,
  AbstractReferenceFormControllerEvents,
  ReservoirKindReferenceSuitesFormControllerEvents,
  ReservoirKindReferenceSuiteCardFormControllerEvents,
  EventBus,
  SysUtils,
  Classes;

type

  TBaseReservoirKindReferenceSuitesFormController =
    class (TAbstractReferenceFormController, IEventHandler)

      protected

        function GetFormClass: TFormClass; override;
        
        procedure SubscribeOnEvents(EventBus: IEventBus); override;

        procedure HandleReservoirKindReferenceSuitesReferenceRequestedEvent(
          Event: TReservoirKindReferenceSuitesReferenceRequestedEvent
        ); virtual;

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

{ TBaseReservoirKindReferenceSuitesFormController }

function TBaseReservoirKindReferenceSuitesFormController.
  GetAddingReferenceRecordRequestedEventClass:
    TAddingReferenceRecordRequestedEventClass;
begin

  Result := TAddingReservoirKindReferenceSuiteRecordRequestedEvent;
  
end;

function TBaseReservoirKindReferenceSuitesFormController.
  GetCardCreatedEventClass: TCardCreatedEventClass;
begin

  Result := TReservoirKindReferenceSuiteCardCreatedEvent;
  
end;

function TBaseReservoirKindReferenceSuitesFormController.
  GetCardModifiedEventClass: TCardModifiedEventClass;
begin

  Result := TReservoirKindReferenceSuiteCardModifiedEvent;
  
end;

function TBaseReservoirKindReferenceSuitesFormController.
  GetCardRemovedEventClass: TCardRemovedEventClass;
begin

  Result := TReservoirKindReferenceSuiteCardRemovedEvent;
  
end;

function TBaseReservoirKindReferenceSuitesFormController.
  GetChangingReferenceRecordRequestedEventClass:
    TChangingReferenceRecordRequestedEventClass;
begin

  Result := TChangingReservoirKindReferenceSuiteRecordRequestedEvent;
  
end;

function TBaseReservoirKindReferenceSuitesFormController.
  GetFormClass: TFormClass;
begin

  Result := TReservoirKindReferenceSuitesForm;
  
end;

function TBaseReservoirKindReferenceSuitesFormController.
  GetReferenceRecordChoosenEventClass: TReferenceRecordChoosenEventClass;
begin

  Result := TReservoirKindReferenceSuiteChoosenEvent;

end;

function TBaseReservoirKindReferenceSuitesFormController.
  GetReferenceRecordChooseRequestedEventClass:
    TReferenceRecordChooseRequestedEventClass;
begin

  Result := TReservoirKindReferenceSuiteChooseRequestedEvent;
  
end;

function TBaseReservoirKindReferenceSuitesFormController.
  GetRemovingReferenceRecordRequestedEventClass:
    TRemovingReferenceRecordRequestedEventClass;
begin

  Result := TRemovingReservoirKindReferenceSuiteRecordRequestedEvent;
  
end;

procedure TBaseReservoirKindReferenceSuitesFormController.Handle(Event: TEvent);
begin

  if Event is TReservoirKindReferenceSuitesReferenceRequestedEvent
  then begin

    HandleReservoirKindReferenceSuitesReferenceRequestedEvent(
      TReservoirKindReferenceSuitesReferenceRequestedEvent(Event)
    );

  end

  else inherited;

end;

procedure TBaseReservoirKindReferenceSuitesFormController.
  HandleReservoirKindReferenceSuitesReferenceRequestedEvent(
    Event: TReservoirKindReferenceSuitesReferenceRequestedEvent
  );
begin

  ShowFormAsModal(TComponent(nil));
  
end;

procedure TBaseReservoirKindReferenceSuitesFormController.
  SubscribeOnEvents(
    EventBus: IEventBus
  );
begin

  inherited;

  EventBus.RegisterEventHandler(
    TReservoirKindReferenceSuitesReferenceRequestedEvent, Self
  );

end;

end.
