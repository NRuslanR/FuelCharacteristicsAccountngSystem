unit StubEmployeesAdministrationReferenceFormController;

interface

uses

  BaseEmployeesAdministrationReferenceFormController,
  Event,
  AbstractFormController,
  ReferenceFormViewModel,
  AbstractDataSetHolder,
  EventBus,
  Forms,
  FuelCharacteristicsAccountingMainFormControllerEvents,
  SysUtils,
  Classes;

type

  TStubEmployeesAdministrationReferenceFormController =
    class (TBaseEmployeesAdministrationReferenceFormController)

      protected

        function CreateReferenceFormViewModel: TReferenceFormViewModel; override;

        procedure SubscribeOnEvents(EventBus: IEventBus); override;

      protected

        procedure OnEmployeeRoleNamesRequestedEventHandler(
          Sender: TObject;
          var EmployeeRoleNames: TStrings
        ); override;

      protected

        procedure OnFuelCharacteristicsAccountingAdministrationFormRequestedEventHandler(
          Event: TFuelCharacteristicsAccountingAdministrationFormRequestedEvent
        );

      public

        procedure Handle(Event: TEvent); override;

    end;


implementation

uses

  EmployeesAdministrationReferenceRecordViewModel,
  EmployeesAdministrationReferenceFormViewModel,
  EmployeesAdministrationReferenceDataSetHolder,
  unTestEmployeesReferenceFormDataModule;
  

{ TStubEmployeesAdministrationReferenceFormController }

function TStubEmployeesAdministrationReferenceFormController.CreateReferenceFormViewModel: TReferenceFormViewModel;
begin

  Result := TEmployeesReferenceAdministrationFormViewModel.Create;

  Result.AddingRecordAllowed := True;
  Result.EditingRecordAllowed := True;
  Result.RemovingRecordAllowed := True;

  Result.DataSetHolder :=
    TEmployeesAdministrationReferenceDataSetHolder.CreateFrom(
      TTestEmployeesReferenceFormDataModule
        .Create(Application)
          .TestEmployeesAdminMemData
    );

  Result.DataSetHolder.FieldDefs :=
    TEmployeesAdministrationReferenceDataSetFieldDefs.Create;

  Result.DataSetHolder.RecordIdGenerator :=
    TNegativeIntegerDataSetRecordIdGenerator.Create(
      TIntegerDataSetRecordIdGenerator.Create
    );

  with Result.DataSetHolder as TEmployeesAdministrationReferenceDataSetHolder do begin

    IdFieldName := 'id';
    IsRecordIdGeneratedFieldName := 'is_record_id_generated';
    NameFieldName := 'name';
    SurnameFieldName := 'surname';
    PatronymicFieldName := 'patronymic';
    BirthDateFieldName := 'birth_date';
    SpecialityFieldName := 'speciality';
    CanBeChangedFieldName := 'can_be_changed';
    CanBeRemovedFieldName := 'can_be_removed';
    LoginFieldName := 'login';
    RoleNameFieldName := 'role_name';

  end;
  
end;

procedure TStubEmployeesAdministrationReferenceFormController.Handle(
  Event: TEvent);
begin

  if Event is TFuelCharacteristicsAccountingAdministrationFormRequestedEvent
  then begin

    OnFuelCharacteristicsAccountingAdministrationFormRequestedEventHandler(
      Event as TFuelCharacteristicsAccountingAdministrationFormRequestedEvent
    );

  end

  else inherited;

end;

procedure TStubEmployeesAdministrationReferenceFormController.
  OnEmployeeRoleNamesRequestedEventHandler(
    Sender: TObject;
    var EmployeeRoleNames: TStrings
  );
begin

  inherited;

  // refactor: from dto in the future

  EmployeeRoleNames.Add('Авиатехник');
  EmployeeRoleNames.Add('Бухгалтер');
  EmployeeRoleNames.Add('Начальник склада');
  
end;

procedure TStubEmployeesAdministrationReferenceFormController.
  OnFuelCharacteristicsAccountingAdministrationFormRequestedEventHandler(
    Event: TFuelCharacteristicsAccountingAdministrationFormRequestedEvent
  );
begin

  ShowFormAsModal(TFormData.Create(Application));
  
end;

procedure TStubEmployeesAdministrationReferenceFormController.SubscribeOnEvents(
  EventBus: IEventBus);
begin

  inherited;

  EventBus.RegisterEventHandler(
    TFuelCharacteristicsAccountingAdministrationFormRequestedEvent,
    Self
  );
  
end;

end.
