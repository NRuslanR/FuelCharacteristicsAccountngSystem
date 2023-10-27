unit EmployeesAdministrationReferenceRecordViewModel;

interface

uses

  EmployeesReferenceRecordViewModel,
  SysUtils,
  Classes;

type

  TEmployeesAdministrationReferenceRecordViewModel =
    class (TEmployeesReferenceRecordViewModel)

      public

        RoleName: String;
        Login: String;

        constructor Create;
        
    end;
  
implementation

uses

  Variants;
  
{ TEmployeesAdministrationReferenceRecordViewModel }

constructor TEmployeesAdministrationReferenceRecordViewModel.Create;
begin

  inherited Create;
  
end;

end.
