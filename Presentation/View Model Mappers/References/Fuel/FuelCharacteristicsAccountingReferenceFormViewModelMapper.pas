unit FuelCharacteristicsAccountingReferenceFormViewModelMapper;

interface

uses

  AbstractReferenceFormViewModelMapper,
  ReferenceFormViewModel,
  ReferenceFormDataSetHolder,
  FuelCharacteristicsAccountingReferenceFormViewModel,
  FuelCharacteristicsAccountingReferenceDataSetHolder,
  FuelCharacteristicsCalculationCardSetHolder,
  EntitySetHolder,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingReferenceFormViewModelMapper =
    class (TAbstractReferenceFormViewModelMapper)

      protected

        function GetReferenceFormViewModelClass: TReferenceFormViewModelClass; override;
        function GetReferenceFormDataSetHolderClass: TReferenceFormDataSetHolderClass; override;
        function GetReferenceFormDataSetFieldDefsClass: TReferenceFormDataSetFieldDefsClass; override;

      protected

        function MapReferenceFormDataSetHolderFrom(
          EntitySetHolder: TEntitySetHolder
        ): TReferenceFormDataSetHolder; override;

      protected

        procedure FillReferenceFormDataSetFieldDefsFrom(
          ReferenceFormDataSetFieldDefs: TReferenceFormDataSetFieldDefs;
          EntitySetFieldDefs: TEntitySetFieldDefs
        ); override;
        
    end;

implementation

uses

  DB;

{ TFuelCharacteristicsAccountingReferenceFormViewModelMapper }

procedure TFuelCharacteristicsAccountingReferenceFormViewModelMapper.
  FillReferenceFormDataSetFieldDefsFrom(
    ReferenceFormDataSetFieldDefs: TReferenceFormDataSetFieldDefs;
    EntitySetFieldDefs: TEntitySetFieldDefs
  );
var FieldDefs: TFuelCharacteristicsAccountingReferenceDataSetFieldDefs;
begin

  inherited;

  FieldDefs :=
    TFuelCharacteristicsAccountingReferenceDataSetFieldDefs(
      ReferenceFormDataSetFieldDefs
    );
    
  with EntitySetFieldDefs as TFuelCharacteristicsCalculationCardSetFieldDefs
  do begin

    FieldDefs.TemperatureFieldName := TemperatureFieldName;
    FieldDefs.DensityFieldName := DensityFieldName;
    FieldDefs.FuelRiseLevelFieldName := FuelRiseLevelFieldName;
    FieldDefs.FuelMassFieldName := FuelMassFieldName;
    FieldDefs.FuelKindFieldName := FuelKindFieldName;
    FieldDefs.ReservoirNumberFieldName := ReservoirNumberFieldName;

    FieldDefs.PerformedCalculationEmployeeIdFieldName :=
      PerformedCalculationEmployeeIdFieldName;

    FieldDefs.PerformedCalculationEmployeeNameFieldName :=
      PerformedCalculationEmployeeNameFieldName;

    FieldDefs.CalculationPerformingDateTimeFieldName :=
      CalculationPerformingDateTimeFieldName;
      
  end;
  
end;

function TFuelCharacteristicsAccountingReferenceFormViewModelMapper.
  GetReferenceFormDataSetFieldDefsClass: TReferenceFormDataSetFieldDefsClass;
begin

  Result := TFuelCharacteristicsAccountingReferenceDataSetFieldDefs;
  
end;

function TFuelCharacteristicsAccountingReferenceFormViewModelMapper.
  GetReferenceFormDataSetHolderClass: TReferenceFormDataSetHolderClass;
begin

  Result := TFuelCharacteristicsAccountingReferenceDataSetHolder;

end;

function TFuelCharacteristicsAccountingReferenceFormViewModelMapper.
  GetReferenceFormViewModelClass: TReferenceFormViewModelClass;
begin

  Result := TFuelCharacteristicsAccountingReferenceFormViewModel;

end;

function TFuelCharacteristicsAccountingReferenceFormViewModelMapper.
  MapReferenceFormDataSetHolderFrom(
    EntitySetHolder: TEntitySetHolder
  ): TReferenceFormDataSetHolder;
var CardSetField: TField;
begin

  Result := inherited MapReferenceFormDataSetHolderFrom(EntitySetHolder);
  
  with
    TFuelCharacteristicsAccountingReferenceDataSetHolder(Result).DataSet,
    TFuelCharacteristicsAccountingReferenceDataSetHolder(Result).FieldDefs
  do begin

    for CardSetField in Fields do begin

      if CardSetField is TFloatField then begin

        with TFloatField(CardSetField) do begin

          Precision := 3;
          DisplayFormat := '0.###';
          
        end;

      end;

    end;

  end;

end;

end.
