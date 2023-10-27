unit ReservoirKindReferenceSuitesFormStubController;

interface

uses

  BaseReservoirKindReferenceSuitesFormController,
  unTestReservoirKindsDataSetModule,
  ReferenceFormViewModel,
  ReservoirKindReferenceSuitesFormViewModel,
  ReservoirKindReferenceSuitesDataSetHolder,
  Forms,
  SysUtils;

type

  TReservoirKindReferenceSuitesFormStubController =
    class (TBaseReservoirKindReferenceSuitesFormController)

      protected

        function CreateReferenceFormViewModel: TReferenceFormViewModel; override;
        
    end;
  
implementation

{ TReservoirKindReferenceSuitesFormStubController }

function TReservoirKindReferenceSuitesFormStubController.
  CreateReferenceFormViewModel: TReferenceFormViewModel;
var ReferenceSuitesFormViewModel: TReservoirKindReferenceSuitesFormViewModel;
begin

  ReferenceSuitesFormViewModel :=
    TReservoirKindReferenceSuitesFormViewModel.Create;

  ReferenceSuitesFormViewModel.ViewRecordsAllowed := True;
  ReferenceSuitesFormViewModel.AddingRecordAllowed := True;
  ReferenceSuitesFormViewModel.EditingRecordAllowed := True;
  ReferenceSuitesFormViewModel.RemovingRecordAllowed := True;

  ReferenceSuitesFormViewModel.DataSetHolder :=
    TReservoirKindReferenceSuitesDataSetHolder.CreateFrom(
      TTestReservoirKindsDataSetModule
        .Create(Application)
          .ReservoirKindReferenceSuitesClientDataSet
    );

  ReferenceSuitesFormViewModel.DataSetHolder.FieldDefs :=
    TReservoirKindReferenceSuitesDataSetFieldDefs.Create;

  with ReferenceSuitesFormViewModel.DataSetHolder do begin

    ReservoirKindNameFieldName := 'reservoir_kind_name';
    HSCValueFieldName := 'hsc';
    CalibrationChartLocationFieldName := 'calibration_chart_location';
    CanBeChangedFieldName := 'can_be_changed';
    CanBeRemovedFieldName := 'can_be_removed';
    
  end;

  Result := ReferenceSuitesFormViewModel;

end;

end.
