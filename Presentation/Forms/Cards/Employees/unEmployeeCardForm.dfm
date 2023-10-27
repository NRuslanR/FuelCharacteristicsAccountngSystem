inherited EmployeeCardForm: TEmployeeCardForm
  Caption = 'EmployeeCardForm'
  ClientHeight = 218
  ClientWidth = 374
  Constraints.MaxHeight = 257
  Constraints.MinHeight = 257
  Constraints.MinWidth = 390
  Position = poDesktopCenter
  ExplicitWidth = 390
  ExplicitHeight = 257
  DesignSize = (
    374
    218)
  PixelsPerInch = 96
  TextHeight = 13
  inherited btnOK: TcxButton
    Left = 204
    Top = 185
    LookAndFeel.SkinName = 'UserSkin'
    ExplicitLeft = 204
    ExplicitTop = 185
  end
  inherited btnCancel: TcxButton
    Left = 291
    Top = 185
    LookAndFeel.SkinName = ''
    ExplicitLeft = 291
    ExplicitTop = 185
  end
  inline EmployeeCardFrame: TEmployeeCardFrame
    Left = 0
    Top = 0
    Width = 374
    Height = 177
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 374
    ExplicitHeight = 177
    DesignSize = (
      374
      177)
    inherited EmployeePersonnelInfoGroupBox: TGroupBox
      inherited BirthDateTimePicker: TDateTimePicker
        Width = 268
        ExplicitWidth = 268
      end
      inherited NameEdit: TRegExprValidateEdit
        Width = 268
        ExplicitWidth = 268
      end
      inherited PatronymicEdit: TRegExprValidateEdit
        Width = 268
        ExplicitWidth = 268
      end
      inherited SpecialityComboBox: TComboBox
        Width = 268
        Style = csDropDownList
        OnChange = EmployeeCardFrameSpecialityComboBoxChange
        ExplicitWidth = 268
      end
      inherited SurnameEdit: TRegExprValidateEdit
        Width = 268
        ExplicitWidth = 268
      end
    end
  end
end
