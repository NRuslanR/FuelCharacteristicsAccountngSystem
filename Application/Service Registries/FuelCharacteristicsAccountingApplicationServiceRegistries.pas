unit FuelCharacteristicsAccountingApplicationServiceRegistries;

interface

uses

  ApplicationServiceRegistries,
  FuelCharacteristicsAccountingSystemServiceRegistry,
  FuelCharacteristicsAccountingPresentationServiceRegistry,
  FuelCharacteristicsAccountingBusinessServiceRegistry;

type

  IFuelCharacteristicsAccountingApplicationServiceRegistries =
    interface (IApplicationServiceRegistries)

      procedure RegisterSystemServiceRegistry(
        SystemServiceRegistry: IFuelCharacteristicsAccountingSystemServiceRegistry
      );

      function GetSystemServiceRegistry:
        IFuelCharacteristicsAccountingSystemServiceRegistry;

      procedure RegisterPresentationServiceRegistry(
        PresentationServiceRegistry:
          IFuelCharacteristicsAccountingPresentationServiceRegistry
      );

      function GetPresentationServiceRegistry:
        IFuelCharacteristicsAccountingPresentationServiceRegistry;

      procedure RegisterBusinessServiceRegistry(
        BusinessServiceRegistry:
          IFuelCharacteristicsAccountingBusinessServiceRegistry
      );

      function GetBusinessServiceRegistry:
        IFuelCharacteristicsAccountingBusinessServiceRegistry;
        
    end;
  
implementation

end.
