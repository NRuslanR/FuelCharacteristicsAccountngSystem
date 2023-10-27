unit EmployeeAdministrationCardFormServiceController;

interface

uses

  BaseEmployeeAdministrationCardFormController,
  CardFormViewModel,
  EmployeeAccountsManagementService,
  EmployeeAdministrationCardFormViewModelMapper,
  EmployeeAdministrationCardFormViewModel,
  FuelCharacteristicsAccountingSystemAuthorizationService,
  EmployeesAdministrationReferenceRecordViewModel,
  SpecialityAccountingAppService,
  EmployeeAccountDtoMapper,
  EmployeeAccountDto,
  AbstractReferenceFormControllerEvents,
  RoleDto,
  EventBus,
  SysUtils,
  Classes;

type

  TEmployeeAdministrationCardFormServiceController =
    class (TBaseEmployeeAdministrationCardFormController)

      protected

        FClientIdentity: Variant;

        FFuelCharacteristicsAccountingSystemAuthorizationService: IFuelCharacteristicsAccountingSystemAuthorizationService;
        FSpecialityAccountingAppService: ISpecialityAccountingAppService;

        FEmployeeAccountsManagementService: IEmployeeAccountsManagementService;

        FFormViewModelMapper: TEmployeeAdministrationCardFormViewModelMapper;

        FEmployeeAccountDtoMapper: TEmployeeAccountDtoMapper;

      protected

        function GetExistingEmployeeSpecialities: TStrings;
        function GetExistingEmployeeRoles: TRoleDtos;
        
      protected

        procedure CreateNewCard(ViewModel: TCardFormViewModel; var Success: Boolean); override;
        procedure ModifyCard(ViewModel: TCardFormViewModel; var Success: Boolean); override;
        procedure RemoveCard(ViewModel: TCardFormViewModel); override;

      protected

        function CreateCardFormViewModelForChangingReferenceRecordRequestHandling(
          ChangingReferenceRecordRequestedEvent: TChangingReferenceRecordRequestedEvent
        ): TCardFormViewModel; override;

        function CreateCardFormViewModelForAddingReferenceRecordRequestHandling(
          AddingReferenceRecordRequestedEvent: TAddingReferenceRecordRequestedEvent
        ): TCardFormViewModel; override;

      public

        destructor Destroy; override;
        
        constructor Create(
          const ClientIdentity: Variant;

          FuelCharacteristicsAccountingSystemAuthorizationService: IFuelCharacteristicsAccountingSystemAuthorizationService;
          SpecialityAccountingAppService: ISpecialityAccountingAppService;
          
          EmployeeAccountsManagementService: IEmployeeAccountsManagementService;

          FormViewModelMapper: TEmployeeAdministrationCardFormViewModelMapper;
          EventBus: IEventBus
        );

    end;

implementation

{ TEmployeeAdministrationCardFormServiceController }

constructor TEmployeeAdministrationCardFormServiceController.Create(
  const ClientIdentity: Variant;

  FuelCharacteristicsAccountingSystemAuthorizationService: IFuelCharacteristicsAccountingSystemAuthorizationService;
  SpecialityAccountingAppService: ISpecialityAccountingAppService;

  EmployeeAccountsManagementService: IEmployeeAccountsManagementService;

  FormViewModelMapper: TEmployeeAdministrationCardFormViewModelMapper;
  EventBus: IEventBus
);
begin

  inherited Create(FormViewModelMapper, EventBus);

  FClientIdentity := ClientIdentity;

  FFuelCharacteristicsAccountingSystemAuthorizationService :=
    FuelCharacteristicsAccountingSystemAuthorizationService;

  FSpecialityAccountingAppService := SpecialityAccountingAppService;
  
  FEmployeeAccountsManagementService :=
    EmployeeAccountsManagementService;

  FFormViewModelMapper := FormViewModelMapper;

  FEmployeeAccountDtoMapper := TEmployeeAccountDtoMapper.Create;

end;

destructor TEmployeeAdministrationCardFormServiceController.Destroy;
begin

  FreeAndNil(FEmployeeAccountDtoMapper);

  inherited;

end;

function TEmployeeAdministrationCardFormServiceController.
  GetExistingEmployeeRoles: TRoleDtos;
begin

  Result :=
    FFuelCharacteristicsAccountingSystemAuthorizationService
      .GetRoles(FClientIdentity);

end;

function TEmployeeAdministrationCardFormServiceController.
  GetExistingEmployeeSpecialities: TStrings;
begin

  Result := FSpecialityAccountingAppService.GetAllSpecialities;
  
end;

function TEmployeeAdministrationCardFormServiceController.
  CreateCardFormViewModelForAddingReferenceRecordRequestHandling(

    AddingReferenceRecordRequestedEvent:
      TAddingReferenceRecordRequestedEvent

  ): TCardFormViewModel;
var RoleDtos: TRoleDtos;
    Specialities: TStrings;
begin

  RoleDtos := nil;
  Specialities := nil;

  try

    Specialities := GetExistingEmployeeSpecialities;
    RoleDtos := GetExistingEmployeeRoles;

    Result :=
      FFormViewModelMapper.CreateEmptyCardFormViewModelFrom(
        Specialities, RoleDtos
      );

  finally

    FreeAndNil(Specialities);
    FreeAndNil(RoleDtos);
    
  end;

end;

function TEmployeeAdministrationCardFormServiceController.
  CreateCardFormViewModelForChangingReferenceRecordRequestHandling(

    ChangingReferenceRecordRequestedEvent:
      TChangingReferenceRecordRequestedEvent
      
  ): TCardFormViewModel;
var Specialities: TStrings;
    RoleDtos: TRoleDtos;
begin

  RoleDtos := nil;
  Specialities := nil;

  try

    Specialities := GetExistingEmployeeSpecialities;
    RoleDtos := GetExistingEmployeeRoles;

    Result :=
      FFormViewModelMapper.MapEmployeeAdministrationCardFormViewModelFrom(
        TEmployeesAdministrationReferenceRecordViewModel(
          ChangingReferenceRecordRequestedEvent.RecordViewModel
        ),
        Specialities,
        RoleDtos
      );
      
  finally

    FreeAndNil(RoleDtos);
    FreeAndNil(Specialities);

  end;
  
end;

procedure TEmployeeAdministrationCardFormServiceController.
  CreateNewCard(
    ViewModel: TCardFormViewModel;
    var Success: Boolean
  );
var EmployeeAccountDto: TEmployeeAccountDto;
begin

  EmployeeAccountDto :=
    FEmployeeAccountDtoMapper.MapEmployeeAccountDtoFrom(
      TEmployeeAdministrationCardFormViewModel(ViewModel)
    );

  try

      ViewModel.Id.Value :=
        FEmployeeAccountsManagementService
          .AddEmployeeAccount(
            FClientIdentity, EmployeeAccountDto
          );
      
  finally

    FreeAndNil(EmployeeAccountDto);
    
  end;

end;

procedure TEmployeeAdministrationCardFormServiceController.
  ModifyCard(
    ViewModel: TCardFormViewModel;
    var Success: Boolean
  );
var EmployeeAccountDto: TEmployeeAccountDto;
begin

  EmployeeAccountDto :=
    FEmployeeAccountDtoMapper.MapEmployeeAccountDtoFrom(
      TEmployeeAdministrationCardFormViewModel(ViewModel)
    );

  try

    FEmployeeAccountsManagementService
      .ChangeEmployeeAccount(FClientIdentity, EmployeeAccountDto);

  finally

    FreeAndNil(EmployeeAccountDto);
    
  end;

end;

procedure TEmployeeAdministrationCardFormServiceController.
  RemoveCard(ViewModel: TCardFormViewModel);
begin

  FEmployeeAccountsManagementService.RemoveEmployeeAccount(
    FClientIdentity, ViewModel.Id.Value
  );

end;

end.
