unit ReservoirKindReferenceSuitesFormServiceController;

interface

uses

  BaseReservoirKindReferenceSuitesFormController,
  ReservoirKindReferenceSuitesFormViewModel,
  ReferenceFormViewModel,
  ReservoirKindReferenceSuitesViewModelMapper,
  ReservoirKindReferenceSuiteRecordViewModelMapper,
  ReservoirKindReferenceSuiteReferenceService,
  ReservoirKindReferenceSuiteAccountingAppService,
  ReferenceFormRecordViewModel,
  ReferenceFormViewModelMapper,
  ReservoirKindReferenceSuiteSetHolder,
  ReservoirKindReferenceSuiteAccessRightsDto,
  EventBus,
  SysUtils,
  Classes;

type

  TReservoirKindReferenceSuitesFormServiceController =
    class (TBaseReservoirKindReferenceSuitesFormController)

      private

        FClientIdentity: Variant;

        FReservoirKindReferenceSuiteReferenceService:
          IReservoirKindReferenceSuiteReferenceService;

        FReservoirKindReferenceSuiteAccountingAppService:
          IReservoirKindReferenceSuiteAccountingAppService;

        FReservoirKindReferenceSuitesViewModelMapper:
          IReferenceFormViewModelMapper;

      protected

        function CreateReferenceFormViewModel: TReferenceFormViewModel; override;

      protected

        procedure OnRecordFocusedEventHandler(
          Sender: TObject;
          var FocusedRecordViewModel: TReferenceFormRecordViewModel
        ); override;

      public

        constructor Create(
          const ClientIdentity: Variant;

          ReservoirKindReferenceSuiteReferenceService:
            IReservoirKindReferenceSuiteReferenceService;

          ReservoirKindReferenceSuiteAccountingAppService:
            IReservoirKindReferenceSuiteAccountingAppService;

          ReservoirKindReferenceSuitesViewModelMapper:
            TReservoirKindReferenceSuitesViewModelMapper;

          ReservoirKindReferenceSuiteRecordViewModelMapper:
            TReservoirKindReferenceSuiteRecordViewModelMapper;

          EventBus: IEventBus
        );

          
    end;

implementation

{ TReservoirKindReferenceSuitesFormServiceController }

constructor TReservoirKindReferenceSuitesFormServiceController.Create(
  const ClientIdentity: Variant;
  ReservoirKindReferenceSuiteReferenceService: IReservoirKindReferenceSuiteReferenceService;
  ReservoirKindReferenceSuiteAccountingAppService: IReservoirKindReferenceSuiteAccountingAppService;
  ReservoirKindReferenceSuitesViewModelMapper: TReservoirKindReferenceSuitesViewModelMapper;
  ReservoirKindReferenceSuiteRecordViewModelMapper: TReservoirKindReferenceSuiteRecordViewModelMapper;
  EventBus: IEventBus
);
begin

  inherited Create(ReservoirKindReferenceSuiteRecordViewModelMapper, EventBus);

  FClientIdentity := ClientIdentity;
  
  FReservoirKindReferenceSuiteReferenceService :=
    ReservoirKindReferenceSuiteReferenceService;

  FReservoirKindReferenceSuiteAccountingAppService :=
    ReservoirKindReferenceSuiteAccountingAppService;

  FReservoirKindReferenceSuitesViewModelMapper :=
    ReservoirKindReferenceSuitesViewModelMapper;

end;

function TReservoirKindReferenceSuitesFormServiceController.
  CreateReferenceFormViewModel: TReferenceFormViewModel;
var ReferenceSuiteSetHolder: TReservoirKindReferenceSuiteSetHolder;
begin

  ReferenceSuiteSetHolder :=
    FReservoirKindReferenceSuiteReferenceService
      .GetAllReservoirKindReferenceSuiteSetForEmployee(
        FClientIdentity
      );

  try

    Result :=
      FReservoirKindReferenceSuitesViewModelMapper
        .MapReferenceFormViewModelFrom(ReferenceSuiteSetHolder);

  finally

    FreeAndNil(ReferenceSuiteSetHolder);
    
  end;

end;

procedure TReservoirKindReferenceSuitesFormServiceController.
  OnRecordFocusedEventHandler(
    Sender: TObject;
    var FocusedRecordViewModel: TReferenceFormRecordViewModel
  );
var ReferenceSuiteAccessRightsDto: TReservoirKindReferenceSuiteAccessRightsDto;
begin

  ReferenceSuiteAccessRightsDto :=
    FReservoirKindReferenceSuiteAccountingAppService
      .GetReservoirKindReferenceSuiteAccessRights(
        FClientIdentity, FocusedRecordViewModel.Id
      );

  try

    FocusedRecordViewModel.CanBeChanged :=
      ReferenceSuiteAccessRightsDto.CanBeEdited;

    FocusedRecordViewModel.CanBeRemoved :=
      ReferenceSuiteAccessRightsDto.CanBeRemoved;
      
  finally

    FreeAndNil(ReferenceSuiteAccessRightsDto);
    
  end;

end;

end.
