unit FuelCharacteristicsAccountingReferenceFormServiceController;

interface

uses

  BaseFuelCharacteristicsAccountingReferenceFormController,
  FuelCharacteristicsCalculationCardSetReadService,
  FuelCharacteristicsAccountingReferenceFormViewModelMapper,
  ReferenceFormViewModel,
  FuelCharacteristicsAccountingReferenceFormViewModel,
  FuelCharacteristicsCalculationCardSetHolder,
  FuelCharacteristicsAccountingReferenceRecordViewModelMapper,
  FuelCharacteristicsCalculationCardAccountingAppService,
  ReferenceFormViewModelMapper,
  FuelCharacteristicsCalculationCardAccessRightsDto,
  ReferenceFormRecordViewModel,
  EventBus,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingReferenceFormServiceController =
    class (TBaseFuelCharacteristicsAccountingReferenceFormController)

      private

        FClientIdentity: Variant;

        FFuelCharacteristicsCalculationCardSetReadService:
          IFuelCharacteristicsCalculationCardSetReadService;

        FFuelCharacteristicsCalculationCardAccountingAppService:
          IFuelCharacteristicsCalculationCardAccountingAppService;
          
        FFuelCharacteristicsAccountingReferenceFormViewModelMapper:
          IReferenceFormViewModelMapper;

      protected

        procedure OnRecordFocusedEventHandler(
          Sender: TObject;
          var FocusedRecordViewModel: TReferenceFormRecordViewModel
        ); override;
        
      protected

        function CreateReferenceFormViewModel: TReferenceFormViewModel; override;

      public

        constructor Create(
          const ClientIdentity: Variant;

          FuelCharacteristicsCalculationCardSetReadService:
            IFuelCharacteristicsCalculationCardSetReadService;

          FuelCharacteristicsCalculationCardAccountingAppService:
            IFuelCharacteristicsCalculationCardAccountingAppService;
            
          FuelCharacteristicsAccountingReferenceFormViewModelMapper:
            IReferenceFormViewModelMapper;
            
          FuelCharacteristicsAccountingReferenceRecordViewModelMapper:
            TFuelCharacteristicsAccountingReferenceRecordViewModelMapper;

          EventBus: IEventBus
        );

    end;
  

implementation

{ TFuelCharacteristicsAccountingReferenceFormServiceController }

constructor TFuelCharacteristicsAccountingReferenceFormServiceController.Create(
  const ClientIdentity: Variant;

  FuelCharacteristicsCalculationCardSetReadService:
    IFuelCharacteristicsCalculationCardSetReadService;

  FuelCharacteristicsCalculationCardAccountingAppService:
    IFuelCharacteristicsCalculationCardAccountingAppService;

  FuelCharacteristicsAccountingReferenceFormViewModelMapper:
    IReferenceFormViewModelMapper;
            
  FuelCharacteristicsAccountingReferenceRecordViewModelMapper:
    TFuelCharacteristicsAccountingReferenceRecordViewModelMapper;

  EventBus: IEventBus
);
begin

  inherited Create(
    FuelCharacteristicsAccountingReferenceRecordViewModelMapper,
    EventBus
  );

  FClientIdentity := ClientIdentity;
  
  FFuelCharacteristicsCalculationCardSetReadService :=
    FuelCharacteristicsCalculationCardSetReadService;

  FFuelCharacteristicsCalculationCardAccountingAppService :=
    FuelCharacteristicsCalculationCardAccountingAppService;

  FFuelCharacteristicsAccountingReferenceFormViewModelMapper :=
    FuelCharacteristicsAccountingReferenceFormViewModelMapper;
    
end;

function TFuelCharacteristicsAccountingReferenceFormServiceController.
  CreateReferenceFormViewModel: TReferenceFormViewModel;
var CardSetHolder: TFuelCharacteristicsCalculationCardSetHolder;
begin

  CardSetHolder :=
    FFuelCharacteristicsCalculationCardSetReadService
      .GetFuelCharacteristicsCalculationCardSetForEmployee(FClientIdentity);

  try

    Result :=
      FFuelCharacteristicsAccountingReferenceFormViewModelMapper.
        MapReferenceFormViewModelFrom(CardSetHolder);

  finally

    FreeAndNil(CardSetHolder);
    
  end;

end;

procedure TFuelCharacteristicsAccountingReferenceFormServiceController.
  OnRecordFocusedEventHandler(
    Sender: TObject;
    var FocusedRecordViewModel: TReferenceFormRecordViewModel
  );
var CardAccessRights: TFuelCharacteristicsCalculationCardAccessRightsDto;
begin


  CardAccessRights :=
    FFuelCharacteristicsCalculationCardAccountingAppService
      .GetFuelCharacteristicsCalculationCardAccessRights(
        FClientIdentity,
        FocusedRecordViewModel.Id
      );

  try

    FocusedRecordViewModel.CanBeRemoved := CardAccessRights.CanBeRemoved;

    FocusedRecordViewModel.CanBeChanged :=
      CardAccessRights.FuelInfoCanBeEdited or
      CardAccessRights.CalculationContextInfoCanBeEdited;
      
  finally

    FreeAndNil(CardAccessRights);
    
  end;

end;

end.
