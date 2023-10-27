unit ReservoirKindInfoMapper;

interface

uses

  ReservoirKindMapper,
  ReservoirKindInfo,
  ReservoirKind,
  ReservoirKindAccessRightsDto,
  ReservoirKindAccessRights,
  SysUtils;

type

  TReservoirKindInfoMapper = class

    private

      FReservoirKindMapper: TReservoirKindMapper;

      function MapReservoirKindAccessRightsDtoFrom(
        ReservoirKindAccessRights: TReservoirKindAccessRights
      ): TReservoirKindAccessRightsDto;

    public

      destructor Destroy; override;
      constructor Create;

      function MapReservoirKindInfoFrom(
        ReservoirKind: TReservoirKind;
        ReservoirKindAccessRights: TReservoirKindAccessRights
      ): TReservoirKindInfo;
      
  end;

implementation

{ TReservoirKindInfoMapper }

constructor TReservoirKindInfoMapper.Create;
begin

  inherited;

  FReservoirKindMapper := TReservoirKindMapper.Create;

end;

destructor TReservoirKindInfoMapper.Destroy;
begin

  FreeAndNil(FReservoirKindMapper);
  
  inherited;

end;

function TReservoirKindInfoMapper.MapReservoirKindAccessRightsDtoFrom(
  ReservoirKindAccessRights: TReservoirKindAccessRights
): TReservoirKindAccessRightsDto;
begin

  Result := TReservoirKindAccessRightsDto.Create;

  Result.CanBeViewed := ReservoirKindAccessRights.CanBeViewed;
  Result.CanBeEdited := ReservoirKindAccessRights.CanBeEdited;
  Result.CanBeRemoved := ReservoirKindAccessRights.CanBeRemoved;

end;

function TReservoirKindInfoMapper.MapReservoirKindInfoFrom(
  ReservoirKind: TReservoirKind;
  ReservoirKindAccessRights: TReservoirKindAccessRights
): TReservoirKindInfo;
begin

  Result := TReservoirKindInfo.Create;

  try

    Result.ReservoirKindDto := FReservoirKindMapper.ToDto(ReservoirKind);
    Result.ReservoirKindAccessRightsDto :=
      MapReservoirKindAccessRightsDtoFrom(ReservoirKindAccessRights);
      
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;

    end;

  end;

end;

end.
