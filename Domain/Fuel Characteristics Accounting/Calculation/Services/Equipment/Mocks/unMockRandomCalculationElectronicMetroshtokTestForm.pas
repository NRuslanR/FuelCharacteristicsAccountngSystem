unit unMockRandomCalculationElectronicMetroshtokTestForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MockRandomCalculationElectronicMetroshtok, StdCtrls,
  ElectronicMetroshtokCalculationResult;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var Mock: TMockRandomCalculationElectronicMetroshtok;
    I: Integer;
    Res: String;
    CalcRes: TElectronicMetroshtokCalculationResult;
begin

  Mock :=
    TMockRandomCalculationElectronicMetroshtok.Create(
      TFuelCharacteristicFloatValueRange.Create(
        -20, 20
      ),
      TFuelCharacteristicFloatValueRange.Create(
        200, 370
      ),
      TFuelCharacteristicFloatValueRange.Create(
        530, 680
      ),
      TFuelCharacteristicFloatValueRange.Create(
        20, 60
      )
    );

  for I := 0 to 10 do begin

    CalcRes := Mock.PerformCalculation;

    Res :=
      Format(
        'Fuel Temperature: %f' + sLineBreak +
        'Fuel Rise Level: %f' + sLineBreak +
        'Fuel Density: %f' + sLineBreak +
        'Bottom Water Level: %f' + sLineBreak,
        [
          CalcRes.FuelTemperature,
          CalcRes.FuelRiseLevel,
          CalcRes.FuelDensity,
          CalcRes.BottomWaterLevel
        ]
      );

    ShowMessage(Res);

  end;
  
end;

end.
