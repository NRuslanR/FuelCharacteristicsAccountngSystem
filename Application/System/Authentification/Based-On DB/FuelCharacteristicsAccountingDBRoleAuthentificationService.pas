unit FuelCharacteristicsAccountingDBRoleAuthentificationService;

interface

uses

  DatabaseServerAuthentificationService,
  DatabaseServerRoleAuthentificationService,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingSystemAuthentificationDbSchemaData =
    class (TUserRoleAccountDbSchemaData)

      public

        EmployeeLogOnInfosTableName: String;

        EmployeeLogOnInfosTableEmployeeIdColumnName: String;

    end;
    
  TFuelCharacteristicsAccountingDBRoleAuthentificationService =
    class (TDatabaseServerRoleAuthentificationService)

      protected

        function PrepareFetchingUserAccountInfoQuery(
          UserAccountDbSchemaData: TUserAccountDbSchemaData
        ): String; override;
        
    end;
  
implementation

{ TFuelCharacteristicsAccountingDBRoleAuthentificationService }

function TFuelCharacteristicsAccountingDBRoleAuthentificationService.
  PrepareFetchingUserAccountInfoQuery(
    UserAccountDbSchemaData: TUserAccountDbSchemaData
  ): String;
begin

  with
    UserAccountDbSchemaData as
    TFuelCharacteristicsAccountingSystemAuthentificationDbSchemaData
  do begin

    Result :=
      Format(
        'SELECT ' +
        'A.%s,C.%s,A.%s,B.%s,B.%s ' +
        'FROM %s A ' +
        'JOIN %s B ON B.%s=A.%s ' +
        'JOIN %s C ON C.%s=A.%s ' +
        'WHERE C.%s=:p%s',
        [
          UserIdColumnName,
          UserLoginColumnName,
          UserFriendlyNameColumnName,
          RoleIdColumnName,
          RoleFriendlyNameColumnName,

          TableName,
          RoleTableName,

          RoleIdColumnName,
          RoleIdForeignKeyColumnName,

          EmployeeLogOnInfosTableName,

          EmployeeLogOnInfosTableEmployeeIdColumnName,
          UserIdColumnName,

          UserLoginColumnName,
          UserLoginColumnName
        ]
    );

  end;
  
end;

end.
