unit WorkingTimeConditionsCardFormAdministrationServiceController;

interface

uses

  WorkingTimeConditionsCardFormServiceController,
  CardFormViewModel,
  WorkingTimeConditionsAccountingAppService,
  WorkingTimeConditionsCardFormViewModelMapper,
  WorkingTimeConditionsDto,
  WorkingTimeConditionsInfo,
  WorkingTimeConditionsDtoMapper,
  WorkingTimeConditionsCardFormViewModel,
  unWorkingTimeConditionsCardForm,
  Disposable,
  Forms,
  Event,
  FormEvents,
  AbstractFormController,
  AbstractCardFormController,
  BaseSystemAdministrationFormControllerEvents,
  WorkingTimeConditionsManagementPrivilegeServices,
  unWorkingTimeConditionsAdministrationCardForm,
  Controls,
  EventBus,
  SysUtils;

type

  TWorkingTimeConditionsCardFormAdministrationServiceController =
    class (TWorkingTimeConditionsCardFormServiceController)

      private

        FPrivilegeId: Variant;

      protected

        function GetFormClass: TFormClass; override;

        procedure CustomizeForm(Form: TForm; FormData: TFormData); override;
        
        procedure SubscribeOnEvents(EventBus: IEventBus); override;

      protected

        procedure HandleSystemAdministrationPrivilegeFormRequestedEvent(
          Event: TSystemAdministrationPrivilegeFormRequestedEvent
        );

      public

        constructor Create(

          const ClientIdentity: Variant;
          
          WorkingTimeConditionsManagementPrivilegeServices:
            TWorkingTimeConditionsManagementPrivilegeServices;

          ViewModelMapper: TWorkingTimeConditionsCardFormViewModelMapper;
          EventBus: IEventBus
        );

        procedure Handle(Event: TEvent); override;
        
    end;
  
implementation

{ TWorkingTimeConditionsCardFormAdministrationServiceController }

constructor TWorkingTimeConditionsCardFormAdministrationServiceController.Create(

  const ClientIdentity: Variant;

  WorkingTimeConditionsManagementPrivilegeServices:
    TWorkingTimeConditionsManagementPrivilegeServices;

  ViewModelMapper: TWorkingTimeConditionsCardFormViewModelMapper;
  EventBus: IEventBus
);
begin

  inherited Create(
    ClientIdentity,

    WorkingTimeConditionsManagementPrivilegeServices
      .WorkingTimeConditionsAccountingAppService,

    ViewModelMapper,
    EventBus
  );

  FPrivilegeId := WorkingTimeConditionsManagementPrivilegeServices.PrivilegeId;
  
end;

procedure TWorkingTimeConditionsCardFormAdministrationServiceController.CustomizeForm(
  Form: TForm; FormData: TFormData);
begin

  inherited;

  with TWorkingTimeConditionsAdministrationCardForm(Form) do begin

    CancelButtonVisible := False;
    btnOK.Anchors := [akLeft, akTop];
    
  end;

end;

function TWorkingTimeConditionsCardFormAdministrationServiceController.
  GetFormClass: TFormClass;
begin

  Result := TWorkingTimeConditionsAdministrationCardForm;
  
end;

procedure TWorkingTimeConditionsCardFormAdministrationServiceController.Handle(
  Event: TEvent);
begin

  if Event is TSystemAdministrationPrivilegeFormRequestedEvent then begin

    HandleSystemAdministrationPrivilegeFormRequestedEvent(
      TSystemAdministrationPrivilegeFormRequestedEvent(Event)
    );

  end

  else inherited;

end;

procedure TWorkingTimeConditionsCardFormAdministrationServiceController.
  HandleSystemAdministrationPrivilegeFormRequestedEvent(
    Event: TSystemAdministrationPrivilegeFormRequestedEvent
  );
var
    ViewModel: TWorkingTimeConditionsCardFormViewModel;
    FreeViewModel: IDisposable;
    
    WorkingTimeConditionsCardForm: TForm;
    FormInflatingRequestedEvent: TSectionalFormInflatingRequestedEvent;
begin

  if Event.PrivilegeId <> FPrivilegeId then
    Exit;

  try
    
    Screen.Cursor := crHourGlass;

    ViewModel := CreateViewModelForActiveWorkingTimeConditions;

    FreeViewModel := ViewModel;
    
  finally

    Screen.Cursor := crDefault;
    
  end;

  WorkingTimeConditionsCardForm :=
    CreateForm(TCardFormData.Create(ViewModel, Application));

  FormInflatingRequestedEvent := nil;
  
  try

    try

      FormInflatingRequestedEvent :=
        TSectionalFormInflatingRequestedEvent.Create(
          FPrivilegeId, WorkingTimeConditionsCardForm
        );

      EventBus.RaiseEvent(FormInflatingRequestedEvent);
      
    except

      on E: Exception do begin

        FreeAndNil(WorkingTimeConditionsCardForm);

        raise;

      end;

    end;

  finally

    FreeAndNil(FormInflatingRequestedEvent);

  end;

end;

procedure TWorkingTimeConditionsCardFormAdministrationServiceController.
  SubscribeOnEvents(EventBus: IEventBus);
begin

  inherited;

  EventBus.RegisterEventHandler(
    TSystemAdministrationPrivilegeFormRequestedEvent, Self
  );
  
end;

end.
