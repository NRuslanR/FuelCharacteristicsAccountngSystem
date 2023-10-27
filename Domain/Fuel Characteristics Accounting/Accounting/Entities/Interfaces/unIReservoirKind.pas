unit unIReservoirKind;

interface

uses

  IGetSelfUnit,
  Employee;
  
type

  IReservoirKind = interface (IGetSelf)

    function GetName: String;
    procedure SetName(const Value: String);

    function GetEditingEmployee: TEmployee;
    procedure SetEditingEmployee(Value: TEmployee);
    
    property Name: String read GetName write SetName;

    property EditingEmployee: TEmployee
    read GetEditingEmployee write SetEditingEmployee;

  end;

  
implementation

end.
