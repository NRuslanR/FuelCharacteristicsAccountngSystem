unit ReservoirKindsFormStubController;

interface

uses

  unTestReservoirKindsDataSetModule,
  BaseReservoirKindsFormController,
  ReservoirKindsDataSetHolder,
  ReferenceFormViewModel,
  ReservoirKindsFormViewModel,
  Forms,
  SysUtils;

type

  TReservoirKindsFormStubController =
    class (TBaseReservoirKindsFormController)

      protected

        function CreateReferenceFormViewModel: TReferenceFormViewModel; override;
        
    end;
  
implementation

{ TReservoirKindsFormStubController }

function TReservoirKindsFormStubController.
  CreateReferenceFormViewModel: TReferenceFormViewModel;
var ReservoirKindsFormViewModel: TReservoirKindsFormViewModel;
begin

  ReservoirKindsFormViewModel := TReservoirKindsFormViewModel.Create;

  ReservoirKindsFormViewModel.ViewRecordsAllowed := True;
  ReservoirKindsFormViewModel.AddingRecordAllowed := False;
  ReservoirKindsFormViewModel.EditingRecordAllowed := False;
  ReservoirKindsFormViewModel.RemovingRecordAllowed := False;

  ReservoirKindsFormViewModel.DataSetHolder :=
    TReservoirKindsDataSetHolder.CreateFrom(
      TTestReservoirKindsDataSetModule
        .Create(Application)
          .ReservoirKindsClientDataSet
    );

  ReservoirKindsFormViewModel.DataSetHolder.FieldDefs :=
    TReservoirKindsDataSetFieldDefs.Create;

  with ReservoirKindsFormViewModel.DataSetHolder do begin

    ReservoirKindNameFieldName := 'reservoir_kind_name';
    CanBeChangedFieldName := 'can_be_changed';
    CanBeRemovedFieldName := 'can_be_removed';
    
  end;

  Result := ReservoirKindsFormViewModel;
    
end;

end.
