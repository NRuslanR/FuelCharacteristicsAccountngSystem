unit FuelCharacteristicsCalculationInputDto;

interface

uses

  SysUtils;

type

  TReservoirSubLayerCharacteristicsCalculationInputDto = class

    public

      ReservoirSubLayerKindId: Variant;

      constructor Create(const ReservoirSubLayerKindId: Variant);
      
  end;

  TBottomWaterCharacteristicsCalculationInputDto =
    class (TReservoirSubLayerCharacteristicsCalculationInputDto)

      public

        BottomWaterLevel: Single;

        constructor Create(
          const BottomWaterId: Variant;
          const BottomWaterLevel: Single
        );
        
    end;

  TIceLayerCharacteristicsCalculationInputDto =
    class (TReservoirSubLayerCharacteristicsCalculationInputDto)

      public

        AltitudinalActualStencil: Single;

        constructor Create(
          const IceLayerId: Variant;
          const AltitudinalActualStencil: Single
        );
        
    end;

  TFuelCharacteristicsCalculationInputDto = class

    private

      FReservoirSubLayerCharacteristicsCalculationInputDto:
        TReservoirSubLayerCharacteristicsCalculationInputDto;

      procedure SetReservoirSubLayerCharacteristicsCalculationInputDto(
        const Value: TReservoirSubLayerCharacteristicsCalculationInputDto
      );
        
    public

      ReservoirKindId: Variant;

      FuelTemperature: Single;
      FuelRiseLevel: Single;
      FuelDensity: Single;

      destructor Destroy; override;
      
      constructor Create;

      property ReservoirSubLayerCharacteristicsCalculationInputDto:
        TReservoirSubLayerCharacteristicsCalculationInputDto
      read FReservoirSubLayerCharacteristicsCalculationInputDto
      write SetReservoirSubLayerCharacteristicsCalculationInputDto;
      
  end;
  
implementation

uses

  Variants;

{ TFuelCharacteristicsCalculationInputDto }

constructor TFuelCharacteristicsCalculationInputDto.Create;
begin

  inherited;

  ReservoirKindId := Null;

end;

destructor TFuelCharacteristicsCalculationInputDto.Destroy;
begin

  FreeAndNil(FReservoirSubLayerCharacteristicsCalculationInputDto);
  
  inherited;

end;

procedure TFuelCharacteristicsCalculationInputDto.
  SetReservoirSubLayerCharacteristicsCalculationInputDto(
    const Value: TReservoirSubLayerCharacteristicsCalculationInputDto
  );
begin

  if FReservoirSubLayerCharacteristicsCalculationInputDto = Value then
    Exit;

  FreeAndNil(FReservoirSubLayerCharacteristicsCalculationInputDto);
  
  FReservoirSubLayerCharacteristicsCalculationInputDto := Value;

end;

{ TReservoirSubLayerCharacteristicsCalculationInputDto }

constructor TReservoirSubLayerCharacteristicsCalculationInputDto.Create(
  const ReservoirSubLayerKindId: Variant
);
begin

  inherited Create;

  Self.ReservoirSubLayerKindId := ReservoirSubLayerKindId;
  
end;

{ TIceLayerCharacteristicsCalculationInputDto }

constructor TIceLayerCharacteristicsCalculationInputDto.Create(
  const IceLayerId: Variant;
  const AltitudinalActualStencil: Single
);
begin

  inherited Create(IceLayerId);

  Self.AltitudinalActualStencil := AltitudinalActualStencil;

end;

{ TBottomWaterCharacteristicsCalculationInputDto }

constructor TBottomWaterCharacteristicsCalculationInputDto.Create(
  const BottomWaterId: Variant;
  const BottomWaterLevel: Single
);
begin

  inherited Create(BottomWaterId);

  Self.BottomWaterLevel := BottomWaterLevel;
  
end;

end.
