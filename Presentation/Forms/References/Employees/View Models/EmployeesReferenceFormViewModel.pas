unit EmployeesReferenceFormViewModel;

interface

uses

  ReferenceFormDataSetHolder,
  ReferenceFormViewModel,
  EmployeesReferenceDataSetHolder,
  SysUtils,
  Classes;

type

  TEmployeesReferenceFormViewModel = class (TReferenceFormViewModel)

    protected

      procedure SetDataSetHolder(const Value: TEmployeesReferenceDataSetHolder);
      function GetDataSetHolder: TEmployeesReferenceDataSetHolder;

    public

      property DataSetHolder: TEmployeesReferenceDataSetHolder
      read GetDataSetHolder write SetDataSetHolder;
      
  end;

  TEmployeesReferenceFormViewModelClass = class of TEmployeesReferenceFormViewModel;
  
implementation

{ TEmployeesReferenceFormViewModel }

{ TEmployeesReferenceFormViewModel }

function TEmployeesReferenceFormViewModel.GetDataSetHolder: TEmployeesReferenceDataSetHolder;
begin

  Result := TEmployeesReferenceDataSetHolder(FDataSetHolder);
  
end;

procedure TEmployeesReferenceFormViewModel.SetDataSetHolder(
  const Value: TEmployeesReferenceDataSetHolder);
begin

  inherited SetDataSetHolder(Value);

end;

end.
