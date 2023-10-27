unit ReservoirKindReferenceSuiteInfoMapper;

interface

uses

  ReservoirKindReferenceSuite,
  ReservoirKindReferenceSuiteInfo,
  ReservoirKindReferenceSuiteAccessRights,
  ReservoirKindReferenceSuiteMapper,
  ReservoirKindReferenceSuiteAccessRightsDto,
  SysUtils;

type

  TReservoirKindReferenceSuiteInfoMapper = class

    private

      FReservoirKindReferenceSuiteMapper: TReservoirKindReferenceSuiteMapper;

    public

      destructor Destroy; override;
      constructor Create; overload;

      constructor Create(
        ReservoirKindReferenceSuiteMapper: TReservoirKindReferenceSuiteMapper
      ); overload;

      function MapReservoirKindReferenceSuiteInfoFrom(
        ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
        ReservoirKindReferenceSuiteAccessRights: TReservoirKindReferenceSuiteAccessRights
      ): TReservoirKindReferenceSuiteInfo;

      function MapReservoirKindReferenceSuiteAcessRightsDtoFrom(
        ReservoirKindReferenceSuiteAccessRights:
          TReservoirKindReferenceSuiteAccessRights
      ): TReservoirKindReferenceSuiteAccessRightsDto;

  end;
  
implementation

{ TReservoirKindReferenceSuiteInfoMapper }

constructor TReservoirKindReferenceSuiteInfoMapper.Create;
begin

  inherited;

  FReservoirKindReferenceSuiteMapper := TReservoirKindReferenceSuiteMapper.Create;
  
end;

constructor TReservoirKindReferenceSuiteInfoMapper.Create(
  ReservoirKindReferenceSuiteMapper: TReservoirKindReferenceSuiteMapper);
begin

  inherited Create;

  FReservoirKindReferenceSuiteMapper := ReservoirKindReferenceSuiteMapper;
  
end;

destructor TReservoirKindReferenceSuiteInfoMapper.Destroy;
begin

  FreeAndNil(FReservoirKindReferenceSuiteMapper);
  
  inherited;

end;

function TReservoirKindReferenceSuiteInfoMapper.
  MapReservoirKindReferenceSuiteAcessRightsDtoFrom(
    ReservoirKindReferenceSuiteAccessRights: TReservoirKindReferenceSuiteAccessRights
  ): TReservoirKindReferenceSuiteAccessRightsDto;
begin

  Result := TReservoirKindReferenceSuiteAccessRightsDto.Create;

  try

    Result.CanBeViewed :=
      ReservoirKindReferenceSuiteAccessRights.CanBeViewed;

    Result.CanBeEdited :=
      ReservoirKindReferenceSuiteAccessRights.CanBeEdited;

    Result.CanBeRemoved :=
      ReservoirKindReferenceSuiteAccessRights.CanBeRemoved;

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

function TReservoirKindReferenceSuiteInfoMapper.
  MapReservoirKindReferenceSuiteInfoFrom(
    ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
    ReservoirKindReferenceSuiteAccessRights: TReservoirKindReferenceSuiteAccessRights
  ): TReservoirKindReferenceSuiteInfo;
begin

  Result := TReservoirKindReferenceSuiteInfo.Create;

  try

    Result.ReservoirKindReferenceSuiteDto :=
      FReservoirKindReferenceSuiteMapper.ToDto(ReservoirKindReferenceSuite);

    Result.ReservoirKindReferenceSuiteAccessRightsDto :=
      MapReservoirKindReferenceSuiteAcessRightsDtoFrom(
        ReservoirKindReferenceSuiteAccessRights
      );

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;

    end;

  end;

end;

end.
