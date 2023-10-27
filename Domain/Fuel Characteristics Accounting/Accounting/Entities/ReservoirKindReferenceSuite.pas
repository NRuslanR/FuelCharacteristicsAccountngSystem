unit ReservoirKindReferenceSuite;

interface

uses

  Employee,
  DomainObjectUnit,
  DomainException,
  DomainObjectListUnit,
  unIReservoirKindReferenceSuite,
  EmployeeReservoirKindReferenceSuiteWorkingRules,
  SysUtils,
  Classes;

type

  TReservoirKindReferenceSuiteException = class (TDomainException)

  end;
  
  TReservoirKindReferenceSuite = class (TDomainObject, IReservoirKindReferenceSuite)

    private

      FReservoirKindName: String;
      FAltitudinalConstantStencil: Variant;
      FCalibrationChartLocation: Variant;

      FEditingEmployee: TEmployee;

      FWorkingRules: TEmployeeReservoirKindReferenceSuiteWorkingRules;
      
      function GetAltitudinalConstantStencil: Variant;
      function GetCalibrationChartLocation: Variant;
      function GetEditingEmployee: TEmployee;
      function GetReservoirKindName: String;

      procedure SetEditingEmployee(const Value: TEmployee);
      procedure SetAltitudinalConstantStencil(const Value: Variant);
      procedure SetCalibrationChartLocation(const Value: Variant);
      procedure SetReservoirKindName(const Value: String);

      procedure SetWorkingRules(
        const Value: TEmployeeReservoirKindReferenceSuiteWorkingRules
      );

    protected

      function GetIdentity: Variant; override;

    private

      procedure RaiseExceptionIfReservoirKindNameIsNotValid(
        const Value: Variant
      );

      procedure RaiseExceptionIfAltitudinalConstantStencilIsNotValid(
        const Value: Variant
      );

      procedure RaiseExceptionIfCalibrationChartLocationIsNotValid(
        const Value: Variant
      );

      procedure RaiseExceptionIfWorkingRulesNotAssigned;
      procedure RaiseExceptionIfEditingEmployeeNotAssigned;

      procedure RaiseExceptionIfEmployeeNotAllowedEditing(Employee: TEmployee);

    public

      constructor Create; override;

      function GetSelf: TObject;

      property EditingEmployee: TEmployee
      read GetEditingEmployee write SetEditingEmployee;
      
    published

      property ReservoirKindName: String
      read GetReservoirKindName write SetReservoirKindName;

      property AltitudinalConstantStencil: Variant
      read GetAltitudinalConstantStencil write SetAltitudinalConstantStencil;
      
      property CalibrationChartLocation: Variant
      read GetCalibrationChartLocation write SetCalibrationChartLocation;

      property WorkingRules: TEmployeeReservoirKindReferenceSuiteWorkingRules
      read FWorkingRules write SetWorkingRules;
      
  end;

  TReservoirKindReferenceSuites = class;

  TReservoirKindReferenceSuitesEnumerator = class (TDomainObjectListEnumerator)

    private

      function GetCurrentReservoirKindReferenceSuite:
        TReservoirKindReferenceSuite;

    public

      constructor Create(
        ReservoirKindReferenceSuites: TReservoirKindReferenceSuites
      );

      property Current: TReservoirKindReferenceSuite
      read GetCurrentReservoirKindReferenceSuite;
      
  end;

  TReservoirKindReferenceSuites = class (TDomainObjectList)

    private
    
      function GetReservoirKindReferenceSuiteByIndex(
        Index: Integer): TReservoirKindReferenceSuite;
      procedure SetReservoirKindReferenceSuiteByIndex(Index: Integer;
        const Value: TReservoirKindReferenceSuite);
    
    public

      procedure Add(
        ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
      );

      procedure Remove(
        ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
      );

      function FindByIdentity(
        const Identity: Variant
      ): TReservoirKindReferenceSuite;

      function GetEnumerator: TReservoirKindReferenceSuitesEnumerator;

      property Items[Index: Integer]: TReservoirKindReferenceSuite
      read GetReservoirKindReferenceSuiteByIndex
      write SetReservoirKindReferenceSuiteByIndex;
      
  end;
  
implementation

uses

  Variants;
  
{ TReservoirKindReferenceSuite }

constructor TReservoirKindReferenceSuite.Create;
begin

  inherited;

  FAltitudinalConstantStencil := Null;

end;

function TReservoirKindReferenceSuite.GetAltitudinalConstantStencil: Variant;
begin

  Result := FAltitudinalConstantStencil;
  
end;

function TReservoirKindReferenceSuite.GetCalibrationChartLocation: Variant;
begin

  Result := FCalibrationChartLocation;
  
end;

function TReservoirKindReferenceSuite.GetEditingEmployee: TEmployee;
begin

  Result := FEditingEmployee;
  
end;

function TReservoirKindReferenceSuite.GetIdentity: Variant;
begin

  Result := FReservoirKindName;
  
end;

function TReservoirKindReferenceSuite.GetReservoirKindName: String;
begin

  Result := FReservoirKindName;
  
end;

function TReservoirKindReferenceSuite.GetSelf: TObject;
begin

  Result := Self;
  
end;

procedure TReservoirKindReferenceSuite.
  RaiseExceptionIfAltitudinalConstantStencilIsNotValid(
    const Value: Variant
  );
begin

  if not InvariantsComplianceRequested then
    Exit;

  if not VarIsType(Value, varDouble) then begin

    raise TReservoirKindReferenceSuiteException.Create(
      'Некорректный тип значения ' +
      'высотного трафарета постоянного'
    );
    
  end;

  if Value <= 0 then begin

    raise TReservoirKindReferenceSuiteException.CreateFmt(
      'Значение "%f" некорректно ' +
      'для высотного трафарета фактического',
      [Value]
    );
    
  end;

end;

procedure TReservoirKindReferenceSuite.
  RaiseExceptionIfCalibrationChartLocationIsNotValid(
    const Value: Variant
  );
begin

  if not InvariantsComplianceRequested then
    Exit;
  
end;

procedure TReservoirKindReferenceSuite.RaiseExceptionIfEditingEmployeeNotAssigned;
begin

  if not InvariantsComplianceRequested then
    Exit;
    
  if not Assigned(FEditingEmployee) then begin

    raise TReservoirKindReferenceSuiteException.Create(
      'Программная ошибка. Для ' +
      'внесения изменений в ' +
      'справочные данные типа резервуаров ' +
      'не назначен сотрудник'
    );
    
  end;

end;

procedure TReservoirKindReferenceSuite.RaiseExceptionIfEmployeeNotAllowedEditing(
  Employee: TEmployee);
begin

  if not InvariantsComplianceRequested then
    Exit;
    
  RaiseExceptionIfWorkingRulesNotAssigned;

  FWorkingRules
    .ReservoirKindReferenceSuiteEditingRule
      .EnsureEmployeeMayEditReservoirKindReferenceSuite(
        Employee, Self
      );
  
end;

procedure TReservoirKindReferenceSuite.
  RaiseExceptionIfReservoirKindNameIsNotValid(
    const Value: Variant
  );
begin

  if Trim(Value) = '' then begin

    raise TReservoirKindReferenceSuiteException.Create(
      'Наименование типа ' +
      'резервуаров не задано'
    );

  end;

end;

procedure TReservoirKindReferenceSuite.RaiseExceptionIfWorkingRulesNotAssigned;
begin

  if not InvariantsComplianceRequested then
    Exit;
    
  if not Assigned(FWorkingRules) then begin

    raise TReservoirKindReferenceSuiteException.Create(
      'Программная ошибка. ' +
      'Правила работы со справочными ' +
      'данными типов резервуаров ' +
      'не назначены'
    );
    
  end;

end;

procedure TReservoirKindReferenceSuite.SetAltitudinalConstantStencil(
  const Value: Variant);
begin

  RaiseExceptionIfEditingEmployeeNotAssigned;
  RaiseExceptionIfAltitudinalConstantStencilIsNotValid(Value);
  
  FAltitudinalConstantStencil := Value;

end;

procedure TReservoirKindReferenceSuite.SetCalibrationChartLocation(
  const Value: Variant);
begin

  RaiseExceptionIfEditingEmployeeNotAssigned;
  RaiseExceptionIfCalibrationChartLocationIsNotValid(Value);
  
  FCalibrationChartLocation := Value;

end;

procedure TReservoirKindReferenceSuite.SetEditingEmployee(
  const Value: TEmployee);
begin

  RaiseExceptionIfEmployeeNotAllowedEditing(Value);

  FEditingEmployee := Value;
  
end;

procedure TReservoirKindReferenceSuite.SetReservoirKindName(const Value: String);
begin

  RaiseExceptionIfEditingEmployeeNotAssigned;
  RaiseExceptionIfReservoirKindNameIsNotValid(Value);
  
  FReservoirKindName := Value;
  
end;

procedure TReservoirKindReferenceSuite.SetWorkingRules(
  const Value: TEmployeeReservoirKindReferenceSuiteWorkingRules);
begin

  if FWorkingRules = Value then
    Exit;

  if not Assigned(Value) then begin

    raise TReservoirKindReferenceSuiteException.Create(
      'Программная ошибка. ' +
      'Правила работы со справочными ' +
      'данными типов резервуаров ' +
      'не назначены'
    );

  end;

  FWorkingRules := Value;

end;

{ TReservoirKindReferenceSuites }

procedure TReservoirKindReferenceSuites.Add(
  ReservoirKindReferenceSuite: TReservoirKindReferenceSuite);
begin

  AddDomainObject(ReservoirKindReferenceSuite);
  
end;

function TReservoirKindReferenceSuites.FindByIdentity(
  const Identity: Variant): TReservoirKindReferenceSuite;
begin

  Result := inherited FindByIdentity(Identity) as TReservoirKindReferenceSuite;

end;

function TReservoirKindReferenceSuites.GetEnumerator:
  TReservoirKindReferenceSuitesEnumerator;
begin

  Result := TReservoirKindReferenceSuitesEnumerator.Create(Self);
  
end;

function TReservoirKindReferenceSuites.GetReservoirKindReferenceSuiteByIndex(
  Index: Integer): TReservoirKindReferenceSuite;
begin

  Result := GetDomainObjectByIndex(Index) as TReservoirKindReferenceSuite;

end;

procedure TReservoirKindReferenceSuites.Remove(
  ReservoirKindReferenceSuite: TReservoirKindReferenceSuite);
begin

  DeleteDomainObject(ReservoirKindReferenceSuite);

end;

procedure TReservoirKindReferenceSuites.SetReservoirKindReferenceSuiteByIndex(
  Index: Integer; const Value: TReservoirKindReferenceSuite);
begin

  SetDomainObjectByIndex(Index, Value);
  
end;

{ TReservoirKindReferenceSuitesEnumerator }

constructor TReservoirKindReferenceSuitesEnumerator.Create(
  ReservoirKindReferenceSuites: TReservoirKindReferenceSuites);
begin

  inherited Create(ReservoirKindReferenceSuites);
  
end;

function TReservoirKindReferenceSuitesEnumerator.
  GetCurrentReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
begin

  Result := GetCurrentDomainObject as TReservoirKindReferenceSuite;

end;

end.
