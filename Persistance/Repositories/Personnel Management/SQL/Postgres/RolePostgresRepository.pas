unit RolePostgresRepository;

interface

uses

  AbstractPostgresRepositoryUnit,
  AbstractRepositoryCriteriaUnit,
  DomainObjectUnit,
  DataReader,
  QueryExecutor,
  VariantListUnit,
  RoleRepository,
  DBTableMappingUnit,
  SysUtils,
  Role,
  Classes;

type

  TRolePostgresRepository =
    class (TAbstractPostgresRepository, IRoleRepository)

      protected

        procedure CustomizeTableMapping(
          TableMapping: TDBTableMapping
        ); override;

      public

        constructor Create(QueryExecutor: IQueryExecutor);
        
        function AddRole(Role: TRole): Boolean;
        function AddRoles(Roles: TRoles): Boolean;
        function UpdateRole(Role: TRole): Boolean;
        function UpdateRoles(Roles: TRoles): Boolean;
        function RemoveRole(Role: TRole): Boolean;
        function RemoveRoles(Roles: TRoles): Boolean;
        function FindRoleById(const RoleId: Variant): TRole;
        function FindRolesByIds(const RoleIds: TVariantList): TRoles;
        function GetAllRoles: TRoles;

    end;

implementation

uses

  RoleTableDefinition;
  
{ TRolePostgresRepository }

constructor TRolePostgresRepository.Create(QueryExecutor: IQueryExecutor);
begin

  inherited;
  
end;

procedure TRolePostgresRepository.CustomizeTableMapping(
  TableMapping: TDBTableMapping);
begin

  inherited;

  TableMapping.SetTableNameMapping(ROLE_TABLE_NAME, TRole, TRoles);

  TableMapping.AddColumnMappingForSelect(
    ROLE_TABLE_ID_COLUMN_NAME, 'Identity'
  );

  TableMapping.AddColumnMappingForSelect(
    ROLE_TABLE_NAME_COLUMN_NAME, 'Name'
  );

  TableMapping.AddColumnMappingForSelect(
    ROLE_TABLE_DISPLAY_NAME_COLUMN_NAME, 'DisplayName'
  );

  TableMapping.AddColumnMappingForModification(
    ROLE_TABLE_NAME_COLUMN_NAME, 'Name'
  );

  TableMapping.AddColumnMappingForModification(
    ROLE_TABLE_DISPLAY_NAME_COLUMN_NAME, 'DisplayName'
  );

  TableMapping.AddPrimaryKeyColumnMapping(
    ROLE_TABLE_ID_COLUMN_NAME, 'Identity'
  );

end;

function TRolePostgresRepository.AddRole(Role: TRole): Boolean;
begin

  Result := Add(Role);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TRolePostgresRepository.AddRoles(Roles: TRoles): Boolean;
begin

  Result := AddDomainObjectList(Roles);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TRolePostgresRepository.FindRoleById(const RoleId: Variant): TRole;
begin

  Result := TRole(FindDomainObjectByIdentity(RoleId));

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TRolePostgresRepository.FindRolesByIds(
  const RoleIds: TVariantList): TRoles;
begin

  Result := TRoles(FindDomainObjectsByIdentities(RoleIds));

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TRolePostgresRepository.GetAllRoles: TRoles;
begin

  Result := TRoles(LoadAll);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TRolePostgresRepository.RemoveRole(Role: TRole): Boolean;
begin

  Result := Remove(Role);

  ThrowExceptionIfErrorIsNotUnknown;

end;

function TRolePostgresRepository.RemoveRoles(Roles: TRoles): Boolean;
begin

  Result := RemoveDomainObjectList(Roles);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TRolePostgresRepository.UpdateRole(Role: TRole): Boolean;
begin

  Result := Update(Role);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TRolePostgresRepository.UpdateRoles(Roles: TRoles): Boolean;
begin

  Result := UpdateDomainObjectList(Roles);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

end.
