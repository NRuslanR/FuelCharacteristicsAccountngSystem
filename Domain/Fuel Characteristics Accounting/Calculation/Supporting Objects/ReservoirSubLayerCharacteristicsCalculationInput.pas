unit ReservoirSubLayerCharacteristicsCalculationInput;

interface

uses

  DomainObjectValueUnit,
  SysUtils,
  Classes;

type

  TReservoirSubLayerCharacteristicsCalculationInput = class (TDomainObjectValue)

    protected

      FSubLayerName: String;

      procedure SetSubLayerName(const Value: String);

      constructor Create(const SubLayerName: String);
      
    published

      property SubLayerName: String
      read FSubLayerName write SetSubLayerName;

  end;

  TBottomWaterCharacteristicsCalculationInput =
    class (TReservoirSubLayerCharacteristicsCalculationInput)

      private

        FBottomWaterLevel: Single;
        
        procedure SetBottomWaterLevel(const Value: Single);
        
      public

        constructor Create(
          const BottomWaterName: String;
          const BottomWaterLevel: Single
        ); overload;
        
        property BottomWaterLevel: Single
        read FBottomWaterLevel write SetBottomWaterLevel;

    end;

  TIceLayerCharacteristicsCalculationInput =
    class (TReservoirSubLayerCharacteristicsCalculationInput)

      private

        FAltitudinalActualStencil: Single;

        procedure SetAltitudinalActualStencil(const Value: Single);
        
      public

        constructor Create(
          const IceLayerName: String;
          const AltitudinalActualStencil: Single
        ); overload;

        property AltitudinalActualStencil: Single
        read FAltitudinalActualStencil write SetAltitudinalActualStencil;

    end;

implementation

{ TReservoirSubLayerCharacteristicsCalculationInput }

constructor TReservoirSubLayerCharacteristicsCalculationInput.Create(
  const SubLayerName: String);
begin

  inherited Create;

  FSubLayerName := SubLayerName;
  
end;

procedure TReservoirSubLayerCharacteristicsCalculationInput.SetSubLayerName(
  const Value: String);
begin

  FSubLayerName := SubLayerName;

end;

{ TIceLayerCharacteristicsCalculationInput }


constructor TIceLayerCharacteristicsCalculationInput.Create(
  const IceLayerName: String;
  const AltitudinalActualStencil: Single
);
begin

  inherited Create(IceLayerName);

  FAltitudinalActualStencil := AltitudinalActualStencil;
  
end;

procedure TIceLayerCharacteristicsCalculationInput.SetAltitudinalActualStencil(
  const Value: Single);
begin

  FAltitudinalActualStencil := Value;

end;

{ TBottomWaterCharacteristicsCalculationInput }

constructor TBottomWaterCharacteristicsCalculationInput.Create(
  const BottomWaterName: String;
  const BottomWaterLevel: Single
);
begin

  inherited Create(BottomWaterName);

  FBottomWaterLevel := BottomWaterLevel;
  
end;

procedure TBottomWaterCharacteristicsCalculationInput.SetBottomWaterLevel(
  const Value: Single);
begin

  FBottomWaterLevel := Value;

end;

end.
