unit StubSystemAdministrationFormController;

interface

uses

  AbstractSectionStackedFormController,
  AbstractStubSectionStackedFormController,
  unSectionStackedForm,
  SectionStackedFormViewModel,
  AbstractFormController,
  SectionRecordViewModel,
  FuelCharacteristicsAccountingMainFormControllerEvents,
  SectionSetHolder,
  EventBus,
  Event,
  DB,
  Forms,
  Controls,
  FormEvents,
  SysUtils,
  Classes;

type

  TStubSystemAdministrationFormController = class (TAbstractStubSectionStackedFormController)

    protected

      procedure SubscribeOnEvents(EventBus: IEventBus); override;

      procedure CustomizeForm(Form: TForm; FormData: TFormData); override;
      
    protected

      procedure CreateSectionSetFieldDefs(
        SectionSet: TDataSet;
        SectionSetFieldDefs: TSectionSetFieldDefs
      ); override;

      procedure InitializeSectionSetFieldDefs(SectionSetFieldDefs: TSectionSetFieldDefs); override;
      procedure FillViewModel(ViewModel: TSectionStackedFormViewModel); override;

    protected

      procedure OnSectionControlRequestedEventHandler(
        Sender: TObject;
        SectionRecordViewModel: TSectionRecordViewModel;
        var Control: TControl;
        var Success: Boolean
      ); override;

      procedure OnFuelCharacteristicsAccountingAdministrationFormRequestedEventHandler(
        Event: TFuelCharacteristicsAccountingAdministrationFormRequestedEvent
      );

    public

      procedure Handle(Event: TEvent); override;
      
  end;

implementation

uses

  Variants,
  StdCtrls,
  ComCtrls,
  DBDataTableFormUnit,
  AuxDataSetFunctionsUnit;
  
{ TStubSystemAdministrationFormController }

procedure TStubSystemAdministrationFormController.CreateSectionSetFieldDefs(
  SectionSet: TDataSet;
  SectionSetFieldDefs: TSectionSetFieldDefs
);
begin

  CreateFieldInDataSet(
    SectionSet, SectionSetFieldDefs.SectionIdFieldName, ftInteger
  );

  CreateFieldInDataSet(
    SectionSet, SectionSetFieldDefs.ParentIdSectionFieldName, ftInteger
  );

  CreateFieldInDataSet(
    SectionSet, SectionSetFieldDefs.SectionNameFieldName, ftString, 200
  );

end;

procedure TStubSystemAdministrationFormController.CustomizeForm(Form: TForm;
  FormData: TFormData);
begin

  inherited;

  Form.Position := poDesktopCenter;
  
end;

procedure TStubSystemAdministrationFormController.FillViewModel(
  ViewModel: TSectionStackedFormViewModel);
var SectionRecordViewModel: TSectionRecordViewModel;
    DBDataTableForm: TDBDataTableForm;
begin

  ViewModel.SectionSetHolder.DataSet.Open;

  SectionRecordViewModel := TSectionRecordViewModel.Create;

  SectionRecordViewModel.Id := 1;
  SectionRecordViewModel.ParentId := Null;
  SectionRecordViewModel.Name := 'Управление';
  
  ViewModel.AddSection(SectionRecordViewModel);

  SectionRecordViewModel.Id := 2;
  SectionRecordViewModel.ParentId := 1;
  SectionRecordViewModel.Name := 'Сотрудники';

  ViewModel.AddSection(SectionRecordViewModel, TComboBox.Create(nil));

  SectionRecordViewModel.Id := 3;
  SectionRecordViewModel.ParentId := Null;
  SectionRecordViewModel.Name := 'Архивирование';

  ViewModel.AddSection(SectionRecordViewModel, TDateTimePicker.Create(nil));

  SectionRecordViewModel.Id := 4;
  SectionRecordViewModel.ParentId := Null;
  SectionRecordViewModel.Name := 'DBDataTableForm';

  DBDataTableForm := TDBDataTableForm.Create(nil);

  DBDataTableForm.BorderStyle := bsNone;
  
  ViewModel.AddSection(SectionRecordViewModel, DBDataTableForm);
  
  SectionRecordViewModel.Free;

end;

procedure TStubSystemAdministrationFormController.Handle(Event: TEvent);
begin

  inherited;

  if Event is TFuelCharacteristicsAccountingAdministrationFormRequestedEvent
  then begin

    OnFuelCharacteristicsAccountingAdministrationFormRequestedEventHandler(
      Event as TFuelCharacteristicsAccountingAdministrationFormRequestedEvent
    );
    
  end;
  
end;

procedure TStubSystemAdministrationFormController.InitializeSectionSetFieldDefs(
  SectionSetFieldDefs: TSectionSetFieldDefs);
begin

  with SectionSetFieldDefs do begin

    SectionIdFieldName := 'section_id';
    ParentIdSectionFieldName := 'parent_section_id';
    SectionNameFieldName := 'section_name';
    
  end;

end;

procedure TStubSystemAdministrationFormController.OnFuelCharacteristicsAccountingAdministrationFormRequestedEventHandler(
  Event: TFuelCharacteristicsAccountingAdministrationFormRequestedEvent);
begin

  ShowFormAsModal(TFormData.Create(Application));

end;

procedure TStubSystemAdministrationFormController.
  OnSectionControlRequestedEventHandler(
    Sender: TObject;
    SectionRecordViewModel: TSectionRecordViewModel;
    var Control: TControl;
    var Success: Boolean
  );
begin

  if SectionRecordViewModel.Id = 2 then
    Control := TComboBox.Create(nil)

  else if SectionRecordViewModel.Id = 3 then
    Control := TDateTimePicker.Create(nil)

  else if SectionRecordViewModel.Id = 4 then
    Control := TDBDataTableForm.Create(nil)

  else Success := False;

end;

procedure TStubSystemAdministrationFormController.SubscribeOnEvents(
  EventBus: IEventBus);
begin

  inherited;

  EventBus.RegisterEventHandler(
    TFuelCharacteristicsAccountingAdministrationFormRequestedEvent,
    Self
  );
  
end;

end.
