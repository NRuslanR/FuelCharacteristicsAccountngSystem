unit WorkingTimeConditionsDto;

interface

uses

  EntityDto,
  SysUtils;

type

  TWorkingTimeConditionsDto = class (TEntityDto)

    public

      IsActive: Boolean;
      Name: String;
      WorkingDayBeginningTime: TDateTime;
      WorkingDayEndingTime: TDateTime;

  end;

implementation

end.
