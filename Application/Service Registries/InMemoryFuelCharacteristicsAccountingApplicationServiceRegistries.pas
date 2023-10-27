unit InMemoryFuelCharacteristicsAccountingApplicationServiceRegistries;

interface

uses

  InMemoryApplicationServiceRegistries,
  FuelCharacteristicsAccountingApplicationServiceRegistries,
  FuelCharacteristicsAccountingSystemServiceRegistry,
  FuelCharacteristicsAccountingPresentationServiceRegistry,
  FuelCharacteristicsAccountingBusinessServiceRegistry,
  SysUtils,
  Classes;

type

  TInMemoryFuelCharacteristicsAccountingApplicationServiceRegistries =
    class (
      TInMemoryApplicationServiceRegistries,
      IFuelCharacteristicsAccountingApplicationServiceRegistries
    )

      public

        procedure RegisterSystemServiceRegistry(
          SystemServiceRegistry: IFuelCharacteristicsAccountingSystemServiceRegistry
        );

        function GetSystemServiceRegistry:
          IFuelCharacteristicsAccountingSystemServiceRegistry;

      public

        procedure RegisterPresentationServiceRegistry(
          PresentationServiceRegistry:
            IFuelCharacteristicsAccountingPresentationServiceRegistry
        );

        function GetPresentationServiceRegistry:
          IFuelCharacteristicsAccountingPresentationServiceRegistry;

      public

        procedure RegisterBusinessServiceRegistry(
          BusinessServiceRegistry:
            IFuelCharacteristicsAccountingBusinessServiceRegistry
        );

        function GetBusinessServiceRegistry:
          IFuelCharacteristicsAccountingBusinessServiceRegistry;

    end;

implementation

uses

  TypInfo;
  
{ TInMemoryFuelCharacteristicsAccountingApplicationServiceRegistries }

function TInMemoryFuelCharacteristicsAccountingApplicationServiceRegistries.
  GetBusinessServiceRegistry:
    IFuelCharacteristicsAccountingBusinessServiceRegistry;
begin

  Result :=
    IFuelCharacteristicsAccountingBusinessServiceRegistry(
      GetApplicationServiceRegistry(
        TypeInfo(IFuelCharacteristicsAccountingBusinessServiceRegistry)
      )
    );
    
end;

function TInMemoryFuelCharacteristicsAccountingApplicationServiceRegistries.
  GetPresentationServiceRegistry:
    IFuelCharacteristicsAccountingPresentationServiceRegistry;
begin

  Result :=
    IFuelCharacteristicsAccountingPresentationServiceRegistry(
      GetApplicationServiceRegistry(
        TypeInfo(IFuelCharacteristicsAccountingPresentationServiceRegistry)
      )
    );
    
end;

function TInMemoryFuelCharacteristicsAccountingApplicationServiceRegistries.
  GetSystemServiceRegistry: IFuelCharacteristicsAccountingSystemServiceRegistry;
begin

  Result :=
    IFuelCharacteristicsAccountingSystemServiceRegistry(
      GetApplicationServiceRegistry(
        TypeInfo(
          IFuelCharacteristicsAccountingSystemServiceRegistry
        )
      )
    );
    
end;

procedure TInMemoryFuelCharacteristicsAccountingApplicationServiceRegistries.
  RegisterBusinessServiceRegistry(
    BusinessServiceRegistry:
      IFuelCharacteristicsAccountingBusinessServiceRegistry
  );
begin

  RegisterApplicationServiceRegistry(
    TypeInfo(IFuelCharacteristicsAccountingBusinessServiceRegistry),
    BusinessServiceRegistry
  );
  
end;

procedure TInMemoryFuelCharacteristicsAccountingApplicationServiceRegistries.
  RegisterPresentationServiceRegistry(
    PresentationServiceRegistry:
      IFuelCharacteristicsAccountingPresentationServiceRegistry
  );
begin

  RegisterApplicationServiceRegistry(
    TypeInfo(IFuelCharacteristicsAccountingPresentationServiceRegistry),
    PresentationServiceRegistry
  );
  
end;

procedure TInMemoryFuelCharacteristicsAccountingApplicationServiceRegistries.
  RegisterSystemServiceRegistry(
    SystemServiceRegistry: IFuelCharacteristicsAccountingSystemServiceRegistry
  );
begin

  RegisterApplicationServiceRegistry(
    TypeInfo(IFuelCharacteristicsAccountingSystemServiceRegistry),
    SystemServiceRegistry
  );
  
end;

end.
