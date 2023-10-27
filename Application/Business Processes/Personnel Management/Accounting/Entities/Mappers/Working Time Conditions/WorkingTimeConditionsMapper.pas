unit WorkingTimeConditionsMapper;

interface

uses

  SysUtils,
  WorkingTimeConditionsDto,
  WorkingTimeConditions;

type

  TWorkingTimeConditionsMapper = class

    public

      function ToDto(WorkingTimeConditions: TWorkingTimeConditions):
        TWorkingTimeConditionsDto;

      procedure FillEntityFromDto(
        WorkingTimeConditions: TWorkingTimeConditions;
        Dto: TWorkingTimeConditionsDto
      );
      
  end;

implementation

{ TWorkingTimeConditionsMapper }

procedure TWorkingTimeConditionsMapper.FillEntityFromDto(
  WorkingTimeConditions: TWorkingTimeConditions;
  Dto: TWorkingTimeConditionsDto);
begin

  WorkingTimeConditions.Identity := Dto.Id;
  WorkingTimeConditions.IsActive := Dto.IsActive;
  WorkingTimeConditions.Name := Dto.Name;
  WorkingTimeConditions.WorkingDayBeginningTime := Dto.WorkingDayBeginningTime;
  WorkingTimeConditions.WorkingDayEndingTime := Dto.WorkingDayEndingTime;
  
end;

function TWorkingTimeConditionsMapper.ToDto(
  WorkingTimeConditions: TWorkingTimeConditions
): TWorkingTimeConditionsDto;
begin

  Result := TWorkingTimeConditionsDto.Create;

  try

    Result.Id := WorkingTimeConditions.Identity;
    Result.IsActive := WorkingTimeConditions.IsActive;
    Result.Name := WorkingTimeConditions.Name;
    Result.WorkingDayBeginningTime := WorkingTimeConditions.WorkingDayBeginningTime;
    Result.WorkingDayEndingTime := WorkingTimeConditions.WorkingDayEndingTime;
    
  except

    on E: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

end.
