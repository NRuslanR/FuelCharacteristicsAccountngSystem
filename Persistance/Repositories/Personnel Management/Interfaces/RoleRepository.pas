unit RoleRepository;

interface

uses

  DomainObjectRepository,
  Role,
  VariantListUnit;

type

  IRoleRepository = interface (IDomainObjectRepository)
    ['{8C78C196-C1D8-4BAA-B64A-2D5611BAD1A9}']

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

end.
