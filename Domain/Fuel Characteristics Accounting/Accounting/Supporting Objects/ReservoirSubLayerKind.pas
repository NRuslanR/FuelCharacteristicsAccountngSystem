unit ReservoirSubLayerKind;

interface

uses

  DomainException,
  DomainObjectValueUnit,
  DomainObjectValueListUnit,
  SysUtils,
  Classes;

const

  ICE_SUB_LAYER_KIND_NAME = 'Лёд';
  BOTTOM_WATER_SUB_LAYER_KIND_NAME = 'Подтоварная вода';
  
type

  TReservoirSubLayerKindException = class (TDomainException)

  end;
  
  TReservoirSubLayerKind = class (TDomainObjectValue)

    private

      FName: String;

      procedure SetName(const Value: String);

    public

      property Name: String read FName write SetName;

  end;

  TReservoirSubLayerKinds = class;

  TReservoirSubLayerKindsEnumerator = class (TDomainObjectValueListEnumerator)

    private
      
      function GetCurrentReservoirSubLayerKind: TReservoirSubLayerKind;

    public

      constructor Create(ReservoirSubLayerKinds: TReservoirSubLayerKinds);

      property Current: TReservoirSubLayerKind
      read GetCurrentReservoirSubLayerKind;
      
  end;
  
  TReservoirSubLayerKinds = class (TDomainObjectValueList)

    private

      function GetReservoirSubLayerKindByIndex(
        Index: Integer
      ): TReservoirSubLayerKind;

      procedure SetReservoirSubLayerKindByIndex(
        Index: Integer;
        const Value: TReservoirSubLayerKind
      );
    
    public

      procedure Insert(
        const Index: Integer;
        ReservoirSubLayerKind: TReservoirSubLayerKind
      );

      function First: TReservoirSubLayerKind;
      function Last: TReservoirSubLayerKind;
      
      procedure Add(ReservoirSubLayerKind: TReservoirSubLayerKind);

      function Contains(ReservoirSubLayerKind: TReservoirSubLayerKind): Boolean;

      procedure Remove(ReservoirSubLayerKind: TReservoirSubLayerKind);

      function GetEnumerator: TReservoirSubLayerKindsEnumerator;

      property Items[Index: Integer]: TReservoirSubLayerKind
      read GetReservoirSubLayerKindByIndex
      write SetReservoirSubLayerKindByIndex; default;

  end;

  TReservoirIce = class (TReservoirSubLayerKind)

    public

      constructor Create; override;

  end;

  TReservoirBottomWater = class (TReservoirSubLayerKind)

    public

      constructor Create; override;
      
  end;
  
implementation

{ TReservoirSubLayerKind }

procedure TReservoirSubLayerKind.SetName(const Value: String);
begin

  if Trim(Value) = '' then begin

    raise TReservoirSubLayerKindException.Create(
      'Недействительное наименование ' +
      'подслойного типа резервуара'
    );

  end;
  
  FName := Value;

end;

{ TReservoirIce }

constructor TReservoirIce.Create;
begin

  inherited;

  Name := ICE_SUB_LAYER_KIND_NAME;
  
end;

{ TReservoirBottomWater }

constructor TReservoirBottomWater.Create;
begin

  inherited;

  Name := BOTTOM_WATER_SUB_LAYER_KIND_NAME;
  
end;

{ TReservoirSubLayerKinds }

procedure TReservoirSubLayerKinds.Add(
  ReservoirSubLayerKind: TReservoirSubLayerKind);
begin

  AddDomainObjectValue(ReservoirSubLayerKind);

end;

function TReservoirSubLayerKinds.Contains(
  ReservoirSubLayerKind: TReservoirSubLayerKind): Boolean;
begin

  Result := inherited Contains(ReservoirSubLayerKind);
  
end;

function TReservoirSubLayerKinds.First: TReservoirSubLayerKind;
begin

  Result := TReservoirSubLayerKind(inherited First);
  
end;

function TReservoirSubLayerKinds.GetEnumerator: TReservoirSubLayerKindsEnumerator;
begin

  Result := TReservoirSubLayerKindsEnumerator.Create(Self);
  
end;

function TReservoirSubLayerKinds.GetReservoirSubLayerKindByIndex(
  Index: Integer): TReservoirSubLayerKind;
begin

  Result := TReservoirSubLayerKind(GetDomainObjectValueByIndex(Index));
  
end;

procedure TReservoirSubLayerKinds.Insert(const Index: Integer;
  ReservoirSubLayerKind: TReservoirSubLayerKind);
begin

  InsertDomainObjectValue(Index, ReservoirSubLayerKind);
  
end;

function TReservoirSubLayerKinds.Last: TReservoirSubLayerKind;
begin

  Result := TReservoirSubLayerKind(inherited Last);
  
end;

procedure TReservoirSubLayerKinds.Remove(
  ReservoirSubLayerKind: TReservoirSubLayerKind);
begin

  DeleteDomainObjectValue(ReservoirSubLayerKind);
  
end;

procedure TReservoirSubLayerKinds.SetReservoirSubLayerKindByIndex(
  Index: Integer; const Value: TReservoirSubLayerKind);
begin

  SetDomainObjectValueByIndex(Index, Value);
  
end;

{ TReservoirSubLayerKindsEnumerator }

constructor TReservoirSubLayerKindsEnumerator.Create(
  ReservoirSubLayerKinds: TReservoirSubLayerKinds);
begin

  inherited Create(ReservoirSubLayerKinds);

end;

function TReservoirSubLayerKindsEnumerator.
  GetCurrentReservoirSubLayerKind: TReservoirSubLayerKind;
begin

  Result := TReservoirSubLayerKind(GetCurrentDomainObjectValue);
  
end;

end.
