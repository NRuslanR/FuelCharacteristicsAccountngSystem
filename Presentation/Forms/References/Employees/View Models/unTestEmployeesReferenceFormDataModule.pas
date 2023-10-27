unit unTestEmployeesReferenceFormDataModule;

interface

uses
  SysUtils, Classes, DB, dxmdaset, DBClient;

type
  TTestEmployeesReferenceFormDataModule = class(TDataModule)
    TestEmployeesMemData: TdxMemData;
    TestEmployeesMemDataid: TIntegerField;
    TestEmployeesMemDataname: TStringField;
    TestEmployeesMemDatasurname: TStringField;
    TestEmployeesMemDatapatronymic: TStringField;
    TestEmployeesMemDatabirth_date: TDateTimeField;
    TestEmployeesMemDataspeciality: TStringField;
    TestEmployeesMemDatais_record_id_generated: TBooleanField;
    TestEmployeesMemDatacan_be_changed: TBooleanField;
    TestEmployeesMemDatacan_be_removed: TBooleanField;
    TestEmployeesClientDataSet: TClientDataSet;
    TestEmployeesClientDataSetid: TIntegerField;
    TestEmployeesClientDataSetname: TStringField;
    TestEmployeesClientDataSetsurname: TStringField;
    TestEmployeesClientDataSetpatronymic: TStringField;
    TestEmployeesClientDataSetbirth_date: TDateTimeField;
    TestEmployeesClientDataSetspeciality: TStringField;
    TestEmployeesClientDataSetcan_be_changed: TBooleanField;
    TestEmployeesClientDataSetcan_be_removed: TBooleanField;
    TestEmployeesClientDataSetis_record_id_generated: TBooleanField;
    TestEmployeesAdminMemData: TdxMemData;
    TestEmployeesAdminMemDataid: TIntegerField;
    TestEmployeesAdminMemDataname: TStringField;
    TestEmployeesAdminMemDatasurname: TStringField;
    TestEmployeesAdminMemDatapatronymic: TStringField;
    TestEmployeesAdminMemDatabirth_date: TDateTimeField;
    TestEmployeesAdminMemDataspeciality: TStringField;
    TestEmployeesAdminMemDatais_record_id_generated: TBooleanField;
    TestEmployeesAdminMemDatacan_be_changed: TBooleanField;
    TestEmployeesAdminMemDatacan_be_removed: TBooleanField;
    TestEmployeesAdminMemDatalogin: TStringField;
    TestEmployeesAdminMemDatarole_name: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TestEmployeesReferenceFormDataModule: TTestEmployeesReferenceFormDataModule;

implementation

{$R *.dfm}

end.
