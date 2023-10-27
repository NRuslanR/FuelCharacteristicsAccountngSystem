unit MockReservoirCalibrationChartRegistry;

interface

uses

  ReservoirCalibrationChartRegistry,
  ReservoirCalibrationChart,
  MockRandomReservoirCalibrationChart,
  SysUtils,
  Classes;

type

    
  TMockReservoirCalibrationChartRegistry =
    class (TAbstractReservoirCalibrationChartRegistry)

      private

        FMockRandomReservoirCalibrationChartVolumeRange: TVolumeRange;
        
      public

        constructor Create; overload;
        constructor Create(
          MockRandomReservoirCalibrationChartVolumeRange: TVolumeRange
        ); overload;
        
        function GetReservoirCalibrationChart(
          const CalibrationChartLocation: Variant;
          const Format: TReservoirCalibrationChartFormat = cfNGE
        ): IReservoirCalibrationChart; override;

      public

        property MockRandomReservoirCalibrationChartVolumeRange: TVolumeRange
        read FMockRandomReservoirCalibrationChartVolumeRange
        write FMockRandomReservoirCalibrationChartVolumeRange;
        
    end;

implementation

uses

  Variants;

{ TMockReservoirCalibrationChartRegistry }

constructor TMockReservoirCalibrationChartRegistry.Create;
begin

  inherited;

  FMockRandomReservoirCalibrationChartVolumeRange.LowerBound := 0;
  FMockRandomReservoirCalibrationChartVolumeRange.UpperBound := 0;

end;

constructor TMockReservoirCalibrationChartRegistry.Create(
  MockRandomReservoirCalibrationChartVolumeRange: TVolumeRange);
begin

  inherited Create;

  FMockRandomReservoirCalibrationChartVolumeRange :=
    MockRandomReservoirCalibrationChartVolumeRange;
    
end;

function TMockReservoirCalibrationChartRegistry.
  GetReservoirCalibrationChart(
    const CalibrationChartLocation: Variant;
    const Format: TReservoirCalibrationChartFormat = cfNGE
  ): IReservoirCalibrationChart;
begin

  if
    CalibrationChartLocation = 'MockRandomReservoirCalibrationChart'
  then begin

    Result :=
      TMockRandomReservoirCalibrationChart.Create(
        FMockRandomReservoirCalibrationChartVolumeRange
      );

  end

  else begin

    raise TReservoirCalibrationChartRegistryException.CreateFmt(
      'Разновидность фиктивной ' +
      'градуировочной таблицы "%s" ' +
      'не найдена',
      [
        VarToStr(CalibrationChartLocation)
      ]
    );
    
  end;
  
end;

end.
