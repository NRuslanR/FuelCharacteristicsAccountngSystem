unit FuelCharacteristicsAutomaticCalculationFormServiceController;

interface

uses

  BaseFuelCharacteristicsAutomaticCalculationFormController,
  FuelCharacteristicsAutomaticCalculationFormViewModel,
  FuelCharacteristicsCalculationAppService,
  ReservoirSubLayerKindAccountingAppService,
  FuelCharacteristicsCalculationDto,
  FuelCharacteristicsCalculationInputDto,
  ViewModelReservoirSubLayerKindValueMapper,
  ReservoirSubLayerKindDto,
  Forms,
  AbstractFormController,
  Controls,
  EventHandler,
  Event,
  EventBus,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAutomaticCalculationFormServiceController =
    class (TBaseFuelCharacteristicsAutomaticCalculationFormController)

      private

        FClientIdentity: Variant;

        FFuelCharacteristicsCalculationAppService:
          IFuelCharacteristicsCalculationAppService;

        FReservoirSubLayerKindAccountingAppService:
          IReservoirSubLayerKindAccountingAppService;

        FReservoirSubLayerKindValueMapper:
          TViewModelReservoirSubLayerKindValueMapper;
          
        function MapFuelCharacteristicsCalculationInputDtoFrom(
          ViewModel: TFuelCharacteristicsAutomaticCalculationFormViewModel
        ): TFuelCharacteristicsCalculationInputDto;

        procedure FillViewModelFromFuelCharacteristicsCalculationDto(
          ViewModel: TFuelCharacteristicsAutomaticCalculationFormViewModel;
          FuelCharacteristicsCalculationDto: TFuelCharacteristicsCalculationDto
        );

        procedure FillViewModelFromReservoirSubLayerKindDtos(
          ViewModel: TFuelCharacteristicsAutomaticCalculationFormViewModel;
          ReservoirSubLayerKindDtos: TReservoirSubLayerKindDtos
        );

      protected

        function CreateFormViewModel(FormData: TFormData):
          TFuelCharacteristicsAutomaticCalculationFormViewModel; override;

      protected

        procedure OnFuelCharacteristicsAutomaticCalculationRequestedEventHandler(
          Sender: TObject;
          var ViewModel: TFuelCharacteristicsAutomaticCalculationFormViewModel
        ); override;

      public

        destructor Destroy; override;
        
        constructor Create(

          const ClientIdentity: Variant;

          FuelCharacteristicsCalculationAppService:
            IFuelCharacteristicsCalculationAppService;

          ReservoirSubLayerKindAccountingAppService:
            IReservoirSubLayerKindAccountingAppService;

          EventBus: IEventBus
        );

    end;

implementation

{ TFuelCharacteristicsAutomaticCalculationFormServiceController }

constructor TFuelCharacteristicsAutomaticCalculationFormServiceController.Create(
  const ClientIdentity: Variant;

  FuelCharacteristicsCalculationAppService:
    IFuelCharacteristicsCalculationAppService;

  ReservoirSubLayerKindAccountingAppService:
    IReservoirSubLayerKindAccountingAppService;

  EventBus: IEventBus
);
begin

  inherited Create(EventBus);

  FClientIdentity := ClientIdentity;

  FFuelCharacteristicsCalculationAppService :=
    FuelCharacteristicsCalculationAppService;

  FReservoirSubLayerKindAccountingAppService :=
    ReservoirSubLayerKindAccountingAppService;

  FReservoirSubLayerKindValueMapper :=
    TViewModelReservoirSubLayerKindValueMapper.Create;
    
end;

function TFuelCharacteristicsAutomaticCalculationFormServiceController.
  CreateFormViewModel(
    FormData: TFormData
  ): TFuelCharacteristicsAutomaticCalculationFormViewModel;

var ReservoirSubLayerKindDtos: TReservoirSubLayerKindDtos;
begin
  
  ReservoirSubLayerKindDtos :=
    FReservoirSubLayerKindAccountingAppService.GetAllReservoirSubLayerKinds;

  try

    Result := inherited CreateFormViewModel(FormData);
    
    try

      Result.SubLayerKinds := TStringList.Create;

      FillViewModelFromReservoirSubLayerKindDtos(
        Result, ReservoirSubLayerKindDtos
      );

    except

      on E: Exception do begin

        FreeAndNil(Result);

        raise;

      end;

    end;

  finally

    FreeAndNil(ReservoirSubLayerKindDtos);

  end;

end;

destructor TFuelCharacteristicsAutomaticCalculationFormServiceController.
  Destroy;
begin

  FreeAndNil(FReservoirSubLayerKindValueMapper);
  
  inherited;

end;

procedure TFuelCharacteristicsAutomaticCalculationFormServiceController.
  FillViewModelFromFuelCharacteristicsCalculationDto(
    ViewModel: TFuelCharacteristicsAutomaticCalculationFormViewModel;
    FuelCharacteristicsCalculationDto: TFuelCharacteristicsCalculationDto
  );
begin

  ViewModel.FuelMass.Value := FuelCharacteristicsCalculationDto.FuelMass;

end;

procedure TFuelCharacteristicsAutomaticCalculationFormServiceController.
  FillViewModelFromReservoirSubLayerKindDtos(
    ViewModel: TFuelCharacteristicsAutomaticCalculationFormViewModel;
    ReservoirSubLayerKindDtos: TReservoirSubLayerKindDtos
  );
var ReservoirSubLayerKindDto: TReservoirSubLayerKindDto;
begin

  for ReservoirSubLayerKindDto in ReservoirSubLayerKindDtos do begin

    ViewModel.SubLayerKinds.AddObject(
      ReservoirSubLayerKindDto.Name,

      TObject(
        FReservoirSubLayerKindValueMapper
          .MapViewModelReservoirSubLayerKindValueFrom(
            ReservoirSubLayerKindDto
          )
      )
    );
    
  end;

end;

function TFuelCharacteristicsAutomaticCalculationFormServiceController
  .MapFuelCharacteristicsCalculationInputDtoFrom(
    ViewModel: TFuelCharacteristicsAutomaticCalculationFormViewModel
  ): TFuelCharacteristicsCalculationInputDto;
var SubLayerKindId: Variant;
begin

  Result := TFuelCharacteristicsCalculationInputDto.Create;

  try

    Result.ReservoirKindId := ViewModel.ReservoirKindName.Value;

    SubLayerKindId :=
      ViewModel.SubLayerKinds[
        ViewModel.SubLayerKinds.IndexOfObject(
          TObject(ViewModel.SubLayerKindValue)
        )
      ];

    Result.FuelTemperature := ViewModel.FuelTemperature.Value;
    Result.FuelRiseLevel := ViewModel.FuelRiseLevel.Value;
    Result.FuelDensity := ViewModel.FuelDensity.Value;
      
    if ViewModel.SubLayerKindValue = skIce then begin

      Result.ReservoirSubLayerCharacteristicsCalculationInputDto :=
        TIceLayerCharacteristicsCalculationInputDto.Create(
          SubLayerKindId,
          ViewModel.ReservoirSubLayerCalculationCharacteristicValue.Value
        );

    end

    else begin

      Result.ReservoirSubLayerCharacteristicsCalculationInputDto :=
        TBottomWaterCharacteristicsCalculationInputDto.Create(
          SubLayerKindId,
          ViewModel.ReservoirSubLayerCalculationCharacteristicValue.Value
        );

    end;

  except

    on E: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

procedure TFuelCharacteristicsAutomaticCalculationFormServiceController.
  OnFuelCharacteristicsAutomaticCalculationRequestedEventHandler(
    Sender: TObject;
    var ViewModel: TFuelCharacteristicsAutomaticCalculationFormViewModel
  );
var FuelCharacteristicsCalculationInputDto:
      TFuelCharacteristicsCalculationInputDto;

    FuelCharacteristicsCalculationDto: TFuelCharacteristicsCalculationDto;
begin

  FuelCharacteristicsCalculationInputDto :=
    MapFuelCharacteristicsCalculationInputDtoFrom(ViewModel);

  try

    Screen.Cursor := crHourGlass;

    FuelCharacteristicsCalculationDto :=
    
      FFuelCharacteristicsCalculationAppService
        .CalculateFuelCharacteristics(
          FClientIdentity, FuelCharacteristicsCalculationInputDto
        );

  finally

    Screen.Cursor := crDefault;
    
    FreeAndNil(FuelCharacteristicsCalculationInputDto);

  end;

  try

    FillViewModelFromFuelCharacteristicsCalculationDto(
      ViewModel,
      FuelCharacteristicsCalculationDto
    );

  finally

    FreeAndNil(FuelCharacteristicsCalculationDto);
    
  end;

  
end;

end.
