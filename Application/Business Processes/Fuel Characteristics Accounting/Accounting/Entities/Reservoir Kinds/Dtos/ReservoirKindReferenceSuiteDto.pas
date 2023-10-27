unit ReservoirKindReferenceSuiteDto;

interface

uses

  EntityDto;

type

  TReservoirKindReferenceSuiteDto = class (TEntityDto)

    private
    
      function GetReservoirKindName: String;
      procedure SetReservoirKindName(const Value: String);

    public

      AltitudinalConstantStencil: Variant;
      CalibrationChartLocation: Variant;

      constructor Create; override;
      
      property ReservoirKindName: String
      read GetReservoirKindName write SetReservoirKindName;

  end;

implementation

uses

  Variants;

{ TReservoirKindReferenceSuiteDto }

constructor TReservoirKindReferenceSuiteDto.Create;
begin

  inherited;

  AltitudinalConstantStencil := Null;
  CalibrationChartLocation := Null;
  
end;

function TReservoirKindReferenceSuiteDto.GetReservoirKindName: String;
begin

  Result := Id;

end;

procedure TReservoirKindReferenceSuiteDto.SetReservoirKindName(
  const Value: String);
begin

  Id := Value;
  
end;

end.
