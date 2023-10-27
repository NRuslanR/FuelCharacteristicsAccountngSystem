unit WorkingTimeConditionsInfo;

interface

uses

  WorkingTimeConditionsDto,
  WorkingTimeConditionsAccessRightsDto,
  SysUtils;

type

  TWorkingTimeConditionsInfo = class

    private

      FWorkingTimeConditionsDto: TWorkingTimeConditionsDto;
      FAccessRightsDto: TWorkingTimeConditionsAccessRightsDto;

      procedure SetAccessRightsDto(
        const Value: TWorkingTimeConditionsAccessRightsDto
      );

      procedure SetWorkingTimeConditionsDto(
        const Value: TWorkingTimeConditionsDto
      );

    public

      destructor Destroy; override;
      
      constructor Create; overload;
      constructor Create(
        WorkingTimeConditionsDto: TWorkingTimeConditionsDto;
        AccessRightsDto: TWorkingTimeConditionsAccessRightsDto
      ); overload;

      property WorkingTimeConditionsDto: TWorkingTimeConditionsDto
      read FWorkingTimeConditionsDto write SetWorkingTimeConditionsDto;

      property AccessRightsDto: TWorkingTimeConditionsAccessRightsDto
      read FAccessRightsDto write SetAccessRightsDto;

  end;

implementation

{ TWorkingTimeConditionsInfo }

constructor TWorkingTimeConditionsInfo.Create(
  WorkingTimeConditionsDto: TWorkingTimeConditionsDto;
  AccessRightsDto: TWorkingTimeConditionsAccessRightsDto
);
begin

  inherited Create;

  Self.WorkingTimeConditionsDto := WorkingTimeConditionsDto;
  Self.AccessRightsDto := AccessRightsDto;
  
end;

constructor TWorkingTimeConditionsInfo.Create;
begin

  inherited;

end;

destructor TWorkingTimeConditionsInfo.Destroy;
begin

  FreeAndNil(FWorkingTimeConditionsDto);
  FreeAndNil(FAccessRightsDto);
  
  inherited;

end;

procedure TWorkingTimeConditionsInfo.SetAccessRightsDto(
  const Value: TWorkingTimeConditionsAccessRightsDto);
begin

  if FAccessRightsDto = Value then
    Exit;

  FreeAndNil(FAccessRightsDto);
  
  FAccessRightsDto := Value;

end;

procedure TWorkingTimeConditionsInfo.SetWorkingTimeConditionsDto(
  const Value: TWorkingTimeConditionsDto);
begin

  if FWorkingTimeConditionsDto = Value then
    Exit;

  FreeAndNil(FWorkingTimeConditionsDto);
  
  FWorkingTimeConditionsDto := Value;

end;

end.
