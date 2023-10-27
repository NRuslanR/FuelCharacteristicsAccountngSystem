unit EmployeesReferenceFormViewModelMapper;

interface

uses

  AbstractReferenceFormViewModelMapper,
  ReferenceFormViewModel,
  ReferenceFormDataSetHolder,
  EmployeesReferenceFormViewModel,
  EmployeesReferenceDataSetHolder,
  EntitySetHolder,
  EmployeeSetHolder,
  SysUtils,
  Classes;

type

  TEmployeesReferenceFormViewModelMapper = class (TAbstractReferenceFormViewModelMapper)

    protected

      function GetReferenceFormViewModelClass: TReferenceFormViewModelClass; override;
      function GetReferenceFormDataSetHolderClass: TReferenceFormDataSetHolderClass; override;
      function GetReferenceFormDataSetFieldDefsClass: TReferenceFormDataSetFieldDefsClass; override;

    protected

      procedure FillReferenceFormDataSetFieldDefsFrom(
        ReferenceFormDataSetFieldDefs: TReferenceFormDataSetFieldDefs;
        EntitySetFieldDefs: TEntitySetFieldDefs
      ); override;
  
  end;
  
implementation

{ TEmployeesReferenceFormViewModelMapper }

procedure TEmployeesReferenceFormViewModelMapper.FillReferenceFormDataSetFieldDefsFrom(
  ReferenceFormDataSetFieldDefs: TReferenceFormDataSetFieldDefs;
  EntitySetFieldDefs: TEntitySetFieldDefs);
var EmployeeSetFieldDefs: TEmployeeSetFieldDefs;
begin

  inherited;

  EmployeeSetFieldDefs := EntitySetFieldDefs as TEmployeeSetFieldDefs;

  with ReferenceFormDataSetFieldDefs as TEmployeesReferenceDataSetFieldDefs
  do begin

    NameFieldName := EmployeeSetFieldDefs.NameFieldName;
    SurnameFieldName := EmployeeSetFieldDefs.SurnameFieldName;
    PatronymicFieldName := EmployeeSetFieldDefs.PatronymicFieldName;
    BirthDateFieldName := EmployeeSetFieldDefs.BirthDateFieldName;
    SpecialityFieldName := EmployeeSetFieldDefs.SpecialityFieldName;
    
  end;

end;

function TEmployeesReferenceFormViewModelMapper.GetReferenceFormDataSetFieldDefsClass: TReferenceFormDataSetFieldDefsClass;
begin

  Result := TEmployeesReferenceDataSetFieldDefs;

end;

function TEmployeesReferenceFormViewModelMapper.GetReferenceFormDataSetHolderClass: TReferenceFormDataSetHolderClass;
begin

  Result := TEmployeesReferenceDataSetHolder;
  
end;

function TEmployeesReferenceFormViewModelMapper.GetReferenceFormViewModelClass: TReferenceFormViewModelClass;
begin

  Result := TEmployeesReferenceFormViewModel;
  
end;

end.
