unit unIFuelCharacteristicsCalculationCard;

interface

uses

  IGetSelfUnit,
  IDomainObjectUnit,
  Employee,
  SysUtils;

type

   IFuelCharacteristicsCalculationCard = interface (IDomainObject)

      function GetFuelDensity: Variant;
      function GetFuelKind: String;
      function GetFuelRiseLevel: Variant;
      function GetFuelTemperature: Variant;
      function GetFuelMass: Variant;
      function GetPerformedCalculationEmployeeId: Variant;
      function GetCalculationPerformingDateTime: Variant;
      function GetReservoirNumber: Variant;
      function GetFuelCharacteristicsInfoEditingEmployee: TEmployee;
      function GetCalculationContextInfoEditingEmployee: TEmployee;
      
      procedure SetCalculationPerformingDateTime(const Value: Variant);
      procedure SetFuelDensity(const Value: Variant);
      procedure SetFuelKind(const Value: String);
      procedure SetFuelRiseLevel(const Value: Variant);
      procedure SetFuelTemperature(const Value: Variant);
      procedure SetFuelMass(const Value: Variant);
      procedure SetPerformedCalculationEmployeeId(const Value: Variant);
      procedure SetReservoirNumber(const Value: Variant);
      procedure SetFuelCharacteristicsInfoEditingEmployee(const Value: TEmployee);
      procedure SetCalculationContextInfoEditingEmployee(const Value: TEmployee);
      
      property FuelTemperature: Variant
      read GetFuelTemperature write SetFuelTemperature;
      
      property FuelDensity: Variant
      read GetFuelDensity write SetFuelDensity;

      property FuelRiseLevel: Variant
      read GetFuelRiseLevel write SetFuelRiseLevel;
      
      property FuelMass: Variant
      read GetFuelMass write SetFuelMass;
      
      property FuelKind: String
      read GetFuelKind write SetFuelKind;
      
      property ReservoirNumber: Variant
      read GetReservoirNumber write SetReservoirNumber;

      property PerformedCalculationEmployeeId: Variant
      read GetPerformedCalculationEmployeeId write SetPerformedCalculationEmployeeId;

      property CalculationPerformingDateTime: Variant
      read GetCalculationPerformingDateTime write SetCalculationPerformingDateTime;

      property FuelCharacteristicsInfoEditingEmployee: TEmployee
      read GetFuelCharacteristicsInfoEditingEmployee
      write SetFuelCharacteristicsInfoEditingEmployee;

      property CalculationContextInfoEditingEmployee: TEmployee
      read GetCalculationContextInfoEditingEmployee
      write SetCalculationContextInfoEditingEmployee;
      
  end;

implementation

end.
