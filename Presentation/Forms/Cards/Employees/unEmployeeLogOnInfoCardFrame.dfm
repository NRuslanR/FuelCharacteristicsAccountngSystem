object EmployeeLogOnInfoCardFrame: TEmployeeLogOnInfoCardFrame
  Left = 0
  Top = 0
  Width = 388
  Height = 148
  TabOrder = 0
  DesignSize = (
    388
    148)
  object LogOnInfoGroupBox: TGroupBox
    Left = 8
    Top = 8
    Width = 372
    Height = 133
    Anchors = [akLeft, akTop, akRight]
    Caption = #1044#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1074#1093#1086#1076#1072' '#1074' '#1089#1080#1089#1090#1077#1084#1091
    TabOrder = 0
    DesignSize = (
      372
      133)
    object LoginLabel: TLabel
      Left = 58
      Top = 27
      Width = 34
      Height = 13
      Caption = #1051#1086#1075#1080#1085':'
    end
    object PasswordLabel: TLabel
      Left = 51
      Top = 62
      Width = 41
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100':'
    end
    object RoleLabel: TLabel
      Left = 64
      Top = 96
      Width = 28
      Height = 13
      Caption = #1056#1086#1083#1100':'
    end
    object LoginEdit: TRegExprValidateEdit
      Left = 98
      Top = 24
      Width = 257
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      InvalidHint = #1053#1077' '#1091#1082#1072#1079#1072#1085' '#1083#1086#1075#1080#1085
      InvalidColor = 10520575
      RegularExpression = '.+'
    end
    object PasswordEdit: TRegExprValidateEdit
      Left = 98
      Top = 59
      Width = 257
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      InvalidColor = 10520575
      RegularExpression = '.*'
    end
    object RoleComboBox: TComboBox
      Left = 98
      Top = 94
      Width = 257
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 2
    end
  end
end
