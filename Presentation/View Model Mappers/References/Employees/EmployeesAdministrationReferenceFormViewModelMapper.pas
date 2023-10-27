unit EmployeesAdministrationReferenceFormViewModelMapper;

interface

uses

  EmployeesReferenceFormViewModelMapper,
  EntitySetHolder,
  ReferenceFormViewModel,
  ReferenceFormDataSetHolder,
  EmployeesAdministrationReferenceFormViewModel,
  EmployeeAccountSetHolder,
  EmployeesAdministrationReferenceDataSetHolder,
  SysUtils,
  Classes;

type

  TEmployeesAdministrationReferenceFormViewModelMapper =
    class (TEmployeesReferenceFormViewModelMapper)

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

{ TEmployeesAdministrationReferenceFormViewModelMapper }

procedure TEmployeesAdministrationReferenceFormViewModelMapper.FillReferenceFormDataSetFieldDefsFrom(
  ReferenceFormDataSetFieldDefs: TReferenceFormDataSetFieldDefs;
  EntitySetFieldDefs: TEntitySetFieldDefs);
var EmployeeAccountSetFieldDefs: TEmployeeAccountSetFieldDefs;
begin

  inherited;

  EmployeeAccountSetFieldDefs := EntitySetFieldDefs as TEmployeeAccountSetFieldDefs;

  with ReferenceFormDataSetFieldDefs as TEmployeesAdministrationReferenceDataSetFieldDefs
  do begin

    RoleNameFieldName := EmployeeAccountSetFieldDefs.RoleNameFieldName;
    LoginFieldName := EmployeeAccountSetFieldDefs.LoginFieldName;

  end;
  
end;

function TEmployeesAdministrationReferenceFormViewModelMapper.GetReferenceFormDataSetFieldDefsClass: TReferenceFormDataSetFieldDefsClass;
begin

  Result := TEmployeesAdministrationReferenceDataSetFieldDefs;
  
end;

function TEmployeesAdministrationReferenceFormViewModelMapper.GetReferenceFormDataSetHolderClass: TReferenceFormDataSetHolderClass;
begin

  Result := TEmployeesAdministrationReferenceDataSetHolder;

end;

function TEmployeesAdministrationReferenceFormViewModelMapper.GetReferenceFormViewModelClass: TReferenceFormViewModelClass;
begin

  Result := TEmployeesReferenceAdministrationFormViewModel;
  
end;

end.
