unit WorkingTimeConditions;

interface

uses

  unIWorkingTimeConditions,
  DomainObjectUnit,
  WorkingTimeConditionsRules,
  DomainObjectListUnit,
  Employee,
  SysUtils,
  Classes;

type

  TWorkingTimeConditions = class (TDomainObject, IWorkingTimeConditions)

    private

      FIsActive: Boolean;
      FName: String;
      FWorkingDayBeginningTime: TDateTime;
      FWorkingDayEndingTime: TDateTime;
      
      FEditingEmployee: TEmployee;
      FRules: TWorkingTimeConditionsRules;

    private

      procedure RaiseExceptionIfEditingEmployeeIsNotAssigned;
      procedure RaiseExceptionIfRulesIsNotAssigned;
      procedure RaiseExceptionIfEmployeeIsNotAllowedMakeChanges(Employee: TEmployee);

    private

      procedure RaiseExceptionIfWorkingDayBeginningAndEndingTimeAreNotValid(
        const BeginningTime, EndingTime: TDateTime
      );

    public

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
      procedure SetRules(const Value: TWorkingTimeConditionsRules);
      
      procedure SetWorkingDayBeginningAndEndingTime(
        const BeginningTime, EndingTime: TDateTime
      );

      function IsCurrenTimeLessOrEqualWorkingDayTime: Boolean;
      function IsTimeLessOrEqualWorkingDayTime(const Time: TDateTime): Boolean;

      property EditingEmployee: TEmployee
      read GetEditingEmployee write SetEditingEmployee;

      property Rules: TWorkingTimeConditionsRules
      read FRules write SetRules;

    published

      property Name: String read GetName write SetName;

      property WorkingDayBeginningTime: TDateTime
      read GetWorkingDayBeginningTime write SetWorkingDayBeginningTime;

      property WorkingDayEndingTime: TDateTime
      read GetWorkingDayEndingTime write SetWorkingDayEndingTime;

      property IsActive: Boolean read GetIsActive write SetIsActive;
      
  end;

  TWorkingTimeConditionsClass = class of TWorkingTimeConditions;
  
  TWorkingTimeConditionsList = class;
  
  TWorkingTimeConditionsListEnumerator = class (TDomainObjectListEnumerator)

    private

      function GetCurrentWorkingTimeConditions: TWorkingTimeConditions;

    public

      constructor Create(WorkingTimeConditionsList: TWorkingTimeConditionsList);

      property Current: TWorkingTimeConditions
      read GetCurrentWorkingTimeConditions;
      
  end;

  TWorkingTimeConditionsList = class (TDomainObjectList)

    private

      function GetWorkingTimeConditionsByIndex(
        Index: Integer
      ): TWorkingTimeConditions;

      procedure SetWorkingTimeConditionsByIndex(
        Index: Integer;
        const Value: TWorkingTimeConditions
      );

    public

      procedure InsertWorkingTimeConditions(
        const Index: Integer;
        WorkingTimeConditions: TWorkingTimeConditions
      );

      function First: TWorkingTimeConditions;
      function Last: TWorkingTimeConditions;

      procedure Add(WorkingTimeConditions: TWorkingTimeConditions);

      function Contains(WorkingTimeConditions: TWorkingTimeConditions): Boolean;

      procedure Remove(WorkingTimeConditions: TWorkingTimeConditions); 
      
      function FindByIdentity(const Identity: Variant): TWorkingTimeConditions;

      function GetEnumerator: TWorkingTimeConditionsListEnumerator;

      property Items[Index: Integer]: TWorkingTimeConditions
      read GetWorkingTimeConditionsByIndex
      write SetWorkingTimeConditionsByIndex; default;
      
  end;
  
implementation

uses

  DateUtils;
  
{ TWorkingTimeConditions }

function TWorkingTimeConditions.GetEditingEmployee: TEmployee;
begin

  Result := FEditingEmployee;

end;

function TWorkingTimeConditions.GetIsActive: Boolean;
begin

  Result := FIsActive
  
end;

function TWorkingTimeConditions.GetName: String;
begin

  Result := FName;

end;

function TWorkingTimeConditions.GetWorkingDayBeginningTime: TDateTime;
begin

  Result := FWorkingDayBeginningTime;

end;

function TWorkingTimeConditions.GetWorkingDayEndingTime: TDateTime;
begin

  Result := FWorkingDayEndingTime;
  
end;

function TWorkingTimeConditions.IsCurrenTimeLessOrEqualWorkingDayTime: Boolean;
begin

  Result := TimeOf(Now) <= FWorkingDayEndingTime;
  
end;

function TWorkingTimeConditions.IsTimeLessOrEqualWorkingDayTime(
  const Time: TDateTime
): Boolean;
begin

  Result :=
    (DateOf(Time) = DateOf(Now)) and
    (TimeOf(Time) <= FWorkingDayEndingTime);
    
end;

procedure TWorkingTimeConditions.RaiseExceptionIfEditingEmployeeIsNotAssigned;
begin

  if not InvariantsComplianceRequested then
    Exit;

  if not Assigned(FEditingEmployee) then begin

    raise TWorkingTimeConditionsException.Create(
      'Программная ошибка. Не назначен ' +
      'сотрудник для доступа к ' +
      'информации о режиме рабочего времени'
    );
    
  end;

end;

procedure TWorkingTimeConditions.RaiseExceptionIfEmployeeIsNotAllowedMakeChanges(
  Employee: TEmployee);
begin

  FRules.AccessingRule.EnsureWorkingTimeConditionsMayBeAccessedByEmployee(
    Self, Employee
  );

end;

procedure TWorkingTimeConditions.RaiseExceptionIfRulesIsNotAssigned;
begin

  if not InvariantsComplianceRequested then
    Exit;

  if not Assigned(FRules) then begin

    raise TWorkingTimeConditionsException.Create(
      'Программная ошибка. Для работы с ' +
      'информацией о режиме рабочего времени ' +
      'не установлены правила'
    );
    
  end;

end;

procedure TWorkingTimeConditions.
  RaiseExceptionIfWorkingDayBeginningAndEndingTimeAreNotValid(
    const BeginningTime, EndingTime: TDateTime
  );
begin

  if not InvariantsComplianceRequested then
    Exit;

  if DateOf(BeginningTime) <> DateOf(EndingTime) then begin

    raise TWorkingTimeConditionsException.Create(
      'Время начала и время окончания ' +
      'рабочего дня принадлежат ' +
      'разным датам'
    );

  end;

  if BeginningTime > EndingTime then begin

    raise TWorkingTimeConditionsException.CreateFmt(
      'Время начала "%s" превышает ' +
      'время окончания "%s" рабочего дня',
      [
        TimeToStr(BeginningTime),
        TimeToStr(EndingTime)
      ]
    );
    
  end;

end;

procedure TWorkingTimeConditions.SetEditingEmployee(const Employee: TEmployee);
begin

  RaiseExceptionIfRulesIsNotAssigned;
  RaiseExceptionIfEmployeeIsNotAllowedMakeChanges(Employee);

  FEditingEmployee := Employee;
  
end;

procedure TWorkingTimeConditions.SetIsActive(const Value: Boolean);
begin

  RaiseExceptionIfEditingEmployeeIsNotAssigned;

  FIsActive := Value;
  
end;

procedure TWorkingTimeConditions.SetName(const Name: String);
begin

  RaiseExceptionIfEditingEmployeeIsNotAssigned;

  FName := Name;
  
end;

procedure TWorkingTimeConditions.SetRules(
  const Value: TWorkingTimeConditionsRules);
begin

  if not Assigned(Value) then begin

    raise TWorkingTimeConditionsException.Create(
      'Программная ошибка. Попытка назначить ' +
      'недействительные правила для работы ' +
      'с информацией о режиме рабочего времени'
    );

  end;

  FRules := Value;
  
end;

procedure TWorkingTimeConditions.SetWorkingDayBeginningAndEndingTime(
  const BeginningTime, EndingTime: TDateTime
);
begin

  RaiseExceptionIfEditingEmployeeIsNotAssigned;
  
  RaiseExceptionIfWorkingDayBeginningAndEndingTimeAreNotValid(
    BeginningTime, EndingTime
  );

  FWorkingDayBeginningTime := BeginningTime;
  FWorkingDayEndingTime := EndingTime;
  
end;

procedure TWorkingTimeConditions.SetWorkingDayBeginningTime(
  const Value: TDateTime);
begin

  RaiseExceptionIfEditingEmployeeIsNotAssigned;

  RaiseExceptionIfWorkingDayBeginningAndEndingTimeAreNotValid(
    Value, FWorkingDayEndingTime
  );

  FWorkingDayBeginningTime := Value;
  
end;

procedure TWorkingTimeConditions.SetWorkingDayEndingTime(
  const Value: TDateTime);
begin

  RaiseExceptionIfEditingEmployeeIsNotAssigned;

  RaiseExceptionIfWorkingDayBeginningAndEndingTimeAreNotValid(
    FWorkingDayBeginningTime, Value
  );
  
  FWorkingDayEndingTime := Value;
  
end;

{ TWorkingTimeConditionsListEnumerator }

constructor TWorkingTimeConditionsListEnumerator.Create(
  WorkingTimeConditionsList: TWorkingTimeConditionsList);
begin

  inherited Create(WorkingTimeConditionsList);
  
end;

function TWorkingTimeConditionsListEnumerator.
  GetCurrentWorkingTimeConditions: TWorkingTimeConditions;
begin

  Result := TWorkingTimeConditions(GetCurrentDomainObject);
  
end;

{ TWorkingTimeConditionsList }

procedure TWorkingTimeConditionsList.Add(
  WorkingTimeConditions: TWorkingTimeConditions);
begin

  AddDomainObject(WorkingTimeConditions);
  
end;

function TWorkingTimeConditionsList.Contains(
  WorkingTimeConditions: TWorkingTimeConditions): Boolean;
begin

  Result := inherited Contains(WorkingTimeConditions);
  
end;

function TWorkingTimeConditionsList.FindByIdentity(
  const Identity: Variant): TWorkingTimeConditions;
begin

  Result := TWorkingTimeConditions(inherited FindByIdentity(Identity));
  
end;

function TWorkingTimeConditionsList.First: TWorkingTimeConditions;
begin

  Result := TWorkingTimeConditions(inherited First);
  
end;

function TWorkingTimeConditionsList.
  GetEnumerator: TWorkingTimeConditionsListEnumerator;
begin

  Result := TWorkingTimeConditionsListEnumerator.Create(Self);

end;

function TWorkingTimeConditionsList.GetWorkingTimeConditionsByIndex(
  Index: Integer): TWorkingTimeConditions;
begin

  Result := TWorkingTimeConditions(GetDomainObjectByIndex(Index));

end;

procedure TWorkingTimeConditionsList.InsertWorkingTimeConditions(
  const Index: Integer;
  WorkingTimeConditions: TWorkingTimeConditions
);
begin

  InsertDomainObject(Index, WorkingTimeConditions);
  
end;

function TWorkingTimeConditionsList.Last: TWorkingTimeConditions;
begin

  Result := TWorkingTimeConditions(inherited Last);
  
end;

procedure TWorkingTimeConditionsList.Remove(
  WorkingTimeConditions: TWorkingTimeConditions);
begin

  DeleteDomainObject(WorkingTimeConditions);
  
end;

procedure TWorkingTimeConditionsList.SetWorkingTimeConditionsByIndex(
  Index: Integer; const Value: TWorkingTimeConditions);
begin

  SetDomainObjectByIndex(Index, Value);
  
end;

end.
