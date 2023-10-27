unit BaseEmployeeAdministrationCardFormController;

interface

uses

  BaseEmployeeCardFormController,
  unEmployeeAdministrationCardForm,
  CardFormViewModel,
  Event,
  EventBus,
  AbstractFormController,
  AbstractCardFormController,
  Forms,
  SysUtils,
  Classes;

type

  TBaseEmployeeAdministrationCardFormController =
    class (TBaseEmployeeCardFormController)

      protected

        function GetFormClass: TFormClass; override;

        procedure CustomizeForm(Form: TForm; FormData: TFormData); override;
        
    end;


implementation

uses

  Variants,
  RegExprValidateEditUnit;
  
{ TBaseEmployeeAdministrationCardFormController }

procedure TBaseEmployeeAdministrationCardFormController.CustomizeForm(
  Form: TForm; FormData: TFormData);
var EmployeeAdministrationCardForm: TEmployeeAdministrationCardForm;
    ViewModel: TCardFormViewModel;
    PasswordEdit: TRegExprValidateEdit;
begin

  inherited;

  EmployeeAdministrationCardForm := Form as TEmployeeAdministrationCardForm;

  ViewModel := EmployeeAdministrationCardForm.ViewModel;

  if VarIsNull(ViewModel.Id.Value) then begin

    PasswordEdit :=
      EmployeeAdministrationCardForm.EmployeeLogOnInfoCardFrame.PasswordEdit;

    PasswordEdit.RegularExpression := '.+';
    PasswordEdit.InvalidHint :=
      'Для нового сотрудника ' +
      'необходимо назначить пароль';
       
  end;

end;

function TBaseEmployeeAdministrationCardFormController.GetFormClass: TFormClass;
begin

  Result := TEmployeeAdministrationCardForm;
  
end;

end.
