unit BaseEmployeesAdministrationReferenceFormController;

interface

uses

  BaseEmployeesReferenceFormController,
  unEmployeesAdministrationReferenceForm,
  BaseSystemAdministrationFormControllerEvents,
  AbstractFormController,
  ReferenceFormRecordViewModelMapper,
  Event,
  EventBus,
  Forms,
  FormEvents,
  SysUtils,
  Classes;

type

  TBaseEmployeesAdministrationReferenceFormController =
    class (TBaseEmployeesReferenceFormController)

      protected

        function GetFormClass: TFormClass; override;

        procedure SubscribeOnFormEvents(Form: TForm); override;
        procedure SubscribeOnEvents(EventBus: IEventBus); override;
        
      protected

        procedure OnEmployeeRoleNamesRequestedEventHandler(
          Sender: TObject;
          var EmployeeRoleNames: TStrings
        ); virtual; abstract;

        procedure OnSystemAdministrationPrivilegeFormRequestedEventHandler(
          Event: TSystemAdministrationPrivilegeFormRequestedEvent
        ); virtual; abstract;

      public

        procedure Handle(Event: TEvent); override;
        
    end;
  
implementation

uses

  AuxDebugFunctionsUnit;
  
{ TBaseEmployeesAdministrationReferenceFormController }

function TBaseEmployeesAdministrationReferenceFormController.GetFormClass: TFormClass;
begin

  Result := TEmployeesAdministrationReferenceForm;
  
end;

procedure TBaseEmployeesAdministrationReferenceFormController.Handle(
  Event: TEvent);
begin

  if Event is TSystemAdministrationPrivilegeFormRequestedEvent then begin

    OnSystemAdministrationPrivilegeFormRequestedEventHandler(
      Event as TSystemAdministrationPrivilegeFormRequestedEvent
    );

  end

  else inherited;

end;

procedure TBaseEmployeesAdministrationReferenceFormController.SubscribeOnEvents(
  EventBus: IEventBus);
begin

  inherited;

  EventBus.RegisterEventHandler(
    TSystemAdministrationPrivilegeFormRequestedEvent,
    Self
  );
  
end;

procedure TBaseEmployeesAdministrationReferenceFormController.SubscribeOnFormEvents(
  Form: TForm);
begin

  inherited;

  with Form as TEmployeesAdministrationReferenceForm do begin

    OnEmployeeRoleNamesRequestedEventHandler :=
      Self.OnEmployeeRoleNamesRequestedEventHandler;

  end;
  
end;

end.
