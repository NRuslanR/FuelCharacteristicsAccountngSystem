unit StandardFuelCharacteristicsAccountingApplication;

interface

uses

  FuelCharacteristicsAccountingApplication,
  FuelCharacteristicsAccountingApplicationServiceRegistries,
  StandardApplication,
  ApplicationServiceRegistries,
  ClientAccount,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsAccountingApplication =
    class (
      TStandardApplication,
      IFuelCharacteristicsAccountingApplication
    )

      public

        constructor Create(ServiceRegistries: IApplicationServiceRegistries); overload;

        constructor Create(
          ClientAccount: TClientAccount;
          ServiceRegistries: IApplicationServiceRegistries
        ); overload;

        function GetFuelCharacteristicsAccountingApplicationServiceRegistries:
          IFuelCharacteristicsAccountingApplicationServiceRegistries;

        procedure SetFuelCharacteristicsAccountingApplicationServiceRegistries(
          ServiceRegistries: IFuelCharacteristicsAccountingApplicationServiceRegistries
        );

        function GetUserRoleAccount: TUserRoleAccount;
        
        procedure SetUserRoleAccount(UserRoleAccount: TUserRoleAccount);

      published
      
        property ServiceRegistries:
          IFuelCharacteristicsAccountingApplicationServiceRegistries
        read GetFuelCharacteristicsAccountingApplicationServiceRegistries
        write SetFuelCharacteristicsAccountingApplicationServiceRegistries;

        property UserRoleAccount: TUserRoleAccount
        read GetUserRoleAccount write SetUserRoleAccount;

    end;

implementation

{ TStandardFuelCharacteristicsAccountingApplication }

constructor TStandardFuelCharacteristicsAccountingApplication.Create(
  ServiceRegistries: IApplicationServiceRegistries);
begin

  inherited;
  
end;

constructor TStandardFuelCharacteristicsAccountingApplication.Create(
  ClientAccount: TClientAccount;
  ServiceRegistries: IApplicationServiceRegistries);
begin

  inherited;
  
end;

function TStandardFuelCharacteristicsAccountingApplication.
  GetFuelCharacteristicsAccountingApplicationServiceRegistries:
    IFuelCharacteristicsAccountingApplicationServiceRegistries;
begin

  Result :=
    IFuelCharacteristicsAccountingApplicationServiceRegistries(
      inherited ServiceRegistries
    );
  
end;

function TStandardFuelCharacteristicsAccountingApplication.GetUserRoleAccount: TUserRoleAccount;
begin

  Result := TUserRoleAccount(ClientAccount);
  
end;

procedure TStandardFuelCharacteristicsAccountingApplication.
  SetFuelCharacteristicsAccountingApplicationServiceRegistries(
    ServiceRegistries: IFuelCharacteristicsAccountingApplicationServiceRegistries
  );
begin

  SetApplicationServiceRegistries(ServiceRegistries);
  
end;

procedure TStandardFuelCharacteristicsAccountingApplication.SetUserRoleAccount(
  UserRoleAccount: TUserRoleAccount);
begin

  ClientAccount := UserRoleAccount;
  
end;

end.
