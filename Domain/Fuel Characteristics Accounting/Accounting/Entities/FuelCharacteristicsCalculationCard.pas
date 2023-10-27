unit FuelCharacteristicsCalculationCard;

interface

uses

  unIFuelCharacteristicsCalculationCard,
  EmployeeFuelCharacteristicsCalculationCardWorkingRules,
  DomainObjectUnit,
  DomainObjectListUnit,
  DomainException,
  DomainObjectValueUnit,
  Employee,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsException = class (TDomainObjectValueException)

  end;

  TFuelCharacteristics = class (TDomainObjectValue)

    strict private

      FFuelTemperature: Variant;
      FFuelDensity: Variant;
      FFuelRiseLevel: Variant;
      FFuelMass: Variant;
      FFuelKind: String;
      FReservoirNumber: Variant;

      procedure SetFuelDensity(const Value: Variant);
      procedure SetFuelKind(const Value: String);
      procedure SetFuelRiseLevel(const Value: Variant);
      procedure SetFuelTemperature(const Value: Variant);
      procedure SetFuelMass(const Value: Variant);
      procedure SetReservoirNumber(const Value: Variant);

    private

      procedure RaiseExceptionIfFuelKindIsNotValid(const Value: String);
      procedure RaiseExceptionIfFuelRiseLevelIsNotValid(const Value: Variant);
      procedure RaiseExceptionIfFuelTemperatureIsNotValid(const Value: Variant);
      procedure RaiseExceptionIfFuelMassIsNotValid(const Value: Variant);
      procedure RaiseExceptionIfReservoirNumberIsNotValid(const Value: Variant);
      procedure RaiseExceptionIfFuelDensityIsNotValid(const Value: Variant);
      
    public

      constructor Create; override;
      
      property FuelTemperature: Variant
      read FFuelTemperature write SetFuelTemperature;
      
      property FuelDensity: Variant
      read FFuelDensity write SetFuelDensity;
      
      property FuelRiseLevel: Variant
      read FFuelRiseLevel write SetFuelRiseLevel;
      
      property FuelMass: Variant
      read FFuelMass write SetFuelMass;
      
      property FuelKind: String
      read FFuelKind write SetFuelKind;
      
      property ReservoirNumber: Variant
      read FReservoirNumber write SetReservoirNumber;
          
  end;

  TFuelCharacteristicsCalculationContextException = class (TDomainObjectValueException)

  end;

  TFuelCharacteristicsCalculationContext = class (TDomainObjectValue)

    strict private

      FPerformedEmployeeId: Variant;
      FPerformingDateTime: Variant;

      procedure SetPerformedEmployeeId(const Value: Variant);
      procedure SetPerformingDateTime(const Value: Variant);

    strict private

      procedure RaiseExceptionIfPerformedEmployeeIdIsNotValid(
        const Value: Variant
      );

      procedure RaiseExceptionIfPerformingDateTimeIsNotValid(
        const Value: Variant
      );
      
    public

      constructor Create; override;

      property PerformedEmployeeId: Variant
      read FPerformedEmployeeId write SetPerformedEmployeeId;

      property PerformingDateTime: Variant
      read FPerformingDateTime write SetPerformingDateTime;
      
  end;

  TFuelCharacteristicsCalculationCardException = class (TDomainObjectException)
  
  end;

  TFuelCharacteristicsCalculationCard =
    class (TDomainObject, IFuelCharacteristicsCalculationCard)

      strict protected

        FFuelCharacteristics: TFuelCharacteristics;
        FCalculationContext: TFuelCharacteristicsCalculationContext;

        FCalculationContextInfoEditingEmployee: TEmployee;
        FFuelCharacteristicsInfoEditingEmployee: TEmployee;
        
        FWorkingRules: TEmployeeFuelCharacteristicsCalculationCardWorkingRules;
        
        procedure CreateInternals;

      strict protected

        procedure RaiseExceptionIfEmployeeIsNotAllowedChangeCalculationContextInfo(
          Employee: TEmployee
        );

        procedure RaiseExceptionIfEmployeeIsNotAllowedChangeFuelCharacteristicsInfo(
          Employee: TEmployee
        );
        
        procedure RaiseExceptionIfFuelCharacteristicsInfoEditingEmployeeIsNotAssigned;
        procedure RaiseExceptionIfCalculationContextInfoEditingEmployeeIsNotAssigned;
        procedure RaiseExceptionIfWorkingRulesAreNotAssigned;

      strict protected

        procedure SetWorkingRules(
          const Value: TEmployeeFuelCharacteristicsCalculationCardWorkingRules
        ); 

        procedure SetInvariantsComplianceRequested(const Value: Boolean); override;

      public

        destructor Destroy; override;

        constructor Create; override;
        constructor Create(AIdentity: Variant); override;

      public

        function GetFuelDensity: Variant; virtual;
        function GetFuelKind: String; virtual;
        function GetFuelRiseLevel: Variant; virtual;
        function GetFuelTemperature: Variant; virtual;
        function GetFuelMass: Variant; virtual;
        function GetPerformedCalculationEmployeeId: Variant; virtual;
        function GetCalculationPerformingDateTime: Variant; virtual;
        function GetReservoirNumber: Variant; virtual;
      
        procedure SetCalculationPerformingDateTime(const Value: Variant); virtual;
        procedure SetFuelDensity(const Value: Variant); virtual;
        procedure SetFuelKind(const Value: String); virtual;
        procedure SetFuelRiseLevel(const Value: Variant); virtual;
        procedure SetFuelTemperature(const Value: Variant); virtual;
        procedure SetFuelMass(const Value: Variant); virtual;
        procedure SetPerformedCalculationEmployeeId(const Value: Variant); virtual;
        procedure SetReservoirNumber(const Value: Variant); virtual;

      public
    
        function GetCalculationContextInfoEditingEmployee: TEmployee; virtual;
        function GetFuelCharacteristicsInfoEditingEmployee: TEmployee; virtual;
        
        procedure SetCalculationContextInfoEditingEmployee(const Value: TEmployee); virtual;
        procedure SetFuelCharacteristicsInfoEditingEmployee(const Value: TEmployee); virtual;

        function GetSelf: TObject;
        
      public

        property FuelCharacteristicsInfoEditingEmployee: TEmployee
        read GetFuelCharacteristicsInfoEditingEmployee
        write SetFuelCharacteristicsInfoEditingEmployee;

        property CalculationContextInfoEditingEmployee: TEmployee
        read GetCalculationContextInfoEditingEmployee
        write SetCalculationContextInfoEditingEmployee;
        
        property WorkingRules: TEmployeeFuelCharacteristicsCalculationCardWorkingRules
        read FWorkingRules write SetWorkingRules;
        
      published

        property FuelTemperature: Variant
        read GetFuelTemperature write SetFuelTemperature;

        property FuelDensity: Variant
        read GetFuelDensity write SetFuelDensity;
      
        property FuelRiseLevel: Variant
        read GetFuelRiseLevel write SetFuelRiseLevel;
      
        property FuelMass: Variant
        read GetFuelMass write SetFuelMass;
      
        property FuelKind: String
        read GetFuelKind write SetFuelKind;
      
        property ReservoirNumber: Variant
        read GetReservoirNumber write SetReservoirNumber;

      published

        property PerformedCalculationEmployeeId: Variant
        read GetPerformedCalculationEmployeeId write SetPerformedCalculationEmployeeId;

        property CalculationPerformingDateTime: Variant
        read GetCalculationPerformingDateTime write SetCalculationPerformingDateTime;

    end;

    TFuelCharacteristicsCalculationCards = class;

    TFuelCharacteristicsCalculationCardsEnumerator =
      class (TDomainObjectListEnumerator)

        private

          function GetCurrentFuelCharacteristicsCalculationCard:
            TFuelCharacteristicsCalculationCard;

        public

          constructor Create(
            FuelCharacteristicsCalculationCards:
              TFuelCharacteristicsCalculationCards
          );

          property Current: TFuelCharacteristicsCalculationCard
          read GetCurrentFuelCharacteristicsCalculationCard;

      end;
      
    TFuelCharacteristicsCalculationCards = class (TDomainObjectList)

      private

        function GetFuelCharacteristicsCalculationCardByIndex(
          Index: Integer
        ): TFuelCharacteristicsCalculationCard;

        procedure SetFuelCharacteristicsCalculationCardByIndex(
          Index: Integer;
          Value: TFuelCharacteristicsCalculationCard
        );

      public

        procedure Add(Card: TFuelCharacteristicsCalculationCard);
        procedure Remove(Card: TFuelCharacteristicsCalculationCard);
        
        function FindByIdentity(
          const CardIdentity: Variant
        ): TFuelCharacteristicsCalculationCard;

        
        function GetEnumerator: TFuelCharacteristicsCalculationCardsEnumerator;

        property Items[Index: Integer]: TFuelCharacteristicsCalculationCard
        read GetFuelCharacteristicsCalculationCardByIndex
        write SetFuelCharacteristicsCalculationCardByIndex;
        
    end;

    TNewFuelCharacteristicsCalculationCard =
      class (TFuelCharacteristicsCalculationCard)

        public

          constructor CreateFor(
            WorkingRules: TEmployeeFuelCharacteristicsCalculationCardWorkingRules;
            Employee: TEmployee
          );
          
      end;

implementation

uses

  Variants,
  AuxiliaryDateFunctions,
  DateUtils;
  
{ TFuelCharacteristics }

constructor TFuelCharacteristics.Create;
begin

  inherited;

  FFuelTemperature := Null;
  FFuelDensity := Null;
  FFuelRiseLevel := Null;
  FFuelMass := Null;
  FReservoirNumber := Null;
  
end;

procedure TFuelCharacteristics.RaiseExceptionIfFuelDensityIsNotValid(
  const Value: Variant);
begin

  if not InvariantsComplianceRequested then
    Exit;

  if not VarIsType(Value, varDouble) then begin

    raise TFuelCharacteristicsException.Create(
      'Некорректный тип значения плотности топлива'
    );

  end;
  
  if Value <= 0 then begin

    raise TFuelCharacteristicsException.Create(
      'Плотность топлива ' +
      'имеет некорректное значение'
    );
    
  end;

end;

procedure TFuelCharacteristics.RaiseExceptionIfFuelKindIsNotValid(
  const Value: String);
begin

  if not InvariantsComplianceRequested then
    Exit;
    
  if Trim(Value) = '' then begin

    raise TFuelCharacteristicsException.Create(
      'Тип топлива имеет некорректное значение'
    );

  end;
  
end;

procedure TFuelCharacteristics.RaiseExceptionIfFuelRiseLevelIsNotValid(
  const Value: Variant);
begin

  if not InvariantsComplianceRequested then
    Exit;

  if not VarIsType(Value, varDouble) then begin

    raise TFuelCharacteristicsException.Create(
      'Некорректный тип значения ' +
      'уровня взлива топлива'
    );

  end;
    
  if Value <= 0 then begin

    raise TFuelCharacteristicsException.Create(
      'Уровень взлива топлива имеет ' +
      'некорректное значение'
    );
    
  end;

end;

procedure TFuelCharacteristics.RaiseExceptionIfFuelTemperatureIsNotValid(
  const Value: Variant);
begin

  if not InvariantsComplianceRequested then
    Exit;

  if not VarIsType(Value, varDouble) then begin

    raise TFuelCharacteristicsException.Create(
      'Некорректный тип значения температуры топлива'
    );

  end;

end;

procedure TFuelCharacteristics.RaiseExceptionIfFuelMassIsNotValid(
  const Value: Variant);
begin

  if not InvariantsComplianceRequested then
    Exit;

  if not VarIsType(Value, varDouble) then begin

    raise TFuelCharacteristicsException.Create(
      'Некорректный тип значения массы топлива'
    );

  end;

  if Value <= 0 then begin

    raise TFuelCharacteristicsException.Create(
      'Масса топлива имеет ' +
      'некорректное значение'
    );
    
  end;

end;

procedure TFuelCharacteristics.RaiseExceptionIfReservoirNumberIsNotValid(
  const Value: Variant);
begin

  if not InvariantsComplianceRequested then
    Exit;

  if not VarIsType(Value, varInteger) then begin

    raise TFuelCharacteristicsException.Create(
      'Некорректный тип номера резервуара'
    );
    
  end;

  if Value <= 0 then begin

    raise TFuelCharacteristicsException.Create(
      'Номер резервуара топлива имеет ' +
      'некорректное значение'
    );
    
  end;

end;

procedure TFuelCharacteristics.SetFuelDensity(const Value: Variant);
begin

  RaiseExceptionIfFuelDensityIsNotValid(Value);

  FFuelDensity := Value;

end;

procedure TFuelCharacteristics.SetFuelKind(const Value: String);
begin

  RaiseExceptionIfFuelKindIsNotValid(Value);

  FFuelKind := Value;

end;

procedure TFuelCharacteristics.SetFuelRiseLevel(const Value: Variant);
begin

  RaiseExceptionIfFuelRiseLevelIsNotValid(Value);

  FFuelRiseLevel := Value;

end;

procedure TFuelCharacteristics.SetFuelTemperature(const Value: Variant);
begin

  RaiseExceptionIfFuelTemperatureIsNotValid(Value);

  FFuelTemperature := Value;

end;

procedure TFuelCharacteristics.SetFuelMass(const Value: Variant);
begin

  RaiseExceptionIfFuelMassIsNotValid(Value);
  
  FFuelMass := Value;

end;

procedure TFuelCharacteristics.SetReservoirNumber(const Value: Variant);
begin

  RaiseExceptionIfReservoirNumberIsNotValid(Value);
  
  FReservoirNumber := Value;

end;

{ TFuelCharacteristicsCalculationContext }

constructor TFuelCharacteristicsCalculationContext.Create;
begin

  inherited;

  FPerformedEmployeeId := Null;
  FPerformingDateTime := Null;
  
end;

procedure TFuelCharacteristicsCalculationContext.
  RaiseExceptionIfPerformedEmployeeIdIsNotValid(
    const Value: Variant
  );
begin

  if not InvariantsComplianceRequested then
    Exit;
    
  if VarIsNull(Value) or VarIsEmpty(Value) then begin

    raise TFuelCharacteristicsCalculationContextException.Create(
      'Некорректная информация о сотруднике, ' +
      'выполневшем расчёт показателей топлива'
    );
    
  end;

end;

procedure TFuelCharacteristicsCalculationContext.
  RaiseExceptionIfPerformingDateTimeIsNotValid(
    const Value: Variant
  );
begin

  if not InvariantsComplianceRequested then
    Exit;
    
  if not VarIsNull(Value) and not IsDateTimeValid(Value) then begin

    raise TFuelCharacteristicsCalculationContextException.Create(
      'Дата выполнения расчёта ' +
      'показателей топлива не корректна'
    );
    
  end;
  
end;

procedure TFuelCharacteristicsCalculationContext.SetPerformedEmployeeId(
  const Value: Variant);
begin

  RaiseExceptionIfPerformedEmployeeIdIsNotValid(Value);
  
  FPerformedEmployeeId := Value;

end;

procedure TFuelCharacteristicsCalculationContext.SetPerformingDateTime(
  const Value: Variant);
begin

  RaiseExceptionIfPerformingDateTimeIsNotValid(Value);
  
  FPerformingDateTime := Value;

end;

{ TFuelCharacteristicsCalculationCard }

constructor TFuelCharacteristicsCalculationCard.Create(AIdentity: Variant);
begin

  inherited;

  CreateInternals;

end;

constructor TFuelCharacteristicsCalculationCard.Create;
begin

  inherited;

  CreateInternals;

end;

procedure TFuelCharacteristicsCalculationCard.CreateInternals;
begin

  FFuelCharacteristics := TFuelCharacteristics.Create;
  FCalculationContext := TFuelCharacteristicsCalculationContext.Create;
  
end;

destructor TFuelCharacteristicsCalculationCard.Destroy;
begin

  FreeAndNil(FFuelCharacteristics);
  FreeAndNil(FCalculationContext);
  
  inherited;

end;

function TFuelCharacteristicsCalculationCard.
  GetFuelCharacteristicsInfoEditingEmployee: TEmployee;
begin

  Result := FFuelCharacteristicsInfoEditingEmployee;
  
end;

function TFuelCharacteristicsCalculationCard.GetFuelDensity: Variant;
begin

  Result := FFuelCharacteristics.FuelDensity;
  
end;

function TFuelCharacteristicsCalculationCard.GetFuelKind: String;
begin

  Result := FFuelCharacteristics.FuelKind;
  
end;

function TFuelCharacteristicsCalculationCard.GetFuelRiseLevel: Variant;
begin

  Result := FFuelCharacteristics.FuelRiseLevel;
  
end;

function TFuelCharacteristicsCalculationCard.GetFuelTemperature: Variant;
begin

  Result := FFuelCharacteristics.FuelTemperature;
  
end;

function TFuelCharacteristicsCalculationCard.GetFuelMass: Variant;
begin

  Result := FFuelCharacteristics.FuelMass;
  
end;

function TFuelCharacteristicsCalculationCard.GetPerformedCalculationEmployeeId: Variant;
begin

  Result := FCalculationContext.PerformedEmployeeId;
  
end;

function TFuelCharacteristicsCalculationCard.
  GetCalculationContextInfoEditingEmployee: TEmployee;
begin

  Result := FCalculationContextInfoEditingEmployee;
  
end;

function TFuelCharacteristicsCalculationCard.GetCalculationPerformingDateTime: Variant;
begin

  Result := FCalculationContext.PerformingDateTime;
  
end;

function TFuelCharacteristicsCalculationCard.GetReservoirNumber: Variant;
begin

  Result := FFuelCharacteristics.ReservoirNumber;
  
end;

function TFuelCharacteristicsCalculationCard.GetSelf: TObject;
begin

  Result := Self;
  
end;

procedure TFuelCharacteristicsCalculationCard.
  RaiseExceptionIfCalculationContextInfoEditingEmployeeIsNotAssigned;
begin

  if not InvariantsComplianceRequested then
    Exit;
    
  if not Assigned(FCalculationContextInfoEditingEmployee) then begin

    raise TFuelCharacteristicsCalculationCardException.Create(
      'Программная ошибка. Для предоставления ' +
      'возможности внесения изменений в служебную ' +
      'информацию карточки необходимо указать ' +
      'сотрудника'
    );
  
  end;
  
end;

procedure TFuelCharacteristicsCalculationCard.
  RaiseExceptionIfEmployeeIsNotAllowedChangeCalculationContextInfo(
    Employee: TEmployee
  );
begin

  if not InvariantsComplianceRequested then
    Exit;
    
  RaiseExceptionIfWorkingRulesAreNotAssigned;

  FWorkingRules.
    ContextInfoEditingRule.
      EnsureEmployeeMayEditFuelCharacteristicsCalculationCardContextInfo(
        Employee, Self
      );

end;

procedure TFuelCharacteristicsCalculationCard.
  RaiseExceptionIfEmployeeIsNotAllowedChangeFuelCharacteristicsInfo(
    Employee: TEmployee
  );
begin

  if not InvariantsComplianceRequested then
    Exit;
    
  RaiseExceptionIfWorkingRulesAreNotAssigned;

  FWorkingRules.
    FuelInfoEditingRule.
      EnsureEmployeeMayEditFuelCharacteristicsCalculationCardFuelInfo(
        Employee, Self
      );

end;

procedure TFuelCharacteristicsCalculationCard.
  RaiseExceptionIfFuelCharacteristicsInfoEditingEmployeeIsNotAssigned;
begin

  if not InvariantsComplianceRequested then
    Exit;
    
  if not Assigned(FFuelCharacteristicsInfoEditingEmployee) then begin

    raise TFuelCharacteristicsCalculationCardException.Create(
      'Программная ошибка. Для предоставления ' +
      'возможности внесения изменений в ' +
      'информацию о топливе необходимо указать ' +
      'сотрудника'
    );
    
  end;

end;

procedure TFuelCharacteristicsCalculationCard.
  RaiseExceptionIfWorkingRulesAreNotAssigned;
begin

  if not InvariantsComplianceRequested then
    Exit;
    
  if not Assigned(FWorkingRules) then begin

    raise TFuelCharacteristicsCalculationCardException.Create(
      'Программная ошибка. Для обеспечения ' +
      'возможности работы с карточкой расчёта ' +
      'показателей топлива не указаны ' +
      'рабочие правила.'
    );
    
  end;

end;

procedure TFuelCharacteristicsCalculationCard.SetCalculationContextInfoEditingEmployee(
  const Value: TEmployee);
begin

  RaiseExceptionIfEmployeeIsNotAllowedChangeCalculationContextInfo(Value);

  FCalculationContextInfoEditingEmployee := Value;
  
end;

procedure TFuelCharacteristicsCalculationCard.SetCalculationPerformingDateTime(
  const Value: Variant);
begin

  RaiseExceptionIfCalculationContextInfoEditingEmployeeIsNotAssigned;
  
  FCalculationContext.PerformingDateTime := Value;
  
end;

procedure TFuelCharacteristicsCalculationCard.SetFuelCharacteristicsInfoEditingEmployee(
  const Value: TEmployee);
begin

  RaiseExceptionIfEmployeeIsNotAllowedChangeFuelCharacteristicsInfo(Value);

  FFuelCharacteristicsInfoEditingEmployee := Value;
  
end;

procedure TFuelCharacteristicsCalculationCard.SetFuelDensity(
  const Value: Variant);
begin

  RaiseExceptionIfFuelCharacteristicsInfoEditingEmployeeIsNotAssigned;
  
  FFuelCharacteristics.FuelDensity := Value;
  
end;

procedure TFuelCharacteristicsCalculationCard.SetFuelKind(const Value: String);
begin

  RaiseExceptionIfFuelCharacteristicsInfoEditingEmployeeIsNotAssigned;
  
  FFuelCharacteristics.FuelKind := Value;
  
end;

procedure TFuelCharacteristicsCalculationCard.SetFuelRiseLevel(
  const Value: Variant);
begin

  RaiseExceptionIfFuelCharacteristicsInfoEditingEmployeeIsNotAssigned;
  
  FFuelCharacteristics.FuelRiseLevel := Value;
  
end;

procedure TFuelCharacteristicsCalculationCard.SetFuelTemperature(
  const Value: Variant);
begin

  RaiseExceptionIfFuelCharacteristicsInfoEditingEmployeeIsNotAssigned;
  
  FFuelCharacteristics.FuelTemperature := Value;

end;

procedure TFuelCharacteristicsCalculationCard.SetFuelMass(
  const Value: Variant);
begin

  RaiseExceptionIfFuelCharacteristicsInfoEditingEmployeeIsNotAssigned;
  
  FFuelCharacteristics.FuelMass := Value;
  
end;

procedure TFuelCharacteristicsCalculationCard.SetInvariantsComplianceRequested(
  const Value: Boolean);
begin

  inherited;

  if Assigned(FFuelCharacteristics) then
    FFuelCharacteristics.InvariantsComplianceRequested := Value;

  if Assigned(FCalculationContext) then
    FCalculationContext.InvariantsComplianceRequested := Value;
  
end;

procedure TFuelCharacteristicsCalculationCard.SetPerformedCalculationEmployeeId(
  const Value: Variant);
begin

  RaiseExceptionIfCalculationContextInfoEditingEmployeeIsNotAssigned;
  
  FCalculationContext.PerformedEmployeeId := Value;

end;

procedure TFuelCharacteristicsCalculationCard.SetReservoirNumber(
  const Value: Variant);
begin

  RaiseExceptionIfFuelCharacteristicsInfoEditingEmployeeIsNotAssigned;
  
  FFuelCharacteristics.ReservoirNumber := Value;
  
end;

procedure TFuelCharacteristicsCalculationCard.SetWorkingRules(
  const Value: TEmployeeFuelCharacteristicsCalculationCardWorkingRules);
begin

  if FWorkingRules = Value then
    Exit;

  if not Assigned(Value) then begin

    raise TFuelCharacteristicsCalculationCardException.Create(
      'Программная ошибка. Правила работы ' +
      'с карточкой расчёта показателей топлива ' +
      'не установлены'
    );
    
  end;
  
  FWorkingRules := Value;

end;

{ TNewFuelCharacteristicsCalculationCard }

constructor TNewFuelCharacteristicsCalculationCard.CreateFor(
  WorkingRules: TEmployeeFuelCharacteristicsCalculationCardWorkingRules;
  Employee: TEmployee
);
begin

  inherited Create;

  Self.WorkingRules := WorkingRules;


  FCalculationContext.PerformedEmployeeId := Employee.Identity;
  {
  FCalculationContext.PerformingDateTime := Now;
  }
  
end;

{ TFuelCharacteristicsCalculationCardsEnumerator }

constructor TFuelCharacteristicsCalculationCardsEnumerator.Create(
  FuelCharacteristicsCalculationCards: TFuelCharacteristicsCalculationCards);
begin

  inherited Create(FuelCharacteristicsCalculationCards);
  
end;

function TFuelCharacteristicsCalculationCardsEnumerator.
  GetCurrentFuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
begin

  Result :=  TFuelCharacteristicsCalculationCard(GetCurrentDomainObject);
  
end;

{ TFuelCharacteristicsCalculationCards }

procedure TFuelCharacteristicsCalculationCards.Add(
  Card: TFuelCharacteristicsCalculationCard);
begin

  AddDomainObject(Card);
  
end;

function TFuelCharacteristicsCalculationCards.FindByIdentity(
  const CardIdentity: Variant): TFuelCharacteristicsCalculationCard;
begin

  Result :=
    TFuelCharacteristicsCalculationCard(inherited FindByIdentity(CardIdentity));
  
end;

function TFuelCharacteristicsCalculationCards.
  GetEnumerator: TFuelCharacteristicsCalculationCardsEnumerator;
begin

  Result := TFuelCharacteristicsCalculationCardsEnumerator.Create(Self);
  
end;

function TFuelCharacteristicsCalculationCards.
  GetFuelCharacteristicsCalculationCardByIndex(
    Index: Integer
  ): TFuelCharacteristicsCalculationCard;
begin

  Result := TFuelCharacteristicsCalculationCard(GetDomainObjectByIndex(Index));
  
end;

procedure TFuelCharacteristicsCalculationCards.Remove(
  Card: TFuelCharacteristicsCalculationCard);
begin

  DeleteDomainObject(Card);
  
end;

procedure TFuelCharacteristicsCalculationCards.
  SetFuelCharacteristicsCalculationCardByIndex(
    Index: Integer;
    Value: TFuelCharacteristicsCalculationCard
  );
begin

  SetDomainObjectByIndex(Index, Value);
  
end;

end.
