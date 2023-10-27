unit FuelCharacteristicsCalculationCardDbSchema;

interface

type

  TFuelCharacteristicsCalculationCardDbSchema = class

    public

      TableName: String;
      
      IdColumnName: String;
      TemperatureColumnName: String;
      DensityColumnName: String;
      FuelRiseLevelColumnName: String;
      FuelMassColumnName: String;
      FuelKindColumnName: String;
      ReservoirNumberColumnName: String;
      PerformedCalculationEmployeeIdColumnName: String;
      CalculationPerformingDateTimeColumnName: String;

  end;

implementation

end.
