unit unTestReservoirKindsDataSetModule;

interface

uses
  SysUtils, Classes, DB, DBClient, dxmdaset;

type
  TTestReservoirKindsDataSetModule = class(TDataModule)
    ReservoirKindReferenceSuitesMemData: TdxMemData;
    ReservoirKindsMemData: TdxMemData;
    ReservoirKindsClientDataSet: TClientDataSet;
    ReservoirKindReferenceSuitesClientDataSet: TClientDataSet;
    ReservoirKindsMemDatareservoir_kind_name: TStringField;
    ReservoirKindsClientDataSetreservoir_kind_name: TStringField;
    ReservoirKindReferenceSuitesMemDatareservoir_kind_name: TStringField;
    ReservoirKindReferenceSuitesMemDatahsc: TFloatField;
    ReservoirKindReferenceSuitesMemDatacalibration_chart_location: TStringField;
    ReservoirKindReferenceSuitesClientDataSetreservoir_kind_name: TStringField;
    ReservoirKindReferenceSuitesClientDataSethsc: TFloatField;
    ReservoirKindReferenceSuitesClientDataSetcalibration_chart_location: TStringField;
    ReservoirKindsMemDatacan_be_changed: TBooleanField;
    ReservoirKindsMemDatacan_be_removed: TBooleanField;
    ReservoirKindsClientDataSetcan_be_changed: TBooleanField;
    ReservoirKindsClientDataSetcan_be_removed: TBooleanField;
    ReservoirKindReferenceSuitesMemDatacan_be_changed: TBooleanField;
    ReservoirKindReferenceSuitesMemDatacan_be_removed: TBooleanField;
    ReservoirKindReferenceSuitesClientDataSetcan_be_changed: TBooleanField;
    ReservoirKindReferenceSuitesClientDataSetcan_be_removed: TBooleanField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TestReservoirKindsDataSetModule: TTestReservoirKindsDataSetModule;

implementation

{$R *.dfm}

end.
