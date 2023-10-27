unit MockRandomReservoirCalibrationChart;

interface

uses

  ReservoirCalibrationChart,
  SysUtils,
  Classes;

type

  TVolumeRange = record

    LowerBound: Single;
    UpperBound: Single;

    constructor Create(const LowerBound, UpperBound: Single);
    
  end;

  TMockRandomReservoirCalibrationChart =
    class (TAbstractReservoirCalibrationChart)

      private

        FVolumeRange: TVolumeRange;

        function GetRandomVolumeFromRange: Single;
        
      public

        constructor Create(VolumeRange: TVolumeRange);
        
        function GetVolume(Input: TReservoirCalibrationChartInput): Single; override;
        
    end;

implementation

{ TVolumeRange }

constructor TVolumeRange.Create(const LowerBound, UpperBound: Single);
begin

  Self.LowerBound := LowerBound;
  Self.UpperBound := UpperBound;
  
end;

{ TMockRandomReservoirCalibrationChart }

constructor TMockRandomReservoirCalibrationChart.Create(
  VolumeRange: TVolumeRange);
begin

  inherited Create(nil);

  FVolumeRange := VolumeRange;
  
end;

function TMockRandomReservoirCalibrationChart.GetRandomVolumeFromRange: Single;
begin

  with FVolumeRange do
    Result := LowerBound + Round(Random * (UpperBound - LowerBound));

end;

function TMockRandomReservoirCalibrationChart.
  GetVolume(
    Input: TReservoirCalibrationChartInput
  ): Single;
begin

  Result := GetRandomVolumeFromRange;
  
end;

end.
