unit ReservoirCalibrationChartRegistry;

interface

uses

  DomainService,
  DomainException,
  DomainObjectValueUnit,
  AbstractDomainService,
  ReservoirCalibrationChart;

type

  TReservoirCalibrationChartRegistryException =
    class (TDomainException)

    end;

  TReservoirCalibrationChartFormat = (cfNGE, cfUnknown);
  
  IReservoirCalibrationChartRegistry = interface (IDomainService)

    function GetReservoirCalibrationChart(
      const CalibrationChartLocation: Variant;
      const Format: TReservoirCalibrationChartFormat = cfNGE
    ): IReservoirCalibrationChart;

  end;

  TAbstractReservoirCalibrationChartRegistry =
    class abstract (TAbstractDomainService, IReservoirCalibrationChartRegistry)

      public

        function GetReservoirCalibrationChart(
          const CalibrationChartLocation: Variant;
          const Format: TReservoirCalibrationChartFormat = cfNGE
        ): IReservoirCalibrationChart; virtual; abstract;
      
    end;

implementation

end.
