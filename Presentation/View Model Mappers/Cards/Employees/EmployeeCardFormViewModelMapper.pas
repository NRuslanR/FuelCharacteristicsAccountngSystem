unit EmployeeCardFormViewModelMapper;

interface

uses

  CardFormViewModel,
  AbstractCardFormViewModelMapper,
  ReferenceFormRecordViewModel,
  EmployeeCardFormViewModel,
  EmployeesReferenceRecordViewModel,
  EmployeeDto,
  SysUtils,
  Classes;

type

  TEmployeeCardFormViewModelMapper = class (TAbstractCardFormViewModelMapper)

    protected

      function GetCardFormViewModelClass: TCardFormViewModelClass; override;

      procedure FillCardFormViewModelFrom(
        CardFormViewModel: TCardFormViewModel;
        ReferenceFormRecordViewModel: TReferenceFormRecordViewModel
      ); override;

      procedure FillEmployeeCardFormViewModelFrom(
        EmployeeCardFormViewModel: TEmployeeCardFormViewModel;
        const EmployeeDto: TEmployeeDto;
        const Specialities: TStrings
      ); overload;

    public

      function CreateEmptyCardFormViewModel: TCardFormViewModel; override;

    public

      function MapEmployeeCardFormViewModelFrom(
        EmployeeReferenceRecordViewModel: TEmployeesReferenceRecordViewModel;
        const Specialities: TStrings
      ): TEmployeeCardFormViewModel; overload;

      function MapEmployeeCardFormViewModelFrom(
        const EmployeeDto: TEmployeeDto;
        const Specialities: TStrings
      ): TEmployeeCardFormViewModel; overload;

  end;

implementation

{ TEmployeeCardFormViewModelMapper }

function TEmployeeCardFormViewModelMapper.
  CreateEmptyCardFormViewModel: TCardFormViewModel;
begin

  Result := inherited CreateEmptyCardFormViewModel;

  with Result as TEmployeeCardFormViewModel do begin

    BirthDate.Value := Now;

  end;

end;

procedure TEmployeeCardFormViewModelMapper.FillCardFormViewModelFrom(
  CardFormViewModel: TCardFormViewModel;
  ReferenceFormRecordViewModel: TReferenceFormRecordViewModel);
var EmployeeCardFormViewModel: TEmployeeCardFormViewModel;
begin

  inherited;

  EmployeeCardFormViewModel := CardFormViewModel as TEmployeeCardFormViewModel;

  with ReferenceFormRecordViewModel as TEmployeesReferenceRecordViewModel do begin

    EmployeeCardFormViewModel.Name.Value := Name;
    EmployeeCardFormViewModel.Surname.Value := Surname;
    EmployeeCardFormViewModel.Patronymic.Value := Patronymic;
    EmployeeCardFormViewModel.BirthDate.Value := BirthDate;
    EmployeeCardFormViewModel.Speciality.Value := Speciality;

  end;
  
end;

procedure TEmployeeCardFormViewModelMapper.
  FillEmployeeCardFormViewModelFrom(
    EmployeeCardFormViewModel: TEmployeeCardFormViewModel;
    const EmployeeDto: TEmployeeDto;
    const Specialities: TStrings
  );
begin

  EmployeeCardFormViewModel.Name.Value := EmployeeDto.Name;
  EmployeeCardFormViewModel.Surname.Value := EmployeeDto.Surname;
  EmployeeCardFormViewModel.Patronymic.Value := EmployeeDto.Patronymic;
  EmployeeCardFormViewModel.BirthDate.Value := EmployeeDto.BirthDate;
  EmployeeCardFormViewModel.Speciality.Value := EmployeeDto.Speciality;

  EmployeeCardFormViewModel.Specialities.Assign(Specialities);
    
end;

function TEmployeeCardFormViewModelMapper.
  GetCardFormViewModelClass: TCardFormViewModelClass;
begin

  Result := TEmployeeCardFormViewModel;
  
end;

function TEmployeeCardFormViewModelMapper.
  MapEmployeeCardFormViewModelFrom(
    EmployeeReferenceRecordViewModel: TEmployeesReferenceRecordViewModel;
    const Specialities: TStrings
  ): TEmployeeCardFormViewModel;
begin

  Result :=
    TEmployeeCardFormViewModel(
      MapCardFormViewModelFrom(EmployeeReferenceRecordViewModel)
    );

  Result.Specialities.Assign(Specialities);
  
end;

function TEmployeeCardFormViewModelMapper.
  MapEmployeeCardFormViewModelFrom(
    const EmployeeDto: TEmployeeDto;
    const Specialities: TStrings
  ): TEmployeeCardFormViewModel;
begin

  Result := TEmployeeCardFormViewModel.Create;

  FillEmployeeCardFormViewModelFrom(
    Result, EmployeeDto, Specialities
  );
  
end;

end.
