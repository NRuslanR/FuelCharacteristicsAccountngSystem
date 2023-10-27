unit EmployeeRepository;

interface

uses

  DomainObjectRepository,
  VariantListUnit,
  Employee;

type

  IEmployeeRepository = interface (IDomainObjectRepository)
    ['{5842D719-5FF8-4BED-B734-B1F3BB6D836C}']

    function AddEmployee(Employee: TEmployee): Boolean;
    function AddEmployees(Employees: TEmployees): Boolean;
    function UpdateEmployee(Employee: TEmployee): Boolean;
    function UpdateEmployees(Employees: TEmployees): Boolean;
    function RemoveEmployee(Employee: TEmployee): Boolean;
    function RemoveEmployees(Employees: TEmployees): Boolean;
    function FindEmployeeById(const EmployeeId: Variant): TEmployee;
    function FindEmployeesByIds(const EmployeeIds: TVariantList): TEmployees;
    function GetAllEmployees: TEmployees;
    
  end;
  
implementation

end.
