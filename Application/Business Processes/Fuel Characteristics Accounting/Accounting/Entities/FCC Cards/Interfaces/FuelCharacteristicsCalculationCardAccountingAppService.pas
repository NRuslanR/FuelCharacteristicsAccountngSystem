unit FuelCharacteristicsCalculationCardAccountingAppService;

interface

uses

  FuelCharacteristicsCalculationCardDto,
  FuelCharacteristicsCalculationCardAccessRightsDto,
  FuelCharacteristicsCalculationCardInfo,
  ApplicationService,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsCalculationCardAccountingAppServiceException =
    class (TApplicationServiceException)

    end;
    
  IFuelCharacteristicsCalculationCardAccountingAppService =
    interface (IApplicationService)

      function GetNewFuelCharacteristicsCalculationCardInfo(
        const RequestingEmployeeId: Variant
      ): TFuelCharacteristicsCalculationCardInfo;
        
      function GetFuelCharacteristicsCalculationCardInfo(
        const RequestingEmployeeId: Variant;
        const CardId: Variant
      ): TFuelCharacteristicsCalculationCardInfo;

      function GetFuelCharacteristicsCalculationCardAccessRights(
        const RequestingEmployeeId: Variant;
        const CardId: Variant
      ): TFuelCharacteristicsCalculationCardAccessRightsDto;
      
      function AccountNewFuelCharacteristicsCalculationCard(
        const RequestingEmployeeId: Variant;

        const FuelCharacteristicsCalculationCardDto:
          TFuelCharacteristicsCalculationCardDto

      ): TFuelCharacteristicsCalculationCardDto;

      function AccountExistingFuelCharacteristicsCalculationCard(
        const RequestingEmployeeId: Variant;

        const FuelCharacteristicsCalculationCardDto:
          TFuelCharacteristicsCalculationCardDto
          
      ): TFuelCharacteristicsCalculationCardDto;

      procedure RemoveFuelCharacteristicsCalculationCard(
        const RequestingEmployeeId: Variant;
        const CardId: Variant
      );

    end;
    
implementation

end.
