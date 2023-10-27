unit unIWorkingTimeConditions;

interface

uses

  Employee,
  DomainException,
  IDomainObjectUnit;

type

  TWorkingTimeConditionsException = class (TDomainException)

  end;
  
  IWorkingTimeConditions = interface (IDomainObject)

    function GetName: String;
    function GetWorkingDayBeginningTime: TDateTime;
    function GetWorkingDayEndingTime: TDateTime;
    function GetIsActive: Boolean;
    function GetEditingEmployee: TEmployee;

    procedure SetName(const Name: String);
    procedure SetWorkingDayBeginningTime(const Value: TDateTime);
    procedure SetWorkingDayEndingTime(const Value: TDateTime);
    procedure SetIsActive(const Value: Boolean);
    procedure SetEditingEmployee(const Employee: TEmployee);

    procedure SetWorkingDayBeginningAndEndingTime(
      const BeginningTime, EndingTime: TDateTime
    );

    function IsCurrenTimeLessOrEqualWorkingDayTime: Boolean;
    function IsTimeLessOrEqualWorkingDayTime(const Time: TDateTime): Boolean;
      
    property Name: String read GetName write SetName;

    property WorkingDayBeginningTime: TDateTime
    read GetWorkingDayBeginningTime write SetWorkingDayBeginningTime;

    property WorkingDayEndingTime: TDateTime
    read GetWorkingDayEndingTime write SetWorkingDayEndingTime;

    property IsActive: Boolean read GetIsActive write SetIsActive;
    
    property EditingEmployee: TEmployee
    read GetEditingEmployee write SetEditingEmployee;
    
  end;

implementation

end.
