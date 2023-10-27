unit ReservoirKindReferenceSuiteTableDefinition;

interface

uses

  SchemaDefinition;

const

  RESERVOIR_KIND_REFERENCE_SUITE_TABLE_NAME =
    SCHEMA_NAME + '.' + 'reservoir_kind_reference_suites';

  RESERVOIR_KIND_REFERENCE_SUITE_TABLE_ID_COLUMN_NAME = 'reservoir_kind_name';

  RESERVOIR_KIND_REFERENCE_SUITE_TABLE_HSC_VALUE_COLUMN_NAME = 'hsc_value';

  RESERVOIR_KIND_REFERENCE_SUITE_TABLE_CALIBRATION_CHART_LOCATION =
    'calibration_chart_location';
    
implementation

end.
