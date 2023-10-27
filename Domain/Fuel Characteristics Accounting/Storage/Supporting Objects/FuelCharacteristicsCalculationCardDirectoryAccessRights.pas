unit FuelCharacteristicsCalculationCardDirectoryAccessRights;

interface

uses

  DirectoryAccessRights,
  VariantListUnit,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsCalculationCardDirectoryAccessRights =
    class (TDirectoryAccessRights)

      private

        FAllowedPerformerIdentities: TVariantList;
        
        procedure SetAllowedPerformerIdentities(const Value: TVariantList);
        
      public

        function AllAccessRightsAbsent: Boolean; override;

        destructor Destroy; override;

        constructor Create;

        property AllowedPerformerIdentities: TVariantList
        read FAllowedPerformerIdentities
        write SetAllowedPerformerIdentities;
        
    end;

implementation

{ TFuelCharacteristicsCalculationCardDirectoryAccessRights }

function TFuelCharacteristicsCalculationCardDirectoryAccessRights.
  AllAccessRightsAbsent: Boolean;
begin

  Result := inherited AllAccessRightsAbsent;
  
end;

constructor TFuelCharacteristicsCalculationCardDirectoryAccessRights.Create;
begin

  inherited;

  FAllowedPerformerIdentities := TVariantList.Create;
  
end;

destructor TFuelCharacteristicsCalculationCardDirectoryAccessRights.Destroy;
begin

  FreeAndNil(FAllowedPerformerIdentities);
  
  inherited;

end;

procedure TFuelCharacteristicsCalculationCardDirectoryAccessRights.
  SetAllowedPerformerIdentities(const Value: TVariantList);
begin

  if FAllowedPerformerIdentities = Value then
    Exit;

  FreeAndNil(FAllowedPerformerIdentities);
  
  FAllowedPerformerIdentities := Value;

end;

end.
