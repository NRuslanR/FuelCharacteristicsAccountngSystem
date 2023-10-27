unit ReservoirKindReferenceSuiteCardFormViewModelMapper;

interface

uses

  AbstractCardFormViewModelMapper,
  CardFormViewModel,
  ReferenceFormRecordViewModel,
  ReservoirKindReferenceSuiteCardFormViewModel,
  ReservoirKindReferenceSuiteRecordViewModel,
  ReservoirKindReferenceSuiteInfo,
  SysUtils;

type

  TReservoirKindReferenceSuiteCardFormViewModelMapper =
    class (TAbstractCardFormViewModelMapper)

      protected

        function GetCardFormViewModelClass: TCardFormViewModelClass; override;

        procedure FillCardFormViewModelFrom(
          CardFormViewModel: TCardFormViewModel;
          ReferenceFormRecordViewModel: TReferenceFormRecordViewModel
        ); override;

      public

        function MapReservoirKindReferenceSuiteCardFormViewModelFrom(
          ReservoirKindReferenceSuiteInfo: TReservoirKindReferenceSuiteInfo
        ): TReservoirKindReferenceSuiteCardFormViewModel;
        
    end;
    
implementation

{ TReservoirKindReferenceSuiteCardFormViewModelMapper }

procedure TReservoirKindReferenceSuiteCardFormViewModelMapper.
  FillCardFormViewModelFrom(
    CardFormViewModel: TCardFormViewModel;
    ReferenceFormRecordViewModel: TReferenceFormRecordViewModel
  );
var ReferenceSuiteCardFormViewModel: TReservoirKindReferenceSuiteCardFormViewModel;
begin

  inherited;

  ReferenceSuiteCardFormViewModel :=
    CardFormViewModel as TReservoirKindReferenceSuiteCardFormViewModel;

  with
    ReferenceFormRecordViewModel as
    TReservoirKindReferenceSuiteRecordViewModel
  do begin

    ReferenceSuiteCardFormViewModel.HSCValue.Value := HSCValue;
    
    ReferenceSuiteCardFormViewModel.CalibrationChartLocation.Value :=
      CalibrationChartLocation;

  end;
  
end;

function TReservoirKindReferenceSuiteCardFormViewModelMapper.
  GetCardFormViewModelClass: TCardFormViewModelClass;
begin

  Result := TReservoirKindReferenceSuiteCardFormViewModel;
  
end;

function TReservoirKindReferenceSuiteCardFormViewModelMapper.
  MapReservoirKindReferenceSuiteCardFormViewModelFrom(
    ReservoirKindReferenceSuiteInfo: TReservoirKindReferenceSuiteInfo
  ): TReservoirKindReferenceSuiteCardFormViewModel;
begin

  Result := TReservoirKindReferenceSuiteCardFormViewModel.Create;

  with ReservoirKindReferenceSuiteInfo.ReservoirKindReferenceSuiteDto
  do begin

    Result.ReservoirKindName.Value := ReservoirKindName;
    Result.HSCValue.Value := AltitudinalConstantStencil;
    Result.CalibrationChartLocation.Value := CalibrationChartLocation;
    
  end;

  with
    ReservoirKindReferenceSuiteInfo.ReservoirKindReferenceSuiteAccessRightsDto
  do begin

    Result.ReservoirKindName.ReadOnly := not CanBeEdited;
    Result.HSCValue.ReadOnly := not CanBeEdited;
    Result.CalibrationChartLocation.ReadOnly := not CanBeEdited;
    
  end;

end;

end.
