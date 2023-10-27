unit StandardFuelCharacteristicsAccountingAdministrationService;

interface

uses

  SystemAdministrationService,
  SystemAdministrationPrivileges,
  SystemAdministrationPrivilegeServices,
  FuelCharacteristicsAccountingSystemAuthorizationService,
  EmployeeAccountReferenceService,
  EmployeesAdministrationPrivilegeServices,
  FuelCharacteristicsAccountingSystemAdministrationPrivileges,
  WorkingTimeConditionsManagementPrivilegeServices,
  WorkingTimeConditionsAccountingAppService,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsAccountingAdministrationService =
    class abstract (TInterfacedObject, ISystemAdministrationService)

      private

        FEmployeeAdministrationPrivilegeId: Variant;
        FWorkingTimeConditionsManagementPrivilegeId: Variant;
        
      protected

        FSystemAuthorizationService: IFuelCharacteristicsAccountingSystemAuthorizationService;
        FEmployeeAccountReferenceService: IEmployeeAccountReferenceService;
        FWorkingTimeConditionsAccountingAppService: IWorkingTimeConditionsAccountingAppService;

        function CreateSystemAdministrationPrivileges: TSystemAdministrationPrivileges; virtual;

        procedure FillSystemAdministrationPrivileges(
          Privileges: TSystemAdministrationPrivileges
        ); virtual;
        
      public

        constructor Create(
          SystemAuthorizationService: IFuelCharacteristicsAccountingSystemAuthorizationService;
          EmployeeAccountReferenceService: IEmployeeAccountReferenceService;
          WorkingTimeConditionsAccountingAppService: IWorkingTimeConditionsAccountingAppService
        );

        function HasClientSystemAdministrationPrivileges(
          const ClientIdentity: Variant
        ): Boolean; virtual;

        function GetAllSystemAdministrationPrivileges(
          const ClientIdentity: Variant
        ): TSystemAdministrationPrivileges; virtual;

        function GetSystemAdministrationPrivilegeServices(
          const ClientIdentity: Variant;
          const PrivilegeIdentity: Variant
        ): TSystemAdministrationPrivilegeServices; virtual;

    end;
  
implementation

uses

  Variants;
  
{ TStandardFuelCharacteristicsAccountingAdministrationService }

constructor TStandardFuelCharacteristicsAccountingAdministrationService.Create(
  SystemAuthorizationService: IFuelCharacteristicsAccountingSystemAuthorizationService;
  EmployeeAccountReferenceService: IEmployeeAccountReferenceService;
  WorkingTimeConditionsAccountingAppService: IWorkingTimeConditionsAccountingAppService
);
begin

  inherited Create;

  FSystemAuthorizationService := SystemAuthorizationService;
  FEmployeeAccountReferenceService := EmployeeAccountReferenceService;
  FWorkingTimeConditionsAccountingAppService := WorkingTimeConditionsAccountingAppService;

  FEmployeeAdministrationPrivilegeId := 1;
  FWorkingTimeConditionsManagementPrivilegeId := 2;
  
end;

function TStandardFuelCharacteristicsAccountingAdministrationService.
  CreateSystemAdministrationPrivileges: TSystemAdministrationPrivileges;
begin

  Result := TFuelCharacteristicsAccountingSystemAdministrationPrivileges.Create;
  
end;

procedure TStandardFuelCharacteristicsAccountingAdministrationService.
  FillSystemAdministrationPrivileges(
    Privileges: TSystemAdministrationPrivileges
  );
begin

  with Privileges as TFuelCharacteristicsAccountingSystemAdministrationPrivileges
  do begin

    EmployeesAdministrationPrivilege :=
      TSystemAdministrationPrivilege.Create(
        1, Null, 'Сотрудники'
      );

    WorkingTimeConditionsManagementPrivilege :=
      TSystemAdministrationPrivilege.Create(
        2, Null, 'Режим рабочего времени'
      );

  end;

end;

function TStandardFuelCharacteristicsAccountingAdministrationService.
  GetAllSystemAdministrationPrivileges(
    const ClientIdentity: Variant
  ): TSystemAdministrationPrivileges;
begin

  FSystemAuthorizationService.EnsureClientIsAdmin(ClientIdentity);

  Result := CreateSystemAdministrationPrivileges;

  FillSystemAdministrationPrivileges(Result);

end;

function TStandardFuelCharacteristicsAccountingAdministrationService.
  GetSystemAdministrationPrivilegeServices(
    const ClientIdentity,
    PrivilegeIdentity: Variant
  ): TSystemAdministrationPrivilegeServices;
begin

  FSystemAuthorizationService.EnsureClientIsAdmin(ClientIdentity);
  
  if PrivilegeIdentity = FEmployeeAdministrationPrivilegeId then begin

    Result :=
      TEmployeesAdministrationPrivilegeServices.Create(
        FEmployeeAdministrationPrivilegeId,
        FEmployeeAccountReferenceService
      );
      
  end

  else if PrivilegeIdentity = FWorkingTimeConditionsManagementPrivilegeId
  then begin

    Result :=
      TWorkingTimeConditionsManagementPrivilegeServices.Create(
        FWorkingTimeConditionsManagementPrivilegeId,
        FWorkingTimeConditionsAccountingAppService
      );

  end

  else begin

    raise Exception.CreateFmt(
      'Привилегия администрирования с ' +
      'идентификатором "%s" не найдена',
      [VarToStr(PrivilegeIdentity)]
    );

  end;

end;

function TStandardFuelCharacteristicsAccountingAdministrationService.
  HasClientSystemAdministrationPrivileges(
    const ClientIdentity: Variant
  ): Boolean;
begin

  try

    FSystemAuthorizationService.EnsureClientIsAdmin(ClientIdentity);

    Result := True;
    
  except

    on E: TFuelCharacteristicsAccountingSystemAuthorizationServiceException
    do Result := False;

  end;

end;

end.
