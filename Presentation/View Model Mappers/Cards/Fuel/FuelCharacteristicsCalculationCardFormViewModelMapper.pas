unit FuelCharacteristicsCalculationCardFormViewModelMapper;

interface

uses

  AbstractCardFormViewModelMapper,
  CardFormViewModel,
  ReferenceFormRecordViewModel,
  FuelCharacteristicsAccountingReferenceRecordViewModel,
  FuelCharacteristicsCalculationCardFormViewModel,
  FuelCharacteristicsCalculationCardInfo,
  FuelCharacteristicsCalculationCardDto,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsCalculationCardFormViewModelMapper =
    class (TAbstractCardFormViewModelMapper)

      protected

        function GetCardFormViewModelClass: TCardFormViewModelClass; override;

      public

        function CreateEmptyCardFormViewModel: TCardFormViewModel; override;

      public

        function MapCardFormViewModelFrom(
          ReferenceFormRecordViewModel: TReferenceFormRecordViewModel
        ): TCardFormViewModel; override;
        
        function MapFuelCharacteristicsCalculationCardFormViewModelFrom(

          FuelCharacteristicsCalculationCardInfo:
            TFuelCharacteristicsCalculationCardInfo

        ): TFuelCharacteristicsCalculationCardFormViewModel;


      public

        procedure FillFuelCharacteristicsCalculationCardFormViewModelFrom(

          ViewModel: TFuelCharacteristicsCalculationCardFormViewModel;
          
          FuelCharacteristicsCalculationCardDto:
            TFuelCharacteristicsCalculationCardDto
        );

        procedure FillCardFormViewModelFrom(
          CardFormViewModel: TCardFormViewModel;
          ReferenceFormRecordViewModel: TReferenceFormRecordViewModel
        ); override;
        
    end;


implementation

{ TFuelCharacteristicsCalculationCardFormViewModelMapper }

function TFuelCharacteristicsCalculationCardFormViewModelMapper.CreateEmptyCardFormViewModel: TCardFormViewModel;
begin

  Result := inherited CreateEmptyCardFormViewModel;

  with Result as TFuelCharacteristicsCalculationCardFormViewModel do begin

    PerformedCalculationEmployeeName.Value := '';
    CalculationPerformingDateTime.Value := Now;
    CalculationPerformingDateTimeChangingEnabled := False;
    
  end;
  
end;

procedure TFuelCharacteristicsCalculationCardFormViewModelMapper.
  FillCardFormViewModelFrom(
    CardFormViewModel: TCardFormViewModel;
    ReferenceFormRecordViewModel: TReferenceFormRecordViewModel
  );

var FuelCharacteristicsAccountingReferenceRecordViewModel:
      TFuelCharacteristicsAccountingReferenceRecordViewModel;
begin

  inherited;

  FuelCharacteristicsAccountingReferenceRecordViewModel :=
    ReferenceFormRecordViewModel as
    TFuelCharacteristicsAccountingReferenceRecordViewModel;

  with CardFormViewModel as TFuelCharacteristicsCalculationCardFormViewModel
  do begin

    FuelTemperature.Value := FuelCharacteristicsAccountingReferenceRecordViewModel.Temperature;
    FuelDensity.Value := FuelCharacteristicsAccountingReferenceRecordViewModel.Density;
    FuelRiseLevel.Value := FuelCharacteristicsAccountingReferenceRecordViewModel.FuelRiseLevel;
    FuelMass.Value := FuelCharacteristicsAccountingReferenceRecordViewModel.FuelMass;
    FuelKind.Value := FuelCharacteristicsAccountingReferenceRecordViewModel.FuelKind;
    ReservoirNumber.Value := FuelCharacteristicsAccountingReferenceRecordViewModel.ReservoirNumber;
    PerformedCalculationEmployeeId.Value := FuelCharacteristicsAccountingReferenceRecordViewModel.PerformedCalculationEmployeeId;
    PerformedCalculationEmployeeName.Value := FuelCharacteristicsAccountingReferenceRecordViewModel.PerformedCalculationEmployeeName;
    CalculationPerformingDateTime.Value := FuelCharacteristicsAccountingReferenceRecordViewModel.CalculationPerformingDateTime;

  end;
  
end;

procedure TFuelCharacteristicsCalculationCardFormViewModelMapper.
  FillFuelCharacteristicsCalculationCardFormViewModelFrom(
    ViewModel: TFuelCharacteristicsCalculationCardFormViewModel;
    FuelCharacteristicsCalculationCardDto: TFuelCharacteristicsCalculationCardDto
  );
begin

  ViewModel.Id.Value := FuelCharacteristicsCalculationCardDto.Id;
    
  ViewModel.FuelTemperature.Value :=
    FuelCharacteristicsCalculationCardDto.FuelTemperature;

  ViewModel.FuelDensity.Value :=
    FuelCharacteristicsCalculationCardDto.FuelDensity;

  ViewModel.FuelRiseLevel.Value :=
    FuelCharacteristicsCalculationCardDto.FuelRiseLevel;

  ViewModel.FuelMass.Value :=
    FuelCharacteristicsCalculationCardDto.FuelMass;

  ViewModel.FuelKind.Value :=
    FuelCharacteristicsCalculationCardDto.FuelKind;

  ViewModel.ReservoirNumber.Value :=
    FuelCharacteristicsCalculationCardDto.ReservoirNumber;

  ViewModel.PerformedCalculationEmployeeId.Value :=
    FuelCharacteristicsCalculationCardDto.PerformedCalculationEmployeeDto.Id;

  ViewModel.PerformedCalculationEmployeeName.Value :=
    FuelCharacteristicsCalculationCardDto.PerformedCalculationEmployeeDto.FullName;

  ViewModel.CalculationPerformingDateTime.Value :=
    FuelCharacteristicsCalculationCardDto.CalculationPerformingDateTime;

end;

function TFuelCharacteristicsCalculationCardFormViewModelMapper.GetCardFormViewModelClass: TCardFormViewModelClass;
begin

  Result := TFuelCharacteristicsCalculationCardFormViewModel;
  
end;

function TFuelCharacteristicsCalculationCardFormViewModelMapper.
  MapCardFormViewModelFrom(
    ReferenceFormRecordViewModel: TReferenceFormRecordViewModel
  ): TCardFormViewModel;
begin

  Result := inherited MapCardFormViewModelFrom(ReferenceFormRecordViewModel);

  with Result as TFuelCharacteristicsCalculationCardFormViewModel do
    CalculationPerformingDateTimeChangingEnabled := False;

end;

function TFuelCharacteristicsCalculationCardFormViewModelMapper.
  MapFuelCharacteristicsCalculationCardFormViewModelFrom(

    FuelCharacteristicsCalculationCardInfo:
      TFuelCharacteristicsCalculationCardInfo

  ): TFuelCharacteristicsCalculationCardFormViewModel;
begin

  Result := TFuelCharacteristicsCalculationCardFormViewModel.Create;

  with FuelCharacteristicsCalculationCardInfo do begin

    FillFuelCharacteristicsCalculationCardFormViewModelFrom(
      Result, FuelCharacteristicsCalculationCardDto
    );

    Result.CalculationPerformingDateTimeChangingEnabled := False;
    
    Result.PerformedCalculationEmployeeName.Visible :=
      FuelCharacteristicsCalculationCardAccessRightsDto
        .CalculationContextInfoCanBeEdited;

    Result.CalculationPerformingDateTime.Visible :=
      Result.PerformedCalculationEmployeeName.Visible;

    Result.FuelTemperature.ReadOnly :=
      not FuelCharacteristicsCalculationCardAccessRightsDto.FuelInfoCanBeEdited;

    Result.FuelDensity.ReadOnly := Result.FuelTemperature.ReadOnly;
    Result.FuelRiseLevel.ReadOnly := Result.FuelTemperature.ReadOnly;
    Result.FuelMass.ReadOnly := Result.FuelTemperature.ReadOnly;
    Result.FuelKind.ReadOnly := Result.FuelTemperature.ReadOnly;
    Result.ReservoirNumber.ReadOnly := Result.FuelTemperature.ReadOnly;

  end;

end;

end.
