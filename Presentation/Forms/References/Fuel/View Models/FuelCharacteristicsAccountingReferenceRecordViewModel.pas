unit FuelCharacteristicsAccountingReferenceRecordViewModel;

interface

uses

  ReferenceFormRecordViewModel,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingReferenceRecordViewModel =
    class (TReferenceFormRecordViewModel)

      public

        Temperature: Single;
        Density: Single;
        FuelRiseLevel: Single;
        FuelMass: Single;
        FuelKind: String;
        ReservoirNumber: Integer;
        PerformedCalculationEmployeeName: String;
        PerformedCalculationEmployeeId: Variant;
        CalculationPerformingDateTime: TDateTime;

    end;

implementation

uses

  Variants;

end.
