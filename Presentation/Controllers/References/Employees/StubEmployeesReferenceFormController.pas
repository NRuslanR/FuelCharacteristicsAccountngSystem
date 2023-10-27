unit StubEmployeesReferenceFormController;

interface

uses

  BaseEmployeesReferenceFormController,
  ReferenceFormViewModel,
  EmployeesReferenceFormViewModel,
  EmployeesReferenceDataSetHolder,
  AbstractDataSetHolder,
  FuelCharacteristicsAccountingMainFormControllerEvents,
  Event,
  EventBus,
  AbstractFormController,
  Forms,
  SysUtils,
  Classes;

type

  TStubEmployeesReferenceFormController = class (TBaseEmployeesReferenceFormController)

    protected

      function CreateReferenceFormViewModel: TReferenceFormViewModel; override;

      procedure SubscribeOnEvents(EventBus: IEventBus); override;

    protected

      procedure OnEmployeeSpecialityStringsRequestedEventHandler(
        Sender: TObject;
        var EmployeeSpecialities: TStrings
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

  unTestEmployeesReferenceFormDataModule;
  
{ TStubEmployeesReferenceFormController }

function TStubEmployeesReferenceFormController.CreateReferenceFormViewModel: TReferenceFormViewModel;
begin

  Result := TEmployeesReferenceFormViewModel.Create;

  Result.AddingRecordAllowed := True;
  Result.EditingRecordAllowed := True;
  Result.RemovingRecordAllowed := True;

  Result.DataSetHolder :=
    TEmployeesReferenceDataSetHolder.CreateFrom(
      TTestEmployeesReferenceFormDataModule
        .Create(Application)
          .TestEmployeesClientDataSet
    );

  Result.DataSetHolder.FieldDefs :=
    TEmployeesReferenceDataSetFieldDefs.Create;

  Result.DataSetHolder.RecordIdGenerator :=
    TNegativeIntegerDataSetRecordIdGenerator.Create(
      TIntegerDataSetRecordIdGenerator.Create
    );

  with Result.DataSetHolder as TEmployeesReferenceDataSetHolder do begin

    IdFieldName := 'id';
    IsRecordIdGeneratedFieldName := 'is_record_id_generated';
    NameFieldName := 'name';
    SurnameFieldName := 'surname';
    PatronymicFieldName := 'patronymic';
    BirthDateFieldName := 'birth_date';
    SpecialityFieldName := 'speciality';
    CanBeChangedFieldName := 'can_be_changed';
    CanBeRemovedFieldName := 'can_be_removed';

  end;

end;

procedure TStubEmployeesReferenceFormController.Handle(Event: TEvent);
begin

  if Event is TFuelCharacteristicsAccountingAdministrationFormRequestedEvent
  then begin

    OnFuelCharacteristicsAccountingAdministrationFormRequestedEventHandler(
      Event as TFuelCharacteristicsAccountingAdministrationFormRequestedEvent
    );

  end

  else inherited;

end;

procedure TStubEmployeesReferenceFormController.OnEmployeeSpecialityStringsRequestedEventHandler(
  Sender: TObject; var EmployeeSpecialities: TStrings);
begin

  inherited;

  // refactor: from dto in the future
  
  EmployeeSpecialities := TStringList.Create;

  EmployeeSpecialities.Add('Авиатехник');
  EmployeeSpecialities.Add('Бухгалтер');
  EmployeeSpecialities.Add('Начальник склада');
  
end;

procedure TStubEmployeesReferenceFormController.OnFuelCharacteristicsAccountingAdministrationFormRequestedEventHandler(
  Event: TFuelCharacteristicsAccountingAdministrationFormRequestedEvent);
begin

  ShowFormAsModal(TFormData.Create(Application));
  
end;

procedure TStubEmployeesReferenceFormController.SubscribeOnEvents(
  EventBus: IEventBus);
begin

  inherited;

  EventBus.RegisterEventHandler(
    TFuelCharacteristicsAccountingAdministrationFormRequestedEvent,
    Self
  );

end;

end.
