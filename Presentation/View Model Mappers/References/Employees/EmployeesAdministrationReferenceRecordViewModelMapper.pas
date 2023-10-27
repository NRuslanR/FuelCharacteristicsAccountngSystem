unit EmployeesAdministrationReferenceRecordViewModelMapper;

interface

uses

  ReferenceFormRecordViewModel,
  CardFormViewModel,
  EmployeesReferenceRecordViewModelMapper,
  SysUtils,
  Classes;

type

  TEmployeesAdministrationReferenceRecordViewModelMapper =
    class (TEmployeesReferenceRecordViewModelMapper)

      protected

        function GetReferenceFormRecordViewModelClass: TReferenceFormRecordViewModelClass; override;

        procedure FillReferenceFormRecordViewModelFrom(
          ReferenceFormRecordViewModel: TReferenceFormRecordViewModel;
          CardFormViewModel: TCardFormViewModel;
          const CanBeChanged: Boolean = True;
          const CanBeRemoved: Boolean = True
        ); override;
      
    end;

implementation

uses

  EmployeesAdministrationReferenceRecordViewModel,
  EmployeeAdministrationCardFormViewModel;
  
{ TEmployeesAdministrationReferenceRecordViewModelMapper }

procedure TEmployeesAdministrationReferenceRecordViewModelMapper.
  FillReferenceFormRecordViewModelFrom(
    ReferenceFormRecordViewModel: TReferenceFormRecordViewModel;
    CardFormViewModel: TCardFormViewModel; const CanBeChanged,
    CanBeRemoved: Boolean
  );
var EmployeeCardFormViewModel: TEmployeeAdministrationCardFormViewModel;
begin

  inherited;

  EmployeeCardFormViewModel :=
    CardFormViewModel as TEmployeeAdministrationCardFormViewModel;

  with ReferenceFormRecordViewModel as TEmployeesAdministrationReferenceRecordViewModel
  do begin

    Login := EmployeeCardFormViewModel.Login.Value;
    RoleName := EmployeeCardFormViewModel.CurrentRoleName.Value;

  end;

end;

function TEmployeesAdministrationReferenceRecordViewModelMapper.
  GetReferenceFormRecordViewModelClass: TReferenceFormRecordViewModelClass;
begin

  Result := TEmployeesAdministrationReferenceRecordViewModel;

end;

end.
