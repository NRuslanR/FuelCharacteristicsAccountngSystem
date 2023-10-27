unit FuelCharacteristicsCalculationCardSetReadService;

interface

uses

  ApplicationService,
  FuelCharacteristicsCalculationCardSetHolder;

type

  TFuelCharacteristicsCalculationCardSetReadServiceException =
    class (TApplicationServiceException)

    end;
    
  IFuelCharacteristicsCalculationCardSetReadService =
    interface (IApplicationService)

      function GetFuelCharacteristicsCalculationCardSetForEmployee(
        const EmployeeId: Variant
      ): TFuelCharacteristicsCalculationCardSetHolder;
      
    end;

implementation

end.
