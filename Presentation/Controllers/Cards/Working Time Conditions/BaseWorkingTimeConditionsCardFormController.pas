unit BaseWorkingTimeConditionsCardFormController;

interface

uses

  AbstractCardFormController,
  unWorkingTimeConditionsCardForm,
  WorkingTimeConditionsCardFormViewModel,
  CardFormViewModel,
  AbstractCardFormControllerEvents,
  AbstractReferenceFormControllerEvents,
  WorkingTimeConditionsCardFormControllerEvents,
  Forms,
  SysUtils;

type

  TBaseWorkingTimeConditionsCardFormController =
    class (TAbstractCardFormController)

      protected

        function GetFormClass: TFormClass; override;
        
      protected

        function GetCardCreatedEventClass: TCardCreatedEventClass; override;
        function GetCardModifiedEventClass: TCardModifiedEventClass; override;
        function GetCardRemovedEventClass: TCardRemovedEventClass; override;

      protected

        function GetAddingReferenceRecordRequestedEventClass: TAddingReferenceRecordRequestedEventClass; override;
        function GetChangingReferenceRecordRequestedEventClass: TChangingReferenceRecordRequestedEventClass; override;
        function GetRemovingReferenceRecordRequestedEventClass: TRemovingReferenceRecordRequestedEventClass; override;

    end; 

implementation

{ TBaseWorkingTimeConditionsCardFormController }

function TBaseWorkingTimeConditionsCardFormController.
  GetAddingReferenceRecordRequestedEventClass:
    TAddingReferenceRecordRequestedEventClass;
begin

  Result := TAddingWorkingTimeConditionsgReferenceRecordRequestedEvent;

end;

function TBaseWorkingTimeConditionsCardFormController.
  GetCardCreatedEventClass: TCardCreatedEventClass;
begin

  Result := TWorkingTimeConditionsCardCreatedEvent;

end;

function TBaseWorkingTimeConditionsCardFormController.
  GetCardModifiedEventClass: TCardModifiedEventClass;
begin

  Result := TWorkingTimeConditionsCardModifiedEvent;

end;

function TBaseWorkingTimeConditionsCardFormController.
  GetCardRemovedEventClass: TCardRemovedEventClass;
begin

  Result := TWorkingTimeConditionsCardRemovedEvent;

end;

function TBaseWorkingTimeConditionsCardFormController.
  GetChangingReferenceRecordRequestedEventClass:
    TChangingReferenceRecordRequestedEventClass;
begin

  Result := TChangingWorkingTimeConditionsgReferenceRecordRequestedEvent;
  
end;

function TBaseWorkingTimeConditionsCardFormController.
  GetFormClass: TFormClass;
begin

  Result := TWorkingTimeConditionsCardForm;
  
end;

function TBaseWorkingTimeConditionsCardFormController.
  GetRemovingReferenceRecordRequestedEventClass:
    TRemovingReferenceRecordRequestedEventClass;
begin

  Result := TRemovingWorkingTimeConditionsgReferenceRecordRequestedEvent;
  
end;

end.
