unit BaseEmployeeCardFormController;

interface

uses

  AbstractCardFormController,
  AbstractFormController,
  CardFormViewModel,
  unEmployeeCardForm,
  AbstractCardFormControllerEvents,
  AbstractReferenceFormControllerEvents,
  Forms,
  SysUtils,
  Classes;

type

  TBaseEmployeeCardFormController = class (TAbstractCardFormController)

    protected

      function GetFormClass: TFormClass; override;

      procedure CustomizeForm(Form: TForm; FormData: TFormData); override;

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

uses

  EmployeeCardFormViewModel,
  BaseEmployeeCardFormControllerEvents,
  BaseEmployeesReferenceFormControllerEvents,
  Variants;
  
{ TBaseEmployeeCardFormController }

procedure TBaseEmployeeCardFormController.CustomizeForm(Form: TForm;
  FormData: TFormData);
var ViewModel: TCardFormViewModel;
begin

  inherited;

  ViewModel := (FormData as TCardFormData).ViewModel;

  if VarIsNull(ViewModel.Id.Value) then
    Form.Caption := 'Карточка для нового сотрудника'

  else Form.Caption := 'Карточка сотрудника';
  
end;

function TBaseEmployeeCardFormController.GetAddingReferenceRecordRequestedEventClass: TAddingReferenceRecordRequestedEventClass;
begin

  Result := TAddingEmployeesReferenceRecordRequestedEvent;
  
end;

function TBaseEmployeeCardFormController.GetCardCreatedEventClass: TCardCreatedEventClass;
begin

  Result := TEmployeeCardCreatedEvent;
  
end;

function TBaseEmployeeCardFormController.GetCardModifiedEventClass: TCardModifiedEventClass;
begin

  Result := TEmployeeCardModifiedEvent;

end;

function TBaseEmployeeCardFormController.GetCardRemovedEventClass: TCardRemovedEventClass;
begin

  Result := TEmployeeCardRemovedEvent;

end;

function TBaseEmployeeCardFormController.GetChangingReferenceRecordRequestedEventClass: TChangingReferenceRecordRequestedEventClass;
begin

  Result := TChangingEmployeesReferenceRecordRequestedEvent;

end;

function TBaseEmployeeCardFormController.GetFormClass: TFormClass;
begin

  Result := TEmployeeCardForm;
  
end;

function TBaseEmployeeCardFormController.GetRemovingReferenceRecordRequestedEventClass: TRemovingReferenceRecordRequestedEventClass;
begin

  Result := TRemovingEmployeesReferenceRecordRequestedEvent;

end;

end.
