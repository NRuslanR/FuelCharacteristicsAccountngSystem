unit ReservoirKindReferenceSuitesFormViewModel;

interface

uses

  ReferenceFormViewModel,
  ReservoirKindReferenceSuitesDataSetHolder,
  SysUtils;

type

  TReservoirKindReferenceSuitesFormViewModel =
    class (TReferenceFormViewModel)

      private

        function GetReservoirKindReferenceSuitesDataSetHolder:
          TReservoirKindReferenceSuitesDataSetHolder;

        procedure SetReservoirKindReferenceSuitesDataSetHolder(
          const Value: TReservoirKindReferenceSuitesDataSetHolder
        );
        
      public

        property DataSetHolder: TReservoirKindReferenceSuitesDataSetHolder
        read GetReservoirKindReferenceSuitesDataSetHolder
        write SetReservoirKindReferenceSuitesDataSetHolder;
        
    end;
    
implementation

{ TReservoirKindReferenceSuitesFormViewModel }

function TReservoirKindReferenceSuitesFormViewModel.
  GetReservoirKindReferenceSuitesDataSetHolder:
    TReservoirKindReferenceSuitesDataSetHolder;
begin

  Result :=
    TReservoirKindReferenceSuitesDataSetHolder(inherited DataSetHolder);
  
end;

procedure TReservoirKindReferenceSuitesFormViewModel.
  SetReservoirKindReferenceSuitesDataSetHolder(
    const Value: TReservoirKindReferenceSuitesDataSetHolder
  );
begin

  SetDataSetHolder(Value);

end;

end.
