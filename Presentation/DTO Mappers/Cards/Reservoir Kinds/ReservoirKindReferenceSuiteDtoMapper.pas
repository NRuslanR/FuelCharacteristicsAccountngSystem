unit ReservoirKindReferenceSuiteDtoMapper;

interface

uses

  CardFormViewModel,
  EntityDto,
  EntityDtoMapper,
  ReservoirKindReferenceSuiteCardFormViewModel,
  ReservoirKindReferenceSuiteDto,
  SysUtils,
  Classes;

type

  TReservoirKindReferenceSuiteDtoMapper = class (TEntityDtoMapper)

    protected

      function GetEntityDtoClass: TEntityDtoClass; override;

      procedure FillEntityDtoFrom(
        EntityDto: TEntityDto;
        CardFormViewModel: TCardFormViewModel
      ); override;

    public

      function MapReservoirKindReferenceSuiteDtoFrom(

        ReservoirKindReferenceSuiteCardFormViewModel:
          TReservoirKindReferenceSuiteCardFormViewModel
          
      ): TReservoirKindReferenceSuiteDto;

  end;
  
implementation

{ TReservoirKindReferenceSuiteDtoMapper }

procedure TReservoirKindReferenceSuiteDtoMapper.FillEntityDtoFrom(
  EntityDto: TEntityDto;
  CardFormViewModel: TCardFormViewModel
);
var ReferenceSuiteDto: TReservoirKindReferenceSuiteDto;
begin

  inherited;

  ReferenceSuiteDto := TReservoirKindReferenceSuiteDto(EntityDto);

  with CardFormViewModel as TReservoirKindReferenceSuiteCardFormViewModel
  do begin

    ReferenceSuiteDto.ReservoirKindName := ReservoirKindName.Value;
    ReferenceSuiteDto.AltitudinalConstantStencil := HSCValue.Value;
    ReferenceSuiteDto.CalibrationChartLocation := CalibrationChartLocation.Value;
    
  end;
  
end;

function TReservoirKindReferenceSuiteDtoMapper.
  GetEntityDtoClass: TEntityDtoClass;
begin

  Result := TReservoirKindReferenceSuiteDto;
  
end;

function TReservoirKindReferenceSuiteDtoMapper.
  MapReservoirKindReferenceSuiteDtoFrom(

    ReservoirKindReferenceSuiteCardFormViewModel:
      TReservoirKindReferenceSuiteCardFormViewModel

  ): TReservoirKindReferenceSuiteDto;
begin

  Result :=
    TReservoirKindReferenceSuiteDto(
      MapEntityDtoFrom(ReservoirKindReferenceSuiteCardFormViewModel)
    );
    
end;

end.
