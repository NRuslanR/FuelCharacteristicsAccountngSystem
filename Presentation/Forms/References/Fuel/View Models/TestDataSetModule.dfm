object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 316
  Width = 800
  object TestMemDataSet: TdxMemData
    Active = True
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F0C0000000400000003000300696400080000000600
      0C0074656D70657261747572650008000000060010006675656C5F726973655F
      6C6576656C000800000006000C006675656C5F766F6C756D6500140000000100
      1A0077686F5F706572666F726D65645F63616C63756C6174696F6E0008000000
      0B00200063616C63756C6174696F6E5F706572666F726D696E675F6461746574
      696D65000200000005000F0063616E5F62655F6368616E676564000200000005
      000F0063616E5F62655F72656D6F76656400020000000500100069735F69645F
      67656E657261746564001400000001000A006675656C5F6B696E640004000000
      030011007265736572766F69725F6E756D62657200080000000600080064656E
      73697479000103000000010000000000006D4001000000000000464001000000
      000040A9400105000000D0E0E4E8EA01000048614EFACC420000000000000100
      000105000000D2E8EF20C001020000000152B81E85EB51384001020000000100
      0000000040A94001000000000056A940010000000000D4AA40010F000000CFE0
      E2E5EB20D1E8EDFCEAE5E2E8F7010000445BF2F6CC4200000000000001000001
      05000000D2E8EF20C10107000000011F85EB51B88E50400101000000013D0AD7
      A3703D3740010000000000F7B04001000000000026A2400112000000CDE8E3EC
      E0F2F3EBEBE8ED20D0F3F1EBE0ED01000082C45EF2CC42000000000000010000
      0105000000D2E8EF20D1010300000001C7293A92CBDB5B40}
    SortOptions = []
    Left = 40
    Top = 24
    object TestMemDataSetid: TIntegerField
      FieldName = 'id'
    end
    object TestMemDataSettemperature: TFloatField
      FieldName = 'temperature'
    end
    object TestMemDataSetfuel_rise_level: TFloatField
      FieldName = 'fuel_rise_level'
    end
    object TestMemDataSetfuel_volume: TFloatField
      FieldName = 'fuel_volume'
    end
    object TestMemDataSetwho_performed_calculation: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'performed_calculation_employee_name'
    end
    object TestMemDataSetcalculation_performing_datetime: TDateTimeField
      FieldName = 'calculation_performing_datetime'
    end
    object TestMemDataSetcan_be_changed: TBooleanField
      FieldName = 'can_be_changed'
    end
    object TestMemDataSetcan_be_removed: TBooleanField
      FieldName = 'can_be_removed'
    end
    object TestMemDataSetis_id_generated: TBooleanField
      FieldName = 'is_id_generated'
    end
    object TestMemDataSetfuel_kind: TStringField
      FieldName = 'fuel_kind'
    end
    object TestMemDataSetreservoir_number: TIntegerField
      FieldName = 'reservoir_number'
    end
    object TestMemDataSetdensity: TFloatField
      FieldName = 'density'
    end
    object TestMemDataSetperformed_calculation_employee_id: TIntegerField
      FieldName = 'performed_calculation_employee_id'
    end
  end
end
