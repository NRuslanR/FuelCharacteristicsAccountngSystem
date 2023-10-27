unit ReservoirKindFormControllersConfigurator;

interface

uses

  AbstractFormControllersConfigurator,
  FuelCharacteristicsAccountingApplication,
  AbstractFormController,
  EventBus,
  BaseReservoirKindsFormController,
  BaseReservoirKindReferenceSuitesFormController,
  BaseReservoirKindReferenceSuiteCardFormController,
  ReservoirKindsFormStubController,
  ReservoirKindReferenceSuitesFormStubController,
  ReservoirKindReferenceSuiteCardFormStubController,
  ReservoirKindReferenceSuiteRecordViewModelMapper,
  ReservoirKindReferenceSuiteCardFormViewModelMapper,
  SysUtils,
  Classes;

type

  TReservoirKindFormControllersConfigurator =
    class (TAbstractFormControllersConfigurator)

      protected

      procedure InternalConfigureControllers(
        Application: IFuelCharacteristicsAccountingApplication;
        EventBus: IEventBus
      ); override;

      function GetEntryFormController: TAbstractFormController; override;

        
    end;

implementation

uses

  FuelCharacteristicsAccountingBusinessServiceRegistry,
  FuelCharacteristicsAccountingPresentationServiceRegistry,
  ReservoirKindsFormServiceController,
  ReservoirKindReferenceSuitesFormServiceController,
  ReservoirKindsFormViewModelMapper,
  ReservoirKindReferenceSuitesViewModelMapper,
  ReservoirKindReferenceSuiteCardFormServiceController;
  
{ TReservoirKindFormControllersConfigurator }

function TReservoirKindFormControllersConfigurator.
  GetEntryFormController: TAbstractFormController;
begin

  Result :=
    TAbstractFormController(
      FControllers[TBaseReservoirKindReferenceSuitesFormController.ClassName]
    );
    
end;

procedure TReservoirKindFormControllersConfigurator.
  InternalConfigureControllers(
    Application: IFuelCharacteristicsAccountingApplication;
    EventBus: IEventBus
  );
var BusinessServiceRegistry: IFuelCharacteristicsAccountingBusinessServiceRegistry;
    PresentationServiceRegistry: IFuelCharacteristicsAccountingPresentationServiceRegistry;
begin

  BusinessServiceRegistry :=
    Application.ServiceRegistries.GetBusinessServiceRegistry;

  PresentationServiceRegistry :=
    Application.ServiceRegistries.GetPresentationServiceRegistry;

  FControllers[TBaseReservoirKindsFormController.ClassName] :=
    TReservoirKindsFormServiceController.Create(
      Application.UserRoleAccount.Identity,

      BusinessServiceRegistry.GetReservoirKindReferenceService,

      TReservoirKindsFormViewModelMapper.Create,

      EventBus
    );


  FControllers[TBaseReservoirKindReferenceSuitesFormController.ClassName] :=
    TReservoirKindReferenceSuitesFormServiceController.Create(
      Application.UserRoleAccount.Identity,

      BusinessServiceRegistry.GetReservoirKindReferenceSuiteReferenceService,
      BusinessServiceRegistry.GetReservoirKindReferenceSuiteAccountingAppService,

      TReservoirKindReferenceSuitesViewModelMapper.Create,
      TReservoirKindReferenceSuiteRecordViewModelMapper.Create,

      EventBus
    );

  FControllers[TBaseReservoirKindReferenceSuiteCardFormController.ClassName] :=
    TReservoirKindReferenceSuiteCardFormServiceController.Create(
      Application.UserRoleAccount.Identity,

      BusinessServiceRegistry.GetReservoirKindReferenceSuiteAccountingAppService,

      TReservoirKindReferenceSuiteCardFormViewModelMapper.Create,

      EventBus
    );

end;

end.
