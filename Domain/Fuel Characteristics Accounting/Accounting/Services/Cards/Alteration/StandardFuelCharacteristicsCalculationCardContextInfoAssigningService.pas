unit StandardFuelCharacteristicsCalculationCardContextInfoAssigningService;

interface

uses

  FuelCharacteristicsCalculationCardContextInfoAssigningService,
  Employee,
  AbstractDomainService,
  FuelCharacteristicsCalculationCard,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsCalculationCardContextInfoAssigningService =
    class (
      TAbstractStandardDomainService,
      IFuelCharacteristicsCalculationCardContextInfoAssigningService
    )

      public

        function IsCalculationContextInfoAssignedToFuelCharacteristicsCalculationCard(
          FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
          PerformedCalculationEmployee: TEmployee
        ): Boolean; virtual;

        procedure AssignCalculationContextInfoToFuelCharacteristicsCalculationCard(
          FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
          PerformedCalculationEmployee: TEmployee
        ); virtual;

    end;

implementation

uses

  Variants,
  AuxiliaryDateFunctions;
  
{ TStandardFuelCharacteristicsCalculationCardContextInfoAssigningService }

procedure
  TStandardFuelCharacteristicsCalculationCardContextInfoAssigningService.
    AssignCalculationContextInfoToFuelCharacteristicsCalculationCard(
      FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
      PerformedCalculationEmployee: TEmployee
    );
begin

  if
    IsCalculationContextInfoAssignedToFuelCharacteristicsCalculationCard(
      FuelCharacteristicsCalculationCard, PerformedCalculationEmployee
    )
  then begin

    raise
    TFuelCharacteristicsCalculationCardContextInfoAssigningServiceException.
      Create(
        'Информация о выполневшем расчёт ' +
        'сотруднике и дате выполнения расчёта ' +
        'уже указана в карточке'
      );
      
  end;

  FuelCharacteristicsCalculationCard.InvariantsComplianceRequested := False;

  try

    if
      VarIsNull(
        FuelCharacteristicsCalculationCard.PerformedCalculationEmployeeId
      )
    then begin
    
      FuelCharacteristicsCalculationCard.PerformedCalculationEmployeeId :=
        PerformedCalculationEmployee.Identity;

    end;

    FuelCharacteristicsCalculationCard.
      CalculationPerformingDateTime := Now;

  finally

    FuelCharacteristicsCalculationCard.InvariantsComplianceRequested := True;

  end;

end;

function TStandardFuelCharacteristicsCalculationCardContextInfoAssigningService.
  IsCalculationContextInfoAssignedToFuelCharacteristicsCalculationCard(
    FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
    PerformedCalculationEmployee: TEmployee
  ): Boolean;
begin

  with FuelCharacteristicsCalculationCard do begin

    Result :=
      not VarIsNull(PerformedCalculationEmployeeId)
      and
      not VarIsNull(CalculationPerformingDateTime)
      and IsDateTimeValid(CalculationPerformingDateTime);

  end;
  
end;

end.
