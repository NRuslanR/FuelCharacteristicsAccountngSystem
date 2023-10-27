unit BasedOnDBEmployeeLogOnInfoService;

interface

uses

  EmployeeLogOnInfoService,
  LogOnInfoDto,
  SysUtils,
  QueryExecutor,
  DataReader,
  Classes;

type

  TEmployeeLogOnInfoDbSchema = class

    public

      TableName: String;

      EmployeeIdColumnName: String;
      LoginColumnName: String;
      PasswordColumnName: String;

  end;

  TBasedOnDBEmployeeLogOnInfoService =
    class (TInterfacedObject, IEmployeeLogOnInfoService)

      protected

        FEmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema;

        FEmployeeLogOnInfoGettingQueryPattern: String;
        FEmployeeLogOnInfoByLoginGettingQueryPattern: String;
        FEmployeeLogOnInfoAddingQueryPattern: String;
        FEmployeeLogOnInfoChangingQueryPattern: String;
        FEmployeeLogOnInfoRemovingQueryPattern: String;
        
        FQueryExecutor: IQueryExecutor;

      protected

        procedure EnsureEmployeeIdValid(
          const EmployeeId: Variant;
          NotValidExceptionMessage: String = ''
        ); virtual;

        procedure EnsureLogOnInfoValidForCreating(
          LogOnInfoDto: TLogOnInfoDto;
          NotValidExceptionMessage: String = ''
        ); virtual;

        procedure EnsureLogOnInfoValidForChanging(
          const ClientIdentity: Variant;
          const EmployeeId: Variant;
          const LogOnInfoDto: TLogOnInfoDto;
          NotValidExceptionMessage: String = ''
        ); virtual;

        procedure EnsureLoginIsValid(
          const Login: String;
          NotValidExceptionMessage: String = ''
        ); virtual;

      protected

        function PrepareEmployeeLogOnInfoGettingQueryPattern(
          EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
        ): String; virtual;

        function PrepareEmployeeLogOnInfoByLoginGettingQueryPattern(
          EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
        ): String; virtual;
        
        function PrepareEmployeeLogOnInfoAddingQueryPattern(
          EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
        ): String; virtual;

        function PrepareEmployeeLogOnInfoChangingQueryPattern(
          EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
        ): String; virtual;

        function PrepareEmployeeLogOnInfoRemovingQueryPattern(
          EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
        ): String; virtual;

      protected

        function ExecuteEmployeeLogOnInfoGettingQuery(
          const QueryPattern: String;
          const EmployeeId: Variant
        ): IDataReader; virtual;

        function ExecuteEmployeeLogOnInfoByLoginGettingQuery(
          const QueryPattern: String;
          const Login: String
        ): IDataReader; virtual;
        
        procedure ExecuteEmployeeLogOnInfoAddingQuery(
          const QueryPattern: String;
          const EmployeeId: Variant;
          const LogOnInfoDto: TLogOnInfoDto
        ); virtual;

        procedure ExecuteEmployeeLogOnInfoChangingQuery(
          const QueryPattern: String;
          const EmployeeId: Variant;
          const LogOnInfoDto: TLogOnInfoDto
        ); virtual;

        procedure ExecuteEmployeeLogOnInfoRemovingQuery(
          const QueryPattern: String;
          const EmployeeId: Variant
        ); virtual;

        function CreateLogOnInfoDtoFrom(DataReader: IDataReader): TLogOnInfoDto;

      protected

        function IsEmployeeLogOnInfoExists(
          const ClientIdentity: Variant;
          const EmployeeId: Variant
        ): Boolean; overload;

        function IsEmployeeLogOnInfoExists(
          const ClientIdentity: Variant;
          const Login: String
        ): Boolean; overload;

      protected

        procedure RaiseExceptionIfEmployeeLoginNotCorrespondExistingLogOnInfo(
          const ClientIdentity: Variant;
          const EmployeeLogin: String;
          const LogOnInfo: TLogOnInfoDto
        ); virtual;
      
      public

        destructor Destroy; override;
        
        constructor Create(
          EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema;
          QueryExecutor: IQueryExecutor
        );

        function GetEmployeeLogOnInfo(
          const ClientIdentity: Variant;
          const EmployeeId: Variant
        ): TLogOnInfoDto;

        function GetEmployeeLogOnInfoByLogin(
          const ClientIdentity: Variant;
          const Login: String
        ): TLogOnInfoDto;

        procedure AddEmployeeLogOnInfo(
          const ClientIdentity: Variant;
          const EmployeeId: Variant;
          const LogOnInfoDto: TLogOnInfoDto
        );

        procedure ChangeEmployeeLogOnInfo(
          const ClientIdentity: Variant;
          const EmployeeId: Variant;
          const LogOnInfoDto: TLogOnInfoDto
        );

        procedure RemoveEmployeeLogOnInfo(
          const ClientIdentity: Variant;
          const EmployeeId: Variant
        );
    
    end;

implementation

uses

  AuxVariantFunctions,
  IDomainObjectBaseUnit;
  
{ TBasedOnDBEmployeeLogOnInfoService }

constructor TBasedOnDBEmployeeLogOnInfoService.Create(
  EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema;
  QueryExecutor: IQueryExecutor
);
begin

  inherited Create;

  FQueryExecutor := QueryExecutor;

  FEmployeeLogOnInfoDbSchema := EmployeeLogOnInfoDbSchema;

  FEmployeeLogOnInfoGettingQueryPattern :=
    PrepareEmployeeLogOnInfoGettingQueryPattern(FEmployeeLogOnInfoDbSchema);

  FEmployeeLogOnInfoByLoginGettingQueryPattern :=
    PrepareEmployeeLogOnInfoByLoginGettingQueryPattern(
      EmployeeLogOnInfoDbSchema
    );
    
  FEmployeeLogOnInfoAddingQueryPattern :=
    PrepareEmployeeLogOnInfoAddingQueryPattern(FEmployeeLogOnInfoDbSchema);

  FEmployeeLogOnInfoChangingQueryPattern :=
    PrepareEmployeeLogOnInfoChangingQueryPattern(FEmployeeLogOnInfoDbSchema);

  FEmployeeLogOnInfoRemovingQueryPattern :=
    PrepareEmployeeLogOnInfoRemovingQueryPattern(FEmployeeLogOnInfoDbSchema);

end;

function TBasedOnDBEmployeeLogOnInfoService.CreateLogOnInfoDtoFrom(
  DataReader: IDataReader): TLogOnInfoDto;
begin

  if DataReader.RecordCount = 0 then begin

    raise TEmployeeLogOnInfoServiceException.Create(
      'Информация о сотруднике для получения ' +
      'его данных для входа в систему не найдена'
    );

  end;

  if DataReader.RecordCount > 1 then begin

    raise TEmployeeLogOnInfoServiceException.Create(
      'Неоднозначность. Для сотрудника найдено ' +
      'более одного набора данных для ' +
      'входа в систему'
    );

  end;

  Result := TLogOnInfoDto.Create;

  try

    Result.Login := DataReader[FEmployeeLogOnInfoDbSchema.LoginColumnName];
    Result.Password := DataReader[FEmployeeLogOnInfoDbSchema.PasswordColumnName];

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;

    end;

  end;
  
end;

function TBasedOnDBEmployeeLogOnInfoService.
  PrepareEmployeeLogOnInfoAddingQueryPattern(
    EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
  ): String;
begin

  Result :=
    Format(
      'INSERT INTO %s (%s,%s,%s) VALUES (:p%s,:p%s,:p%s)',
      [
        EmployeeLogOnInfoDbSchema.TableName,

        EmployeeLogOnInfoDbSchema.EmployeeIdColumnName,
        EmployeeLogOnInfoDbSchema.LoginColumnName,
        EmployeeLogOnInfoDbSchema.PasswordColumnName,

        EmployeeLogOnInfoDbSchema.EmployeeIdColumnName,
        EmployeeLogOnInfoDbSchema.LoginColumnName,
        EmployeeLogOnInfoDbSchema.PasswordColumnName
      ]
    );

end;

function TBasedOnDBEmployeeLogOnInfoService.
  PrepareEmployeeLogOnInfoByLoginGettingQueryPattern(
    EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
  ): String;
begin

  Result :=
    Format(
      'SELECT %s,%s FROM %s WHERE %s=:p%s',
      [
        EmployeeLogOnInfoDbSchema.LoginColumnName,
        EmployeeLogOnInfoDbSchema.PasswordColumnName,

        EmployeeLogOnInfoDbSchema.TableName,

        EmployeeLogOnInfoDbSchema.LoginColumnName,
        EmployeeLogOnInfoDbSchema.LoginColumnName
      ]
    );
    
end;

function TBasedOnDBEmployeeLogOnInfoService.
  PrepareEmployeeLogOnInfoChangingQueryPattern(
    EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
  ): String;
begin

  Result :=
    Format(
      'UPDATE %s SET %s=:p%s, %s=:p%s WHERE %s=:p%s',
      [
        EmployeeLogOnInfoDbSchema.TableName,

        EmployeeLogOnInfoDbSchema.LoginColumnName,
        EmployeeLogOnInfoDbSchema.LoginColumnName,

        EmployeeLogOnInfoDbSchema.PasswordColumnName,
        EmployeeLogOnInfoDbSchema.PasswordColumnName,

        EmployeeLogOnInfoDbSchema.EmployeeIdColumnName,
        EmployeeLogOnInfoDbSchema.EmployeeIdColumnName
      ]
    );
    
end;

function TBasedOnDBEmployeeLogOnInfoService.
  PrepareEmployeeLogOnInfoGettingQueryPattern(
    EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
  ): String;
begin

  Result :=
    Format(
      'SELECT %s,%s FROM %s WHERE %s=:p%s',
      [
        EmployeeLogOnInfoDbSchema.LoginColumnName,
        EmployeeLogOnInfoDbSchema.PasswordColumnName,

        EmployeeLogOnInfoDbSchema.TableName,

        EmployeeLogOnInfoDbSchema.EmployeeIdColumnName,
        EmployeeLogOnInfoDbSchema.EmployeeIdColumnName
      ]
    );

end;

function TBasedOnDBEmployeeLogOnInfoService.
  PrepareEmployeeLogOnInfoRemovingQueryPattern(
    EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
  ): String;
begin

  Result :=
    Format(
      'DELETE FROM %s WHERE %s=:p%s',
      [
        EmployeeLogOnInfoDbSchema.TableName,

        EmployeeLogOnInfoDbSchema.EmployeeIdColumnName
      ]
    );

end;

destructor TBasedOnDBEmployeeLogOnInfoService.Destroy;
begin

  FreeAndNil(FEmployeeLogOnInfoDbSchema);
  
  inherited;

end;

function TBasedOnDBEmployeeLogOnInfoService.GetEmployeeLogOnInfo(
  const ClientIdentity: Variant;
  const EmployeeId: Variant
): TLogOnInfoDto;
var DataReader: IDataReader;
begin

  EnsureEmployeeIdValid(
    EmployeeId,
    'Некорректный идентификатор сотрудника ' +
    'для получения данных для входа в систему'
  );
  
  DataReader :=
    ExecuteEmployeeLogOnInfoGettingQuery(
      FEmployeeLogOnInfoGettingQueryPattern,
      EmployeeId
    );

  Result := CreateLogOnInfoDtoFrom(DataReader);

end;

function TBasedOnDBEmployeeLogOnInfoService.GetEmployeeLogOnInfoByLogin(
  const ClientIdentity: Variant;
  const Login: String
): TLogOnInfoDto;
var DataReader: IDataReader;
begin

  EnsureLoginIsValid(
    Login,
    'Некорректный логин для получения ' +
    'данных для входа в систему'
  );

  DataReader :=
    ExecuteEmployeeLogOnInfoByLoginGettingQuery(
      FEmployeeLogOnInfoByLoginGettingQueryPattern,
      Login
    );

  Result := CreateLogOnInfoDtoFrom(DataReader);

end;

function TBasedOnDBEmployeeLogOnInfoService.IsEmployeeLogOnInfoExists(
  const ClientIdentity: Variant;
  const Login: String
): Boolean;
begin

  try

    GetEmployeeLogOnInfoByLogin(ClientIdentity, Login).Free;

    Result := True;

  except

    on e: TEmployeeLogOnInfoServiceException
    do Result := False;

  end;

end;

function TBasedOnDBEmployeeLogOnInfoService.IsEmployeeLogOnInfoExists(
  const ClientIdentity: Variant;
  const EmployeeId: Variant
): Boolean;
begin

  try

    GetEmployeeLogOnInfo(ClientIdentity, EmployeeId).Free;

    Result := True;

  except

    on e: TEmployeeLogOnInfoServiceException
    do Result := False;

  end;

end;

procedure TBasedOnDBEmployeeLogOnInfoService.AddEmployeeLogOnInfo(
  const ClientIdentity: Variant;
  const EmployeeId: Variant;
  const LogOnInfoDto: TLogOnInfoDto
);
begin

  EnsureEmployeeIdValid(
    EmployeeId,
    'Некорректный идентификатор сотрудника ' +
    'обнаружен при попытке назначения ему данных ' +
    'для входа в систему'
  );
  
  EnsureLogOnInfoValidForCreating(LogOnInfoDto);

  if IsEmployeeLogOnInfoExists(ClientIdentity, LogOnInfoDto.Login)
  then begin

      raise TEmployeeLogOnInfoServiceException.CreateFmt(
        'Логин "%s" уже назначен ' +
        'другому сотруднику',
        [
          LogOnInfoDto.Login
        ]
      );

  end;

  ExecuteEmployeeLogOnInfoAddingQuery(
      FEmployeeLogOnInfoAddingQueryPattern,
      EmployeeId,
      LogOnInfoDto
  );

end;

procedure TBasedOnDBEmployeeLogOnInfoService.ChangeEmployeeLogOnInfo(
  const ClientIdentity: Variant;
  const EmployeeId: Variant;
  const LogOnInfoDto: TLogOnInfoDto
);
var
    EmployeeLogOnInfo: TLogOnInfoDto;
    EmployeeLogOnInfoExists: Boolean;
begin

  EnsureEmployeeIdValid(
    EmployeeId,
    'Некорректный идентификатор сотрудника ' +
    'обнаружен при попытке назначения ему данных ' +
    'для входа в систему'
  );

  EnsureLogOnInfoValidForChanging(
    ClientIdentity,
    EmployeeId,
    LogOnInfoDto
  );

  EmployeeLogOnInfo := GetEmployeeLogOnInfo(ClientIdentity, EmployeeId);

  try

    if not Assigned(EmployeeLogOnInfo) then begin

      raise TEmployeeLogOnInfoServiceException.Create(
        'Не найдены подлежащие изменению ' +
        'данные для входа в систему'
      );

    end;

    RaiseExceptionIfEmployeeLoginNotCorrespondExistingLogOnInfo(
      ClientIdentity, EmployeeLogOnInfo.Login, LogOnInfoDto
    );

  finally

    FreeAndNil(EmployeeLogOnInfo);
    
  end;

  ExecuteEmployeeLogOnInfoChangingQuery(
    FEmployeeLogOnInfoChangingQueryPattern,
    EmployeeId,
    LogOnInfoDto
  );

end;

procedure TBasedOnDBEmployeeLogOnInfoService.
  RaiseExceptionIfEmployeeLoginNotCorrespondExistingLogOnInfo(
    const ClientIdentity: Variant;
    const EmployeeLogin: String;
    const LogOnInfo: TLogOnInfoDto
  );
begin

  if
      IsEmployeeLogOnInfoExists(ClientIdentity, LogOnInfo.Login) then
  begin

    if (LogOnInfo.Login <> EmployeeLogin)
    then begin

      raise TEmployeeLogOnInfoServiceException.CreateFmt(
        'Логин "%s" уже назначен ' +
        'другому сотруднику',
        [
          LogOnInfo.Login
        ]
      );

    end;

  end
    
end;

procedure TBasedOnDBEmployeeLogOnInfoService.RemoveEmployeeLogOnInfo(
  const ClientIdentity: Variant;
  const EmployeeId: Variant
);
begin

  EnsureEmployeeIdValid(
    EmployeeId,
    'Некорректный идентификатор сотрудника ' +
    'для удаления данных для входа в систему'
  );

  if ClientIdentity = EmployeeId then begin

    raise TEmployeeLogOnInfoServiceException.Create(
      'Недопустимо удалять собственные ' +
      'данные для входа в систему'
    );
    
  end;

  ExecuteEmployeeLogOnInfoRemovingQuery(
    FEmployeeLogOnInfoRemovingQueryPattern, EmployeeId
  );
  
end;

procedure TBasedOnDBEmployeeLogOnInfoService.
  ExecuteEmployeeLogOnInfoAddingQuery(
    const QueryPattern: String;
    const EmployeeId: Variant;
    const LogOnInfoDto: TLogOnInfoDto
  );
var QueryParams: TQueryParams;
begin

  QueryParams := TQueryParams.Create;

  try

    QueryParams
      .AddFluently('p' + FEmployeeLogOnInfoDbSchema.EmployeeIdColumnName, EmployeeId)
      .AddFluently('p' + FEmployeeLogOnInfoDbSchema.LoginColumnName, LogOnInfoDto.Login)
      .AddFluently('p' + FEmployeeLogOnInfoDbSchema.PasswordColumnName, LogOnInfoDto.Password);

    FQueryExecutor.ExecuteModificationQuery(QueryPattern, QueryParams);
    
  finally

    FreeAndNil(QueryParams);

  end;

end;

function TBasedOnDBEmployeeLogOnInfoService.
  ExecuteEmployeeLogOnInfoByLoginGettingQuery(
    const QueryPattern, Login: String
  ): IDataReader;
var QueryParams: TQueryParams;
begin

  QueryParams := TQueryParams.Create;

  try

    QueryParams.Add(
      'p' + FEmployeeLogOnInfoDbSchema.LoginColumnName, Login
    );

    Result := FQueryExecutor.ExecuteSelectionQuery(QueryPattern, QueryParams);
    
  finally

    FreeAndNil(QueryParams);
    
  end;

end;

procedure TBasedOnDBEmployeeLogOnInfoService.ExecuteEmployeeLogOnInfoChangingQuery(
  const QueryPattern: String; const EmployeeId: Variant;
  const LogOnInfoDto: TLogOnInfoDto);
var QueryParams: TQueryParams;
begin

  QueryParams := TQueryParams.Create;

  try

    QueryParams
      .AddFluently('p' + FEmployeeLogOnInfoDbSchema.EmployeeIdColumnName, EmployeeId)
      .AddFluently('p' + FEmployeeLogOnInfoDbSchema.LoginColumnName, LogOnInfoDto.Login)
      .AddFluently('p' + FEmployeeLogOnInfoDbSchema.PasswordColumnName, LogOnInfoDto.Password);

    FQueryExecutor.ExecuteModificationQuery(QueryPattern, QueryParams);

  finally

    FreeAndNil(QueryParams);
    
  end;

end;

function TBasedOnDBEmployeeLogOnInfoService.ExecuteEmployeeLogOnInfoGettingQuery(
  const QueryPattern: String;
  const EmployeeId: Variant
): IDataReader;
var QueryParams: TQueryParams;
begin

  QueryParams := TQueryParams.Create;

  try

    QueryParams.Add(
      'p' + FEmployeeLogOnInfoDbSchema.EmployeeIdColumnName, EmployeeId
    );

    Result := FQueryExecutor.ExecuteSelectionQuery(QueryPattern, QueryParams);
    
  finally

    FreeAndNil(QueryParams);

  end;

end;

procedure TBasedOnDBEmployeeLogOnInfoService.ExecuteEmployeeLogOnInfoRemovingQuery(
  const QueryPattern: String;
  const EmployeeId: Variant
);
var QueryParams: TQueryParams;
begin

  QueryParams := TQueryParams.Create;

  try

    QueryParams.Add('p' + FEmployeeLogOnInfoDbSchema.EmployeeIdColumnName, EmployeeId);

    FQueryExecutor.ExecuteModificationQuery(QueryPattern, QueryParams);
    
  finally

    FreeAndNil(QueryParams);

  end;

end;

procedure TBasedOnDBEmployeeLogOnInfoService.EnsureEmployeeIdValid(
  const EmployeeId: Variant;
  NotValidExceptionMessage: String
);
begin

  if VarIsNullOrEmpty(EmployeeId) then begin

    if NotValidExceptionMessage = '' then begin

      NotValidExceptionMessage :=
        'Обнаружен некорректный идентификатор сотрудника';

    end;

    raise TEmployeeLogOnInfoServiceException.Create(NotValidExceptionMessage);
    
  end;

end;

procedure TBasedOnDBEmployeeLogOnInfoService.EnsureLoginIsValid(
  const Login: String;
  NotValidExceptionMessage: String
);
begin

  if Trim(Login) = '' then begin

    if NotValidExceptionMessage = '' then
      NotValidExceptionMessage := 'Некорректный логин';

    raise TEmployeeLogOnInfoServiceException.Create(NotValidExceptionMessage);
    
  end;

end;

procedure TBasedOnDBEmployeeLogOnInfoService.
  EnsureLogOnInfoValidForChanging(
    const ClientIdentity: Variant;
    const EmployeeId: Variant;
    const LogOnInfoDto: TLogOnInfoDto;
    NotValidExceptionMessage: String
  );
begin

  EnsureLogOnInfoValidForCreating(LogOnInfoDto);

end;

procedure TBasedOnDBEmployeeLogOnInfoService.EnsureLogOnInfoValidForCreating(
  LogOnInfoDto: TLogOnInfoDto;
  NotValidExceptionMessage: String
);
begin

  if
    not Assigned(LogOnInfoDto) or
    (Trim(LogOnInfoDto.Login) = '') or
    (Trim(LogOnInfoDto.Password) = '')
  then begin

    if NotValidExceptionMessage = '' then begin

      NotValidExceptionMessage :=
        'Обнаружена попытка назначения ' +
        'сотруднику некорректных данных ' +
        'для входа в систему';
         
    end;

    raise TEmployeeLogOnInfoServiceException.Create(NotValidExceptionMessage);

  end;

end;

end.
