unit FuelCharacteristicsCalculationCardAccessRights;

interface

uses

  DomainObjectValueUnit,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsCalculationCardAccessRights  = class (TDomainObjectValue)

    private

      FCanBeRemoved: Boolean;
      FCalculationContextInfoCanBeViewed: Boolean;
      FCalculationContextInfoCanBeEdited: Boolean;
      FFuelInfoCanBeViewed: Boolean;
      FFuelInfoCanBeEdited: Boolean;

    public

      constructor Create;

      function AllAccessRightsAbsent: Boolean;
      
      property CanBeRemoved: Boolean
      read FCanBeRemoved write FCanBeRemoved;
      
      property CalculationContextInfoCanBeViewed: Boolean
      read FCalculationContextInfoCanBeViewed
      write FCalculationContextInfoCanBeViewed;
      
      property CalculationContextInfoCanBeEdited: Boolean
      read FCalculationContextInfoCanBeEdited
      write FCalculationContextInfoCanBeEdited;
      
      property FuelInfoCanBeViewed: Boolean
      read FFuelInfoCanBeViewed write FFuelInfoCanBeViewed;
      
      property FuelInfoCanBeEdited: Boolean
      read FFuelInfoCanBeEdited write FFuelInfoCanBeEdited;

  end;

implementation

{ TFuelCharacteristicsCalculationCardAccessRights }

function TFuelCharacteristicsCalculationCardAccessRights.
  AllAccessRightsAbsent: Boolean;
begin

  Result :=
    not (
      CanBeRemoved or
      CalculationContextInfoCanBeViewed or
      CalculationContextInfoCanBeEdited or
      FuelInfoCanBeViewed or
      FuelInfoCanBeEdited
    );

end;

constructor TFuelCharacteristicsCalculationCardAccessRights.Create;
begin

  inherited;
  
end;

end.
