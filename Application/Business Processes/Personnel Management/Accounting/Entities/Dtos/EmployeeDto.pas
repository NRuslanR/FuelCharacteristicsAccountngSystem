unit EmployeeDto;

interface

uses

  EntityDto,
  RoleDto,
  SysUtils;

type

  TEmployeeDto = class (TEntityDto)

    private

      FRoleDto: TRoleDto;

      procedure SetRoleDto(const Value: TRoleDto);

    public

      Name: String;
      Surname: String;
      Patronymic: String;
      BirthDate: TDateTime;
      Speciality: String;

      property RoleDto: TRoleDto
      read FRoleDto write SetRoleDto;

      destructor Destroy; override;
      
      constructor Create; override;

      function FullName: String;

  end;
  
implementation

uses

  Variants;

{ TEmployeeDto }

constructor TEmployeeDto.Create;
begin

  inherited Create;

  FRoleDto := TRoleDto.Create;

end;

destructor TEmployeeDto.Destroy;
begin

  FreeAndNil(FRoleDto);
  
  inherited;

end;

function TEmployeeDto.FullName: String;
begin

  Result := Surname + ' ' + Name + ' ' + Patronymic;
  
end;

procedure TEmployeeDto.SetRoleDto(const Value: TRoleDto);
begin

  if FRoleDto = Value then
    Exit;

  FreeAndNil(FRoleDto);
  
  FRoleDto := Value;

end;

end.
