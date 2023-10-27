unit FuelCharacteristicsAccountingFormControllersConfigurator;

interface

uses

  AbstractFormControllersConfigurator,
  FuelCharacteristicsAccountingApplication,
  BaseFuelCharacteristicsAccountingMainFormController,
  BaseFuelCharacteristicsAccountingReferenceFormController,
  BaseFuelCharacteristicsCalculationCardFormController,
  BaseSystemAdministrationFormController,
  EventBus,
  AbstractFormController,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingFormControllersConfigurator =
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

  Variants,
  ClientAccount,
  FuelCharacteristicsAccountingMainFormServiceController,
  FuelCharacteristicsAutomaticCalculationFormServiceController,
  StubFuelCharacteristicsAccountingReferenceFormController,
  FuelCharacteristicsAccountingReferenceRecordViewModelMapper,
  StubFuelCharacteristicsCalculationCardFormController,
  FuelCharacteristicsCalculationCardFormViewModelMapper,
  BaseFuelCharacteristicsAutomaticCalculationFormController,
  FuelCharacteristicsAutomaticCalculationFormStubController,
  FuelCharacteristicsCalculationCardFormServiceController,
  FuelCharacteristicsAccountingReferenceFormServiceController,
  FuelCharacteristicsAccountingSystemAdministrationFormServiceController,
  FuelCharacteristicsAccountingBusinessServiceRegistry,
  FuelCharacteristicsAccountingPresentationServiceRegistry,
  FuelCharacteristicsAccountingReferenceFormViewModelMapper,
  FuelCharacteristicsAccountingSystemServiceRegistry,
  BaseReservoirKindsFormController,
  BaseReservoirKindReferenceSuitesFormController,
  ReservoirKindReferenceSuitesFormStubController,
  ReservoirKindsFormStubController,
  SystemAdministrationFormViewModelMapper;

{ TFuelCharacteristicsAccountingFormControllersConfigurator }

function TFuelCharacteristicsAccountingFormControllersConfigurator.GetEntryFormController: TAbstractFormController;
begin

  Result :=
    TAbstractFormController(
      FControllers[TBaseFuelCharacteristicsAccountingMainFormController.ClassName]
    );
    
end;

procedure TFuelCharacteristicsAccountingFormControllersConfigurator.InternalConfigureControllers(
  Application: IFuelCharacteristicsAccountingApplication;
  EventBus: IEventBus
);
var BusinessServiceRegistry: IFuelCharacteristicsAccountingBusinessServiceRegistry;
    PresentationServiceRegistry: IFuelCharacteristicsAccountingPresentationServiceRegistry;
    SystemServiceRegistry: IFuelCharacteristicsAccountingSystemServiceRegistry;
begin

  BusinessServiceRegistry :=
    Application.ServiceRegistries.GetBusinessServiceRegistry;

  PresentationServiceRegistry :=
    Application.ServiceRegistries.GetPresentationServiceRegistry;

  SystemServiceRegistry :=
    Application.ServiceRegistries.GetSystemServiceRegistry;
    
  FControllers[TBaseFuelCharacteristicsAccountingMainFormController.ClassName] :=
    TFuelCharacteristicsAccountingMainFormServiceController.Create(
      Application.UserRoleAccount,
      SystemServiceRegistry.GetSystemAdministrationService,
      BusinessServiceRegistry.GetReservoirKindReferenceSuiteReferenceService,
      EventBus
    );

  FControllers[TBaseFuelCharacteristicsAccountingReferenceFormController.ClassName] :=
    TFuelCharacteristicsAccountingReferenceFormServiceController.Create(
      Application.UserRoleAccount.Identity,

      PresentationServiceRegistry
        .GetFuelCharacteristicsCalculationCardSetReadService,

      BusinessServiceRegistry
        .GetFuelCharacteristicsCalculationCardAccountingAppService,
        
      TFuelCharacteristicsAccountingReferenceFormViewModelMapper.Create,
      TFuelCharacteristicsAccountingReferenceRecordViewModelMapper.Create,

      EventBus
    );
    
  FControllers[TBaseFuelCharacteristicsCalculationCardFormController.ClassName] :=
    TFuelCharacteristicsCalculationCardFormServiceController.Create(

      Application.UserRoleAccount.Identity,

      BusinessServiceRegistry
        .GetFuelCharacteristicsCalculationCardAccountingAppService,

      TFuelCharacteristicsCalculationCardFormViewModelMapper.Create,

      EventBus
    );

  FControllers[
    TBaseFuelCharacteristicsAutomaticCalculationFormController.ClassName
  ] :=
    TFuelCharacteristicsAutomaticCalculationFormServiceController.Create(
      Application.UserRoleAccount.Identity,
      BusinessServiceRegistry.GetFuelCharacteristicsCalculationAppService,
      BusinessServiceRegistry.GetReservoirSubLayerKindAccountingAppService,
      EventBus
    );

  FControllers[TBaseSystemAdministrationFormController.ClassName] :=
    TFuelCharacteristicsAccountingSystemAdministrationFormServiceController.Create(
      Application.UserRoleAccount.Identity,
      SystemServiceRegistry.GetSystemAdministrationService,
      TSystemAdministrationFormViewModelMapper.Create,
      EventBus
    );  

end;

end.
