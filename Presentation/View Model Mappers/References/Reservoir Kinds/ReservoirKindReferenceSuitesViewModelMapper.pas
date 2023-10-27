unit ReservoirKindReferenceSuitesViewModelMapper;

interface

uses

  AbstractReferenceFormViewModelMapper,
  ReferenceFormViewModel,
  ReferenceFormDataSetHolder,
  ReservoirKindReferenceSuitesFormViewModel,
  ReservoirKindReferenceSuitesDataSetHolder,
  ReservoirKindReferenceSuiteSetHolder,
  EntitySetHolder,
  SysUtils,
  Classes;

type

  TReservoirKindReferenceSuitesViewModelMapper =
    class (TAbstractReferenceFormViewModelMapper)

      protected

        function GetReferenceFormViewModelClass: TReferenceFormViewModelClass; override;
        function GetReferenceFormDataSetHolderClass: TReferenceFormDataSetHolderClass; override;
        function GetReferenceFormDataSetFieldDefsClass: TReferenceFormDataSetFieldDefsClass; override;

      protected

        procedure FillReferenceFormDataSetFieldDefsFrom(
          ReferenceFormDataSetFieldDefs: TReferenceFormDataSetFieldDefs;
          EntitySetFieldDefs: TEntitySetFieldDefs
        ); override;

    end;

    
implementation

{ TReservoirKindReferenceSuitesViewModelMapper }

procedure TReservoirKindReferenceSuitesViewModelMapper.
  FillReferenceFormDataSetFieldDefsFrom(
    ReferenceFormDataSetFieldDefs: TReferenceFormDataSetFieldDefs;
    EntitySetFieldDefs: TEntitySetFieldDefs
  );
var FieldDefs: TReservoirKindReferenceSuitesDataSetFieldDefs;
begin

  inherited;

  FieldDefs :=
    TReservoirKindReferenceSuitesDataSetFieldDefs(
      ReferenceFormDataSetFieldDefs
    );

  with EntitySetFieldDefs as TReservoirKindReferenceSuiteSetFieldDefs
  do begin

    FieldDefs.HSCValueFieldName :=
      AltitudinalConstantStencilFieldName;

    FieldDefs.CalibrationChartLocationFieldName :=
      CalibrationChartLocationFieldName;

    FieldDefs.ReservoirKindNameFieldName := ReservoirKindNameFieldName;

  end;

end;

function TReservoirKindReferenceSuitesViewModelMapper.
  GetReferenceFormDataSetFieldDefsClass: TReferenceFormDataSetFieldDefsClass;
begin

  Result := TReservoirKindReferenceSuitesDataSetFieldDefs;

end;

function TReservoirKindReferenceSuitesViewModelMapper.
  GetReferenceFormDataSetHolderClass: TReferenceFormDataSetHolderClass;
begin

  Result := TReservoirKindReferenceSuitesDataSetHolder;

end;

function TReservoirKindReferenceSuitesViewModelMapper.
  GetReferenceFormViewModelClass: TReferenceFormViewModelClass;
begin

  Result := TReservoirKindReferenceSuitesFormViewModel;
  
end;

end.
