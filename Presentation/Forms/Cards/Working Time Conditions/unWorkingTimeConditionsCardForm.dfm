inherited WorkingTimeConditionsCardForm: TWorkingTimeConditionsCardForm
  Caption = #1056#1077#1078#1080#1084' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1074#1088#1077#1084#1077#1085#1080
  ClientHeight = 131
  ClientWidth = 396
  ExplicitWidth = 412
  ExplicitHeight = 170
  PixelsPerInch = 96
  TextHeight = 13
  object WorkingDayBeginningTimeLabel: TLabel [0]
    Left = 34
    Top = 17
    Width = 145
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1085#1072#1095#1072#1083#1072' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1076#1085#1103':'
  end
  object WorkingDayEndingTimeLabel: TLabel [1]
    Left = 16
    Top = 51
    Width = 163
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1076#1085#1103':'
  end
  inherited btnOK: TcxButton
    Left = 226
    Top = 98
    LookAndFeel.SkinName = 'UserSkin'
  end
  inherited btnCancel: TcxButton
    Left = 313
    Top = 98
    LookAndFeel.SkinName = 'UserSkin'
  end
  object WorkingDayBeginningTimePicker: TDateTimePicker
    Left = 185
    Top = 16
    Width = 186
    Height = 21
    Date = 43965.624385011570000000
    Time = 43965.624385011570000000
    Kind = dtkTime
    TabOrder = 2
  end
  object WorkingDayEndingTimePicker: TDateTimePicker
    Left = 185
    Top = 50
    Width = 186
    Height = 21
    Date = 43965.625195092590000000
    Time = 43965.625195092590000000
    Kind = dtkTime
    TabOrder = 3
  end
end
