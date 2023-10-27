program Externals;

uses
  Forms,
  unTestForm in 'Electronic Files\References\Reservoir Kinds\unTestForm.pas' {Form2},
  ReservoirCalibrationChartElectronicFileRegistry in 'Electronic Files\References\Reservoir Kinds\ReservoirCalibrationChartElectronicFileRegistry.pas',
  TableData in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Tables\Interfaces\TableData.pas',
  OLEExcelTableData in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Tables\OLEExcelTableData.pas',
  unTestOLEExcelTableDataForm in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Tables\unTestOLEExcelTableDataForm.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
