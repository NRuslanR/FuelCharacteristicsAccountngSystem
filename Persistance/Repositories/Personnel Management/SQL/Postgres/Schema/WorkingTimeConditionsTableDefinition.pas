unit WorkingTimeConditionsTableDefinition;

interface

uses

  SchemaDefinition;

const

  WORKING_TIME_CONDITIONS_TABLE_NAME =
    SCHEMA_NAME + '.' + 'working_time_conditions';

  WORKING_TIME_CONDITIONS_TABLE_ID_COLUMN_NAME = 'conditions_id';
  WORKING_TIME_CONDITIONS_TABLE_NAME_COLUMN_NAME = 'name';

  WORKING_TIME_CONDITIONS_TABLE_WORKING_DAY_BEGINNING_TIME_COLUMN_NAME =
    'working_day_beginning_time';

  WORKING_TIME_CONDITIONS_TABLE_WORKING_DAY_ENDING_TIME_COLUMN_NAME =
    'working_day_ending_time';
    
  WORKING_TIME_CONDITIONS_TABLE_IS_ACTIVE_COLUMN_NAME = 'is_active';
  
implementation

end.
