unit SystemAuthentificationFormControllersConfigurator;

interface

uses

  AbstractFormControllersConfigurator,
  FuelCharacteristicsAccountingApplication,
  AbstractFormController,
  SystemAuthentificationFormController,
  EventBus,
  SysUtils,
  Classes;

type

  TSystemAuthentificationFormControllersConfigurator =
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

  SystemAuthentificationService,
  DatabaseServerRoleAuthentificationService,
  AuxSystemFunctionsUnit,
  ExtendedDatabaseAuthentificationFormViewModelPropertiesINIFile,
  ExtendedDatabaseAuthentificationFormController;
  
{ TSystemAuthentificationFormControllersConfigurator }

function TSystemAuthentificationFormControllersConfigurator.
  GetEntryFormController: TAbstractFormController;
begin

  Result :=
    TAbstractFormController(
      FControllers[TSystemAuthentificationFormController.ClassName]
    );
    
end;

procedure TSystemAuthentificationFormControllersConfigurator.
  InternalConfigureControllers(
    Application: IFuelCharacteristicsAccountingApplication;
    EventBus: IEventBus
  );
var SystemAuthentificationService: ISystemAuthentificationService;
    DatabaseServerRoleAuthentificationService: IDatabaseServerRoleAuthentificationService;
    SystemAuthentificationFormViewModelPropertiesStorage:
      TExtendedDatabaseAuthentificationFormViewModelPropertiesINIFile;
begin

  inherited;

  SystemAuthentificationService :=
    Application
      .ServiceRegistries
      .GetSystemServiceRegistry
      .GetSystemAuthentificationService;

  if
    SystemAuthentificationService.QueryInterface(
      IDatabaseServerRoleAuthentificationService,
      DatabaseServerRoleAuthentificationService
    ) <> 0
  then begin

    raise TAbstractFormControllersConfiguratorException.Create(
      'Программная ошибка. ' +
      'Обнаружен недопустимый тип интерфейса ' +
      'для службы аутентификации'
    );
    
  end;

  SystemAuthentificationFormViewModelPropertiesStorage :=
    TExtendedDatabaseAuthentificationFormViewModelPropertiesINIFile.Create(
      IncludeTrailingPathDelimiter(
        GetAppLocalDataFolderPath(
          GetApplicationExeNameWithoutExtension,
          CreateFolderIfNotExists
        )
      ) + 'settings.ini'
    );

  FControllers[TSystemAuthentificationFormController.ClassName] :=
    TExtendedDatabaseAuthentificationFormController.Create(
      EventBus,
      DatabaseServerRoleAuthentificationService,
      SystemAuthentificationFormViewModelPropertiesStorage
    );
    
end;

end.
