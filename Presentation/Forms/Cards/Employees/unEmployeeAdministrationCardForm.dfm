inherited EmployeeAdministrationCardForm: TEmployeeAdministrationCardForm
  Caption = 'EmployeeAdministrationCardForm'
  ClientHeight = 398
  ClientWidth = 394
  Constraints.MaxHeight = 437
  Constraints.MinHeight = 437
  Constraints.MinWidth = 410
  ExplicitWidth = 410
  ExplicitHeight = 437
  PixelsPerInch = 96
  TextHeight = 13
  inherited btnOK: TcxButton
    Left = 224
    Top = 365
    ExplicitLeft = 224
    ExplicitTop = 365
  end
  inherited btnCancel: TcxButton
    Left = 311
    Top = 365
    LookAndFeel.SkinName = 'UserSkin'
    ExplicitLeft = 311
    ExplicitTop = 365
  end
  inherited EmployeeCardFrame: TEmployeeCardFrame
    Width = 394
    Height = 209
    ExplicitWidth = 394
    ExplicitHeight = 209
    inherited EmployeePersonnelInfoGroupBox: TGroupBox
      Width = 378
      Height = 198
      ExplicitWidth = 378
      ExplicitHeight = 198
      inherited BirthDateTimePicker: TDateTimePicker
        Width = 263
        ExplicitWidth = 263
      end
      inherited NameEdit: TRegExprValidateEdit
        Width = 263
        ExplicitWidth = 263
      end
      inherited PatronymicEdit: TRegExprValidateEdit
        Width = 263
        ExplicitWidth = 263
      end
      inherited SpecialityComboBox: TComboBox
        Width = 263
        ExplicitWidth = 263
      end
      inherited SurnameEdit: TRegExprValidateEdit
        Width = 263
        ExplicitWidth = 263
      end
    end
  end
  inline EmployeeLogOnInfoCardFrame: TEmployeeLogOnInfoCardFrame
    Left = 0
    Top = 208
    Width = 399
    Height = 148
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    ExplicitTop = 208
    ExplicitWidth = 399
    inherited LogOnInfoGroupBox: TGroupBox
      Width = 378
      ExplicitWidth = 378
      inherited LoginEdit: TRegExprValidateEdit
        Width = 263
        ExplicitWidth = 263
      end
      inherited PasswordEdit: TRegExprValidateEdit
        Width = 263
        PasswordChar = '*'
        ExplicitWidth = 263
      end
      inherited RoleComboBox: TComboBox
        Width = 263
        OnChange = EmployeeLogOnInfoCardFrameRoleComboBoxChange
        ExplicitWidth = 263
      end
    end
  end
end
