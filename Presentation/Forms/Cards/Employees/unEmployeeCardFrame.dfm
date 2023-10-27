object EmployeeCardFrame: TEmployeeCardFrame
  Left = 0
  Top = 0
  Width = 401
  Height = 217
  TabOrder = 0
  DesignSize = (
    401
    217)
  object EmployeePersonnelInfoGroupBox: TGroupBox
    Left = 8
    Top = 8
    Width = 385
    Height = 201
    Anchors = [akLeft, akTop, akRight]
    Caption = #1051#1080#1095#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
    TabOrder = 0
    DesignSize = (
      385
      201)
    object BirthDateLabel: TLabel
      Left = 8
      Top = 128
      Width = 84
      Height = 13
      Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103':'
    end
    object NameLabel: TLabel
      Left = 69
      Top = 23
      Width = 23
      Height = 13
      Caption = #1048#1084#1103':'
    end
    object PatronymicLabel: TLabel
      Left = 39
      Top = 94
      Width = 53
      Height = 13
      Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
    end
    object SpecialityLabel: TLabel
      Left = 31
      Top = 163
      Width = 61
      Height = 13
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
    end
    object SurnameLabel: TLabel
      Left = 44
      Top = 59
      Width = 48
      Height = 13
      Caption = #1060#1072#1084#1080#1083#1080#1103':'
    end
    object BirthDateTimePicker: TDateTimePicker
      Left = 98
      Top = 126
      Width = 270
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Date = 43874.612518425930000000
      Time = 43874.612518425930000000
      TabOrder = 0
    end
    object NameEdit: TRegExprValidateEdit
      Left = 98
      Top = 20
      Width = 270
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      InvalidHint = #1048#1084#1103' '#1085#1077' '#1091#1082#1072#1079#1072#1085#1086
      InvalidColor = 10520575
      RegularExpression = '.+'
    end
    object PatronymicEdit: TRegExprValidateEdit
      Left = 98
      Top = 91
      Width = 270
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      InvalidHint = #1054#1090#1095#1077#1089#1090#1074#1086' '#1085#1077' '#1091#1082#1072#1079#1072#1085#1086
      InvalidColor = 10520575
      RegularExpression = '.+'
    end
    object SpecialityComboBox: TComboBox
      Left = 98
      Top = 160
      Width = 270
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 3
    end
    object SurnameEdit: TRegExprValidateEdit
      Left = 98
      Top = 56
      Width = 270
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
      InvalidHint = #1060#1072#1084#1080#1083#1080#1103' '#1085#1077' '#1091#1082#1072#1079#1072#1085#1072
      InvalidColor = 10520575
      RegularExpression = '.+'
    end
  end
end
