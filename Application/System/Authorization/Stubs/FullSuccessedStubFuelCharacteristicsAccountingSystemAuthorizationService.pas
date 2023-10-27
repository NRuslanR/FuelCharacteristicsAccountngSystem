unit FullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService;

interface

uses

  FullSuccessedStubSystemAuthorizationService,
  FuelCharacteristicsAccountingSystemAuthorizationService,
  RoleDto,
  SysUtils,
  Classes;

type

  TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService =
    class (
      TFullSuccessedStubSystemAuthorizationService,
      IFuelCharacteristicsAccountingSystemAuthorizationService
    )

      public

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

{ TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService }

procedure
TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService.
  EnsureClientIsAdmin(
    const ClientIdentity: Variant
  );
begin

end;

procedure
TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService.
EnsureClientIsAircraftTechnician(
  const ClientIdentity: Variant);
begin

end;

procedure TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService.EnsureClientIsWarehouseHead(
  const ClientIdentity: Variant);
begin

end;

procedure TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService.EnsureThatClientIsAccountant(
  const ClientIdentity: Variant);
begin

end;

function
  TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService.
    GetRoles(
      const ClientIdentity: Variant
    ): TRoleDtos;
begin

  Result := nil;

end;

function TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService.IsClientAccountant(
  const ClientIdentity: Variant): Boolean;
begin

  Result := True;
  
end;

function
  TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService.
    IsClientAdmin(
      const ClientIdentity: Variant
    ): Boolean;
begin

end;

function TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService.IsClientAircraftTechnician(
  const ClientIdentity: Variant): Boolean;
begin

  Result := True;
  
end;

function TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService.IsClientWarehouseHead(
  const ClientIdentity: Variant): Boolean;
begin

  Result := True;
  
end;

procedure TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService.MakeClientAccountant(
  const ClientIdentity: Variant);
begin

end;

procedure
  TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService.
    MakeClientAdmin(
      const ClientIdentity: Variant
    );
begin

end;

procedure TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService.MakeClientAircraftTechnician(
  const ClientIdentity: Variant);
begin

end;

procedure TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService.MakeClientWarehouseHead(
  const ClientIdentity: Variant);
begin

end;

end.
