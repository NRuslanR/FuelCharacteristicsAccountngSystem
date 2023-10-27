unit FuelCharacteristicsCalculationCardFormServiceController;

interface

uses

  BaseFuelCharacteristicsCalculationCardFormController,
  FuelCharacteristicsCalculationCardFormViewModel,
  FuelCharacteristicsCalculationCardInfo,
  FuelCharacteristicsCalculationCardAccountingAppService,
  CardFormViewModelMapper,
  FuelCharacteristicsCalculationCardDtoMapper,
  FuelCharacteristicsCalculationCardFormViewModelMapper,
  FuelCharacteristicsCalculationCardDto,
  CardFormViewModel,
  AbstractReferenceFormControllerEvents,
  EventBus,
  EventHandler,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsCalculationCardFormServiceController =
    class (TBaseFuelCharacteristicsCalculationCardFormController)

      private

        FClientIdentity: Variant;

        FFuelCharacteristicsCalculationCardAccountingAppService:
          IFuelCharacteristicsCalculationCardAccountingAppService;

        FFuelCharacteristicsCalculationCardDtoMapper:
          TFuelCharacteristicsCalculationCardDtoMapper;
          
        FFormViewModelMapper:
          TFuelCharacteristicsCalculationCardFormViewModelMapper;

      protected

        procedure CreateNewCard(
          ViewModel: TCardFormViewModel;
          var Success: Boolean
        ); override;

        procedure ModifyCard(
          ViewModel: TCardFormViewModel;
          var Success: Boolean
        ); override;

        procedure RemoveCard(
          ViewModel: TCardFormViewModel
        ); override;

      protected

        function CreateCardFormViewModelForAddingReferenceRecordRequestHandling(
          AddingReferenceRecordRequestedEvent: TAddingReferenceRecordRequestedEvent
        ): TCardFormViewModel; override;

        function CreateCardFormViewModelForChangingReferenceRecordRequestHandling(
          ChangingReferenceRecordRequestedEvent: TChangingReferenceRecordRequestedEvent
        ): TCardFormViewModel; override;

      public

        destructor Destroy; override;
        
        constructor Create(
          const ClientIdentity: Variant;

          FuelCharacteristicsCalculationCardAccountingAppService:
            IFuelCharacteristicsCalculationCardAccountingAppService;

          FormViewModelMapper:
            TFuelCharacteristicsCalculationCardFormViewModelMapper;
            
          EventBus: IEventBus
        );
      
    end;


implementation

{ TFuelCharacteristicsCalculationCardFormServiceController }

destructor TFuelCharacteristicsCalculationCardFormServiceController.Destroy;
begin

  FreeAndNil(FFuelCharacteristicsCalculationCardDtoMapper);
  
  inherited;

end;

constructor TFuelCharacteristicsCalculationCardFormServiceController.Create(
  const ClientIdentity: Variant;

  FuelCharacteristicsCalculationCardAccountingAppService:
    IFuelCharacteristicsCalculationCardAccountingAppService;

  FormViewModelMapper:
    TFuelCharacteristicsCalculationCardFormViewModelMapper;

  EventBus: IEventBus
);
begin

  inherited Create(FormViewModelMapper, EventBus);

  FClientIdentity := ClientIdentity;

  FFuelCharacteristicsCalculationCardAccountingAppService :=
    FuelCharacteristicsCalculationCardAccountingAppService;

  FFormViewModelMapper := FormViewModelMapper;

  FFuelCharacteristicsCalculationCardDtoMapper :=
    TFuelCharacteristicsCalculationCardDtoMapper.Create;

end;

function TFuelCharacteristicsCalculationCardFormServiceController.
  CreateCardFormViewModelForAddingReferenceRecordRequestHandling(
    AddingReferenceRecordRequestedEvent: TAddingReferenceRecordRequestedEvent
  ): TCardFormViewModel;
var FuelCharacteristicsCalculationCardInfo:
      TFuelCharacteristicsCalculationCardInfo;
begin

  FuelCharacteristicsCalculationCardInfo :=
    FFuelCharacteristicsCalculationCardAccountingAppService
      .GetNewFuelCharacteristicsCalculationCardInfo(FClientIdentity);

  try

    Result :=
      FFormViewModelMapper.
        MapFuelCharacteristicsCalculationCardFormViewModelFrom(
          FuelCharacteristicsCalculationCardInfo
        );

  finally

    FreeAndNil(FuelCharacteristicsCalculationCardInfo);

  end;

end;

function TFuelCharacteristicsCalculationCardFormServiceController.
  CreateCardFormViewModelForChangingReferenceRecordRequestHandling(

    ChangingReferenceRecordRequestedEvent:
      TChangingReferenceRecordRequestedEvent
      
  ): TCardFormViewModel;
var FuelCharacteristicsCalculationCardInfo:
      TFuelCharacteristicsCalculationCardInfo;
begin

  FuelCharacteristicsCalculationCardInfo :=
    FFuelCharacteristicsCalculationCardAccountingAppService
      .GetFuelCharacteristicsCalculationCardInfo(
        FClientIdentity,
        ChangingReferenceRecordRequestedEvent.RecordViewModel.Id
      );

  try

    Result :=
      FFormViewModelMapper
        .MapFuelCharacteristicsCalculationCardFormViewModelFrom(
          FuelCharacteristicsCalculationCardInfo
        );

  finally

    FreeAndNil(FuelCharacteristicsCalculationCardInfo);

  end;

end;

procedure TFuelCharacteristicsCalculationCardFormServiceController.
  CreateNewCard(
    ViewModel: TCardFormViewModel;
    var Success: Boolean
  );
var FuelCharacteristicsCalculationCardDto:
      TFuelCharacteristicsCalculationCardDto;

    AddedFuelCharacteristicsCalculationCardDto:
      TFuelCharacteristicsCalculationCardDto;
begin

  FuelCharacteristicsCalculationCardDto :=
    FFuelCharacteristicsCalculationCardDtoMapper
      .MapFuelCharacteristicsCalculationCardDtoFrom(
        TFuelCharacteristicsCalculationCardFormViewModel(ViewModel)
      );
  
  try

    AddedFuelCharacteristicsCalculationCardDto := nil;
    
    AddedFuelCharacteristicsCalculationCardDto :=
      FFuelCharacteristicsCalculationCardAccountingAppService
        .AccountNewFuelCharacteristicsCalculationCard(
          FClientIdentity,
          FuelCharacteristicsCalculationCardDto
        );

    FFormViewModelMapper
      .FillFuelCharacteristicsCalculationCardFormViewModelFrom(
        TFuelCharacteristicsCalculationCardFormViewModel(ViewModel),
        AddedFuelCharacteristicsCalculationCardDto
      );

  finally

    FreeAndNil(FuelCharacteristicsCalculationCardDto);
    FreeAndNil(AddedFuelCharacteristicsCalculationCardDto);
    
  end;

end;

procedure TFuelCharacteristicsCalculationCardFormServiceController.
  ModifyCard(
    ViewModel: TCardFormViewModel;
    var Success: Boolean
  );
var FuelCharacteristicsCalculationCardDto:
      TFuelCharacteristicsCalculationCardDto;

    ModifiedFuelCharacteristicsCalculationCardDto:
      TFuelCharacteristicsCalculationCardDto;
begin

  FuelCharacteristicsCalculationCardDto :=
    FFuelCharacteristicsCalculationCardDtoMapper
      .MapFuelCharacteristicsCalculationCardDtoFrom(
        TFuelCharacteristicsCalculationCardFormViewModel(
          ViewModel
        )
      );

  try

    ModifiedFuelCharacteristicsCalculationCardDto := nil;

    ModifiedFuelCharacteristicsCalculationCardDto :=
      FFuelCharacteristicsCalculationCardAccountingAppService
        .AccountExistingFuelCharacteristicsCalculationCard(
          FClientIdentity,
          FuelCharacteristicsCalculationCardDto
        );

    FFormViewModelMapper
      .FillFuelCharacteristicsCalculationCardFormViewModelFrom(
        TFuelCharacteristicsCalculationCardFormViewModel(ViewModel),
        ModifiedFuelCharacteristicsCalculationCardDto
      );
      
  finally

    FreeAndNil(ModifiedFuelCharacteristicsCalculationCardDto);
    FreeAndNil(FuelCharacteristicsCalculationCardDto);

  end;

end;

procedure TFuelCharacteristicsCalculationCardFormServiceController.RemoveCard(
  ViewModel: TCardFormViewModel);
begin

  FFuelCharacteristicsCalculationCardAccountingAppService
    .RemoveFuelCharacteristicsCalculationCard(
      FClientIdentity, ViewModel.Id.Value
    );

end;

end.
