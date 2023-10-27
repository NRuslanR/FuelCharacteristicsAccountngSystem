unit unTestReservoirCalibrationChartsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ReservoirCalibrationChart, NGEReservoirCalibrationChart,
  TableData, OLEExcelTableData, StdCtrls;

type
  TTestReservoirCalibrationChartsForm = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

    Chart: IReservoirCalibrationChart;

    procedure TestNGEReservoirCalibrationChart;
    
  public
    
  end;

var
  TestReservoirCalibrationChartsForm: TTestReservoirCalibrationChartsForm;

implementation

uses

  AuxDebugFunctionsUnit;
  
{$R *.dfm}

procedure TTestReservoirCalibrationChartsForm.Button1Click(Sender: TObject);
begin

  TestNGEReservoirCalibrationChart;
  
end;

procedure TTestReservoirCalibrationChartsForm.FormCreate(Sender: TObject);
var TableData: ITableData;
begin

  TableData :=
    TOLEExcelTableData.Create(
      'C:\Users\admin\Documents\Code Gear\Projects\' +
      'FuelCharacteristicsAccountingSystem\Справочные' +
      ' данные\Резервуары\ГТ_ЦистернаТип62.xlsx'
    );

  Chart := TNGEReservoirCalibrationChart.Create(TableData);

end;

procedure TTestReservoirCalibrationChartsForm.TestNGEReservoirCalibrationChart;
begin

  Edit2.Text :=
    FloatToStr(
      Chart.GetVolume(
        TReservoirCalibrationChartInput.Create(StrToFloat(Edit1.Text))
      )
    );
  
end;

end.
