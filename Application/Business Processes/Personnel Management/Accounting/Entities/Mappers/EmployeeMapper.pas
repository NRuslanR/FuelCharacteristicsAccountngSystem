unit EmployeeMapper;

interface

uses

  Employee,
  Role,
  EmployeeDto,
  RoleMapper,
  SysUtils,
  Classes;

type

  TEmployeeMapper = class

    private

      FRoleMapper: TRoleMapper;

    public

      destructor Destroy; override;
      constructor Create;

      function ToDto(Employee: TEmployee): TEmployeeDto;
      function ToEntity(EmployeeDto: TEmployeeDto): TEmployee;
      
  end;
  
implementation

uses

  AuxVariantFunctions;

{ TEmployeeMapper }

constructor TEmployeeMapper.Create;
begin

  inherited;

  FRoleMapper := TRoleMapper.Create;
  
end;

destructor TEmployeeMapper.Destroy;
begin

  FreeAndNil(FRoleMapper);

  inherited;

end;

function TEmployeeMapper.ToDto(Employee: TEmployee): TEmployeeDto;
begin

  Result := TEmployeeDto.Create;

  try

    Result.Id := Employee.Identity;
    Result.Name := Employee.Name;
    Result.Surname := Employee.Surname;
    Result.Patronymic := Employee.Patronymic;
    Result.BirthDate := Employee.BirthDate;
    Result.Speciality := Employee.Speciality;

    Result.RoleDto := FRoleMapper.ToDto(Employee.Role);

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

function TEmployeeMapper.ToEntity(EmployeeDto: TEmployeeDto): TEmployee;
begin

  Result := TEmployee.Create;

  try

    if not VarIsNullOrEmpty(EmployeeDto.Id)  then
      Result.Identity := EmployeeDto.Id;

    Result.Name := EmployeeDto.Name;
    Result.Surname := EmployeeDto.Surname;
    Result.Patronymic := EmployeeDto.Patronymic;
    Result.BirthDate := EmployeeDto.BirthDate;
    Result.Speciality := EmployeeDto.Speciality;

    Result.Role := FRoleMapper.ToEntity(EmployeeDto.RoleDto);

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;

    end;

  end;

end;

end.
