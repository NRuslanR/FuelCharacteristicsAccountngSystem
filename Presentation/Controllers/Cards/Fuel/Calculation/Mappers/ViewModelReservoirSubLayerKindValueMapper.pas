unit ViewModelReservoirSubLayerKindValueMapper;

interface

uses

  ReservoirSubLayerKindDto,
  FuelCharacteristicsAutomaticCalculationFormViewModel,
  SysUtils,
  Classes;

type

  TViewModelReservoirSubLayerKindValueMapperException = class (Exception)

  end;
  
  TViewModelReservoirSubLayerKindValueMapper = class

    function MapViewModelReservoirSubLayerKindValueFrom(
      ReservoirSubLayerKindDto: TReservoirSubLayerKindDto
    ): TSubLayerKind;

  end;
  
implementation

uses

  AuxVariantFunctions;
  
{ TViewModelReservoirSubLayerKindValueMapper }

function TViewModelReservoirSubLayerKindValueMapper.
  MapViewModelReservoirSubLayerKindValueFrom(
    ReservoirSubLayerKindDto: TReservoirSubLayerKindDto
  ): TSubLayerKind;
begin

  if ReservoirSubLayerKindDto.Id = 1 then
    Result := skBottomWater

  else if ReservoirSubLayerKindDto.Id = 2 then
    Result := skIce

  else begin

    raise TViewModelReservoirSubLayerKindValueMapperException.Create(
      'Программная ошибка. Обнаружен недействительный ' +
      'идентификатор резервуарного подслоя'
    );

  end;
  
end;

end.
