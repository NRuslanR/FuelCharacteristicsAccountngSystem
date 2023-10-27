unit ReservoirKindMapper;

interface

uses

  ReservoirKind,
  ReservoirKindDto,
  SysUtils;

type

  TReservoirKindMapper = class

    public

      function ToDto(ReservoirKind: TReservoirKind): TReservoirKindDto;
      
  end;

implementation

{ TReservoirKindMapper }

function TReservoirKindMapper.ToDto(
  ReservoirKind: TReservoirKind): TReservoirKindDto;
begin

  Result := TReservoirKindDto.Create;

  try

    Result.Name := ReservoirKind.Name;
    
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;

    end;

  end;

end;

end.
