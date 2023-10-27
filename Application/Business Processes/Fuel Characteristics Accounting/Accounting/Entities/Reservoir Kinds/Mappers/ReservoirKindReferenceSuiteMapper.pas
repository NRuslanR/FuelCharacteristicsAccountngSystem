unit ReservoirKindReferenceSuiteMapper;

interface

uses

  ReservoirKindReferenceSuite,
  ReservoirKindReferenceSuiteDto,
  SysUtils;

type

  TReservoirKindReferenceSuiteMapper = class

    public

      function ToDto(
        ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
      ): TReservoirKindReferenceSuiteDto;

      procedure FillEntityFromDto(
        ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
        ReservoirKindReferenceSuiteDto: TReservoirKindReferenceSuiteDto
      );
      
  end;

implementation

{ TReservoirKindReferenceSuiteMapper }

procedure TReservoirKindReferenceSuiteMapper.FillEntityFromDto(
  ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
  ReservoirKindReferenceSuiteDto: TReservoirKindReferenceSuiteDto
);
begin

  ReservoirKindReferenceSuite.ReservoirKindName :=
    ReservoirKindReferenceSuiteDto.ReservoirKindName;

  ReservoirKindReferenceSuite.AltitudinalConstantStencil :=
    ReservoirKindReferenceSuiteDto.AltitudinalConstantStencil;

  ReservoirKindReferenceSuite.CalibrationChartLocation :=
    ReservoirKindReferenceSuiteDto.CalibrationChartLocation;
    
end;

function TReservoirKindReferenceSuiteMapper.ToDto(
  ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
): TReservoirKindReferenceSuiteDto;
begin

  Result := TReservoirKindReferenceSuiteDto.Create;

  try

    Result.Id :=
      ReservoirKindReferenceSuite.Identity;
      
    Result.AltitudinalConstantStencil :=
      ReservoirKindReferenceSuite.AltitudinalConstantStencil;

    Result.CalibrationChartLocation :=
      ReservoirKindReferenceSuite.CalibrationChartLocation;

    Result.ReservoirKindName :=
      ReservoirKindReferenceSuite.ReservoirKindName;
      
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

end.
