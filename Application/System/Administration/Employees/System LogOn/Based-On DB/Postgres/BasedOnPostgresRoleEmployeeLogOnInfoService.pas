unit BasedOnPostgresRoleEmployeeLogOnInfoService;

interface

uses

  EmployeeLogOnInfoService,
  BasedOnDBEmployeeLogOnInfoService,
  LogOnInfoDto,
  SysUtils,
  Classes;

type

  TBasedOnPostgresRoleEmployeeLogOnInfoService =
    class (TBasedOnDBEmployeeLogOnInfoService)

      protected

        function PrepareEmployeeLogOnInfoGettingQueryPattern(
          EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
        ): String; override;

        function PrepareEmployeeLogOnInfoByLoginGettingQueryPattern(
          EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
        ): String; override;
        
        function PrepareEmployeeLogOnInfoAddingQueryPattern(
          EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
        ): String; override;

        function PrepareEmployeeLogOnInfoChangingQueryPattern(
          EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
        ): String; override;

        function PrepareEmployeeLogOnInfoRemovingQueryPattern(
          EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
        ): String; override;

      protected

        procedure EnsureLogOnInfoValidForChanging(
          const ClientIdentity: Variant;
          const EmployeeId: Variant;
          const LogOnInfoDto: TLogOnInfoDto;
          NotValidExceptionMessage: String = ''
        ); override;

      protected

        procedure RaiseExceptionIfEmployeeLoginNotCorrespondExistingLogOnInfo(
          const ClientIdentity: Variant;
          const EmployeeLogin: String;
          const LogOnInfo: TLogOnInfoDto
        ); override;
        
    end;

implementation

{ TBasedOnPostgresRoleEmployeeLogOnInfoService }

procedure TBasedOnPostgresRoleEmployeeLogOnInfoService.
  EnsureLogOnInfoValidForChanging(
    const ClientIdentity: Variant;
    const EmployeeId: Variant;
    const LogOnInfoDto: TLogOnInfoDto;
    NotValidExceptionMessage: String
  );
begin

  if Trim(LogOnInfoDto.Login) = '' then begin

    if NotValidExceptionMessage = '' then begin

      NotValidExceptionMessage :=
        'Обнаружена попытка назначения ' +
        'сотруднику некорректных данных ' +
        'для входа в систему';

    end;

    raise TEmployeeLogOnInfoServiceException.Create(NotValidExceptionMessage);

  end;
  
end;

function TBasedOnPostgresRoleEmployeeLogOnInfoService.
  PrepareEmployeeLogOnInfoAddingQueryPattern(
    EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
  ): String;
begin

  Result :=
    Format(
      'SELECT fca.create_or_update_employee_role(:p%s,:p%s,:p%s)',
      [
        EmployeeLogOnInfoDbSchema.EmployeeIdColumnName,
        EmployeeLogOnInfoDbSchema.LoginColumnName,
        EmployeeLogOnInfoDbSchema.PasswordColumnName
      ]
    );
    
end;

function TBasedOnPostgresRoleEmployeeLogOnInfoService.
  PrepareEmployeeLogOnInfoChangingQueryPattern(
    EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
  ): String;
begin

  Result :=
    Format(
      'SELECT fca.create_or_update_employee_role(:p%s,:p%s,:p%s)',
      [
        EmployeeLogOnInfoDbSchema.EmployeeIdColumnName,
        EmployeeLogOnInfoDbSchema.LoginColumnName,
        EmployeeLogOnInfoDbSchema.PasswordColumnName
      ]
    );
    
end;

function TBasedOnPostgresRoleEmployeeLogOnInfoService.
  PrepareEmployeeLogOnInfoGettingQueryPattern(
    EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
  ): String;
begin

  Result :=
    Format(
      'SELECT ' +
      't.login AS %s, t.password AS %s ' +
      'FROM fca.get_employee_role_logon_data(:p%s) t',
      [
        EmployeeLogOnInfoDbSchema.LoginColumnName,
        EmployeeLogOnInfoDbSchema.PasswordColumnName,

        EmployeeLogOnInfoDbSchema.EmployeeIdColumnName
      ]
    );

end;

function TBasedOnPostgresRoleEmployeeLogOnInfoService.
  PrepareEmployeeLogOnInfoByLoginGettingQueryPattern(
    EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
  ): String;
begin

  Result :=
    Format(
      'SELECT ' +
      't.login AS %s, t.password AS %s ' +
      'FROM fca.get_employee_role_logon_data_by_login(:p%s) t',
      [
        EmployeeLogOnInfoDbSchema.LoginColumnName,
        EmployeeLogOnInfoDbSchema.PasswordColumnName,

        EmployeeLogOnInfoDbSchema.LoginColumnName
      ]
    );

end;

function TBasedOnPostgresRoleEmployeeLogOnInfoService.
  PrepareEmployeeLogOnInfoRemovingQueryPattern(
    EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
  ): String;
begin

  Result :=
    Format(
      'SELECT fca.remove_employee_role(:p%s)',
      [
        EmployeeLogOnInfoDbSchema.EmployeeIdColumnName
      ]
    );
    
end;

procedure TBasedOnPostgresRoleEmployeeLogOnInfoService.
  RaiseExceptionIfEmployeeLoginNotCorrespondExistingLogOnInfo(
    const ClientIdentity: Variant;
    const EmployeeLogin: String;
    const LogOnInfo: TLogOnInfoDto
  );
begin

  inherited;

  if (EmployeeLogin <> LogOnInfo.Login) and (Trim(LogOnInfo.Password) = '')
  then begin

    raise TEmployeeLogOnInfoServiceException.CreateFmt(
      'Для логина "%s" не задан ' +
      'соответствующий пароль',
      [
        LogOnInfo.Login
      ]
    );

  end;

end;

end.
