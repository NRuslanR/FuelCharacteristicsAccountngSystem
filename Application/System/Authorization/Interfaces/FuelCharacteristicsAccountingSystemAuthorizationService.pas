unit FuelCharacteristicsAccountingSystemAuthorizationService;

interface

uses

  RoleDto,
  SystemAuthorizationService;

type

  TFuelCharacteristicsAccountingSystemAuthorizationServiceException =
    class (TSystemAuthorizationServiceException)

    end;
    
  IFuelCharacteristicsAccountingSystemAuthorizationService =
    interface (ISystemAuthorizationService)

      function GetRoles(const ClientIdentity: Variant): TRoleDtos;
      
      function IsClientAccountant(const ClientIdentity: Variant): Boolean;
      function IsClientWarehouseHead(const ClientIdentity: Variant): Boolean;
      function IsClientAircraftTechnician(const ClientIdentity: Variant): Boolean;
      function IsClientAdmin(const ClientIdentity: Variant): Boolean;

      procedure EnsureThatClientIsAccountant(const ClientIdentity: Variant);
      procedure EnsureClientIsWarehouseHead(const ClientIdentity: Variant);
      procedure EnsureClientIsAircraftTechnician(const ClientIdentity: Variant);
      procedure EnsureClientIsAdmin(const ClientIdentity: Variant);

      procedure MakeClientAccountant(const ClientIdentity: Variant);
      procedure MakeClientWarehouseHead(const ClientIdentity: Variant);
      procedure MakeClientAircraftTechnician(const ClientIdentity: Variant);
      procedure MakeClientAdmin(const ClientIdentity: Variant);

    end;


implementation

end.
