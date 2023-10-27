unit BaseEmployeesReferenceFormController;

interface

uses

  AbstractReferenceFormController,
  ReferenceFormViewModel,
  unEmployeesReferenceForm,
  AbstractReferenceFormControllerEvents,
  ReferenceFormRecordViewModel,
  BaseEmployeeCardFormControllerEvents,
  BaseEmployeesReferenceFormControllerEvents,
  AbstractCardFormControllerEvents,
  unReferenceForm,
  EventBus,
  Event,
  ReferenceFormRecordViewModelMapper,
  Forms,
  SysUtils,
  Classes;

type

  TBaseEmployeesReferenceFormController = class (TAbstractReferenceFormController)

    protected

      procedure SubscribeOnEvents(EventBus: IEventBus); override;

    protected

      function GetFormClass: TFormClass; override;

      procedure CustomizeReferenceFormForChooseRecord(
        ReferenceForm: TReferenceForm
      ); override;

      procedure SubscribeOnFormEvents(Form: TForm); override;
      
    protected

      procedure OnEmployeeSpecialityStringsRequestedEventHandler(
        Sender: TObject;
        var EmployeeSpecialities: TStrings
      ); virtual; abstract;
    
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
      
  end;

implementation

{ TBaseEmployeesReferenceFormController }


procedure TBaseEmployeesReferenceFormController.
  CustomizeReferenceFormForChooseRecord(
    ReferenceForm: TReferenceForm
  );
begin

  inherited;

  ReferenceForm.Caption := 'Выбор сотрудника';

end;

function TBaseEmployeesReferenceFormController.GetAddingReferenceRecordRequestedEventClass: TAddingReferenceRecordRequestedEventClass;
begin

  Result := TAddingEmployeesReferenceRecordRequestedEvent;

end;

function TBaseEmployeesReferenceFormController.GetCardCreatedEventClass: TCardCreatedEventClass;
begin

  Result := TEmployeeCardCreatedEvent;
  
end;

function TBaseEmployeesReferenceFormController.GetCardModifiedEventClass: TCardModifiedEventClass;
begin

  Result := TEmployeeCardModifiedEvent;
  
end;

function TBaseEmployeesReferenceFormController.GetCardRemovedEventClass: TCardRemovedEventClass;
begin

  Result := TEmployeeCardRemovedEvent;

end;

function TBaseEmployeesReferenceFormController.GetChangingReferenceRecordRequestedEventClass: TChangingReferenceRecordRequestedEventClass;
begin

  Result := TChangingEmployeesReferenceRecordRequestedEvent;
  
end;

function TBaseEmployeesReferenceFormController.GetFormClass: TFormClass;
begin

  Result := TEmployeesReferenceForm;
  
end;

function TBaseEmployeesReferenceFormController.
  GetReferenceRecordChoosenEventClass: TReferenceRecordChoosenEventClass;
begin

  Result := TEmployeeChoosenEvent;

end;

function TBaseEmployeesReferenceFormController.
  GetReferenceRecordChooseRequestedEventClass:
    TReferenceRecordChooseRequestedEventClass;
begin

  Result := TEmployeeChooseRequestedEvent;
  
end;

function TBaseEmployeesReferenceFormController.GetRemovingReferenceRecordRequestedEventClass: TRemovingReferenceRecordRequestedEventClass;
begin

  Result := TRemovingEmployeesReferenceRecordRequestedEvent;
  
end;

procedure TBaseEmployeesReferenceFormController.SubscribeOnEvents(
  EventBus: IEventBus);
begin

  inherited;

  EventBus.RegisterEventHandler(TEmployeeChooseRequestedEvent, Self);

end;

procedure TBaseEmployeesReferenceFormController.SubscribeOnFormEvents(
  Form: TForm);
begin

  inherited;

  with Form as TEmployeesReferenceForm do begin

    OnEmployeeSpecialityStringsRequestedEventHandler :=
      Self.OnEmployeeSpecialityStringsRequestedEventHandler;
      
  end;

end;

end.
