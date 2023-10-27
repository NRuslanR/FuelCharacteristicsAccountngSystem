unit ReservoirSubLayerKindDto;

interface

uses

  SysUtils,
  Classes;

type

  TReservoirSubLayerKindDto = class

    public

      Id: Variant;
      Name: String;

      constructor Create;
      
  end;

  TReservoirSubLayerKindDtos = class;

  TReservoirSubLayerKindDtosEnumerator = class (TListEnumerator)

    private

      function GetCurrentReservoirSubLayerKindDto:
        TReservoirSubLayerKindDto;

    public

      constructor Create(ReservoirSubLayerKindDtos: TReservoirSubLayerKindDtos);

      property Current: TReservoirSubLayerKindDto
      read GetCurrentReservoirSubLayerKindDto;
      
  end;

  TReservoirSubLayerKindDtos = class (TList)

    private

      function GetReservoirSubLayerKindDtoByIndex(
        Index: Integer
      ): TReservoirSubLayerKindDto;

      procedure SetReservoirSubLayerKindDtoByIndex(Index: Integer;
        const Value: TReservoirSubLayerKindDto
      );

    public

      function Add(Dto: TReservoirSubLayerKindDto): Integer;

      function GetEnumerator: TReservoirSubLayerKindDtosEnumerator;

      property Items[Index: Integer]: TReservoirSubLayerKindDto
      read GetReservoirSubLayerKindDtoByIndex
      write SetReservoirSubLayerKindDtoByIndex;
      
  end;

implementation

uses

  Variants;
  
{ TReservoirSubLayerKindDtos }

function TReservoirSubLayerKindDtos.Add(Dto: TReservoirSubLayerKindDto): Integer;
begin

  Result := inherited Add(Dto);

end;

function TReservoirSubLayerKindDtos.
  GetEnumerator: TReservoirSubLayerKindDtosEnumerator;
begin

  Result := TReservoirSubLayerKindDtosEnumerator.Create(Self);
  
end;

function TReservoirSubLayerKindDtos.GetReservoirSubLayerKindDtoByIndex(
  Index: Integer): TReservoirSubLayerKindDto;
begin

  Result := TReservoirSubLayerKindDto(Get(Index));
  
end;

procedure TReservoirSubLayerKindDtos.SetReservoirSubLayerKindDtoByIndex(
  Index: Integer; const Value: TReservoirSubLayerKindDto);
begin

  Put(Index, Value);
  
end;

{ TReservoirSubLayerKindDtosEnumerator }

constructor TReservoirSubLayerKindDtosEnumerator.Create(
  ReservoirSubLayerKindDtos: TReservoirSubLayerKindDtos);
begin

  inherited Create(ReservoirSubLayerKindDtos);

end;

function TReservoirSubLayerKindDtosEnumerator.
  GetCurrentReservoirSubLayerKindDto: TReservoirSubLayerKindDto;
begin

  Result := TReservoirSubLayerKindDto(GetCurrent);
  
end;

{ TReservoirSubLayerKindDto }

constructor TReservoirSubLayerKindDto.Create;
begin

  inherited;

  Id := Null;
  
end;

end.
