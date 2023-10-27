unit EmployeesAdministrationReferenceFormServiceController;

interface

uses

  BaseEmployeesAdministrationReferenceFormController,
  EmployeeAccountReferenceService,
  EmployeeAccountSetHolder,
  EmployeesAdministrationPrivilegeServices,
  ReferenceFormRecordViewModelMapper,
  ReferenceFormViewModelMapper,
  EmployeesAdministrationReferenceFormViewModelMapper,
  BaseSystemAdministrationFormControllerEvents,
  FuelCharacteristicsAccountingSystemAuthorizationService,
  SpecialityAccountingAppService,
  ReferenceFormViewModel,
  AbstractFormController,
  EventBus,
  FormEvents,
  Forms,
  Event,
  SysUtils,
  Classes;

type

  TEmployeesAdministrationReferenceFormServiceController =
    class (TBaseEmployeesAdministrationReferenceFormController)

      protected

        protected

          FClientIdentity: Variant;

          FSystemAdministrationPrivilegeId: Variant;
          FEmployeeAccountReferenceService: IEmployeeAccountReferenceService;

          FFuelCharacteristicsAccountingSystemAuthorizationService: IFuelCharacteristicsAccountingSystemAuthorizationService;
          FSpecialityAccountingAppService: ISpecialityAccountingAppService;

          FReferenceFormViewModelMapper: IReferenceFormViewModelMapper;
           
        protected

          procedure OnEmployeeRoleNamesRequestedEventHandler(
            Sender: TObject;
            var EmployeeRoleNames: TStrings
          ); override;

          procedure OnEmployeeSpecialityStringsRequestedEventHandler(
            Sender: TObject;
            var EmployeeSpecialities: TStrings
          ); override;

          procedure OnSystemAdministrationPrivilegeFormRequestedEventHandler(
            Event: TSystemAdministrationPrivilegeFormRequestedEvent
          ); override;

        protected

          function CreateReferenceFormViewModel: TReferenceFormViewModel; override;

        public

          constructor Create(
            const ClientIdentity: Variant;

            EmployeesAdministrationPrivilegeServices: TEmployeesAdministrationPrivilegeServices;

            FuelCharacteristicsAccountingSystemAuthorizationService: IFuelCharacteristicsAccountingSystemAuthorizationService;
            SpecialityAccountingAppService: ISpecialityAccountingAppService;

            ReferenceFormRecordViewModelMapper: IReferenceFormRecordViewModelMapper;
            EmployeesAdministrationReferenceFormViewModelMapper: IReferenceFormViewModelMapper;

            EventBus: IEventBus
          );
    
    end;

implementation

uses

  RoleDto;

{ TEmployeesAdministrationReferenceFormServiceController }

constructor TEmployeesAdministrationReferenceFormServiceController.Create(
  const ClientIdentity: Variant;

  EmployeesAdministrationPrivilegeServices: TEmployeesAdministrationPrivilegeServices;

  FuelCharacteristicsAccountingSystemAuthorizationService: IFuelCharacteristicsAccountingSystemAuthorizationService;
  SpecialityAccountingAppService: ISpecialityAccountingAppService;

  ReferenceFormRecordViewModelMapper: IReferenceFormRecordViewModelMapper;
  EmployeesAdministrationReferenceFormViewModelMapper: IReferenceFormViewModelMapper;

  EventBus: IEventBus
);
begin

  inherited Create(ReferenceFormRecordViewModelMapper, EventBus);

  FClientIdentity := ClientIdentity;

  FSystemAdministrationPrivilegeId := EmployeesAdministrationPrivilegeServices.PrivilegeId;
  FEmployeeAccountReferenceService := EmployeesAdministrationPrivilegeServices.EmployeeAccountReferenceService;

  FFuelCharacteristicsAccountingSystemAuthorizationService :=
    FuelCharacteristicsAccountingSystemAuthorizationService;

  FSpecialityAccountingAppService := SpecialityAccountingAppService;
  
  FReferenceFormViewModelMapper := EmployeesAdministrationReferenceFormViewModelMapper;

end;

function TEmployeesAdministrationReferenceFormServiceController.
  CreateReferenceFormViewModel: TReferenceFormViewModel;
var EmployeeAccountSetHolder: TEmployeeAccountSetHolder;
begin

  EmployeeAccountSetHolder :=
    FEmployeeAccountReferenceService.GetEmployeeAccountsFor(FClientIdentity);

  try

    Result :=
      FReferenceFormViewModelMapper.MapReferenceFormViewModelFrom(
        EmployeeAccountSetHolder
      );

  finally

    FreeAndNil(EmployeeAccountSetHolder);
    
  end;

end;

procedure TEmployeesAdministrationReferenceFormServiceController.
  OnEmployeeRoleNamesRequestedEventHandler(
    Sender: TObject;
    var EmployeeRoleNames: TStrings
  );
var RoleDtos: TRoleDtos;
    RoleDto: TRoleDto;
begin

  inherited;

  RoleDtos :=
    FFuelCharacteristicsAccountingSystemAuthorizationService
      .GetRoles(FClientIdentity);

  try

    EmployeeRoleNames := TStringList.Create;

    for RoleDto in RoleDtos do
      EmployeeRoleNames.Add(RoleDto.DisplayName);

  finally

    FreeAndNil(RoleDtos);
    
  end;

end;

procedure TEmployeesAdministrationReferenceFormServiceController.
  OnEmployeeSpecialityStringsRequestedEventHandler(
    Sender: TObject;
    var EmployeeSpecialities: TStrings
  );
begin

  inherited;

  EmployeeSpecialities := FSpecialityAccountingAppService.GetAllSpecialities;

end;

procedure TEmployeesAdministrationReferenceFormServiceController.
  OnSystemAdministrationPrivilegeFormRequestedEventHandler(
    Event: TSystemAdministrationPrivilegeFormRequestedEvent
  );
var EmployeesAdministrationReferenceForm: TForm;
    SectionalFormInflatingRequestedEvent: TSectionalFormInflatingRequestedEvent;
begin

  if Event.PrivilegeId <> FSystemAdministrationPrivilegeId then Exit;

  EmployeesAdministrationReferenceForm := CreateForm(Application);

  EmployeesAdministrationReferenceForm.BorderStyle := bsNone;
  
  SectionalFormInflatingRequestedEvent :=
    TSectionalFormInflatingRequestedEvent.Create(
      FSystemAdministrationPrivilegeId,
      EmployeesAdministrationReferenceForm
    );

  try

    EventBus.RaiseEvent(SectionalFormInflatingRequestedEvent);

  finally

    FreeAndNil(SectionalFormInflatingRequestedEvent);

  end;

end;

end.
