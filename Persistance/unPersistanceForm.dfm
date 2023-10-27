object RepositoryTestForm: TRepositoryTestForm
  Left = 0
  Top = 0
  Caption = 'RepositoryTestForm'
  ClientHeight = 316
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TestRoleRepositoryButton: TButton
    Left = 8
    Top = 8
    Width = 185
    Height = 25
    Caption = #1058#1077#1089#1090' '#1088#1077#1087#1086#1079#1080#1090#1086#1088#1080#1103' '#1088#1086#1083#1077#1081
    TabOrder = 0
    OnClick = TestRoleRepositoryButtonClick
  end
  object TestEmployeeRepositoryButton: TButton
    Left = 8
    Top = 48
    Width = 185
    Height = 25
    Caption = #1058#1077#1089#1090' '#1088#1077#1087#1086#1079#1080#1090#1086#1088#1080#1103' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1086#1074
    TabOrder = 1
    OnClick = TestEmployeeRepositoryButtonClick
  end
  object Button1: TButton
    Left = 8
    Top = 88
    Width = 185
    Height = 25
    Caption = #1058#1077#1089#1090' '#1088#1077#1087#1086#1079#1080#1090#1086#1088#1080#1103' '#1082#1072#1088#1090#1086#1095#1077#1082
    TabOrder = 2
    OnClick = Button1Click
  end
  object Connection: TZConnection
    ControlsCodePage = cGET_ACP
    AutoEncodeStrings = False
    ClientCodepage = 'WIN1251'
    Properties.Strings = (
      'controls_cp=GET_ACP'
      'codepage=WIN1251')
    HostName = '127.0.0.1'
    Port = 5432
    Database = 'FuelCharacteristicsAccounting'
    User = 'postgres'
    Password = '123456'
    Protocol = 'postgresql'
    LibraryLocation = 'C:\Program Files (x86)\PostgreSQL\9.6\bin\libpq.dll'
    Top = 288
  end
end
