unit FuelCharacteristicsCalculationCardInfoMapper;

interface

uses

  FuelCharacteristicsCalculationCard,
  FuelCharacteristicsCalculationCardInfo,
  FuelCharacteristicsCalculationCardAccessRights,
  FuelCharacteristicsCalculationCardAccessRightsDto,
  FuelCharacteristicsCalculationCardMapper,
  EmployeeRepository,
  SysUtils;

type

  TFuelCharacteristicsCalculationCardInfoMapper = class

    private

      FFuelCharacteristicsCalculationCardMapper:
        TFuelCharacteristicsCalculationCardMapper;

    public

      destructor Destroy; override;
      
      constructor Create(
        EmployeeRepository: IEmployeeRepository
      ); overload;

      constructor Create(
        FuelCharacteristicsCalculationCardMapper:
          TFuelCharacteristicsCalculationCardMapper
      ); overload;

      function MapFuelCharacteristicsCalculationCardInfoFrom(
        FuelCharacteristicsCalculationCard:
          TFuelCharacteristicsCalculationCard;

        FuelCharacteristicsCalculationCardAccessRights:
          TFuelCharacteristicsCalculationCardAccessRights
      ): TFuelCharacteristicsCalculationCardInfo;

      function MapFuelCharacteristicsCalculationCardAccessRightsDtoFrom(

        FuelCharacteristicsCalculationCardAccessRights:
          TFuelCharacteristicsCalculationCardAccessRights

      ): TFuelCharacteristicsCalculationCardAccessRightsDto;

  end;

implementation

{ TFuelCharacteristicsCalculationCardInfoMapper }

constructor TFuelCharacteristicsCalculationCardInfoMapper.Create(
  EmployeeRepository: IEmployeeRepository
);
begin

  inherited Create;

  FFuelCharacteristicsCalculationCardMapper :=
    TFuelCharacteristicsCalculationCardMapper.Create(EmployeeRepository);
    
end;

constructor TFuelCharacteristicsCalculationCardInfoMapper.Create(
  FuelCharacteristicsCalculationCardMapper:
    TFuelCharacteristicsCalculationCardMapper
);
begin

  inherited Create;

  FFuelCharacteristicsCalculationCardMapper :=
    FuelCharacteristicsCalculationCardMapper;
    
end;

destructor TFuelCharacteristicsCalculationCardInfoMapper.Destroy;
begin

  FreeAndNil(FFuelCharacteristicsCalculationCardMapper);
  
  inherited;

end;

function TFuelCharacteristicsCalculationCardInfoMapper.
  MapFuelCharacteristicsCalculationCardAccessRightsDtoFrom(
    FuelCharacteristicsCalculationCardAccessRights:
      TFuelCharacteristicsCalculationCardAccessRights
  ): TFuelCharacteristicsCalculationCardAccessRightsDto;
begin

  Result := TFuelCharacteristicsCalculationCardAccessRightsDto.Create;

  Result.CanBeRemoved :=
    FuelCharacteristicsCalculationCardAccessRights.CanBeRemoved;

  Result.CalculationContextInfoCanBeViewed :=
    FuelCharacteristicsCalculationCardAccessRights.CalculationContextInfoCanBeViewed;

  Result.CalculationContextInfoCanBeEdited :=
    FuelCharacteristicsCalculationCardAccessRights.CalculationContextInfoCanBeEdited;

  Result.FuelInfoCanBeViewed :=
    FuelCharacteristicsCalculationCardAccessRights.FuelInfoCanBeViewed;

  Result.FuelInfoCanBeEdited :=
    FuelCharacteristicsCalculationCardAccessRights.FuelInfoCanBeEdited;
    
end;

function TFuelCharacteristicsCalculationCardInfoMapper.
  MapFuelCharacteristicsCalculationCardInfoFrom(
    FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;

    FuelCharacteristicsCalculationCardAccessRights:
      TFuelCharacteristicsCalculationCardAccessRights
      
  ): TFuelCharacteristicsCalculationCardInfo;
begin

  Result := TFuelCharacteristicsCalculationCardInfo.Create;

  try

    Result.FuelCharacteristicsCalculationCardDto :=
      FFuelCharacteristicsCalculationCardMapper.ToDto(
        FuelCharacteristicsCalculationCard
      );

    Result.FuelCharacteristicsCalculationCardAccessRightsDto :=
      MapFuelCharacteristicsCalculationCardAccessRightsDtoFrom(
        FuelCharacteristicsCalculationCardAccessRights
      );

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

end.
