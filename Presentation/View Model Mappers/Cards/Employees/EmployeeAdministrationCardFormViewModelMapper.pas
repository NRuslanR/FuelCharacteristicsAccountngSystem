unit EmployeeAdministrationCardFormViewModelMapper;

interface

uses

  EmployeeAdministrationCardFormViewModel,
  EmployeeCardFormViewModelMapper,
  CardFormViewModel,
  ReferenceFormRecordViewModel,
  EmployeesAdministrationReferenceRecordViewModel,
  EmployeeAccountDto,
  RoleDto,
  SysUtils,
  Classes;

type

  TEmployeeAdministrationCardFormViewModelMapper =
    class (TEmployeeCardFormViewModelMapper)

      protected

        function GetCardFormViewModelClass: TCardFormViewModelClass; override;

        procedure FillCardFormViewModelFrom(
          CardFormViewModel: TCardFormViewModel;
          ReferenceFormRecordViewModel: TReferenceFormRecordViewModel
        ); override;

        function MapRoleViewModelsFrom(
          const RoleDtos: TRoleDtos
        ): TRoleViewModels;

        procedure SetCurrentRoleInViewModel(
          ViewModel: TEmployeeAdministrationCardFormViewModel
        );
        
      public

        function CreateEmptyCardFormViewModel: TCardFormViewModel; override;

        function CreateEmptyCardFormViewModelFrom(
          const Specialities: TStrings;
          const RoleDtos: TRoleDtos
        ): TEmployeeAdministrationCardFormViewModel;

      public

        function MapEmployeeAdministrationCardFormViewModelFrom(

          EmployeesAdministrationReferenceRecordViewModel:
            TEmployeesAdministrationReferenceRecordViewModel;
            
          const Specialities: TStrings;
          const RoleDtos: TRoleDtos

        ): TEmployeeAdministrationCardFormViewModel; overload;

        function MapEmployeeAdministrationCardFormViewModelFrom(
          const EmployeeAccountDto: TEmployeeAccountDto;
          const Specialities: TStrings;
          const RoleDtos: TRoleDtos
        ): TEmployeeAdministrationCardFormViewModel; overload;
          
    end;

implementation
  
{ TEmployeeAdministrationCardFormViewModelMapper }

function TEmployeeAdministrationCardFormViewModelMapper.
  CreateEmptyCardFormViewModel: TCardFormViewModel;
begin

  Result := inherited CreateEmptyCardFormViewModel;
  
end;

function TEmployeeAdministrationCardFormViewModelMapper.
  CreateEmptyCardFormViewModelFrom(
    const Specialities: TStrings;
    const RoleDtos: TRoleDtos
  ): TEmployeeAdministrationCardFormViewModel;
begin

  Result :=
    TEmployeeAdministrationCardFormViewModel(
      CreateEmptyCardFormViewModel
    );

  Result.Specialities.Assign(Specialities);
  Result.RoleViewModels := MapRoleViewModelsFrom(RoleDtos);

  SetCurrentRoleInViewModel(Result);

end;

procedure TEmployeeAdministrationCardFormViewModelMapper.
  FillCardFormViewModelFrom(
    CardFormViewModel: TCardFormViewModel;
    ReferenceFormRecordViewModel: TReferenceFormRecordViewModel
  );
var EmployeeCardFormViewModel: TEmployeeAdministrationCardFormViewModel;
begin

  inherited;

  EmployeeCardFormViewModel :=
    CardFormViewModel as TEmployeeAdministrationCardFormViewModel;

  with ReferenceFormRecordViewModel as TEmployeesAdministrationReferenceRecordViewModel
  do begin

    EmployeeCardFormViewModel.Login.Value := Login;
    EmployeeCardFormViewModel.CurrentRoleName.Value := RoleName;

  end;

end;

function TEmployeeAdministrationCardFormViewModelMapper.
  GetCardFormViewModelClass: TCardFormViewModelClass;
begin

  Result := TEmployeeAdministrationCardFormViewModel;
  
end;

function TEmployeeAdministrationCardFormViewModelMapper.
  MapEmployeeAdministrationCardFormViewModelFrom(

    EmployeesAdministrationReferenceRecordViewModel:
      TEmployeesAdministrationReferenceRecordViewModel;

    const Specialities: TStrings;
    const RoleDtos: TRoleDtos
    
  ): TEmployeeAdministrationCardFormViewModel;
begin

  Result :=
    TEmployeeAdministrationCardFormViewModel(
      MapEmployeeCardFormViewModelFrom(
        EmployeesAdministrationReferenceRecordViewModel,
        Specialities
      )
    );

  Result.RoleViewModels := MapRoleViewModelsFrom(RoleDtos);

end;

function TEmployeeAdministrationCardFormViewModelMapper.
  MapEmployeeAdministrationCardFormViewModelFrom(
    const EmployeeAccountDto: TEmployeeAccountDto;
    const Specialities: TStrings;
    const RoleDtos: TRoleDtos
  ): TEmployeeAdministrationCardFormViewModel;
begin

  Result := TEmployeeAdministrationCardFormViewModel.Create;

  FillEmployeeCardFormViewModelFrom(
    Result, EmployeeAccountDto.EmployeeDto, Specialities
  );

  Result.RoleViewModels := MapRoleViewModelsFrom(RoleDtos);

  SetCurrentRoleInViewModel(Result);
  
  Result.Login.Value := EmployeeAccountDto.LogOnInfoDto.Login;
  Result.Password.Value := EmployeeAccountDto.LogOnInfoDto.Password;
  
end;


function TEmployeeAdministrationCardFormViewModelMapper.
  MapRoleViewModelsFrom(const RoleDtos: TRoleDtos): TRoleViewModels;
var RoleDto: TRoleDto;
begin

  Result := TRoleViewModels.Create;

  try

    for RoleDto in RoleDtos do
      Result.Add(TRoleViewModel.Create(RoleDto.Id, RoleDto.DisplayName));

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

procedure TEmployeeAdministrationCardFormViewModelMapper.SetCurrentRoleInViewModel(
  ViewModel: TEmployeeAdministrationCardFormViewModel
);
var CurrentRoleViewModel: TRoleViewModel;
begin

  CurrentRoleViewModel :=
    ViewModel.RoleViewModels.FindRoleViewModelByName(
      ViewModel.Specialities[0]
    );

  if Assigned(CurrentRoleViewModel) then
    ViewModel.CurrentRoleName.Value := CurrentRoleViewModel.Name;

end;

end.
