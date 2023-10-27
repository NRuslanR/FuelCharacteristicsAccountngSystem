unit WorkingTimeConditionsDtoMapper;

interface

uses

  EntityDto,
  EntityDtoMapper,
  WorkingTimeConditionsCardFormViewModel,
  WorkingTimeConditionsDto,
  CardFormViewModel,
  SysUtils,
  Classes;

type

  TWorkingTimeConditionsDtoMapper = class (TEntityDtoMapper)

    protected

      function GetEntityDtoClass: TEntityDtoClass; override;
      
    public

      procedure FillEntityDtoFrom(
        EntityDto: TEntityDto;
        CardFormViewModel: TCardFormViewModel
      ); override;

      function MapWorkingTimeConditionsDtoFrom(
        const ViewModel: TWorkingTimeConditionsCardFormViewModel
      ): TWorkingTimeConditionsDto;

  end;

implementation

{ TWorkingTimeConditionsDtoMapper }

procedure TWorkingTimeConditionsDtoMapper.FillEntityDtoFrom(
  EntityDto: TEntityDto;
  CardFormViewModel: TCardFormViewModel
);
var WorkingTimeConditionsDto: TWorkingTimeConditionsDto;
begin

  inherited;

  WorkingTimeConditionsDto := TWorkingTimeConditionsDto(EntityDto);

  with CardFormViewModel as TWorkingTimeConditionsCardFormViewModel do begin

    WorkingTimeConditionsDto.Id := Id.Value;
    WorkingTimeConditionsDto.IsActive := IsActive.Value;
    WorkingTimeConditionsDto.Name := Name.Value;
    WorkingTimeConditionsDto.WorkingDayBeginningTime := WorkingDayBeginningTime.Value;
    WorkingTimeConditionsDto.WorkingDayEndingTime := WorkingDayEndingTime.Value;

  end;

end;

function TWorkingTimeConditionsDtoMapper.GetEntityDtoClass: TEntityDtoClass;
begin

  Result := TWorkingTimeConditionsDto;
  
end;

function TWorkingTimeConditionsDtoMapper.MapWorkingTimeConditionsDtoFrom(
  const ViewModel: TWorkingTimeConditionsCardFormViewModel
): TWorkingTimeConditionsDto;
begin

  Result := TWorkingTimeConditionsDto(MapEntityDtoFrom(ViewModel));
  
end;

end.
