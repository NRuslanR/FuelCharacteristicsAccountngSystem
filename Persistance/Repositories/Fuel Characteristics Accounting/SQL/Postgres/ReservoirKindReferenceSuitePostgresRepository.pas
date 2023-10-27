unit ReservoirKindReferenceSuitePostgresRepository;

interface

uses

  ReservoirKindReferenceSuiteRepository,
  ReservoirKindReferenceSuite,
  AbstractPostgresRepositoryUnit,
  AbstractDBRepositoryUnit,
  DBTableMappingUnit,
  AbstractRepositoryUnit,
  DomainObjectUnit,
  QueryExecutor,
  VariantListUnit,
  SysUtils,
  Classes;

type

  TReservoirKindReferenceSuitePostgresRepository =
    class (TAbstractPostgresRepository, IReservoirKindReferenceSuiteRepository)

      protected

        procedure CustomizeTableMapping(
          TableMapping: TDBTableMapping
        ); override;

        procedure Initialize; override;

      protected

        function CreateDefaultRepositoryErrorCreator: TRepositoryErrorCreator; override;

      public

        constructor Create(QueryExecutor: IQueryExecutor);
        
        function AddReservoirKindReferenceSuite(
          ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
        ): Boolean;
      
        function AddReservoirKindReferenceSuites(
          ReservoirKindReferenceSuites: TReservoirKindReferenceSuites
        ): Boolean;
      
        function UpdateReservoirKindReferenceSuite(
          ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
        ): Boolean;

        function UpdateReservoirKindReferenceSuites(
          ReservoirKindReferenceSuites: TReservoirKindReferenceSuites
        ): Boolean;

        function RemoveReservoirKindReferenceSuite(
          ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
        ): Boolean;

        function RemoveReservoirKindReferenceSuites(
          ReservoirKindReferenceSuites: TReservoirKindReferenceSuites
        ): Boolean;
      
        function FindReservoirKindReferenceSuiteByIdentity(
          Identity: Variant
        ): TReservoirKindReferenceSuite;
      
        function FindReservoirKindReferenceSuitesByIdentities(
          const Identities: TVariantList
        ): TReservoirKindReferenceSuites;
      
        function LoadAllReservoirKindReferenceSuites:
          TReservoirKindReferenceSuites;
      
    end;

     TReservoirKindReferenceSuitePostgresRepositoryErrorCreator =
      class (TDBRepositoryErrorCreator)

        protected

          function CreateErrorFromException(
            const SourceException: Exception;
            ExceptionalDomainObject: TDomainObject
          ): TRepositoryError; override;

      end;

implementation

uses

  Variants,
  ReservoirKindReferenceSuiteTableDefinition;

{ TReservoirKindReferenceSuitePostgresRepository }

function TReservoirKindReferenceSuitePostgresRepository.
  AddReservoirKindReferenceSuite(
    ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
  ): Boolean;
begin

  Result := Add(ReservoirKindReferenceSuite);

  ThrowExceptionIfErrorIsNotUnknown;

end;

function TReservoirKindReferenceSuitePostgresRepository.
  AddReservoirKindReferenceSuites(
    ReservoirKindReferenceSuites: TReservoirKindReferenceSuites
  ): Boolean;
begin

  Result := AddDomainObjectList(ReservoirKindReferenceSuites);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

constructor TReservoirKindReferenceSuitePostgresRepository.Create(
  QueryExecutor: IQueryExecutor);
begin

  inherited;
  
end;

function TReservoirKindReferenceSuitePostgresRepository.
  CreateDefaultRepositoryErrorCreator: TRepositoryErrorCreator;
begin

  Result :=
    TReservoirKindReferenceSuitePostgresRepositoryErrorCreator.Create(Self);

end;

procedure TReservoirKindReferenceSuitePostgresRepository.CustomizeTableMapping(
  TableMapping: TDBTableMapping);
begin

  inherited;

  TableMapping.SetTableNameMapping(
    RESERVOIR_KIND_REFERENCE_SUITE_TABLE_NAME,
    TReservoirKindReferenceSuite,
    TReservoirKindReferenceSuites
  );

  TableMapping.AddColumnMappingForSelect(
    RESERVOIR_KIND_REFERENCE_SUITE_TABLE_ID_COLUMN_NAME, 'ReservoirKindName'
  );

  TableMapping.AddColumnMappingForSelect(
    RESERVOIR_KIND_REFERENCE_SUITE_TABLE_HSC_VALUE_COLUMN_NAME,
    'AltitudinalConstantStencil'
  );

  TableMapping.AddColumnMappingForSelect(
    RESERVOIR_KIND_REFERENCE_SUITE_TABLE_CALIBRATION_CHART_LOCATION,
    'CalibrationChartLocation'
  );

  TableMapping.AddColumnMappingForModification(
    RESERVOIR_KIND_REFERENCE_SUITE_TABLE_ID_COLUMN_NAME, 'ReservoirKindName'
  );

  TableMapping.AddColumnMappingForModification(
    RESERVOIR_KIND_REFERENCE_SUITE_TABLE_HSC_VALUE_COLUMN_NAME,
    'AltitudinalConstantStencil'
  );

  TableMapping.AddColumnMappingForModification(
    RESERVOIR_KIND_REFERENCE_SUITE_TABLE_CALIBRATION_CHART_LOCATION,
    'CalibrationChartLocation'
  );

  TableMapping.AddPrimaryKeyColumnMapping(
    RESERVOIR_KIND_REFERENCE_SUITE_TABLE_ID_COLUMN_NAME,
    'ReservoirKindName'
  );

end;

function TReservoirKindReferenceSuitePostgresRepository.
  FindReservoirKindReferenceSuiteByIdentity(
    Identity: Variant
  ): TReservoirKindReferenceSuite;
begin

  Result :=
    FindDomainObjectByIdentity(Identity) as TReservoirKindReferenceSuite;

  ThrowExceptionIfErrorIsNotUnknown;

end;

function TReservoirKindReferenceSuitePostgresRepository.
  FindReservoirKindReferenceSuitesByIdentities(
    const Identities: TVariantList
  ): TReservoirKindReferenceSuites;
begin

  Result :=
    FindDomainObjectsByIdentities(Identities) as TReservoirKindReferenceSuites;

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

procedure TReservoirKindReferenceSuitePostgresRepository.Initialize;
begin

  inherited;

  FReturnSurrogateIdOfDomainObjectAfterAdding := False;
  
end;

function TReservoirKindReferenceSuitePostgresRepository.
  LoadAllReservoirKindReferenceSuites: TReservoirKindReferenceSuites;
begin

  Result := LoadAll as TReservoirKindReferenceSuites;

end;

function TReservoirKindReferenceSuitePostgresRepository.
  RemoveReservoirKindReferenceSuite(
    ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
  ): Boolean;
begin

  Remove(ReservoirKindReferenceSuite);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TReservoirKindReferenceSuitePostgresRepository.
  RemoveReservoirKindReferenceSuites(
    ReservoirKindReferenceSuites: TReservoirKindReferenceSuites
  ): Boolean;
begin

  RemoveDomainObjectList(ReservoirKindReferenceSuites);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TReservoirKindReferenceSuitePostgresRepository.
  UpdateReservoirKindReferenceSuite(
    ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
  ): Boolean;
begin

  Update(ReservoirKindReferenceSuite);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TReservoirKindReferenceSuitePostgresRepository.
  UpdateReservoirKindReferenceSuites(
    ReservoirKindReferenceSuites: TReservoirKindReferenceSuites
  ): Boolean;
begin

  UpdateDomainObjectList(ReservoirKindReferenceSuites);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

{ TReservoirKindReferenceSuitePostgresRepositoryErrorCreator }

function TReservoirKindReferenceSuitePostgresRepositoryErrorCreator.
  CreateErrorFromException(
    const SourceException: Exception;
    ExceptionalDomainObject: TDomainObject
  ): TRepositoryError;
var
    ReferenceSuite: TReservoirKindReferenceSuite;
    QueryExecutionError: TQueryExecutingError;

    ErrorMessage: String;
    InformativeMessage: String;
    ErrorData: Variant;
begin

  if not (SourceException is TQueryExecutingError) then begin

    Result :=
      inherited CreateErrorFromException(
        SourceException, ExceptionalDomainObject
      );
      
    Exit;

  end;

  ReferenceSuite := TReservoirKindReferenceSuite(ExceptionalDomainObject);
  
  QueryExecutionError := TQueryExecutingError(SourceException);

  if FAbstractRepository.LastOperation in [roAdding, roChanging]
  then begin

    ErrorMessage := QueryExecutionError.Message;
    ErrorData := QueryExecutionError.Code;
    
    if QueryExecutionError.Code = '23505' then begin

      InformativeMessage :=
        Format(
          'Для типа резервуаров "%s" ' +
          'уже имеются справочные данные',
          [ReferenceSuite.ReservoirKindName]
        );

    end

    else if QueryExecutionError.Code = '23503' then begin

      InformativeMessage :=
        Format(
          'Информация о типе резервуаров "%s" ' +
          'не найдена',
          [ReferenceSuite.ReservoirKindName]
        );

    end;

    Result := CreateError(ErrorMessage, InformativeMessage, ErrorData);

  end

  else begin

    Result :=
      inherited CreateErrorFromException(
        SourceException, ExceptionalDomainObject
      );

  end;

end;

end.
