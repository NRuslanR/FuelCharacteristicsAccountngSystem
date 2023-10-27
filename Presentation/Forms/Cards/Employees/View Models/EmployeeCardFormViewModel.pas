unit EmployeeCardFormViewModel;

interface

uses

  CardFormViewModel,
  SysUtils,
  Classes;

type
  
  TEmployeeCardFormViewModel = class (TCardFormViewModel)

    protected

      FName: TCardFormViewModelProperty;
      FSurname: TCardFormViewModelProperty;
      FPatronymic: TCardFormViewModelProperty;
      FBirthDate: TCardFormViewModelProperty;
      FSpeciality: TCardFormViewModelProperty;
      FSpecialities: TStrings;

      procedure RestoreProperties; override;

    public

      destructor Destroy; override;
      constructor Create; override;

      function Clone: TObject; override;
      procedure CopyFrom(OtherCardFormViewModel: TCardFormViewModel); override;

    published

      property Name: TCardFormViewModelProperty read FName;
      property Surname: TCardFormViewModelProperty read FSurname;
      property Patronymic: TCardFormViewModelProperty read FPatronymic;
      property BirthDate: TCardFormViewModelProperty read FBirthDate;
      property Speciality: TCardFormViewModelProperty read FSpeciality;
      property Specialities: TStrings read FSpecialities;
      
  end;

implementation

uses

  Variants;
  
{ TEmployeeCardFormViewModel }

function TEmployeeCardFormViewModel.Clone: TObject;
var ClonedViewModel: TEmployeeCardFormViewModel;
begin

  ClonedViewModel := TEmployeeCardFormViewModel(inherited Clone);
  
  ClonedViewModel.Specialities.Assign(Specialities);

  Result := ClonedViewModel;
  
end;

procedure TEmployeeCardFormViewModel.CopyFrom(
  OtherCardFormViewModel: TCardFormViewModel);
var Other: TEmployeeCardFormViewModel;
begin

  if not (OtherCardFormViewModel is TEmployeeCardFormViewModel) then
    Exit;

  inherited;

  Other := TEmployeeCardFormViewModel(OtherCardFormViewModel);

  Specialities.Assign(Other.Specialities);
  
end;

constructor TEmployeeCardFormViewModel.Create;
begin

  inherited;

  FName := AddProperty('Name');
  FSurname := AddProperty('Surname');
  FPatronymic := AddProperty('Patronymic');
  FBirthDate := AddProperty('BirthDate');
  FSpeciality := AddProperty('Speciality');

  FSpecialities := TStringList.Create;
  
end;

destructor TEmployeeCardFormViewModel.Destroy;
begin

  FreeAndNil(FSpecialities);
  
  inherited;

end;

procedure TEmployeeCardFormViewModel.RestoreProperties;
begin

  inherited;

  FName := FindProperty('Name');
  FSurname := FindProperty('Surname');
  FPatronymic := FindProperty('Patronymic');
  FBirthDate := FindProperty('BirthDate');
  FSpeciality := FindProperty('Speciality');

end;

end.
