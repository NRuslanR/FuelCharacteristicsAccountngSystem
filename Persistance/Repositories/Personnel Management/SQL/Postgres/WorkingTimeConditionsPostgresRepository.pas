unit WorkingTimeConditionsPostgresRepository;

interface

uses

  AbstractPostgresRepositoryUnit,
  WorkingTimeConditionsRepository,
  DBTableMappingUnit,
  WorkingTimeConditions,
  VariantListUnit,
  QueryExecutor,
  AbstractRepositoryCriteriaUnit,
  SysUtils,
  Classes;

type

  TWorkingTimeConditionsPostgresRepository =
    class (TAbstractPostgresRepository, IWorkingTimeConditionsRepository)

      protected

        procedure CustomizeTableMapping(
          TableMapping: TDBTableMapping
        ); override;

      public

        constructor Create(QueryExecutor: IQueryExecutor);
        
        function AddWorkingTimeConditions(WorkingTimeConditions: TWorkingTimeConditions): Boolean;
        function AddWorkingTimeConditionsList(WorkingTimeConditionsList: TWorkingTimeConditionsList): Boolean;
        function UpdateWorkingTimeConditions(WorkingTimeConditions: TWorkingTimeConditions): Boolean;
        function UpdateWorkingTimeConditionsList(WorkingTimeConditionsList: TWorkingTimeConditionsList): Boolean;
        function RemoveWorkingTimeConditions(WorkingTimeConditions: TWorkingTimeConditions): Boolean;
        function RemoveWorkingTimeConditionsList(WorkingTimeConditionsList: TWorkingTimeConditionsList): Boolean;
        function FindActiveWorkingTimeConditions: TWorkingTimeConditions;
        function FindWorkingTimeConditionsByIdentity(Identity: Variant): TWorkingTimeConditions;
        function FindWorkingTimeConditionsListByIdentities(const Identities: TVariantList): TWorkingTimeConditionsList;
        function LoadAllWorkingTimeConditionsList: TWorkingTimeConditionsList;

    end;
  
implementation

uses

  IDomainObjectBaseUnit,
  IDomainObjectBaseListUnit,
  WorkingTimeConditionsTableDefinition;

type

  TWorkingTimeConditionsPostgresRepositoryCriterion =
    class abstract (TAbstractRepositoryCriterion)

      protected

        FRepository: TWorkingTimeConditionsPostgresRepository;
        
      public

        constructor Create(Repository: TWorkingTimeConditionsPostgresRepository);
        
    end;
    
  TFindActiveWorkingTimeConditionsCriterion =
    class (TWorkingTimeConditionsPostgresRepositoryCriterion)

      protected

        function GetExpression: String; override;
        
    end;
{ TWorkingTimeConditionsPostgresRepository }

constructor TWorkingTimeConditionsPostgresRepository.Create(
  QueryExecutor: IQueryExecutor);
begin

  inherited;
  
end;

procedure TWorkingTimeConditionsPostgresRepository.CustomizeTableMapping(
  TableMapping: TDBTableMapping);
begin

  inherited;

  TableMapping.SetTableNameMapping(
    WORKING_TIME_CONDITIONS_TABLE_NAME,
    TWorkingTimeConditions,
    TWorkingTimeConditionsList
  );

  TableMapping.AddColumnMappingForSelect(
    WORKING_TIME_CONDITIONS_TABLE_ID_COLUMN_NAME, 'Identity'
  );

  TableMapping.AddColumnMappingForSelect(
    WORKING_TIME_CONDITIONS_TABLE_NAME_COLUMN_NAME, 'Name'
  );

  TableMapping.AddColumnMappingForSelect(
    WORKING_TIME_CONDITIONS_TABLE_IS_ACTIVE_COLUMN_NAME, 'IsActive'
  );

  TableMapping.AddColumnMappingForSelect(
    WORKING_TIME_CONDITIONS_TABLE_WORKING_DAY_ENDING_TIME_COLUMN_NAME,
    'WorkingDayEndingTime'
  );

  TableMapping.AddColumnMappingForSelect(
    WORKING_TIME_CONDITIONS_TABLE_WORKING_DAY_BEGINNING_TIME_COLUMN_NAME,
    'WorkingDayBeginningTime'
  );

  TableMapping.AddColumnMappingForModification(
    WORKING_TIME_CONDITIONS_TABLE_NAME_COLUMN_NAME, 'Name'
  );

  TableMapping.AddColumnMappingForModification(
    WORKING_TIME_CONDITIONS_TABLE_IS_ACTIVE_COLUMN_NAME, 'IsActive'
  );

  TableMapping.AddColumnMappingForModification(
    WORKING_TIME_CONDITIONS_TABLE_WORKING_DAY_ENDING_TIME_COLUMN_NAME,
    'WorkingDayEndingTime'
  );

  TableMapping.AddColumnMappingForModification(
    WORKING_TIME_CONDITIONS_TABLE_WORKING_DAY_BEGINNING_TIME_COLUMN_NAME,
    'WorkingDayBeginningTime'
  );

  TableMapping.AddPrimaryKeyColumnMapping(
    WORKING_TIME_CONDITIONS_TABLE_ID_COLUMN_NAME, 'Identity'
  );
  
end;

function TWorkingTimeConditionsPostgresRepository.AddWorkingTimeConditions(
  WorkingTimeConditions: TWorkingTimeConditions): Boolean;
begin

  Result := Add(WorkingTimeConditions);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TWorkingTimeConditionsPostgresRepository.AddWorkingTimeConditionsList(
  WorkingTimeConditionsList: TWorkingTimeConditionsList): Boolean;
begin

  Result := AddWorkingTimeConditionsList(WorkingTimeConditionsList);

  ThrowExceptionIfErrorIsNotUnknown;

end;

function TWorkingTimeConditionsPostgresRepository.
  FindActiveWorkingTimeConditions: TWorkingTimeConditions;
var FindActiveWorkingTimeConditionsCriterion:
      TFindActiveWorkingTimeConditionsCriterion;

    WorkingTimeConditionsList: TWorkingTimeConditionsList;
    FreeWorkingTimeConditionsList: IDomainObjectBaseList;
begin

  FindActiveWorkingTimeConditionsCriterion :=
    TFindActiveWorkingTimeConditionsCriterion.Create(Self);

  try

    WorkingTimeConditionsList :=
      TWorkingTimeConditionsList(
        FindDomainObjectsByCriteria(FindActiveWorkingTimeConditionsCriterion)
      );

    if Assigned(WorkingTimeConditionsList) then begin

      FreeWorkingTimeConditionsList := WorkingTimeConditionsList;
      
      if WorkingTimeConditionsList.Count > 1 then begin

        raise TWorkingTimeConditionsRepositoryException.Create(
          'Найдено более одного активного ' +
          'режима рабочего времени'
        );
        
      end;

      Result := TWorkingTimeConditions(WorkingTimeConditionsList[0].Clone);

    end

    else begin

      ThrowExceptionIfErrorIsNotUnknown;

      Result := nil;

    end;
    
  finally

    FreeAndNil(FindActiveWorkingTimeConditionsCriterion);

  end;

end;

function TWorkingTimeConditionsPostgresRepository.
  FindWorkingTimeConditionsByIdentity(
    Identity: Variant
  ): TWorkingTimeConditions;
begin

  Result := TWorkingTimeConditions(FindDomainObjectByIdentity(Identity));

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TWorkingTimeConditionsPostgresRepository.
  FindWorkingTimeConditionsListByIdentities(
    const Identities: TVariantList
  ): TWorkingTimeConditionsList;
begin

  Result := TWorkingTimeConditionsList(FindDomainObjectsByIdentities(Identities));

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TWorkingTimeConditionsPostgresRepository.
  LoadAllWorkingTimeConditionsList: TWorkingTimeConditionsList;
begin

  Result := TWorkingTimeConditionsList(LoadAll);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TWorkingTimeConditionsPostgresRepository.RemoveWorkingTimeConditions(
  WorkingTimeConditions: TWorkingTimeConditions
): Boolean;
begin

  Result := Remove(WorkingTimeConditions);

  ThrowExceptionIfErrorIsNotUnknown;

end;

function TWorkingTimeConditionsPostgresRepository.
  RemoveWorkingTimeConditionsList(
    WorkingTimeConditionsList: TWorkingTimeConditionsList
  ): Boolean;
begin

  Result := RemoveDomainObjectList(WorkingTimeConditionsList);
  
end;

function TWorkingTimeConditionsPostgresRepository.UpdateWorkingTimeConditions(
  WorkingTimeConditions: TWorkingTimeConditions
): Boolean;
begin

  Result := Update(WorkingTimeConditions);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TWorkingTimeConditionsPostgresRepository.
  UpdateWorkingTimeConditionsList(
    WorkingTimeConditionsList: TWorkingTimeConditionsList
  ): Boolean;
begin

  Result := UpdateDomainObjectList(WorkingTimeConditionsList);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

{ TWorkingTimeConditionsPostgresRepositoryCriterion }

constructor TWorkingTimeConditionsPostgresRepositoryCriterion.Create(
  Repository: TWorkingTimeConditionsPostgresRepository);
begin

  inherited Create;

  FRepository := Repository;
  
end;

{ TFindActiveWorkingTimeConditionsCriterion }

function TFindActiveWorkingTimeConditionsCriterion.GetExpression: String;
var IsActiveColumnName: String;
begin

  IsActiveColumnName :=
    FRepository.TableMapping.FindSelectColumnMappingByObjectPropertyName(
      'IsActive'
    ).ColumnName;

  Result := IsActiveColumnName;
  
end;

end.
