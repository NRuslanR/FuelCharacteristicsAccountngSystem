unit RoleViewModelMapper;

interface

uses

  EmployeeAdministrationCardFormViewModel,
  RoleDto,
  SysUtils;

type

  TRoleViewModelMapper = class

    public

      function MapRoleViewModelFrom(RoleDto: TRoleDto): TRoleViewModel;
      function MapRoleViewModelsFrom(RoleDtos: TRoleDtos): TRoleViewModels;
      
  end;

implementation

{ TRoleViewModelMapper }

function TRoleViewModelMapper.MapRoleViewModelFrom(
  RoleDto: TRoleDto): TRoleViewModel;
begin

  Result := TRoleViewModel.Create;

  Result.Id := RoleDto.Id;
  Result.Name := RoleDto.DisplayName;
  
end;

function TRoleViewModelMapper.MapRoleViewModelsFrom(
  RoleDtos: TRoleDtos): TRoleViewModels;
var RoleDto: TRoleDto;
begin

  Result := TRoleViewModels.Create;

  try

    for RoleDto in RoleDtos do
      Result.Add(MapRoleViewModelFrom(RoleDto));
      
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;

    end;

  end;

end;

end.
