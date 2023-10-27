object TestReservoirKindsDataSetModule: TTestReservoirKindsDataSetModule
  OldCreateOrder = False
  Height = 290
  Width = 644
  object ReservoirKindReferenceSuitesMemData: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F0300000014000000010014007265736572766F6972
      5F6B696E645F6E616D65000800000006000400687363001400000001001B0063
      616C6962726174696F6E5F63686172745F6C6F636174696F6E00010F000000D6
      E8F1F2E5F0EDE020F2E8EF20363201FCA9F1D24D2229400106000000C3D22E78
      6C73}
    SortOptions = []
    Left = 88
    Top = 96
    object ReservoirKindReferenceSuitesMemDatareservoir_kind_name: TStringField
      FieldName = 'reservoir_kind_name'
    end
    object ReservoirKindReferenceSuitesMemDatahsc: TFloatField
      FieldName = 'hsc'
    end
    object ReservoirKindReferenceSuitesMemDatacalibration_chart_location: TStringField
      FieldName = 'calibration_chart_location'
    end
    object ReservoirKindReferenceSuitesMemDatacan_be_changed: TBooleanField
      FieldName = 'can_be_changed'
    end
    object ReservoirKindReferenceSuitesMemDatacan_be_removed: TBooleanField
      FieldName = 'can_be_removed'
    end
  end
  object ReservoirKindsMemData: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F0100000014000000010014007265736572766F6972
      5F6B696E645F6E616D6500010F000000D6E8F1F2E5F0EDE020F2E8EF203632}
    SortOptions = []
    Left = 56
    Top = 16
    object ReservoirKindsMemDatareservoir_kind_name: TStringField
      FieldName = 'reservoir_kind_name'
    end
    object ReservoirKindsMemDatacan_be_changed: TBooleanField
      FieldName = 'can_be_changed'
    end
    object ReservoirKindsMemDatacan_be_removed: TBooleanField
      FieldName = 'can_be_removed'
    end
  end
  object ReservoirKindsClientDataSet: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 200
    Top = 16
    Data = {
      A60000009619E0BD010000001800000004000100000003000000900005526563
      496404000100020001000B5345525645525F43414C4302000380FFFF13726573
      6572766F69725F6B696E645F6E616D6501004900000001000557494454480200
      020014000E63616E5F62655F6368616E67656402000300000000000E63616E5F
      62655F72656D6F766564020003000000000000000050010000000FD6E8F1F2E5
      F0EDE020F2E8EF203632}
    object ReservoirKindsClientDataSetreservoir_kind_name: TStringField
      FieldName = 'reservoir_kind_name'
      Size = 0
    end
    object ReservoirKindsClientDataSetcan_be_changed: TBooleanField
      FieldName = 'can_be_changed'
    end
    object ReservoirKindsClientDataSetcan_be_removed: TBooleanField
      FieldName = 'can_be_removed'
    end
  end
  object ReservoirKindReferenceSuitesClientDataSet: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 320
    Top = 96
    Data = {
      F10000009619E0BD010000001800000006000100000003000000CB0005526563
      496404000100020001000B5345525645525F43414C4302000380FFFF13726573
      6572766F69725F6B696E645F6E616D6501004900000001000557494454480200
      020014000368736308000400000000001A63616C6962726174696F6E5F636861
      72745F6C6F636174696F6E01004900000001000557494454480200020014000E
      63616E5F62655F6368616E67656402000300000000000E63616E5F62655F7265
      6D6F76656402000300000000000000000005010000000FD6E8F1F2E5F0EDE020
      F2E8EF203632FCA9F1D24D22294006C3D22E786C73}
    object ReservoirKindReferenceSuitesClientDataSetreservoir_kind_name: TStringField
      FieldName = 'reservoir_kind_name'
    end
    object ReservoirKindReferenceSuitesClientDataSethsc: TFloatField
      FieldName = 'hsc'
    end
    object ReservoirKindReferenceSuitesClientDataSetcalibration_chart_location: TStringField
      FieldName = 'calibration_chart_location'
    end
    object ReservoirKindReferenceSuitesClientDataSetcan_be_changed: TBooleanField
      FieldName = 'can_be_changed'
    end
    object ReservoirKindReferenceSuitesClientDataSetcan_be_removed: TBooleanField
      FieldName = 'can_be_removed'
    end
  end
end
