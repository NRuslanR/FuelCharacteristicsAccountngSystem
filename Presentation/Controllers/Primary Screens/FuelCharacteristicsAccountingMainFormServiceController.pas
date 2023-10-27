unit FuelCharacteristicsAccountingMainFormServiceController;

interface

uses

  BaseFuelCharacteristicsAccountingMainFormController,
  unIReservoirKindReferenceSuite,
  ReservoirKindReferenceSuiteReferenceService,
  AbstractFormController,
  SystemAdministrationService,
  unFuelCharacteristicsAccountingMainForm,
  ClientAccount,
  EventBus,
  Forms,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingMainFormServiceController =
    class (TBaseFuelCharacteristicsAccountingMainFormController)

      private

        FUserRoleAccount: TUserRoleAccount;
        FSystemAdministrationService: ISystemAdministrationService;

      private

        FReservoirKindReferenceSuiteReferenceService:
          IReservoirKindReferenceSuiteReferenceService;
          
      protected

        procedure CustomizeForm(Form: TForm; FormData: TFormData); override;

        procedure SetReferenceDataMenuItemVisibilityBySubItemsVisibility(
          Form: TFuelCharacteristicsAccountingMainForm
        );
        
      public

        constructor Create(
          UserRoleAccount: TUserRoleAccount;
          SystemAdministrationService: ISystemAdministrationService;

          ReservoirKindReferenceSuiteReferenceService:
            IReservoirKindReferenceSuiteReferenceService;
            
          EventBus: IEventBus
        );
        
    end;


implementation

{ TFuelCharacteristicsAccountingMainFormServiceController }

constructor TFuelCharacteristicsAccountingMainFormServiceController.Create(
  UserRoleAccount: TUserRoleAccount;
  SystemAdministrationService: ISystemAdministrationService;

  ReservoirKindReferenceSuiteReferenceService:
    IReservoirKindReferenceSuiteReferenceService;

  EventBus: IEventBus
);
begin

  inherited Create(EventBus);

  FUserRoleAccount := UserRoleAccount;
  FSystemAdministrationService := SystemAdministrationService;

  FReservoirKindReferenceSuiteReferenceService :=
    ReservoirKindReferenceSuiteReferenceService;
  
end;

procedure TFuelCharacteristicsAccountingMainFormServiceController.CustomizeForm(
  Form: TForm;
  FormData: TFormData
);
var FuelCharacteristicsAccountingMainForm: TFuelCharacteristicsAccountingMainForm;
begin

  inherited;

  FuelCharacteristicsAccountingMainForm := Form as TFuelCharacteristicsAccountingMainForm;

  FuelCharacteristicsAccountingMainForm.Caption :=
    Format(
      'Учёт показателей топлива - %s, %s',
      [
        FUserRoleAccount.UserFriendlyName,
        FUserRoleAccount.RoleFriendlyName
      ]
    );
    
  FuelCharacteristicsAccountingMainForm.actAdministration.Visible := 
    FSystemAdministrationService.HasClientSystemAdministrationPrivileges(
      FUserRoleAccount.Identity
    );

  FuelCharacteristicsAccountingMainForm.actReservoirKindsReferenceData.Visible :=
    FReservoirKindReferenceSuiteReferenceService
      .HasEmployeeAccessRightsForReservoirKindReferenceSuites(
        FUserRoleAccount.Identity
      );

  SetReferenceDataMenuItemVisibilityBySubItemsVisibility(
    FuelCharacteristicsAccountingMainForm
  );
  
end;

procedure TFuelCharacteristicsAccountingMainFormServiceController.
  SetReferenceDataMenuItemVisibilityBySubItemsVisibility(
    Form: TFuelCharacteristicsAccountingMainForm
  );
var I: Integer;
begin

  with Form do begin

    for I := 0 to ReferenceDataMenuItem.Count - 1 do
      if ReferenceDataMenuItem[I].Visible then begin

        ReferenceDataMenuItem.Visible := True;

        Exit;
        
      end;

    ReferenceDataMenuItem.Visible := False;

  end;
  
end;

end.
