unit ReservoirKindPostgresRepository;

interface

uses

  ReservoirKindRepository,
  ReservoirKind,
  AbstractPostgresRepositoryUnit,
  DBTableMappingUnit,
  QueryExecutor,
  AbstractRepositoryUnit,
  AbstractDBRepositoryUnit,
  VariantListUnit,
  DomainObjectUnit,
  SysUtils,
  Classes;

type

  TReservoirKindPostgresRepository =
    class (TAbstractPostgresRepository, IReservoirKindRepository)

      protected

        procedure CustomizeTableMapping(
          TableMapping: TDBTableMapping
        ); override;

        procedure Initialize; override;

      protected

        function CreateDefaultRepositoryErrorCreator: TRepositoryErrorCreator; override;

      public

        constructor Create(QueryExecutor: IQueryExecutor);
        
        function AddReservoirKind(
          ReservoirKind: TReservoirKind
        ): Boolean;
      
        function AddReservoirKinds(
          ReservoirKinds: TReservoirKinds
        ): Boolean;
      
        function UpdateReservoirKind(
          ReservoirKind: TReservoirKind
        ): Boolean;

        function UpdateReservoirKinds(
          ReservoirKinds: TReservoirKinds
        ): Boolean;

        function RemoveReservoirKind(
          ReservoirKind: TReservoirKind
        ): Boolean;

        function RemoveReservoirKinds(
          ReservoirKinds: TReservoirKinds
        ): Boolean;
      
        function FindReservoirKindByIdentity(
          Identity: Variant
        ): TReservoirKind;
      
        function FindReservoirKindsByIdentities(
          const Identities: TVariantList
        ): TReservoirKinds;
      
        function LoadAllReservoirKinds:
          TReservoirKinds;
      
    end;

    TReservoirKindPostgresRepositoryErrorCreator =
      class (TDBRepositoryErrorCreator)

        public

          function CreateErrorFromException(
            const SourceException: Exception;
            ExceptionalDomainObject: TDomainObject
          ): TRepositoryError; override;

      end;
      
implementation

uses

  Variants,
  ReservoirKindTableDefinition;

{ TReservoirKindPostgresRepository }

function TReservoirKindPostgresRepository.
  AddReservoirKind(
    ReservoirKind: TReservoirKind
  ): Boolean;
begin

  Result := Add(ReservoirKind);

  ThrowExceptionIfErrorIsNotUnknown;

end;

function TReservoirKindPostgresRepository.
  AddReservoirKinds(
    ReservoirKinds: TReservoirKinds
  ): Boolean;
begin

  Result := AddDomainObjectList(ReservoirKinds);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

constructor TReservoirKindPostgresRepository.Create(
  QueryExecutor: IQueryExecutor);
begin

  inherited;
  
end;

function TReservoirKindPostgresRepository.
  CreateDefaultRepositoryErrorCreator: TRepositoryErrorCreator;
begin

  Result := TReservoirKindPostgresRepositoryErrorCreator.Create(Self);
  
end;

procedure TReservoirKindPostgresRepository.CustomizeTableMapping(
  TableMapping: TDBTableMapping);
begin

  inherited;

  TableMapping.SetTableNameMapping(
    RESERVOIR_KIND_TABLE_NAME,
    TReservoirKind,
    TReservoirKinds
  );

  TableMapping.AddColumnMappingForSelect(
    RESERVOIR_KIND_TABLE_NAME_COLUMN_NAME, 'Name'
  );

  TableMapping.AddColumnMappingForModification(
    RESERVOIR_KIND_TABLE_NAME_COLUMN_NAME, 'Name'
  );

  TableMapping.AddPrimaryKeyColumnMapping(
    RESERVOIR_KIND_TABLE_NAME_COLUMN_NAME, 'Name'
  );

end;

function TReservoirKindPostgresRepository.
  FindReservoirKindByIdentity(
    Identity: Variant
  ): TReservoirKind;
begin

  Result :=
    FindDomainObjectByIdentity(Identity) as TReservoirKind;

  ThrowExceptionIfErrorIsNotUnknown;

end;

function TReservoirKindPostgresRepository.
  FindReservoirKindsByIdentities(
    const Identities: TVariantList
  ): TReservoirKinds;
begin

  Result :=
    FindDomainObjectsByIdentities(Identities) as TReservoirKinds;

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

procedure TReservoirKindPostgresRepository.Initialize;
begin

  inherited;

  FReturnSurrogateIdOfDomainObjectAfterAdding := False;
  
end;

function TReservoirKindPostgresRepository.
  LoadAllReservoirKinds: TReservoirKinds;
begin

  Result := LoadAll as TReservoirKinds;

end;

function TReservoirKindPostgresRepository.
  RemoveReservoirKind(
    ReservoirKind: TReservoirKind
  ): Boolean;
begin

  Remove(ReservoirKind);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TReservoirKindPostgresRepository.
  RemoveReservoirKinds(
    ReservoirKinds: TReservoirKinds
  ): Boolean;
begin

  RemoveDomainObjectList(ReservoirKinds);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TReservoirKindPostgresRepository.
  UpdateReservoirKind(
    ReservoirKind: TReservoirKind
  ): Boolean;
begin

  Update(ReservoirKind);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

function TReservoirKindPostgresRepository.
  UpdateReservoirKinds(
    ReservoirKinds: TReservoirKinds
  ): Boolean;
begin

  UpdateDomainObjectList(ReservoirKinds);

  ThrowExceptionIfErrorIsNotUnknown;
  
end;

{ TReservoirKindPostgresRepositoryErrorCreator }

function TReservoirKindPostgresRepositoryErrorCreator.CreateErrorFromException(
  const SourceException: Exception;
  ExceptionalDomainObject: TDomainObject
): TRepositoryError;
var
  QueryExecutionError: TQueryExecutingError;
  ReservoirKind: TReservoirKind;
  
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

  ReservoirKind := TReservoirKind(ExceptionalDomainObject);
  
  QueryExecutionError := TQueryExecutingError(SourceException);

  if FAbstractRepository.LastOperation in [roAdding, roChanging]
  then begin

    ErrorMessage := QueryExecutionError.Message;
    ErrorData := QueryExecutionError.Code;
    
    if QueryExecutionError.Code = '23505' then begin

      InformativeMessage :=
        Format(
          'Данные о типе резервуаров "%s" ' +
          'уже находятся в базе данных',
          [ReservoirKind.Name]
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

