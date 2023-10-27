unit FuelCharacteristicsCalculationAppService;

interface

uses

  FuelCharacteristicsCalculationInputDto,
  FuelCharacteristicsCalculationDto,
  ApplicationService;

type

  TFuelCharacteristicsCalculationAppServiceException =
    class (TApplicationServiceException)
    
    end;

  IFuelCharacteristicsCalculationAppService = interface (IApplicationService)

    function CalculateFuelCharacteristics(
      const ClientIdentity: Variant;
      const Input: TFuelCharacteristicsCalculationInputDto
    ): TFuelCharacteristicsCalculationDto;

  end;

implementation

end.
