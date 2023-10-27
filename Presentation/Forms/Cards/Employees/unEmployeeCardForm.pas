unit unEmployeeCardForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogFormUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Menus, StdCtrls, cxButtons, unCardForm, CardFormViewModel, unEmployeeCardFrame,
  EmployeeCardFormViewModel;

type
  TEmployeeCardForm = class(TCardForm)
    EmployeeCardFrame: TEmployeeCardFrame;
    procedure EmployeeCardFrameSpecialityComboBoxChange(Sender: TObject);
  private

  protected

    procedure FillControlsByViewModel(ViewModel: TCardFormViewModel); override;
    procedure FillViewModelByControls(ViewModel: TCardFormViewModel); override;

    procedure FillSpecialityComboBoxFrom(ViewModel: TCardFormViewModel);

    procedure SetComboBoxAsReadOnly(ComboBox: TComboBox);
    
  protected

    function IsInputDataValid: Boolean; override;
    function IsSpecialitySelected: Boolean;

    function IsComboBoxItemSelected(
      ComboBox: TComboBox;
      const InvalidHint: String;
      const InvalidColor: TColor
    ): Boolean;
    
  public

  end;

var
  EmployeeCardForm: TEmployeeCardForm;

implementation

{$R *.dfm}

{ TEmployeeCardForm }

procedure TEmployeeCardForm.EmployeeCardFrameSpecialityComboBoxChange(
  Sender: TObject);
begin

  IsSpecialitySelected;

end;

procedure TEmployeeCardForm.FillControlsByViewModel(
  ViewModel: TCardFormViewModel);
begin

  inherited;

  with ViewModel as TEmployeeCardFormViewModel do begin

    EmployeeCardFrame.NameEdit.Visible := Name.Visible;

    if Name.Visible then begin

      EmployeeCardFrame.NameEdit.Text := Name.ToString;
      EmployeeCardFrame.NameEdit.ReadOnly := Name.ReadOnly;

    end;

    EmployeeCardFrame.SurnameEdit.Visible := Surname.Visible;

    if Surname.Visible then begin

      EmployeeCardFrame.SurnameEdit.Text := Surname.ToString;
      EmployeeCardFrame.SurnameEdit.ReadOnly := Surname.ReadOnly;

    end;

    EmployeeCardFrame.PatronymicEdit.Visible := Patronymic.Visible;

    if Patronymic.Visible then begin

      EmployeeCardFrame.PatronymicEdit.Text := Patronymic.ToString;
      EmployeeCardFrame.PatronymicEdit.ReadOnly := Patronymic.ReadOnly;
      
    end;

    EmployeeCardFrame.BirthDateTimePicker.Visible := BirthDate.Visible;

    if BirthDate.Visible then begin

      EmployeeCardFrame.BirthDateTimePicker.DateTime := BirthDate.AsDateTime;
      EmployeeCardFrame.BirthDateTimePicker.Enabled := not BirthDate.ReadOnly;
      
    end;

    FillSpecialityComboBoxFrom(ViewModel);
    
  end;
  
end;

procedure TEmployeeCardForm.FillSpecialityComboBoxFrom(
  ViewModel: TCardFormViewModel);
var SpecialityName: String;
    EmployeeCardFormViewModel: TEmployeeCardFormViewModel;
begin

  EmployeeCardFormViewModel := ViewModel as TEmployeeCardFormViewModel;
  
  EmployeeCardFrame.SpecialityComboBox.Visible :=
    EmployeeCardFormViewModel.Speciality.Visible;

  if not EmployeeCardFormViewModel.Speciality.Visible then Exit;

  if
    not Assigned(EmployeeCardFormViewModel.Specialities) or
    (EmployeeCardFormViewModel.Specialities.Count = 0)
  then begin

    EmployeeCardFrame.SpecialityComboBox.Text := '';
    EmployeeCardFrame.SpecialityComboBox.Clear;

    Exit;

  end;

  EmployeeCardFrame.SpecialityComboBox.Items :=
    EmployeeCardFormViewModel.Specialities;

  if EmployeeCardFormViewModel.Speciality.IsAssigned then begin

    EmployeeCardFrame.SpecialityComboBox.ItemIndex :=
      EmployeeCardFrame.SpecialityComboBox.Items.IndexOf(
        EmployeeCardFormViewModel.Speciality.ToString
      );

  end

  else EmployeeCardFrame.SpecialityComboBox.ItemIndex := 0;

  if EmployeeCardFormViewModel.Speciality.ReadOnly then
    SetComboBoxAsReadOnly(EmployeeCardFrame.SpecialityComboBox);
  
end;

procedure TEmployeeCardForm.FillViewModelByControls(
  ViewModel: TCardFormViewModel);
begin

  inherited;
  
  with ViewModel as TEmployeeCardFormViewModel do begin

    if Name.Visible then
      Name.Value := EmployeeCardFrame.NameEdit.Text;

    if Surname.Visible then
      Surname.Value := EmployeeCardFrame.SurnameEdit.Text;

    if Patronymic.Visible then
      Patronymic.Value := EmployeeCardFrame.PatronymicEdit.Text;

    if BirthDate.Visible then
      BirthDate.Value := EmployeeCardFrame.BirthDateTimePicker.DateTime;

    if Speciality.Visible then begin

      Speciality.Value :=
        EmployeeCardFrame.SpecialityComboBox.Items[
          EmployeeCardFrame.SpecialityComboBox.ItemIndex
        ];

    end;

  end;

end;

function TEmployeeCardForm.IsComboBoxItemSelected(
  ComboBox: TComboBox;
  const InvalidHint: String;
  const InvalidColor: TColor
): Boolean;
begin

  Result := ComboBox.ItemIndex <> -1;

  if not Result then begin

    ComboBox.Color := InvalidColor;
    ComboBox.Hint := InvalidHint;
    ComboBox.ShowHint := True;
    
  end

  else begin

    ComboBox.Color := clWindow;
    ComboBox.ShowHint := False;

  end;

end;

function TEmployeeCardForm.IsInputDataValid: Boolean;
var IsNameValid, IsSurnameValid, IsPatronymicValid,
    IsBirthDateValid, IsSpecialityValid: Boolean;
begin

  IsNameValid := EmployeeCardFrame.NameEdit.IsValid;
  IsSurnameValid := EmployeeCardFrame.SurnameEdit.IsValid;
  IsPatronymicValid := EmployeeCardFrame.PatronymicEdit.IsValid;
  IsSpecialityValid := IsSpecialitySelected;
  
  Result :=
    IsNameValid and
    IsSurnameValid and
    IsPatronymicValid and
    IsSpecialityValid;
  
end;

function TEmployeeCardForm.IsSpecialitySelected: Boolean;
begin

  Result :=
    IsComboBoxItemSelected(
      EmployeeCardFrame.SpecialityComboBox,
      '”казана некорректна€ должность сотрудника',
      EmployeeCardFrame.NameEdit.InvalidColor
    );
  
end;

procedure TEmployeeCardForm.SetComboBoxAsReadOnly(ComboBox: TComboBox);
begin

  ComboBox.Enabled := False;
  ComboBox.Style := csSimple;
  
end;

end.
