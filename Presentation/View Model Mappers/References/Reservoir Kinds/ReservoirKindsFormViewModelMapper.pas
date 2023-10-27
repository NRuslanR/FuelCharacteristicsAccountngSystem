unit ReservoirKindsFormViewModelMapper;

interface

uses

  AbstractReferenceFormViewModelMapper,
  ReferenceFormViewModel,
  ReservoirKindsFormViewModel,
  ReferenceFormDataSetHolder,
  ReservoirKindsDataSetHolder,
  EntitySetHolder,
  ReservoirKindSetHolder,
  SysUtils,
  Classes;

type

  TReservoirKindsFormViewModelMapper =
    class (TAbstractReferenceFormViewModelMapper)

      protected

        function GetReferenceFormViewModelClass: TReferenceFormViewModelClass; override;
        function GetReferenceFormDataSetHolderClass: TReferenceFormDataSetHolderClass; override;
        function GetReferenceFormDataSetFieldDefsClass: TReferenceFormDataSetFieldDefsClass; override;

        procedure FillReferenceFormDataSetFieldDefsFrom(
          ReferenceFormDataSetFieldDefs: TReferenceFormDataSetFieldDefs;
          EntitySetFieldDefs: TEntitySetFieldDefs
        ); override;

    end;

implementation

{ TReservoirKindFormViewModelMapper }

procedure TReservoirKindsFormViewModelMapper.FillReferenceFormDataSetFieldDefsFrom(
  ReferenceFormDataSetFieldDefs: TReferenceFormDataSetFieldDefs;
  EntitySetFieldDefs: TEntitySetFieldDefs
);
var FieldDefs: TReservoirKindsDataSetFieldDefs;
begin

  inherited;

  FieldDefs := TReservoirKindsDataSetFieldDefs(ReferenceFormDataSetFieldDefs);

  with EntitySetFieldDefs as TReservoirKindSetFieldDefs do begin

    FieldDefs.ReservoirKindNameFieldName := ReservoirKindNameFieldName;
    
  end;

end;

function TReservoirKindsFormViewModelMapper.GetReferenceFormDataSetFieldDefsClass: TReferenceFormDataSetFieldDefsClass;
begin

  Result := TReservoirKindsDataSetFieldDefs;

end;

function TReservoirKindsFormViewModelMapper.GetReferenceFormDataSetHolderClass: TReferenceFormDataSetHolderClass;
begin

  Result := TReservoirKindsDataSetHolder;
  
end;

function TReservoirKindsFormViewModelMapper.GetReferenceFormViewModelClass: TReferenceFormViewModelClass;
begin

  Result := TReservoirKindsFormViewModel;
  
end;

end.
