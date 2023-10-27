unit ReservoirKindsFormServiceController;

interface

uses

  BaseReservoirKindsFormController,
  EventBus,
  ReferenceFormRecordViewModel,
  AbstractReferenceFormControllerEvents,
  ReferenceFormViewModel,
  ReservoirKindsFormViewModel,
  ReservoirKindReferenceService,
  ReferenceFormViewModelMapper,
  ReservoirKindSetHolder,
  ReservoirKindsFormViewModelMapper,
  SysUtils,
  Classes;

type

  TReservoirKindsFormServiceController =
    class (TBaseReservoirKindsFormController)

      private

        FClientIdentity: Variant;

        FReservoirKindReferenceService: IReservoirKindReferenceService;

        FReservoirKindsFormViewModelMapper: IReferenceFormViewModelMapper;

      protected

        function CreateReferenceFormViewModel:
          TReferenceFormViewModel; override;

      public

        constructor Create(
          const ClientIdentity: Variant;

          ReservoirKindReferenceService: IReservoirKindReferenceService;

          ReservoirKindsFormViewModelMapper: IReferenceFormViewModelMapper;

          EventBus: IEventBus
        );

    end;

implementation

{ TReservoirKindsFormServiceController }

constructor TReservoirKindsFormServiceController.Create(
  const ClientIdentity: Variant;
  ReservoirKindReferenceService: IReservoirKindReferenceService;
  ReservoirKindsFormViewModelMapper: IReferenceFormViewModelMapper;
  EventBus: IEventBus
);
begin

  inherited Create(nil, EventBus);

  FClientIdentity := ClientIdentity;

  FReservoirKindReferenceService := ReservoirKindReferenceService;

  FReservoirKindsFormViewModelMapper := ReservoirKindsFormViewModelMapper;

end;

function TReservoirKindsFormServiceController.
  CreateReferenceFormViewModel: TReferenceFormViewModel;
var ReservoirKindSetHolder: TReservoirKindSetHolder;
begin

  ReservoirKindSetHolder :=
    FReservoirKindReferenceService.GetAllReservoirKindsForEmployee(
      FClientIdentity
    );

  try

    Result :=
      FReservoirKindsFormViewModelMapper.MapReferenceFormViewModelFrom(
        ReservoirKindSetHolder
      );

  finally

    FreeAndNil(ReservoirKindSetHolder);
    
  end;

end;

end.
