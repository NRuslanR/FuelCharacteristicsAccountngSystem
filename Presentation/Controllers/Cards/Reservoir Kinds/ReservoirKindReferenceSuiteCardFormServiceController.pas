unit ReservoirKindReferenceSuiteCardFormServiceController;

interface

uses

  BaseReservoirKindReferenceSuiteCardFormController,
  CardFormViewModelMapper,
  ReservoirKindReferenceSuiteCardFormViewModelMapper,
  CardFormViewModel,
  ReservoirKindReferenceSuiteAccountingAppService,
  ReservoirKindReferenceSuiteDtoMapper,
  ReservoirKindReferenceSuiteCardFormViewModel,
  AbstractReferenceFormControllerEvents,
  ReservoirKindReferenceSuiteInfo,
  ReservoirKindReferenceSuiteDto,
  EventBus,
  Forms,
  Controls,
  SysUtils,
  Classes;

type

  TReservoirKindReferenceSuiteCardFormServiceController =
    class (TBaseReservoirKindReferenceSuiteCardFormController)

      private

        FClientIdentity: Variant;

        FReservoirKindReferenceSuiteAccountingAppService:
          IReservoirKindReferenceSuiteAccountingAppService;

        FReservoirKindReferenceSuiteDtoMapper:
          TReservoirKindReferenceSuiteDtoMapper;
          
        FFormViewModelMapper:
          TReservoirKindReferenceSuiteCardFormViewModelMapper;
        
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

          ReservoirKindReferenceSuiteAccountingAppService:
            IReservoirKindReferenceSuiteAccountingAppService;

          FormViewModelMapper:
            TReservoirKindReferenceSuiteCardFormViewModelMapper;

          EventBus: IEventBus
        );

        
    end;
  
implementation

{ TReservoirKindReferenceSuiteCardFormServiceController }

destructor TReservoirKindReferenceSuiteCardFormServiceController.Destroy;
begin

  FreeAndNil(FReservoirKindReferenceSuiteDtoMapper);
  
  inherited;

end;

constructor TReservoirKindReferenceSuiteCardFormServiceController.Create(
  const ClientIdentity: Variant;
  ReservoirKindReferenceSuiteAccountingAppService: IReservoirKindReferenceSuiteAccountingAppService;
  FormViewModelMapper: TReservoirKindReferenceSuiteCardFormViewModelMapper;
  EventBus: IEventBus
);
begin

  inherited Create(FormViewModelMapper, EventBus);

  FClientIdentity := ClientIdentity;

  FReservoirKindReferenceSuiteAccountingAppService :=
    ReservoirKindReferenceSuiteAccountingAppService;

  FReservoirKindReferenceSuiteDtoMapper :=
    TReservoirKindReferenceSuiteDtoMapper.Create;
    
  FFormViewModelMapper := FormViewModelMapper;

end;

function TReservoirKindReferenceSuiteCardFormServiceController.
  CreateCardFormViewModelForAddingReferenceRecordRequestHandling(
    AddingReferenceRecordRequestedEvent: TAddingReferenceRecordRequestedEvent
  ): TCardFormViewModel;
begin

  Result :=
    inherited CreateCardFormViewModelForAddingReferenceRecordRequestHandling(
      AddingReferenceRecordRequestedEvent
    );
    
end;

function TReservoirKindReferenceSuiteCardFormServiceController.
  CreateCardFormViewModelForChangingReferenceRecordRequestHandling(
    ChangingReferenceRecordRequestedEvent: TChangingReferenceRecordRequestedEvent
  ): TCardFormViewModel;
var ReferenceSuiteInfo: TReservoirKindReferenceSuiteInfo;
begin

  ReferenceSuiteInfo :=
    FReservoirKindReferenceSuiteAccountingAppService
      .GetReservoirKindReferenceSuiteInfo(
        FClientIdentity,
        ChangingReferenceRecordRequestedEvent.RecordViewModel.Id
      );

  try

    Result :=
      FFormViewModelMapper
        .MapReservoirKindReferenceSuiteCardFormViewModelFrom(
          ReferenceSuiteInfo
        );

  finally

    FreeAndNil(ReferenceSuiteInfo);
    
  end;
    
end;

procedure TReservoirKindReferenceSuiteCardFormServiceController.CreateNewCard(
  ViewModel: TCardFormViewModel;
  var Success: Boolean
);
var ReferenceSuiteDto: TReservoirKindReferenceSuiteDto;
begin

  ReferenceSuiteDto :=
    FReservoirKindReferenceSuiteDtoMapper
      .MapReservoirKindReferenceSuiteDtoFrom(
        TReservoirKindReferenceSuiteCardFormViewModel(ViewModel)
      );

  try

    FReservoirKindReferenceSuiteAccountingAppService
      .AccountNewReservoirKindReferenceSuite(
        FClientIdentity, ReferenceSuiteDto
      );

  finally
    
    FreeAndNil(ReferenceSuiteDto);
    
  end;

end;

procedure TReservoirKindReferenceSuiteCardFormServiceController.ModifyCard(
  ViewModel: TCardFormViewModel;
  var Success: Boolean
);
var ReferenceSuiteDto: TReservoirKindReferenceSuiteDto;
begin

  ReferenceSuiteDto :=
    FReservoirKindReferenceSuiteDtoMapper
      .MapReservoirKindReferenceSuiteDtoFrom(
        TReservoirKindReferenceSuiteCardFormViewModel(ViewModel)
      );

  try

    FReservoirKindReferenceSuiteAccountingAppService
      .AccountExistingReservoirKindReferenceSuite(
        FClientIdentity, ReferenceSuiteDto
      );
      
  finally

    FreeAndNil(ReferenceSuiteDto);

  end;

end;

procedure TReservoirKindReferenceSuiteCardFormServiceController.
  RemoveCard(
    ViewModel: TCardFormViewModel
  );
begin

  FReservoirKindReferenceSuiteAccountingAppService
    .RemoveReservoirKindReferenceSuite(
      FClientIdentity, ViewModel.Id.Value
    );

end;

end.
