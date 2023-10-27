unit BasedOnDBEmployeeAccountSetReadService;

interface

uses

  EmployeeAccountSetReadService,
  EmployeeDbSchema,
  LogOnInfoDbSchema,
  RoleDbSchema,
  QueryExecutor,
  AbstractQueryExecutor,
  DataReader,
  AbstractDataReader,
  EmployeeAccountSetHolder,
  DB,
  SysUtils,
  Classes;

type

  TBasedOnDBEmployeeAccountSetReadService =
    class (TInterfacedObject, IEmployeeAccountSetReadService)

      protected

        FEmployeeDbSchema: TEmployeeDbSchema;
        FRoleDbSchema: TRoleDbSchema;
        FLogOnInfoDbSchema: TLogOnInfoDbSchema;
        
        FQueryExecutor: TAbstractQueryExecutor;

      protected

        FEmployeeAccountSetFetchingQueryPattern: String;

        function PrepareEmployeeAccountSetFetchingQueryPattern(
          EmployeeDbSchema: TEmployeeDbSchema;
          RoleDbSchema: TRoleDbSchema;
          LogOnInfoDbSchema: TLogOnInfoDbSchema
        ): String; virtual;

        function ExecuteEmployeeAccountSetFetchingQuery(
          const EmployeeAccountSetFetchingQueryPattern: String
        ): TDataSet; virtual;

        function CreateEmployeeAccountSetFieldDefsFrom(
          AccountSet: TDataSet;
          EmployeeDbSchema: TEmployeeDbSchema;
          RoleDbSchema: TRoleDbSchema;
          LogOnInfoDbSchema: TLogOnInfoDbSchema
        ): TEmployeeAccountSetFieldDefs; virtual;
        
      public

        constructor Create(
          EmployeeDbSchema: TEmployeeDbSchema;
          RoleDbSchema: TRoleDbSchema;
          LogOnInfoDbSchema: TLogOnInfoDbSchema;
          QueryExecutor: TAbstractQueryExecutor
        );

        function GetAllEmployeeAccountSet: TEmployeeAccountSetHolder; virtual;
        
    end;

implementation

{ TBasedOnDBEmployeeAccountSetReadService }

constructor TBasedOnDBEmployeeAccountSetReadService.Create(
  EmployeeDbSchema: TEmployeeDbSchema;
  RoleDbSchema: TRoleDbSchema;
  LogOnInfoDbSchema: TLogOnInfoDbSchema;
  QueryExecutor: TAbstractQueryExecutor
);
begin

  inherited Create;

  FEmployeeDbSchema := EmployeeDbSchema;
  FRoleDbSchema := RoleDbSchema;
  FLogOnInfoDbSchema := LogOnInfoDbSchema;
  
  FQueryExecutor := QueryExecutor;

  FEmployeeAccountSetFetchingQueryPattern :=
    PrepareEmployeeAccountSetFetchingQueryPattern(
      FEmployeeDbSchema,
      FRoleDbSchema,
      FLogOnInfoDbSchema
    );
    
end;

function TBasedOnDBEmployeeAccountSetReadService.
  CreateEmployeeAccountSetFieldDefsFrom(
    AccountSet: TDataSet;
    EmployeeDbSchema: TEmployeeDbSchema;
    RoleDbSchema: TRoleDbSchema;
    LogOnInfoDbSchema: TLogOnInfoDbSchema
  ): TEmployeeAccountSetFieldDefs;
begin

  Result := TEmployeeAccountSetFieldDefs.Create;

  try

    Result.RoleIdFieldName :=
      EmployeeDbSchema.RoleIdColumnName;
      
    Result.RoleNameFieldName :=
      RoleDbSchema.DisplayColumnName;

    Result.LoginFieldName :=
      LogOnInfoDbSchema.LoginColumnName;

    Result.RecordIdFieldName :=
      EmployeeDbSchema.IdColumnName;

    Result.NameFieldName :=
      EmployeeDbSchema.NameColumnName;

    Result.SurnameFieldName :=
      EmployeeDbSchema.SurnameColumnName;

    Result.PatronymicFieldName :=
      EmployeeDbSchema.PatronymicColumnName;

    Result.BirthDateFieldName :=
      EmployeeDbSchema.BirthDateColumnName;

    Result.SpecialityFieldName :=
      EmployeeDbSchema.SpecialityColumnName;

    Result.CanBeChangedFieldName := 'can_be_changed';
    Result.CanBeRemovedFieldName := 'can_be_removed';
    
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

function TBasedOnDBEmployeeAccountSetReadService.
  ExecuteEmployeeAccountSetFetchingQuery(
    const EmployeeAccountSetFetchingQueryPattern: String
  ): TDataSet;
var DataReader: IDataReader;
begin

  DataReader :=
    FQueryExecutor.ExecuteSelectionQuery(
      EmployeeAccountSetFetchingQueryPattern
    );

  Result := TAbstractDataReader(DataReader.Self).ToDataSet;

end;

function TBasedOnDBEmployeeAccountSetReadService.
  GetAllEmployeeAccountSet: TEmployeeAccountSetHolder;
var DataSet: TDataSet;
    FieldDefs: TEmployeeAccountSetFieldDefs;
begin

  DataSet := nil;
  FieldDefs := nil;

  try

    DataSet :=
      ExecuteEmployeeAccountSetFetchingQuery(
        FEmployeeAccountSetFetchingQueryPattern
      );

    FieldDefs :=
      CreateEmployeeAccountSetFieldDefsFrom(
        DataSet,
        FEmployeeDbSchema,
        FRoleDbSchema,
        FLogOnInfoDbSchema
      );

    Result := TEmployeeAccountSetHolder.CreateFrom(DataSet, FieldDefs);

    with DataSet, FieldDefs do begin

      FieldByName(Result.CanBeChangedFieldName).ReadOnly := False;
      FieldByName(Result.CanBeRemovedFieldName).ReadOnly := False;
      
    end;

  except

    on e: Exception do begin

      FreeAndNil(DataSet);
      FreeAndNil(FieldDefs);

      raise;
      
    end;

  end;

end;

function TBasedOnDBEmployeeAccountSetReadService.
  PrepareEmployeeAccountSetFetchingQueryPattern(
    EmployeeDbSchema: TEmployeeDbSchema;
    RoleDbSchema: TRoleDbSchema;
    LogOnInfoDbSchema: TLogOnInfoDbSchema
  ): String;
begin

  Result :=
    Format(
      'SELECT ' +
      'A.%s,A.%s,A.%s,A.%s,A.%s,A.%s,A.%s,C.%s,B.%s,' +
      'null as can_be_changed,' +
      'null as can_be_removed ' +
      'FROM %s A ' +
      'JOIN %s B ON A.%s=B.%s ' +
      'JOIN %s C ON A.%s=C.%s',
      [
        EmployeeDbSchema.IdColumnName,
        EmployeeDbSchema.NameColumnName,
        EmployeeDbSchema.SurnameColumnName,
        EmployeeDbSchema.PatronymicColumnName,
        EmployeeDbSchema.BirthDateColumnName,
        EmployeeDbSchema.SpecialityColumnName,
        EmployeeDbSchema.RoleIdColumnName,
        LogOnInfoDbSchema.LoginColumnName,
        RoleDbSchema.DisplayColumnName,

        EmployeeDbSchema.TableName,
        RoleDbSchema.TableName,
        EmployeeDbSchema.RoleIdColumnName,
        RoleDbSchema.IdColumnName,
        LogOnInfoDbSchema.TableName,
        EmployeeDbSchema.IdColumnName,
        LogOnInfoDbSchema.EmployeeIdColumnName
      ]
    );

end;

end.
