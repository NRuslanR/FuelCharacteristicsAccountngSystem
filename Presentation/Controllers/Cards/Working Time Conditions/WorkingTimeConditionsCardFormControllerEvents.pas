unit WorkingTimeConditionsCardFormControllerEvents;

interface

uses

  AbstractCardFormControllerEvents,
  AbstractReferenceFormControllerEvents,
  SysUtils;

type

  TWorkingTimeConditionsCardCreatedEvent = class (TCardCreatedEvent)

  end;

  TWorkingTimeConditionsCardModifiedEvent = class (TCardModifiedEvent)

  end;

  TWorkingTimeConditionsCardRemovedEvent = class (TCardRemovedEvent)

  end;

  TAddingWorkingTimeConditionsgReferenceRecordRequestedEvent =
    class (TAddingReferenceRecordRequestedEvent)

    end;

  TChangingWorkingTimeConditionsgReferenceRecordRequestedEvent =
    class (TChangingReferenceRecordRequestedEvent)

    end;

  TRemovingWorkingTimeConditionsgReferenceRecordRequestedEvent =
    class (TRemovingReferenceRecordRequestedEvent)

    end;
    
implementation

end.
