unit unEmployeeAdministrationCardForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unEmployeeCardForm, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, unEmployeeLogOnInfoCardFrame,
  unEmployeeCardFrame, StdCtrls, cxButtons, CardFormViewModel,
  EmployeeAdministrationCardFormViewModel,
  VariantTypeUnit;

type
  TEmployeeAdministrationCardForm = class(TEmployeeCardForm)
    EmployeeLogOnInfoCardFrame: TEmployeeLogOnInfoCardFrame;
    procedure EmployeeCardFrameSpecialityComboBoxChange(Sender: TObject);
    procedure EmployeeLogOnInfoCardFrameRoleComboBoxChange(Sender: TObject);
  private

  protected

    procedure FillControlsByViewModel(ViewModel: TCardFormViewModel); override;
    procedure FillViewModelByControls(ViewModel: TCardFormViewModel); override;

    procedure FillRoleNameComboBoxFrom(ViewModel: TCardFormViewModel);

    procedure ClearRoleNameComboBox;
    
  protected

    function IsInputDataValid: Boolean; override;
    function IsRoleNameSelected: Boolean;
    
  public

    destructor Destroy; override;

  end;

var
  EmployeeAdministrationCardForm: TEmployeeAdministrationCardForm;

implementation

{$R *.dfm}

procedure TEmployeeAdministrationCardForm.ClearRoleNameComboBox;
var I: Integer;
    RoleIdVariantObject: TVariant;
begin

  with EmployeeLogOnInfoCardFrame do begin

    while RoleComboBox.Items.Count <> 0 do begin


      if Assigned(RoleComboBox.Items.Objects[0]) then begin

        RoleIdVariantObject := RoleComboBox.Items.Objects[0] as TVariant;

        FreeAndNil(RoleIdVariantObject);

      end;

      RoleComboBox.Items.Delete(0);

    end;

  end;
    
end;

destructor TEmployeeAdministrationCardForm.Destroy;
begin

  ClearRoleNameComboBox;

  inherited;

end;

procedure TEmployeeAdministrationCardForm.EmployeeCardFrameSpecialityComboBoxChange(
  Sender: TObject);
var SelectedSpecialityIndex: Integer;
begin

  inherited;

  SelectedSpecialityIndex :=
    EmployeeLogOnInfoCardFrame.RoleComboBox.Items.IndexOf(
      EmployeeCardFrame.SpecialityComboBox.Items[
        EmployeeCardFrame.SpecialityComboBox.ItemIndex
      ]
    );

  if SelectedSpecialityIndex <> -1 then
    EmployeeLogOnInfoCardFrame.RoleComboBox.ItemIndex := SelectedSpecialityIndex;
  
end;

procedure TEmployeeAdministrationCardForm.EmployeeLogOnInfoCardFrameRoleComboBoxChange(
  Sender: TObject);
begin

  IsRoleNameSelected;

end;

procedure TEmployeeAdministrationCardForm.FillControlsByViewModel(
  ViewModel: TCardFormViewModel);
begin

  inherited;

  with ViewModel as TEmployeeAdministrationCardFormViewModel do begin

    EmployeeLogOnInfoCardFrame.LoginEdit.Visible := Login.Visible;

    if Login.Visible then begin

      EmployeeLogOnInfoCardFrame.LoginEdit.Text := Login.ToString;
      EmployeeLogOnInfoCardFrame.LoginEdit.ReadOnly := Login.ReadOnly;
      
    end;

    EmployeeLogOnInfoCardFrame.PasswordEdit.Visible := Password.Visible;

    if Password.Visible then begin

      EmployeeLogOnInfoCardFrame.PasswordEdit.Text := Password.ToString;
      EmployeeLogOnInfoCardFrame.PasswordEdit.ReadOnly := Password.ReadOnly;
      
    end;

    FillRoleNameComboBoxFrom(ViewModel);
    
  end;

end;

procedure TEmployeeAdministrationCardForm.FillRoleNameComboBoxFrom(
  ViewModel: TCardFormViewModel
);
var RoleViewModel: TRoleViewModel;
begin
  
  with ViewModel as TEmployeeAdministrationCardFormViewModel do begin

    EmployeeLogOnInfoCardFrame.RoleComboBox.Visible :=
      CurrentRoleName.Visible;

    if not CurrentRoleName.Visible then Exit;

    if not Assigned(RoleViewModels) or (RoleViewModels.Count = 0)
    then begin

      EmployeeLogOnInfoCardFrame.RoleComboBox.Text := '';
      EmployeeLogOnInfoCardFrame.RoleComboBox.Clear;

      Exit;
      
    end;

    for RoleViewModel in RoleViewModels do begin

      EmployeeLogOnInfoCardFrame
        .RoleComboBox.AddItem(
          RoleViewModel.Name,
          TVariant.Create(RoleViewModel.Id)
        );

    end;

    if CurrentRoleName.IsAssigned then begin

      EmployeeLogOnInfoCardFrame.RoleComboBox.ItemIndex :=
        EmployeeLogOnInfoCardFrame.RoleComboBox.Items.IndexOf(
          CurrentRoleName.ToString
        );

    end

    else EmployeeLogOnInfoCardFrame.RoleComboBox.ItemIndex := 0;

    if CurrentRoleName.ReadOnly then
      SetComboBoxAsReadOnly(EmployeeLogOnInfoCardFrame.RoleComboBox);

  end;

end;

procedure TEmployeeAdministrationCardForm.FillViewModelByControls(
  ViewModel: TCardFormViewModel);
begin

  inherited;
  
  with ViewModel as TEmployeeAdministrationCardFormViewModel do begin

    if Login.Visible then
      Login.Value := EmployeeLogOnInfoCardFrame.LoginEdit.Text;

    if Password.Visible then
      Password.Value := Trim(EmployeeLogOnInfoCardFrame.PasswordEdit.Text);

    if CurrentRoleName.Visible then begin

      CurrentRoleName.Value :=
        EmployeeLogOnInfoCardFrame.RoleComboBox.Items[
          EmployeeLogOnInfoCardFrame.RoleComboBox.ItemIndex
        ];
        
    end;

  end;

end;

function TEmployeeAdministrationCardForm.IsInputDataValid: Boolean;
var IsLoginValid, IsRoleNameValid, IsPasswordValid: Boolean;
begin

  Result := inherited IsInputDataValid;

  IsLoginValid := EmployeeLogOnInfoCardFrame.LoginEdit.IsValid;
  IsPasswordValid := EmployeeLogOnInfoCardFrame.PasswordEdit.IsValid;
  IsRoleNameValid := IsRoleNameSelected;

  Result :=
    Result and
    IsLoginValid and
    IsPasswordValid and
    IsRoleNameValid;
  
end;

function TEmployeeAdministrationCardForm.IsRoleNameSelected: Boolean;
begin

  Result :=
    IsComboBoxItemSelected(
      EmployeeLogOnInfoCardFrame.RoleComboBox,
      '”казана некорректна€ роль сотрудника',
      EmployeeCardFrame.NameEdit.InvalidColor
    );

end;

end.
