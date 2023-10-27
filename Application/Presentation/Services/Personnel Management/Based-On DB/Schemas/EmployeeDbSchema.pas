unit EmployeeDbSchema;

interface

uses

  SysUtils,
  Classes;

type

  TEmployeeDbSchema = class

    public

      TableName: String;

      IdColumnName: String;
      NameColumnName: String;
      SurnameColumnName: String;
      PatronymicColumnName: String;
      SpecialityColumnName: String;
      BirthDateColumnName: String;
      RoleIdColumnName: String;
      
  end;

implementation

end.
