unit TestDataSetModule;

interface

uses
  SysUtils, Classes, DB, dxmdaset;

type
  TDataModule1 = class(TDataModule)
    TestMemDataSet: TdxMemData;
    TestMemDataSetid: TIntegerField;
    TestMemDataSettemperature: TFloatField;
    TestMemDataSetfuel_rise_level: TFloatField;
    TestMemDataSetfuel_volume: TFloatField;
    TestMemDataSetwho_performed_calculation: TStringField;
    TestMemDataSetcalculation_performing_datetime: TDateTimeField;
    TestMemDataSetcan_be_changed: TBooleanField;
    TestMemDataSetcan_be_removed: TBooleanField;
    TestMemDataSetis_id_generated: TBooleanField;
    TestMemDataSetfuel_kind: TStringField;
    TestMemDataSetreservoir_number: TIntegerField;
    TestMemDataSetdensity: TFloatField;
    TestMemDataSetperformed_calculation_employee_id: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

end.
