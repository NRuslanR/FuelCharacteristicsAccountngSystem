unit FuelCharacteristicsAccountingApplication;

interface

uses

  Application,
  ClientAccount,
  FuelCharacteristicsAccountingApplicationServiceRegistries;

type

  IFuelCharacteristicsAccountingApplication = interface
  ['{00E695D8-522C-4882-B521-3D668A7D5F9F}']

    function GetFuelCharacteristicsAccountingApplicationServiceRegistries:
      IFuelCharacteristicsAccountingApplicationServiceRegistries;

    procedure SetFuelCharacteristicsAccountingApplicationServiceRegistries(
      ServiceRegistries: IFuelCharacteristicsAccountingApplicationServiceRegistries
    );

    function GetUserRoleAccount: TUserRoleAccount;
    procedure SetUserRoleAccount(UserRoleAccount: TUserRoleAccount);

    property ServiceRegistries: IFuelCharacteristicsAccountingApplicationServiceRegistries
    read GetFuelCharacteristicsAccountingApplicationServiceRegistries
    write SetFuelCharacteristicsAccountingApplicationServiceRegistries;

    property UserRoleAccount: TUserRoleAccount
    read GetUserRoleAccount write SetUserRoleAccount;
    
  end;


implementation

end.
