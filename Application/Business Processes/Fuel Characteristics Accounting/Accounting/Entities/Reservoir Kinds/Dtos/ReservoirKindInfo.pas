unit ReservoirKindInfo;

interface

uses

  ReservoirKindDto,
  ReservoirKindAccessRightsDto,
  SysUtils;

type

  TReservoirKindInfo = class

    private

      FReservoirKindDto: TReservoirKindDto;
      FReservoirKindAccessRightsDto: TReservoirKindAccessRightsDto;

      procedure SetReservoirKindAccessRightsDto(
        const Value: TReservoirKindAccessRightsDto
      );
      
      procedure SetReservoirKindDto(const Value: TReservoirKindDto);

    public

      destructor Destroy; override;
      constructor Create;

      property ReservoirKindDto: TReservoirKindDto
      read FReservoirKindDto write SetReservoirKindDto;

      property ReservoirKindAccessRightsDto: TReservoirKindAccessRightsDto
      read FReservoirKindAccessRightsDto
      write SetReservoirKindAccessRightsDto;

  end;
  
implementation

{ TReservoirKindInfo }

constructor TReservoirKindInfo.Create;
begin

  inherited;

  FReservoirKindDto := TReservoirKindDto.Create;
  FReservoirKindAccessRightsDto := TReservoirKindAccessRightsDto.Create;
  
end;

destructor TReservoirKindInfo.Destroy;
begin

  FreeAndNil(FReservoirKindDto);
  FreeAndNil(FReservoirKindAccessRightsDto);
  
  inherited;

end;

procedure TReservoirKindInfo.SetReservoirKindAccessRightsDto(
  const Value: TReservoirKindAccessRightsDto);
begin

  if FReservoirKindAccessRightsDto = Value then
    Exit;

  FreeAndNil(FReservoirKindAccessRightsDto);
  
  FReservoirKindAccessRightsDto := Value;

end;

procedure TReservoirKindInfo.SetReservoirKindDto(
  const Value: TReservoirKindDto);
begin

  if FReservoirKindDto = Value then
    Exit;

  FreeAndNil(FReservoirKindDto);
  
  FReservoirKindDto := Value;

end;

end.
