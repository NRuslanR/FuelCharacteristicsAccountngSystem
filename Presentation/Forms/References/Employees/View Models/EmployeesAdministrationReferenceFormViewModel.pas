unit EmployeesAdministrationReferenceFormViewModel;

interface

uses

  EmployeesReferenceFormViewModel,
  EmployeesReferenceDataSetHolder,
  EmployeesAdministrationReferenceDataSetHolder,
  SysUtils,
  Classes;

type

  TEmployeesReferenceAdministrationFormViewModel =
    class (TEmployeesReferenceFormViewModel)

      protected

        procedure SetAdministrationDataSetHolder(const Value: TEmployeesAdministrationReferenceDataSetHolder);
        function GetAdministrationDataSetHolder: TEmployeesAdministrationReferenceDataSetHolder;

      public

        property DataSetHolder: TEmployeesAdministrationReferenceDataSetHolder
        read GetAdministrationDataSetHolder write SetAdministrationDataSetHolder;
        
    end;
  
implementation

{ TEmployeesReferenceAdministrationFormViewModel }

function TEmployeesReferenceAdministrationFormViewModel.GetAdministrationDataSetHolder: TEmployeesAdministrationReferenceDataSetHolder;
begin

  Result := TEmployeesAdministrationReferenceDataSetHolder(inherited DataSetHolder);
  
end;

procedure TEmployeesReferenceAdministrationFormViewModel.SetAdministrationDataSetHolder(
  const Value: TEmployeesAdministrationReferenceDataSetHolder);
begin

  SetDataSetHolder(Value);
  
end;

end.
