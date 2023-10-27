unit StandardFuelCharacteristicsCalculationService;

interface

uses

  FuelCharacteristicsCalculationService,
  FuelCharacteristicsCalculation,
  AbstractDomainService,
  ReservoirSubLayerKind,
  ReservoirKindReferenceSuiteDirectory,
  ReservoirCalibrationChartRegistry,
  ReservoirSubLayerKindAccountingService,
  ReservoirSubLayerCharacteristicsCalculationInput,
  Employee,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsCalculationService =
    class (
      TAbstractStandardDomainService,
      IFuelCharacteristicsCalculationService
    )

      protected

        FReservoirSubLayerKindAccountingService: IReservoirSubLayerKindAccountingService;
        FReservoirKindReferenceSuiteDirectory: IReservoirKindReferenceSuiteDirectory;
        FReservoirCalibrationChartRegistry: IReservoirCalibrationChartRegistry;

        function MakeFuelCharacteristicsCalculationFrom(

          const Input: TFuelCharacteristicsCalculationInput

        ): TFuelCharacteristicsCalculation; virtual;

        function CalculateOilProductVolumeFrom(

          const Input: TFuelCharacteristicsCalculationInput

        ): Single;

        function CalculateFuelMassFrom(
          const OilProductVolume: Single;
          const Input: TFuelCharacteristicsCalculationInput
        ): Single;
        
      public

        constructor Create(
          ReservoirSubLayerKindAccountingService: IReservoirSubLayerKindAccountingService;
          ReservoirKindReferenceSuiteDirectory: IReservoirKindReferenceSuiteDirectory;
          ReservoirCalibrationChartRegistry: IReservoirCalibrationChartRegistry
        );

        function CalculateFuelCharacteristicsOnBehalfOfEmployee(
          Input: TFuelCharacteristicsCalculationInput;
          Employee: TEmployee
        ): TFuelCharacteristicsCalculation; virtual;

    end;

implementation

uses

  ReservoirCalibrationChart,
  IDomainObjectBaseUnit,
  unIReservoirKindReferenceSuite,
  StandardFuelCharacteristicsCalculationRuleRegistry;
  
{ TStandardFuelCharacteristicsCalculationService }

function TStandardFuelCharacteristicsCalculationService.
  CalculateFuelCharacteristicsOnBehalfOfEmployee(
    Input: TFuelCharacteristicsCalculationInput;
    Employee: TEmployee
  ): TFuelCharacteristicsCalculation;
begin

  TFuelCharacteristicsCalculationRuleRegistry
    .Current
    .GetFuelCharacteristicsCalculationAccessRule
    .EnsureEmployeeHasFuelCharacteristicsCalculationAccess(Employee);

  Result := MakeFuelCharacteristicsCalculationFrom(Input);
    
end;

function TStandardFuelCharacteristicsCalculationService.
  CalculateFuelMassFrom(
    const OilProductVolume: Single;
    const Input: TFuelCharacteristicsCalculationInput
  ): Single;
const

  ACTValue = 0.0000125;
  ASValue = 0.0000125;

var

  CorrectedVolume: Single;
begin

  CorrectedVolume :=
    OilProductVolume *
    (1 + (2 * ACTValue + ASValue) * (Input.FuelTemperature - 20));
    
  Result := CorrectedVolume * Input.FuelDensity;

end;

function TStandardFuelCharacteristicsCalculationService.
  CalculateOilProductVolumeFrom(

    const Input: TFuelCharacteristicsCalculationInput

  ): Single;
var

    ReservoirKindReferenceSuite: IReservoirKindReferenceSuite;

    ReservoirSubLayerKind: TReservoirSubLayerKind;
    Free: IDomainObjectBase;

    ReservoirCalibrationChart: IReservoirCalibrationChart;

    function CalculateOnBottomWaterOilProductVolume(
        const OilProductRiseLevel: Single;
        const BottomWaterLevel: Single;
        const CalibrationChart: IReservoirCalibrationChart
    ): Single;
    var OilProductRiseLevelInput: TReservoirCalibrationChartInput;
        FreeOilProductRiseLevelInput: IDomainObjectBase;

        BottomWaterLevelInput: TReservoirCalibrationChartInput;
        FreeBottomWaterLevelInput: IDomainObjectBase;
    begin

      if OilProductRiseLevel < BottomWaterLevel then begin

        raise TFuelCharacteristicsCalculationServiceException.Create(
          'Уровень подтоварной воды выше ' +
          'уровня взлива нефтепродукта'
        );

      end;

      OilProductRiseLevelInput :=
        TReservoirCalibrationChartInput.Create(OilProductRiseLevel);

      FreeOilProductRiseLevelInput := OilProductRiseLevelInput;

      BottomWaterLevelInput :=
        TReservoirCalibrationChartInput.Create(BottomWaterLevel);

      FreeBottomWaterLevelInput := BottomWaterLevelInput;
      
      Result :=
        CalibrationChart.GetVolume(OilProductRiseLevelInput) -
        CalibrationChart.GetVolume(BottomWaterLevelInput);

    end;

    function CalculateOnIceOilProductVolume(
        const OilProductRiseLevel: Single;
        const AltitudinalConstantStencil: Single;
        const AltitudinalActualStencil: Single;
        const CalibrationChart: IReservoirCalibrationChart
    ): Single;
    var IceLevel: Single;
        CommonRiseLevel: Single;

        CommonRiseLevelInput: TReservoirCalibrationChartInput;
        FreeCommonRiseLevelInput: IDomainObjectBase;

        IceLevelInput: TReservoirCalibrationChartInput;
        FreeIceLevelInput: IDomainObjectBase;
    begin

      if AltitudinalConstantStencil < AltitudinalActualStencil then begin

        raise TFuelCharacteristicsCalculationServiceException.CreateFmt(
          'Значение ВТП резервуара типа "%s" ' +
          'меньше значения ВТФ',
          [
            Input.ReservoirKindName
          ]
        );
        
      end;

      IceLevel := AltitudinalConstantStencil - AltitudinalActualStencil;

      if OilProductRiseLevel < IceLevel then begin

        raise TFuelCharacteristicsCalculationServiceException.Create(
          'Высота слоя льда выше уровня ' +
          'взлива нефтепродукта'
        );
        
      end;

      CommonRiseLevel := OilProductRiseLevel + IceLevel;

      CommonRiseLevelInput :=
        TReservoirCalibrationChartInput.Create(CommonRiseLevel);

      FreeCommonRiseLevelInput := CommonRiseLevelInput;

      IceLevelInput :=
        TReservoirCalibrationChartInput.Create(IceLevel);

      FreeIceLevelInput := IceLevelInput;

      Result :=
        CalibrationChart.GetVolume(CommonRiseLevelInput) -
        CalibrationChart.GetVolume(IceLevelInput);
        
    end;
    
begin

  ReservoirKindReferenceSuite :=
    FReservoirKindReferenceSuiteDirectory.FindReservoirKindReferenceSuite(
      Input.ReservoirKindName
    );

  ReservoirCalibrationChart :=
    FReservoirCalibrationChartRegistry.GetReservoirCalibrationChart(
      ReservoirKindReferenceSuite.CalibrationChartLocation
    );

  ReservoirSubLayerKind :=
    FReservoirSubLayerKindAccountingService.TakeReservoirSubLayerKind(
      Input.ReservoirSubLayerCharacteristicsCalculationInput.SubLayerName
    );

  Free := ReservoirSubLayerKind;

  if ReservoirSubLayerKind is TReservoirBottomWater then begin

    Result :=
      CalculateOnBottomWaterOilProductVolume(
        Input.FuelRiseLevel,

        TBottomWaterCharacteristicsCalculationInput(
          Input.ReservoirSubLayerCharacteristicsCalculationInput
        ).BottomWaterLevel,

        ReservoirCalibrationChart
      );

  end

  else if ReservoirSubLayerKind is TReservoirIce then begin

    Result :=
      CalculateOnIceOilProductVolume(
        Input.FuelRiseLevel,
        ReservoirKindReferenceSuite.AltitudinalConstantStencil,

        TIceLayerCharacteristicsCalculationInput(
          Input.ReservoirSubLayerCharacteristicsCalculationInput
        ).AltitudinalActualStencil,
        
        ReservoirCalibrationChart
      );

  end

  else begin

    raise TFuelCharacteristicsCalculationServiceException.Create(
      'Программная ошибка. Тип резервуарного подслоя ' +
      'не определён для вычисления обьёма нефтепродукта'
    );

  end;

end;

constructor TStandardFuelCharacteristicsCalculationService.Create(
  ReservoirSubLayerKindAccountingService: IReservoirSubLayerKindAccountingService;
  ReservoirKindReferenceSuiteDirectory: IReservoirKindReferenceSuiteDirectory;
  ReservoirCalibrationChartRegistry: IReservoirCalibrationChartRegistry
);
begin

  inherited Create;

  FReservoirSubLayerKindAccountingService := ReservoirSubLayerKindAccountingService;
  FReservoirKindReferenceSuiteDirectory := ReservoirKindReferenceSuiteDirectory;
  FReservoirCalibrationChartRegistry := ReservoirCalibrationChartRegistry;
  
end;

function TStandardFuelCharacteristicsCalculationService.
  MakeFuelCharacteristicsCalculationFrom(

    const Input: TFuelCharacteristicsCalculationInput
      
  ): TFuelCharacteristicsCalculation;
var OilProductVolume: Single;
begin

  Result := TFuelCharacteristicsCalculation.Create;

  try

    OilProductVolume := CalculateOilProductVolumeFrom(Input);

    Result.FuelMass := CalculateFuelMassFrom(OilProductVolume, Input);

  except

    on E: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

  
end;

end.
