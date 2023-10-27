unit EmployeeAdministrationCardFormViewModel;

interface

uses

  CardFormViewModel,
  EmployeeCardFormViewModel,
  SysUtils,
  Classes;

type

  TRoleViewModel = class

    private

      FId: Variant;
      FName: String;
      
      procedure SetId(const Value: Variant);
      procedure SetName(const Value: String);

    public

      constructor Create; overload;
      
      constructor Create(
        const Id: Variant;
        const Name: String
      ); overload;

      property Id: Variant read FId write SetId;
      property Name: String read FName write SetName;

  end;

  TRoleViewModels = class;

  TRoleViewModelsEnumerator = class (TListEnumerator)

    private

      function GetCurrentRoleViewModel: TRoleViewModel;

    public

      constructor Create(RoleViewModels: TRoleViewModels);

      property Current: TRoleViewModel read GetCurrentRoleViewModel;

  end;
  
  TRoleViewModels = class (TList)

    private

      function GetRoleViewModelByIndex(Index: Integer): TRoleViewModel;

      procedure SetRoleViewModelByIndex(
        Index: Integer;
        const Value: TRoleViewModel
      );

    protected

      procedure Notify(Ptr: Pointer; Action: TListNotification); override;

    public

      function Add(RoleViewModel: TRoleViewModel): Integer;
      procedure Remove(RoleViewModel: TRoleViewModel);

      function FindRoleViewModelById(const Id: Variant): TRoleViewModel;
      function FindRoleViewModelByName(const Name: String): TRoleViewModel;

      function FetchRoleNames: TStrings;

      function GetEnumerator: TRoleViewModelsEnumerator;

      property Items[Index: Integer]: TRoleViewModel
      read GetRoleViewModelByIndex write SetRoleViewModelByIndex; default;

  end;

  TEmployeeAdministrationCardFormViewModel = class (TEmployeeCardFormViewModel)

    private

      FCurrentRoleName: TCardFormViewModelProperty;
      FLogin: TCardFormViewModelProperty;
      FPassword: TCardFormViewModelProperty;

      FRoleViewModels: TRoleViewModels;
      
      procedure SetRoleViewModels(const Value: TRoleViewModels);
      function GetCurrentRoleNameValue: String;

      procedure CopyRoleViewModels(OtherRoleViewModels: TRoleViewModels);

    protected

      function IsPropertyModified(
        ViewModelProperty: TCardFormViewModelProperty
      ): Boolean; override;

      procedure RestoreProperties; override;

    public

      destructor Destroy; override;
      constructor Create; override;

      function Clone: TObject; override;
      procedure CopyFrom(OtherCardFormViewModel: TCardFormViewModel); override;
      
    public

      property Login: TCardFormViewModelProperty read FLogin;
      property Password: TCardFormViewModelProperty read FPassword;

      property CurrentRoleName: TCardFormViewModelProperty
      read FCurrentRoleName;

      property RoleViewModels: TRoleViewModels
      read FRoleViewModels write SetRoleViewModels;
      
  end;

implementation

uses

  Variants,
  AuxDebugFunctionsUnit;

{ TEmployeeAdministrationCardFormViewModel }

function TEmployeeAdministrationCardFormViewModel.Clone: TObject;
var ClonedViewModel: TEmployeeAdministrationCardFormViewModel;
    RoleViewModel: TRoleViewModel;
begin

  ClonedViewModel := TEmployeeAdministrationCardFormViewModel(inherited Clone);

  ClonedViewModel.CopyRoleViewModels(RoleViewModels);

  Result := ClonedViewModel;

end;

procedure TEmployeeAdministrationCardFormViewModel.CopyFrom(
  OtherCardFormViewModel: TCardFormViewModel);
var Other: TEmployeeAdministrationCardFormViewModel;
begin

  if not (OtherCardFormViewModel is TEmployeeAdministrationCardFormViewModel)
  then Exit;
  
  inherited;

  Other := TEmployeeAdministrationCardFormViewModel(OtherCardFormViewModel);

  CopyRoleViewModels(Other.RoleViewModels);

end;

procedure TEmployeeAdministrationCardFormViewModel.CopyRoleViewModels(
  OtherRoleViewModels: TRoleViewModels);
var RoleViewModel: TRoleViewModel;
begin

  for RoleViewModel in OtherRoleViewModels do begin

    RoleViewModels.Add(
      TRoleViewModel.Create(RoleViewModel.Id, RoleViewModel.Name)
    );

  end;
  
end;

constructor TEmployeeAdministrationCardFormViewModel.Create;
var I :Integer;
begin

  inherited;

  FLogin := AddProperty('Login');
  FPassword := AddProperty('Password');
  FCurrentRoleName := AddProperty('CurrentRoleName');

  FRoleViewModels := TRoleViewModels.Create;

  FPassword.Value := '';

end;

destructor TEmployeeAdministrationCardFormViewModel.Destroy;
begin

  FreeAndNil(FRoleViewModels);
  
  inherited;

end;

function TEmployeeAdministrationCardFormViewModel.
  GetCurrentRoleNameValue: String;
var CurrentRoleViewModel: TRoleViewModel;
begin

  CurrentRoleViewModel :=
    FRoleViewModels.FindRoleViewModelById(CurrentRoleName.Value);

  if Assigned(CurrentRoleViewModel) then
    Result := CurrentRoleViewModel.Name

  else Result := '';
  
end;

function TEmployeeAdministrationCardFormViewModel.IsPropertyModified(
  ViewModelProperty: TCardFormViewModelProperty): Boolean;
begin

  if FPassword = ViewModelProperty then
    Result := Trim(FPassword.Value) <> ''

  else Result := inherited IsPropertyModified(ViewModelProperty);
  
end;

procedure TEmployeeAdministrationCardFormViewModel.RestoreProperties;
begin

  inherited;

  FLogin := FindProperty('Login');
  FPassword := FindProperty('Password');
  FCurrentRoleName := FindProperty('CurrentRoleName');
  
end;

procedure TEmployeeAdministrationCardFormViewModel.SetRoleViewModels(
  const Value: TRoleViewModels);
begin

  if FRoleViewModels = Value then
    Exit;

  FreeAndNil(FRoleViewModels);

  FRoleViewModels := Value;

end;

{ TRoleViewModel }

constructor TRoleViewModel.Create;
begin

  inherited Create;

  FId := Null;

end;

constructor TRoleViewModel.Create(const Id: Variant; const Name: String);
begin

  inherited Create;

  FId := Id;
  FName := Name;

end;

procedure TRoleViewModel.SetId(const Value: Variant);
begin

  if VarIsEmpty(Value) then
    FId := Null

  else FId := Value;

end;

procedure TRoleViewModel.SetName(const Value: String);
begin

  FName := Value;

end;

{ TRoleViewModelsEnumerator }

constructor TRoleViewModelsEnumerator.Create(RoleViewModels: TRoleViewModels);
begin

  inherited Create(RoleViewModels);

end;

function TRoleViewModelsEnumerator.GetCurrentRoleViewModel: TRoleViewModel;
begin

  Result := TRoleViewModel(GetCurrent);
  
end;

{ TRoleViewModels }

function TRoleViewModels.Add(RoleViewModel: TRoleViewModel): Integer;
begin

  Result := inherited Add(RoleViewModel);
  
end;

function TRoleViewModels.FetchRoleNames: TStrings;
var RoleViewModel: TRoleViewModel;
begin

  Result := TStringList.Create;

  try

    for RoleViewModel in Self do
      Result.Add(RoleViewModel.Name);

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

function TRoleViewModels.FindRoleViewModelById(
  const Id: Variant): TRoleViewModel;
begin

  for Result in Self do
    if Result.Id = Id then
      Exit;

  Result := nil;

end;

function TRoleViewModels.FindRoleViewModelByName(
  const Name: String): TRoleViewModel;
begin

  for Result in Self do
    if Result.Name = Name then
      Exit;

  Result := nil;

end;

function TRoleViewModels.GetEnumerator: TRoleViewModelsEnumerator;
begin

  Result := TRoleViewModelsEnumerator.Create(Self);
  
end;

function TRoleViewModels.GetRoleViewModelByIndex(
  Index: Integer): TRoleViewModel;
begin

  Result := TRoleViewModel(Get(Index));

end;

procedure TRoleViewModels.Notify(Ptr: Pointer; Action: TListNotification);
begin

  inherited;

  if Action = lnDeleted then
    TRoleViewModel(Ptr).Free;

end;

procedure TRoleViewModels.Remove(RoleViewModel: TRoleViewModel);
var Index: Integer;
begin

  if not Assigned(RoleViewModel) then
    Exit;

  Index := IndexOf(RoleViewModel);

  if Index <> -1 then
    Delete(Index);

end;

procedure TRoleViewModels.SetRoleViewModelByIndex(Index: Integer;
  const Value: TRoleViewModel);
begin

  Put(Index, Value);
  
end;


end.
