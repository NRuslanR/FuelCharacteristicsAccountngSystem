unit ReservoirKindReferenceSuiteInfo;

interface

uses

  ReservoirKindReferenceSuiteDto,
  ReservoirKindReferenceSuiteAccessRightsDto,
  SysUtils;

type

  TReservoirKindReferenceSuiteInfo = class

    private

      FReservoirKindReferenceSuiteDto: TReservoirKindReferenceSuiteDto;

      FReservoirKindReferenceSuiteAccessRightsDto:
        TReservoirKindReferenceSuiteAccessRightsDto;

      procedure SetReservoirKindReferenceSuiteAccessRightsDto(
        const Value: TReservoirKindReferenceSuiteAccessRightsDto
      );

      procedure SetReservoirKindReferenceSuiteDto(
        const Value: TReservoirKindReferenceSuiteDto
      );

    public

      destructor Destroy; override;
      constructor Create;

      property ReservoirKindReferenceSuiteDto: TReservoirKindReferenceSuiteDto
      read FReservoirKindReferenceSuiteDto
      write SetReservoirKindReferenceSuiteDto;

      property ReservoirKindReferenceSuiteAccessRightsDto:
        TReservoirKindReferenceSuiteAccessRightsDto
      read FReservoirKindReferenceSuiteAccessRightsDto
      write SetReservoirKindReferenceSuiteAccessRightsDto;

  end;

implementation

{ TReservoirKindReferenceSuiteInfo }

constructor TReservoirKindReferenceSuiteInfo.Create;
begin

  inherited;

  FReservoirKindReferenceSuiteDto := TReservoirKindReferenceSuiteDto.Create;

  FReservoirKindReferenceSuiteAccessRightsDto :=
    TReservoirKindReferenceSuiteAccessRightsDto.Create;
    
end;

destructor TReservoirKindReferenceSuiteInfo.Destroy;
begin

  FreeAndNil(FReservoirKindReferenceSuiteDto);
  FreeAndNil(FReservoirKindReferenceSuiteAccessRightsDto);
  
  inherited;

end;

procedure TReservoirKindReferenceSuiteInfo.
  SetReservoirKindReferenceSuiteAccessRightsDto(
    const Value: TReservoirKindReferenceSuiteAccessRightsDto
  );
begin

  if FReservoirKindReferenceSuiteAccessRightsDto = Value then
    Exit;

  FreeAndNil(FReservoirKindReferenceSuiteAccessRightsDto);

  FReservoirKindReferenceSuiteAccessRightsDto := Value;

end;

procedure TReservoirKindReferenceSuiteInfo.SetReservoirKindReferenceSuiteDto(
  const Value: TReservoirKindReferenceSuiteDto);
begin

  if FReservoirKindReferenceSuiteDto = Value then
    Exit;

  FreeAndNil(FReservoirKindReferenceSuiteDto);
  
  FReservoirKindReferenceSuiteDto := Value;

end;

end.
