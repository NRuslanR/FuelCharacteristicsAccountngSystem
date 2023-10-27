unit StubEmployeeAccountSetReadService;

interface

uses

  EmployeeAccountSetReadService,
  EmployeeAccountSetHolder,
  SysUtils,
  Classes;

type

  TStubEmployeeAccountSetReadService =
  class (TInterfacedObject, IEmployeeAccountSetReadService)

    public

      function GetAllEmployeeAccountSet: TEmployeeAccountSetHolder;

  end;
  
implementation

uses

  AbstractDataSetHolder,
  unTestEmployeesReferenceFormDataModule;
  
{ TStubEmployeeAccountSetReadService }

function TStubEmployeeAccountSetReadService.GetAllEmployeeAccountSet: TEmployeeAccountSetHolder;
begin

  Result :=
    TEmployeeAccountSetHolder.CreateFrom(
      TTestEmployeesReferenceFormDataModule.Create(nil).TestEmployeesAdminMemData
    );

  Result.FieldDefs := TEmployeeAccountSetFieldDefs.Create;
  
  Result.RecordIdGenerator :=
    TNegativeIntegerDataSetRecordIdGenerator.Create(
      TIntegerDataSetRecordIdGenerator.Create
    );

  with Result as TEmployeeAccountSetHolder do begin

    IdFieldName := 'id';
    IsRecordIdGeneratedFieldName := 'is_record_id_generated';
    NameFieldName := 'name';
    SurnameFieldName := 'surname';
    PatronymicFieldName := 'patronymic';
    BirthDateFieldName := 'birth_date';
    SpecialityFieldName := 'speciality';
    LoginFieldName := 'login';
    RoleNameFieldName := 'role_name';
    CanBeChangedFieldName := 'can_be_changed';
    CanBeRemovedFieldName := 'can_be_removed';

  end;
  
end;

end.
