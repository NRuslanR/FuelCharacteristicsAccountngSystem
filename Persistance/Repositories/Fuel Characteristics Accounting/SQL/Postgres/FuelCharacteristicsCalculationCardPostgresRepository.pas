unit FuelCharacteristicsCalculationCardPostgresRepository;

interface

uses

  AbstractPostgresRepositoryUnit,
  FuelCharacteristicsCalculationCardRepository,
  FuelCharacteristicsCalculationCard,
  QueryExecutor,
  DBTableMappingUnit,
  VariantListUnit,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsCalculationCardPostgresRepository =
    class (
      TAbstractPostgresRepository,
      IFuelCharacteristicsCalculationCardRepository
    )

      protected

        procedure CustomizeTableMapping(
          TableMapping: TDBTableMapping
        ); override;
        
      public

        constructor Create(QueryExecutor: IQueryExecutor);
        
        function AddFuelCharacteristicsCalculationCard(
          FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
        ): Boolean;
      
        function AddFuelCharacteristicsCalculationCards(
          FuelCharacteristicsCalculationCards: TFuelCharacteristicsCalculationCards
        ): Boolean;
      
        function UpdateFuelCharacteristicsCalculationCard(
          FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
        ): Boolean;

        function UpdateFuelCharacteristicsCalculationCards(
          FuelCharacteristicsCalculationCards: TFuelCharacteristicsCalculationCards
        ): Boolean;
      
        function RemoveFuelCharacteristicsCalculationCard(
          FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
        ): Boolean;
      
        function RemoveFuelCharacteristicsCalculationCards(
          FuelCharacteristicsCalculationCards: TFuelCharacteristicsCalculationCards
        ): Boolean;
      
        function FindFuelCharacteristicsCalculationCardByIdentity(
          Identity: Variant
        ): TFuelCharacteristicsCalculationCard;
      
        function FindFuelCharacteristicsCalculationCardsByIdentities(
          const Identities: TVariantList
        ): TFuelCharacteristicsCalculationCards;

        function LoadAllFuelCharacteristicsCalculationCards:
          TFuelCharacteristicsCalculationCards;
        
      end;
    
implementation

uses

  PostgresTypeNameConstants,
  FuelCharacteristicsCalculationCardTableDefinition;
  
{ TFuelCharacteristicsCalculationCardPostgresRepository }

constructor TFuelCharacteristicsCalculationCardPostgresRepository.Create(
  QueryExecutor: IQueryExecutor);
begin

  inherited;
  
end;

procedure TFuelCharacteristicsCalculationCardPostgresRepository.
  CustomizeTableMapping(
    TableMapping: TDBTableMapping
  );
begin

  TableMapping.SetTableNameMapping(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_NAME,
    TFuelCharacteristicsCalculationCard,
    TFuelCharacteristicsCalculationCards
  );

  TableMapping.AddColumnMappingForSelect(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_ID_COLUMN_NAME,
    'Identity'
  );

  TableMapping.AddColumnMappingForSelect(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_KIND_COLUMN_NAME,
    'FuelKind'
  );

  TableMapping.AddColumnMappingForSelect(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_RISE_LEVEL_COLUMN_NAME,
    'FuelRiseLevel'
  );

  TableMapping.AddColumnMappingForSelect(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_MASS_COLUMN_NAME,
    'FuelMass'
  );

  TableMapping.AddColumnMappingForSelect(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_DENSITY_COLUMN_NAME,
    'FuelDensity'
  );

  TableMapping.AddColumnMappingForSelect(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_TEMPERATURE_COLUMN_NAME,
    'FuelTemperature'
  );

  TableMapping.AddColumnMappingForSelect(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_RESERVOIR_NUMBER_COLUMN_NAME,
    'ReservoirNumber'
  );

  TableMapping.AddColumnMappingForSelect(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_CALCULATION_PERFORMER_ID_COLUMN_NAME,
    'PerformedCalculationEmployeeId'
  );

  TableMapping.AddColumnMappingForSelect(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_CALCULATION_PERFORMING_DATETIME_COLUMN_NAME,
    'CalculationPerformingDateTime'
  );

  TableMapping.AddColumnMappingForModification(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_KIND_COLUMN_NAME,
    'FuelKind'
  );

  TableMapping.AddColumnMappingForModification(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_RISE_LEVEL_COLUMN_NAME,
    'FuelRiseLevel'
  );

  TableMapping.AddColumnMappingForModification(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_MASS_COLUMN_NAME,
    'FuelMass'
  );

  TableMapping.AddColumnMappingForModification(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_DENSITY_COLUMN_NAME,
    'FuelDensity'
  );

  TableMapping.AddColumnMappingForModification(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_TEMPERATURE_COLUMN_NAME,
    'FuelTemperature'
  );

  TableMapping.AddColumnMappingForModification(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_RESERVOIR_NUMBER_COLUMN_NAME,
    'ReservoirNumber'
  );

  TableMapping.AddColumnMappingForModification(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_CALCULATION_PERFORMER_ID_COLUMN_NAME,
    'PerformedCalculationEmployeeId'
  );

  TableMapping.AddColumnMappingForModification(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_CALCULATION_PERFORMING_DATETIME_COLUMN_NAME,
    'CalculationPerformingDateTime',
    PostgresTypeNameConstants.TIMESTAMP_WITHOUT_TIME_ZONE_TYPE_NAME
  );

  TableMapping.AddPrimaryKeyColumnMapping(
    FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_ID_COLUMN_NAME,
    'Identity'
  );

end;

function TFuelCharacteristicsCalculationCardPostgresRepository.
  AddFuelCharacteristicsCalculationCard(
    FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
  ): Boolean;
begin

  Add(FuelCharacteristicsCalculationCard);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TFuelCharacteristicsCalculationCardPostgresRepository.
  AddFuelCharacteristicsCalculationCards(
    FuelCharacteristicsCalculationCards: TFuelCharacteristicsCalculationCards
  ): Boolean;
begin

  AddDomainObjectList(FuelCharacteristicsCalculationCards);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TFuelCharacteristicsCalculationCardPostgresRepository.
  FindFuelCharacteristicsCalculationCardByIdentity(
    Identity: Variant
  ): TFuelCharacteristicsCalculationCard;
begin

  Result :=
    TFuelCharacteristicsCalculationCard(FindDomainObjectByIdentity(Identity));

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TFuelCharacteristicsCalculationCardPostgresRepository.
  FindFuelCharacteristicsCalculationCardsByIdentities(
    const Identities: TVariantList
  ): TFuelCharacteristicsCalculationCards;
begin

  Result :=
    TFuelCharacteristicsCalculationCards(
      FindDomainObjectsByIdentities(Identities)
    );

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TFuelCharacteristicsCalculationCardPostgresRepository.
  LoadAllFuelCharacteristicsCalculationCards: TFuelCharacteristicsCalculationCards;
begin

  Result := TFuelCharacteristicsCalculationCards(LoadAll);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TFuelCharacteristicsCalculationCardPostgresRepository.
  RemoveFuelCharacteristicsCalculationCard(
    FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
  ): Boolean;
begin

  Remove(FuelCharacteristicsCalculationCard);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TFuelCharacteristicsCalculationCardPostgresRepository.
  RemoveFuelCharacteristicsCalculationCards(
    FuelCharacteristicsCalculationCards: TFuelCharacteristicsCalculationCards
  ): Boolean;
begin

  RemoveDomainObjectList(FuelCharacteristicsCalculationCards);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TFuelCharacteristicsCalculationCardPostgresRepository.
  UpdateFuelCharacteristicsCalculationCard(
    FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
  ): Boolean;
begin

  Update(FuelCharacteristicsCalculationCard);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TFuelCharacteristicsCalculationCardPostgresRepository.
  UpdateFuelCharacteristicsCalculationCards(
    FuelCharacteristicsCalculationCards: TFuelCharacteristicsCalculationCards
  ): Boolean;
begin

  UpdateDomainObjectList(FuelCharacteristicsCalculationCards);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

end.
