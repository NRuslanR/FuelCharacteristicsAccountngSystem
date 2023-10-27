unit FuelCharacteristicsAccountingReferenceFormViewModel;

interface

uses

  ReferenceFormViewModel,
  FuelCharacteristicsAccountingReferenceDataSetHolder,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingReferenceFormViewModel = class (TReferenceFormViewModel)

    private

      procedure SetDataSetHolder(
        const Value: TFuelCharacteristicsAccountingReferenceDataSetHolder
      );
      
      function GetDataSetHolder: TFuelCharacteristicsAccountingReferenceDataSetHolder;

    public

      destructor Destroy; override;

      property DataSetHolder: TFuelCharacteristicsAccountingReferenceDataSetHolder
      read GetDataSetHolder write SetDataSetHolder;

  end;

implementation

{ TFuelCharacteristicsAccountingReferenceFormViewModel }

destructor TFuelCharacteristicsAccountingReferenceFormViewModel.Destroy;
begin

  inherited;

end;

function TFuelCharacteristicsAccountingReferenceFormViewModel.GetDataSetHolder: TFuelCharacteristicsAccountingReferenceDataSetHolder;
begin

  Result := TFuelCharacteristicsAccountingReferenceDataSetHolder(FDataSetHolder);
  
end;

procedure TFuelCharacteristicsAccountingReferenceFormViewModel.SetDataSetHolder(
  const Value: TFuelCharacteristicsAccountingReferenceDataSetHolder);
begin

  inherited SetDataSetHolder(Value);

end;

end.
