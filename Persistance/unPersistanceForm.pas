unit unPersistanceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RoleRepository, RolePostgresRepository, ZAbstractConnection, ZConnection,
  EmployeeRepository, EmployeePostgresRepository, Role, Employee,
  FuelCharacteristicsCalculationCardDirectory;

type
  TRepositoryTestForm = class(TForm)
    TestRoleRepositoryButton: TButton;
    Connection: TZConnection;
    TestEmployeeRepositoryButton: TButton;
    Button1: TButton;
    procedure TestRoleRepositoryButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TestEmployeeRepositoryButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private

    procedure InitializeRepositoryRegistry;

    procedure TestRoleRepository;
    procedure TestEmployeeRepository;
    
  public
    { Public declarations }
  end;

var
  RepositoryTestForm: TRepositoryTestForm;

implementation

uses

  ZDataset,
  IDomainObjectUnit,
  QueryExecutor,
  DateUtils,
  VariantListUnit,
  AuxDebugFunctionsUnit,
  ZQueryExecutor,
  FuelCharacteristicsCalculationCard,
  StandardEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry,
  FuelCharacteristicsAccountingRepositoryRegistry,
  StandardFuelCharacteristicsAccountingRepositoryRegistry,
  FuelCharacteristicsCalculationCardRepository,
  BasedOnRepositoryFuelCharacteristicsCalculationCardDirectory,
  FuelCharacteristicsCalculationCardPostgresRepository;

{$R *.dfm}

procedure TRepositoryTestForm.Button1Click(Sender: TObject);
var CardRepo: IFuelCharacteristicsCalculationCardRepository;
    Card: TFuelCharacteristicsCalculationCard;
    Cards: TFuelCharacteristicsCalculationCards;
    Identities: TVariantList;
    FreeCard: IDomainObject;
    Performer: TEmployee;
    Role: TRole;

    procedure ShowCardInfo(TestCard: TFuelCharacteristicsCalculationCard);
    begin

      DebugOutput(
        Format(
          'Id: %s' + sLineBreak +
          'Fuel Kind: %s' + sLineBreak +
          'Reservoir Number: %d',
          [
            VarToStr(TestCard.Identity),
            TestCard.FuelKind,
            TestCard.ReservoirNumber
          ]
        )
      );
    
    end;
begin

  CardRepo :=
    TFuelCharacteristicsAccountingRepositoryRegistry
      .Current
      .GetFuelCharacteristicsCalculationCardRepository;

  Cards := CardRepo.LoadAllFuelCharacteristicsCalculationCards;

  if Assigned(Cards) then
    CardRepo.RemoveFuelCharacteristicsCalculationCards(Cards);
    
  Role := TRole.Create;

  Role.Name := 'WarehouseHead';
  
  Performer := TEmployee.Create(21);
  Performer.Role := Role;
  
  Card := TFuelCharacteristicsCalculationCard.Create;

  FreeCard := Card;
  
  Card.WorkingRules :=
    TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry
      .Current
      .GetEmployeeFuelCharacteristicsCalculationCardWorkingRules;

  Card.FuelCharacteristicsInfoEditingEmployee := Performer;
  Card.CalculationContextInfoEditingEmployee := Performer;
  
  Card.FuelTemperature := 20.435;
  Card.FuelDensity := 650.765;
  Card.FuelRiseLevel := 350.355;
  Card.FuelVolume := 434.543;
  Card.FuelKind := 'Нефть';
  Card.ReservoirNumber := 5;
  Card.PerformedCalculationEmployeeId := 21;
  Card.CalculationPerformingDateTime := Now;

  CardRepo.AddFuelCharacteristicsCalculationCard(Card);

  Cards := CardRepo.LoadAllFuelCharacteristicsCalculationCards;

  for Card in Cards do begin

    ShowCardInfo(Card);

  end;

  Card :=
    CardRepo.FindFuelCharacteristicsCalculationCardByIdentity(
      Cards[0].Identity
    );

  FreeCard := Card;
  
  ShowCardInfo(Card);

  Card.WorkingRules :=
    TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry
      .Current
      .GetEmployeeFuelCharacteristicsCalculationCardWorkingRules;
      
  Card.FuelCharacteristicsInfoEditingEmployee := Performer;
  Card.FuelKind := 'Плазма';
  Card.ReservoirNumber := 27;

  CardRepo.UpdateFuelCharacteristicsCalculationCard(Card);

  Card :=
    CardRepo.FindFuelCharacteristicsCalculationCardByIdentity(Card.Identity);

  FreeCard := Card;
  
  ShowCardInfo(Card);

  CardRepo.RemoveFuelCharacteristicsCalculationCard(Card);

  Card :=
    CardRepo.FindFuelCharacteristicsCalculationCardByIdentity(Card.Identity);

  if not Assigned(Card) then
    DebugOutput('Card is removed');

  Cards := TFuelCharacteristicsCalculationCards.Create;

  Card := TFuelCharacteristicsCalculationCard.Create;

  FreeCard := Card;
  
  Card.WorkingRules :=
    TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry
      .Current
      .GetEmployeeFuelCharacteristicsCalculationCardWorkingRules;

  Card.FuelCharacteristicsInfoEditingEmployee := Performer;
  Card.CalculationContextInfoEditingEmployee := Performer;

  Card.FuelTemperature := 20.435;
  Card.FuelDensity := 24.765;
  Card.FuelRiseLevel := 11.355;
  Card.FuelVolume := 4544.543;
  Card.FuelKind := 'Нефтепродуктовая жидкость';
  Card.ReservoirNumber := 15;
  Card.PerformedCalculationEmployeeId := 21;
  Card.CalculationPerformingDateTime := EncodeDate(2010, 5, 15);

  Cards.Add(Card);

  Card := TFuelCharacteristicsCalculationCard.Create;

  FreeCard := Card;
  
  Card.WorkingRules :=
    TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry
      .Current
      .GetEmployeeFuelCharacteristicsCalculationCardWorkingRules;

  Card.FuelCharacteristicsInfoEditingEmployee := Performer;
  Card.CalculationContextInfoEditingEmployee := Performer;

  Card.FuelTemperature := 230.0;
  Card.FuelDensity := 653.2;
  Card.FuelRiseLevel := 56.34;
  Card.FuelVolume := 87.4;
  Card.FuelKind := 'Нефтепродуктовая жидкость';
  Card.ReservoirNumber := 2;
  Card.PerformedCalculationEmployeeId := 21;
  Card.CalculationPerformingDateTime := EncodeDate(2024, 8, 25);

  Cards.Add(Card);

  CardRepo.AddFuelCharacteristicsCalculationCards(Cards);

  Cards := CardRepo.LoadAllFuelCharacteristicsCalculationCards;

  for Card in Cards do begin

    ShowCardInfo(Card);

    Card.WorkingRules :=
      TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry
        .Current
        .GetEmployeeFuelCharacteristicsCalculationCardWorkingRules;

    Card.FuelCharacteristicsInfoEditingEmployee := Performer;
    Card.CalculationContextInfoEditingEmployee := Performer;

    Card.FuelKind := Card.FuelKind + ' (UPDATED)';

  end;

  CardRepo.UpdateFuelCharacteristicsCalculationCards(Cards);

  Cards := CardRepo.LoadAllFuelCharacteristicsCalculationCards;

  for Card in Cards do begin

    ShowCardInfo(Card);

  end;

  Identities := Cards.CreateDomainObjectIdentityList;

  Cards :=
    CardRepo.FindFuelCharacteristicsCalculationCardsByIdentities(Identities);

  for Card in Cards do begin

    ShowCardInfo(Card);

  end;

  CardRepo.RemoveFuelCharacteristicsCalculationCards(Cards);

  Cards := CardRepo.LoadAllFuelCharacteristicsCalculationCards;

  if not Assigned(Cards) then
    DebugOutput('Cards are removed');
  
end;

procedure TRepositoryTestForm.FormCreate(Sender: TObject);
begin

  InitializeRepositoryRegistry;

end;

procedure TRepositoryTestForm.InitializeRepositoryRegistry;
var QueryExecutor: IQueryExecutor;
begin

  QueryExecutor := TZQueryExecutor.Create(Connection);

  TFuelCharacteristicsAccountingRepositoryRegistry.Current :=
    TFuelCharacteristicsAccountingRepositoryRegistry.Create;

  TFuelCharacteristicsAccountingRepositoryRegistry
  .Current
  .RegisterRoleRepository(
    TRolePostgresRepository.Create(
      QueryExecutor
    )
  );

  TFuelCharacteristicsAccountingRepositoryRegistry
  .Current
  .RegisterEmployeeRepository(
    TEmployeePostgresRepository.Create(
      QueryExecutor
    )
  );

  TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
    .RegisterFuelCharacteristicsCalculationCardRepository(
      TFuelCharacteristicsCalculationCardPostgresRepository.Create(
        QueryExecutor
      )
    );

  TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry
    .Current
    .RegisterStandardEmployeeFuelCharacteristicsCalculationCardWorkingRules;
    
end;

procedure TRepositoryTestForm.TestEmployeeRepository;
var EmployeeRepo: IEmployeeRepository;
    Employee: TEmployee;
    Employees: TEmployees;
begin

  EmployeeRepo :=
    TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
    .GetEmployeeRepository;

  Employee := TEmployee.Create;

  Employee.Name := 'TestName';
  Employee.Surname := 'TestSurname';
  Employee.Patronymic := 'TestPatronymic';
  Employee.BirthDate := EncodeDate(1995, 1, 30);
  Employee.Speciality := 'TestSpeciality';
  Employee.Role := TRole.Create(1);

  EmployeeRepo.AddEmployee(Employee);

  DebugOutput('Added employee: ' + VarToStr(Employee.Identity));

  Employees := TEmployees.Create;

  Employee := TEmployee.Create;

  Employee.Name := 'Name1';
  Employee.Surname := 'Surname1';
  Employee.Patronymic := 'Patronymic1';
  Employee.BirthDate := EncodeDate(1987, 4, 23);
  Employee.Speciality := 'Speciality1';
  Employee.Role := TRole.Create(2);

  Employees.Add(Employee);

  Employee := TEmployee.Create;
  
  Employee.Name := 'Name2';
  Employee.Surname := 'Surname2';
  Employee.Patronymic := 'Patronymic2';
  Employee.BirthDate := EncodeDate(1967, 7, 15);
  Employee.Speciality := 'Speciality2';
  Employee.Role := TRole.Create(3);
  
  Employees.Add(Employee);

  EmployeeRepo.AddEmployees(Employees);

  Employees := EmployeeRepo.GetAllEmployees;

  DebugOutput('Added employees:');
  
  for Employee in Employees do
    DebugOutput('Employee id:' + VarToStr(Employee.Identity) + ', name:' + Employee.Name);

  Employee := Employees[0];

  Employee.Name := Employee.Name + ' (UPD)';
  Employee.Surname := Employee.Surname + ' (UPD)';
  Employee.BirthDate := Now;

  EmployeeRepo.UpdateEmployee(Employee);

  Employee := EmployeeRepo.FindEmployeeById(Employee.Identity);

  DebugOutput('Employee name after update: ' + Employee.Name);

  for Employee in Employees do begin

    Employee.Patronymic := Employee.Patronymic + ' (UPD)';
    Employee.Speciality := Employee.Speciality + '(UPD)';
    Employee.Role := TRole.Create(2);
    
  end;

  EmployeeRepo.UpdateEmployees(Employees);

  Employees := EmployeeRepo.FindEmployeesByIds(Employees.CreateDomainObjectIdentityList);

  DebugOutput('Employee patronymics after update many:');

  for Employee in Employees do
    DebugOutput('Employee speciality:' + Employee.Speciality + ', patronymic:' + Employee.Patronymic);

  Employee := Employees[0];

  EmployeeRepo.RemoveEmployee(Employee);

  Employees := EmployeeRepo.GetAllEmployees;

  DebugOutput('Employees after remove one:');

  for Employee in Employees do
    DebugOutput('Employee id:' + VarToStr(Employee.Identity) + ', name:' + Employee.Name);

  EmployeeRepo.RemoveEmployees(Employees);

  Employees := EmployeeRepo.GetAllEmployees;

  if Assigned(Employees) then begin

    DebugOutput('Employees after multiple removes:');

    for Employee in Employees do
      DebugOutput('Employee id:' + VarToStr(Employee.Identity) + ', name:' + Employee.Name);

  end;

end;

procedure TRepositoryTestForm.TestEmployeeRepositoryButtonClick(
  Sender: TObject);
begin

  TestEmployeeRepository;
  
end;

procedure TRepositoryTestForm.TestRoleRepository;
var RoleRepo: IRoleRepository;
    TestRole: TRole;
    FreeTestRole: IDomainObject;
    TestRoles: TRoles;
    LoadedRole: TRole;
    LoadedRoles: TRoles;
    RoleIds: TVariantList;
begin

  RoleRepo :=
    TFuelCharacteristicsAccountingRepositoryRegistry.Current.GetRoleRepository;

  TestRole := TRole.Create;
  TestRole.Name := 'TestRole';
  TestRole.DisplayName := 'Тестовая роль';

  RoleRepo.AddRole(TestRole);

  DebugOutput('Added Role:' + VarToStr(TestRole.Identity));
  
  TestRole := TRole.Create;
  TestRole.Name := 'TestRole1';
  TestRole.DisplayName := 'Тестовая роль 1';

  TestRoles := TRoles.Create;

  TestRoles.Add(TestRole);

  TestRole := TRole.Create;
  TestRole.Name := 'TestRole2';
  TestRole.DisplayName := 'Тестовая роль 2';

  TestRoles.Add(TestRole);

  TestRole := TRole.Create;
  TestRole.Name := 'TestRole3';
  TestRole.DisplayName := 'Тестовая роль 3';

  TestRoles.Add(TestRole);

  RoleRepo.AddRoles(TestRoles);

  for TestRole in TestRoles do
    DebugOutput('Added role from multiple query:' + VarToStr(TestRole.Identity));

  TestRoles[0].Name := 'TestRole1 (UPD)';
  TestRoles[0].DisplayName := 'DisplayName1 (UPD)';

  TestRole := TestRoles[0];

  FreeTestRole := TestRole;
  
  RoleRepo.UpdateRole(TestRole);

  DebugOutput('Role updated');

  TestRoles.Remove(TestRoles[0]);

  TestRoles[0].Name := 'Name2 (UPD)';
  TestRoles[0].DisplayName := 'DisplayName2 (UPD)';

  TestRoles[1].Name := 'Name3 (UPD)';
  TestRoles[1].DisplayName := 'DisplayName3 (UPD)';

  RoleRepo.UpdateRoles(TestRoles);

  DebugOutput('Multiple update done');

  LoadedRoles := RoleRepo.GetAllRoles;

  DebugOutput('Load All:');

  for LoadedRole in LoadedRoles do
    DebugOutput('Loaded role name: ' + LoadedRole.Name);
    
  RoleRepo.RemoveRole(TestRole);

  DebugOutput('Load All after remove one:');

  LoadedRoles := RoleRepo.GetAllRoles;
  
  for LoadedRole in LoadedRoles do
    DebugOutput('Loaded role name: ' + LoadedRole.Name);

  RoleRepo.RemoveRoles(TestRoles);

  DebugOutput('Load All after remove many:');

  LoadedRoles := RoleRepo.GetAllRoles;

  for LoadedRole in LoadedRoles do
    DebugOutput('Loaded role name: ' + LoadedRole.Name);

  TestRole := LoadedRoles[0];

  DebugOutput('Role name:' + TestRole.Name);
  
  TestRole := RoleRepo.FindRoleById(TestRole.Identity);

  DebugOutput('Role name after findrolebyid:' + TestRole.Name);

  RoleIds := LoadedRoles.CreateDomainObjectIdentityList;

  TestRoles := RoleRepo.FindRolesByIds(RoleIds);

  DebugOutput(TestRoles.Equals(LoadedRoles));
  
end;

procedure TRepositoryTestForm.TestRoleRepositoryButtonClick(Sender: TObject);
begin

  TestRoleRepository;
  
end;

end.
