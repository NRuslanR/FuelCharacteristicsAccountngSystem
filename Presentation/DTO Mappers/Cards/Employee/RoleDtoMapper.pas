unit RoleDtoMapper;

interface

uses

  EmployeeAdministrationCardFormViewModel,
  RoleDto,
  SysUtils,
  Classes;

type

  TRoleDtoMapper = class

    public

      function MapRoleDtoFrom(RoleViewModel: TRoleViewModel): TRoleDto;
      
  end;
  
implementation

{ TRoleDtoMapper }

function TRoleDtoMapper.MapRoleDtoFrom(RoleViewModel: TRoleViewModel): TRoleDto;
begin

  Result := TRoleDto.Create;

  try

    Result.Id := RoleViewModel.Id;
    Result.DisplayName := RoleViewModel.Name;
    
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;

    end;

  end;

end;

end.
