unit BasedOnDBReservoirKindSetReadService;

interface

uses

  ReservoirKindSetReadService,
  ReservoirKindSetHolder,
  ReservoirKindDbSchema,
  QueryExecutor,
  AbstractQueryExecutor,
  DataReader,
  AbstractDataReader,
  DB,
  SysUtils,
  Classes;

type

  TBasedOnDBReservoirKindSetReadService =
    class (TInterfacedObject, IReservoirKindSetReadService)

      protected

        FReservoirKindSetFetchingQueryPattern: String;

      protected

        FReservoirKindDbSchema: TReservoirKindDbSchema;
        FQueryExecutor: TAbstractQueryExecutor;

        function PrepareReservoirKindSetFetchingQueryPattern(
          ReservoirKindDbSchema: TReservoirKindDbSchema
        ): String; virtual;

        function ExecuteReservoirKindSetFetchingQuery(
          const ReservoirKindSetFetchingQueryPattern: String
        ): TDataSet; virtual;

        function CreateReservoirKindSetFieldDefsFrom(
          ReservoirKindSet: TDataSet;
          ReservoirKindDbSchema: TReservoirKindDbSchema
        ): TReservoirKindSetFieldDefs; virtual;

        procedure CustomizeReservoirKindSetHolder(
          ReservoirKindSetHolder: TReservoirKindSetHolder
        );
        
      public

        constructor Create(
          ReservoirKindDbSchema: TReservoirKindDbSchema;
          QueryExecutor: TAbstractQueryExecutor
        );

        function GetAllReservoirKindSet: TReservoirKindSetHolder; virtual;
        
    end;

implementation

{ TBasedOnDBReservoirKindSetReadService }

constructor TBasedOnDBReservoirKindSetReadService.Create(
  ReservoirKindDbSchema: TReservoirKindDbSchema;
  QueryExecutor: TAbstractQueryExecutor);
begin

  inherited Create;

  FReservoirKindDbSchema := ReservoirKindDbSchema;
  FQueryExecutor := QueryExecutor;

  FReservoirKindSetFetchingQueryPattern :=
    PrepareReservoirKindSetFetchingQueryPattern(FReservoirKindDbSchema);

end;

function TBasedOnDBReservoirKindSetReadService.
  CreateReservoirKindSetFieldDefsFrom(
    ReservoirKindSet: TDataSet;
    ReservoirKindDbSchema: TReservoirKindDbSchema
  ): TReservoirKindSetFieldDefs;
begin

  Result := TReservoirKindSetFieldDefs.Create;

  try

    Result.ReservoirKindNameFieldName :=
      ReservoirKindDbSchema.ReservoirKindNameColumnName;

    Result.CanBeChangedFieldName := 'can_be_changed';
    Result.CanBeRemovedFieldName := 'can_be_removed';
    
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;

    end;

  end;

end;

procedure TBasedOnDBReservoirKindSetReadService.
  CustomizeReservoirKindSetHolder(
    ReservoirKindSetHolder: TReservoirKindSetHolder
  );
begin

  with ReservoirKindSetHolder.DataSet, ReservoirKindSetHolder.FieldDefs
  do begin

    FieldByName('can_be_changed').ReadOnly := False;
    FieldByName('can_be_removed').ReadOnly := False;
    
  end;

end;

function TBasedOnDBReservoirKindSetReadService.
  ExecuteReservoirKindSetFetchingQuery(
    const ReservoirKindSetFetchingQueryPattern: String
  ): TDataSet;
begin

  Result :=
    TAbstractDataReader(
      FQueryExecutor.ExecuteSelectionQuery(
        ReservoirKindSetFetchingQueryPattern
      ).Self
    ).ToDataSet;
    
end;

function TBasedOnDBReservoirKindSetReadService.
  GetAllReservoirKindSet: TReservoirKindSetHolder;
var DataSet: TDataSet;
    FieldDefs: TReservoirKindSetFieldDefs;
begin

  DataSet := nil;
  FieldDefs := nil;

  try

    DataSet :=
      ExecuteReservoirKindSetFetchingQuery(
        FReservoirKindSetFetchingQueryPattern
      );

    FieldDefs :=
      CreateReservoirKindSetFieldDefsFrom(
        DataSet, FReservoirKindDbSchema
      );

    Result := TReservoirKindSetHolder.CreateFrom(DataSet, FieldDefs);

    CustomizeReservoirKindSetHolder(Result);
    
  except

    on e: Exception do begin

      FreeAndNil(DataSet);
      FreeAndNil(FieldDefs);

      raise;
      
    end;

  end;

end;

function TBasedOnDBReservoirKindSetReadService.
  PrepareReservoirKindSetFetchingQueryPattern(
    ReservoirKindDbSchema: TReservoirKindDbSchema
  ): String;
begin

  Result :=
    Format(
      'SELECT ' +
      '%s, ' +
      'null as can_be_changed,' +
      'null as can_be_removed ' +
      'FROM %s',
      [
        ReservoirKindDbSchema.ReservoirKindNameColumnName,
        ReservoirKindDbSchema.TableName
      ]
    );
    
end;

end.
