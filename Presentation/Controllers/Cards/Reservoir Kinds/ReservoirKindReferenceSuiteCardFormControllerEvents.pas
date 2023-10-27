unit ReservoirKindReferenceSuiteCardFormControllerEvents;

interface

uses

  AbstractCardFormControllerEvents,
  Event;

type

  TReservoirKindReferenceSuiteCardCreatedEvent = class (TCardCreatedEvent)

  end;

  TReservoirKindReferenceSuiteCardModifiedEvent = class (TCardModifiedEvent)

  end;

  TReservoirKindReferenceSuiteCardRemovedEvent = class (TCardRemovedEvent)

  end;
  
implementation

end.
