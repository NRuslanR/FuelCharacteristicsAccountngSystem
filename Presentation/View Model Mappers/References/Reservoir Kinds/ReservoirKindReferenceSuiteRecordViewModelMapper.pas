unit ReservoirKindReferenceSuiteRecordViewModelMapper;

interface

uses

  AbstractReferenceFormRecordViewModelMapper,
  ReservoirKindReferenceSuiteCardFormViewModel,
  ReservoirKindReferenceSuiteRecordViewModel,
  ReferenceFormRecordViewModel,
  CardFormViewModel,
  SysUtils;

type

  TReservoirKindReferenceSuiteRecordViewModelMapper =
    class (TAbstractReferenceFormRecordViewModelMapper)

      protected

        function GetReferenceFormRecordViewModelClass:
          TReferenceFormRecordViewModelClass; override;

        procedure FillReferenceFormRecordViewModelFrom(
          ReferenceFormRecordViewModel: TReferenceFormRecordViewModel;
          CardFormViewModel: TCardFormViewModel;
          const CanBeChanged: Boolean = True;
          const CanBeRemoved: Boolean = True
        ); override;
        
    end;
  
implementation

{ TReservoirKindReferenceSuiteRecordViewModelMapper }

procedure TReservoirKindReferenceSuiteRecordViewModelMapper.
  FillReferenceFormRecordViewModelFrom(
    ReferenceFormRecordViewModel: TReferenceFormRecordViewModel;
    CardFormViewModel: TCardFormViewModel;
    const CanBeChanged, CanBeRemoved: Boolean
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

    HSCValue := ReferenceSuiteCardFormViewModel.HSCValue.Value;
    
    CalibrationChartLocation :=
      ReferenceSuiteCardFormViewModel.CalibrationChartLocation.Value;

  end;

end;

function TReservoirKindReferenceSuiteRecordViewModelMapper.
  GetReferenceFormRecordViewModelClass: TReferenceFormRecordViewModelClass;
begin

  Result := TReservoirKindReferenceSuiteRecordViewModel;
  
end;

end.
