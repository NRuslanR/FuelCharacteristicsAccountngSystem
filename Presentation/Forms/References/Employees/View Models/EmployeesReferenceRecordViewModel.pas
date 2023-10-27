unit EmployeesReferenceRecordViewModel;

interface

uses

  ReferenceFormRecordViewModel,
  SysUtils,
  Classes;

type

  TEmployeesReferenceRecordViewModel = class (TReferenceFormRecordViewModel)

    public

      Name: String;
      Surname: String;
      Patronymic: String;
      BirthDate: TDateTime;
      Speciality: String;
      
  end;

implementation

uses

  Variants;

end.
