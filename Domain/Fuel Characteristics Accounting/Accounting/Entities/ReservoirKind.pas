unit ReservoirKind;

interface

uses

  unIReservoirKind,
  DomainObjectUnit,
  DomainException,
  DomainObjectListUnit,
  EmployeeReservoirKindWorkingRules,
  Employee,
  SysUtils,
  Classes;

type

  TReservoirKindException = class (TDomainException)

  end;
  
  TReservoirKind = class (TDomainObject, IReservoirKind)

    private

      FEditingEmployee: TEmployee;

      FWorkingRules: TEmployeeReservoirKindWorkingRules;
      
    private
    
      function GetName: String;
      procedure SetName(const Value: String);

      function GetEditingEmployee: TEmployee;
      procedure SetEditingEmployee(Value: TEmployee);
      
      procedure SetWorkingRules(const Value: TEmployeeReservoirKindWorkingRules);
      
    private

      procedure RaiseExceptionIfWorkingRulesNotAssigned;
      procedure RaiseExceptionIfEditingEmployeeNotAssigned;
      procedure RaiseExceptionIfEmployeeNotAllowedEdit(Employee: TEmployee);
      
    protected

      procedure RaiseExceptionIfIdentityIsNotValid(
        const Value: Variant
      ); override;

    public

      function GetSelf: TObject;

      property EditingEmployee: TEmployee
      read GetEditingEmployee write SetEditingEmployee;
      
    published

      property Name: String read GetName write SetName;

      property WorkingRules: TEmployeeReservoirKindWorkingRules
      read FWorkingRules write SetWorkingRules;

  end;

  TReservoirKinds = class;

  TReservoirKindsEnumerator = class (TDomainObjectListEnumerator)

    private

      function GetCurrentReservoirKind:
        TReservoirKind;

    public

      constructor Create(
        ReservoirKinds: TReservoirKinds
      );

      property Current: TReservoirKind
      read GetCurrentReservoirKind;
      
  end;

  TReservoirKinds = class (TDomainObjectList)

    private
    
      function GetReservoirKindByIndex(
        Index: Integer): TReservoirKind;
      procedure SetReservoirKindByIndex(Index: Integer;
        const Value: TReservoirKind);
    
    public

      procedure Add(
        ReservoirKind: TReservoirKind
      );

      procedure Remove(
        ReservoirKind: TReservoirKind
      );

      function FindByIdentity(
        const Identity: Variant
      ): TReservoirKind;

      function GetEnumerator: TReservoirKindsEnumerator;

      property Items[Index: Integer]: TReservoirKind
      read GetReservoirKindByIndex
      write SetReservoirKindByIndex;
      
  end;

implementation

uses

  Variants;


{ TReservoirKind }

function TReservoirKind.GetEditingEmployee: TEmployee;
begin

  Result := FEditingEmployee;
  
end;

function TReservoirKind.GetName: String;
begin

  Result := Identity;
  
end;

function TReservoirKind.GetSelf: TObject;
begin

  Result := Self;
  
end;

procedure TReservoirKind.RaiseExceptionIfEditingEmployeeNotAssigned;
begin

  if not InvariantsComplianceRequested then
    Exit;
    
  if not Assigned(FEditingEmployee) then begin

    raise TReservoirKindException.Create(
      'Программная ошибка. Для работы с ' +
      'типом резервуаров не назначен ' +
      'сотрудник'
    );
    
  end;

end;

procedure TReservoirKind.RaiseExceptionIfEmployeeNotAllowedEdit(
  Employee: TEmployee);
begin

  if not Assigned(Employee) then begin

    raise TReservoirKindException.Create(
      'Программная ошибка. Попытка ' +
      'назначить неизвестного сотрудника ' +
      'для работы с типом резервуаров'
    );
    
  end;

  if not InvariantsComplianceRequested then
    Exit;

  RaiseExceptionIfWorkingRulesNotAssigned;

  FWorkingRules
    .ReservoirKindEditingRule
      .EnsureEmployeeMayEditReservoirKind(
        Employee, Self
      );
      
end;

procedure TReservoirKind.RaiseExceptionIfIdentityIsNotValid(
  const Value: Variant);
begin

  inherited;

  if not VarIsType(Value, varString) then begin

    raise TReservoirKindException.Create(
      'Некорректный тип идентификатора для ' +
      'типа резервуаров'
    );

  end;

end;

procedure TReservoirKind.RaiseExceptionIfWorkingRulesNotAssigned;
begin

  if not InvariantsComplianceRequested then
    Exit;

  if not Assigned(FWorkingRules) then begin

    raise TReservoirKindException.Create(
      'Программная ошибка. Правила работы ' +
      'с типами резервуаров не установлены'
    );
    
  end;

end;

procedure TReservoirKind.SetEditingEmployee(Value: TEmployee);
begin

  RaiseExceptionIfEmployeeNotAllowedEdit(Value);

  FEditingEmployee := Value;
  
end;

procedure TReservoirKind.SetName(const Value: String);
begin

  RaiseExceptionIfEditingEmployeeNotAssigned;
  
  Identity := Value;
  
end;

procedure TReservoirKind.SetWorkingRules(
  const Value: TEmployeeReservoirKindWorkingRules);
begin

  if FWorkingRules = Value then
    Exit;

  if not Assigned(Value) then begin

    raise TReservoirKindException.Create(
      'Программная ошибка. Правила работы ' +
      'с типами резервуаров не установлены'
    );
    
  end;

  FWorkingRules := Value;

end;

{ TReservoirKinds }

procedure TReservoirKinds.Add(
  ReservoirKind: TReservoirKind);
begin

  AddDomainObject(ReservoirKind);
  
end;

function TReservoirKinds.FindByIdentity(
  const Identity: Variant): TReservoirKind;
begin

  Result := inherited FindByIdentity(Identity) as TReservoirKind;

end;

function TReservoirKinds.GetEnumerator:
  TReservoirKindsEnumerator;
begin

  Result := TReservoirKindsEnumerator.Create(Self);
  
end;

function TReservoirKinds.GetReservoirKindByIndex(
  Index: Integer): TReservoirKind;
begin

  Result := GetDomainObjectByIndex(Index) as TReservoirKind;

end;

procedure TReservoirKinds.Remove(
  ReservoirKind: TReservoirKind);
begin

  DeleteDomainObject(ReservoirKind);

end;

procedure TReservoirKinds.SetReservoirKindByIndex(
  Index: Integer; const Value: TReservoirKind);
begin

  SetDomainObjectByIndex(Index, Value);
  
end;

{ TReservoirKindsEnumerator }

constructor TReservoirKindsEnumerator.Create(
  ReservoirKinds: TReservoirKinds);
begin

  inherited Create(ReservoirKinds);
  
end;

function TReservoirKindsEnumerator.
  GetCurrentReservoirKind: TReservoirKind;
begin

  Result := GetCurrentDomainObject as TReservoirKind;

end;

end.
