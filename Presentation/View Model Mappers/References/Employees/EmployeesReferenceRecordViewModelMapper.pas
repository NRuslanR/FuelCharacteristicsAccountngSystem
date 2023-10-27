unit EmployeesReferenceRecordViewModelMapper;

interface

uses

  AbstractReferenceFormRecordViewModelMapper,
  EmployeesReferenceRecordViewModel,
  ReferenceFormRecordViewModel,
  EmployeeCardFormViewModel,
  CardFormViewModel,
  SysUtils,
  Classes;

type

  TEmployeesReferenceRecordViewModelMapper = class (TAbstractReferenceFormRecordViewModelMapper)

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

{ TEmployeesReferenceRecordViewModelMapper }

procedure TEmployeesReferenceRecordViewModelMapper.FillReferenceFormRecordViewModelFrom(
  ReferenceFormRecordViewModel: TReferenceFormRecordViewModel;
  CardFormViewModel: TCardFormViewModel; const CanBeChanged,
  CanBeRemoved: Boolean);
var EmployeeCardFormViewModel: TEmployeeCardFormViewModel;
begin

  inherited;

  EmployeeCardFormViewModel := CardFormViewModel as TEmployeeCardFormViewModel;

  with ReferenceFormRecordViewModel as TEmployeesReferenceRecordViewModel do begin

    Name := EmployeeCardFormViewModel.Name.Value;
    Surname := EmployeeCardFormViewModel.Surname.Value;
    Patronymic := EmployeeCardFormViewModel.Patronymic.Value;
    BirthDate := EmployeeCardFormViewModel.BirthDate.Value;
    Speciality := EmployeeCardFormViewModel.Speciality.Value;
    
  end;

end;

function TEmployeesReferenceRecordViewModelMapper.GetReferenceFormRecordViewModelClass: TReferenceFormRecordViewModelClass;
begin

  Result := TEmployeesReferenceRecordViewModel;
  
end;

end.
