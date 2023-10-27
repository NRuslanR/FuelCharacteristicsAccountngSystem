unit WorkingTimeConditionsInfoMapper;

interface

uses

  WorkingTimeConditionsMapper,
  WorkingTimeConditionsAccessRights,
  WorkingTimeConditions,
  WorkingTimeConditionsAccessRightsDto,
  WorkingTimeConditionsDto,
  WorkingTimeConditionsInfo,
  SysUtils;

type

  TWorkingTimeConditionsInfoMapper = class

    private

      FWorkingTimeConditionsMapper: TWorkingTimeConditionsMapper;

    public

      destructor Destroy; override;

      constructor Create;

      function MapWorkingTimeConditionsInfoFrom(
        WorkingTimeConditions: TWorkingTimeConditions;
        AccessRights: TWorkingTimeConditionsAccessRights
      ): TWorkingTimeConditionsInfo;

      function MapWorkingTimeConditionsAccessRightsDtoFrom(
        AccessRights: TWorkingTimeConditionsAccessRights
      ): TWorkingTimeConditionsAccessRightsDto;

      property WorkingTimeConditionsMapper: TWorkingTimeConditionsMapper
      read FWorkingTimeConditionsMapper;
      
  end;

  
implementation

{ TWorkingTimeConditionsInfoMapper }

constructor TWorkingTimeConditionsInfoMapper.Create;
begin

  inherited;

  FWorkingTimeConditionsMapper := TWorkingTimeConditionsMapper.Create;

end;

destructor TWorkingTimeConditionsInfoMapper.Destroy;
begin

  FreeAndNil(FWorkingTimeConditionsMapper);
  
  inherited;

end;

function TWorkingTimeConditionsInfoMapper.
  MapWorkingTimeConditionsAccessRightsDtoFrom(
    AccessRights: TWorkingTimeConditionsAccessRights
  ): TWorkingTimeConditionsAccessRightsDto;
begin

  Result := TWorkingTimeConditionsAccessRightsDto.Create;

  try

    Result.CanBeViewed := AccessRights.CanBeViewed;
    Result.CanBeEdited := AccessRights.CanBeEdited;
    Result.CanBeRemoved := AccessRights.CanBeRemoved;
    
  except

    on E: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

function TWorkingTimeConditionsInfoMapper.MapWorkingTimeConditionsInfoFrom(
  WorkingTimeConditions: TWorkingTimeConditions;
  AccessRights: TWorkingTimeConditionsAccessRights
): TWorkingTimeConditionsInfo;
begin

  Result := TWorkingTimeConditionsInfo.Create;

  try

    Result.WorkingTimeConditionsDto :=
      FWorkingTimeConditionsMapper.ToDto(WorkingTimeConditions);

    Result.AccessRightsDto :=
      MapWorkingTimeConditionsAccessRightsDtoFrom(AccessRights);
      
  except

    on E: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

end.
