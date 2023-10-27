unit RoleMapper;

interface

uses

  Role,
  RoleDto,
  SysUtils;

type

  TRoleMapper = class

    public

      function ToDto(Role: TRole): TRoleDto;
      function ToEntity(RoleDto: TRoleDto): TRole;

      function ToDtos(Roles: TRoles): TRoleDtos;
      function ToEntities(RoleDtos: TRoleDtos): TRoles;

  end;
  
implementation

uses

  AuxVariantFunctions;
  
{ TRoleMapper }

function TRoleMapper.ToDto(Role: TRole): TRoleDto;
begin

  Result := TRoleDto.Create;

  Result.Id := Role.Identity;
  Result.Name := Role.Name;
  Result.DisplayName := Role.DisplayName;
  
end;

function TRoleMapper.ToDtos(Roles: TRoles): TRoleDtos;
var Role: TRole;
begin

  Result := TRoleDtos.Create;

  for Role in Roles do
    Result.Add(ToDto(Role));
    
end;

function TRoleMapper.ToEntities(RoleDtos: TRoleDtos): TRoles;
var RoleDto: TRoleDto;
begin

  Result := TRoles.Create;

  for RoleDto in RoleDtos do
    Result.Add(ToEntity(RoleDto));

end;

function TRoleMapper.ToEntity(RoleDto: TRoleDto): TRole;
begin

  Result := TRole.Create;

  if not VarIsNullOrEmpty(RoleDto.Id) then
    Result.Identity := RoleDto.Id;

  if Trim(RoleDto.Name) <> '' then
    Result.Name := RoleDto.Name;

  if Trim(RoleDto.DisplayName) <> '' then
    Result.DisplayName := RoleDto.DisplayName;
  
end;

end.
