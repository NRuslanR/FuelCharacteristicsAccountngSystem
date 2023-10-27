unit BaseEmployeeCardFormControllerEvents;

interface

uses

  AbstractCardFormControllerEvents;

type

  TEmployeeCardCreatedEvent = class (TCardCreatedEvent)

  end;

  TEmployeeCardModifiedEvent = class (TCardModifiedEvent)

  end;

  TEmployeeCardRemovedEvent = class (TCardRemovedEvent)

  end;

implementation

end.
