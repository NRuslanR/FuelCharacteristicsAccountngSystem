unit ReservoirKindsFormViewModel;

interface

uses

  ReferenceFormViewModel,
  ReservoirKindsDataSetHolder,
  SysUtils,
  Classes;

type

  TReservoirKindsFormViewModel = class (TReferenceFormViewModel)

    private
    function GetReservoirKindsDataSetHolder: TReservoirKindsDataSetHolder;
    procedure SetReservoirKindsDataSetHolder(
      const Value: TReservoirKindsDataSetHolder);


    public

      property DataSetHolder: TReservoirKindsDataSetHolder
      read GetReservoirKindsDataSetHolder
      write SetReservoirKindsDataSetHolder;

  end;
  
implementation

{ TReservoirKindsFormViewModel }

function TReservoirKindsFormViewModel.
  GetReservoirKindsDataSetHolder: TReservoirKindsDataSetHolder;
begin

  Result := inherited DataSetHolder as TReservoirKindsDataSetHolder;

end;

procedure TReservoirKindsFormViewModel.SetReservoirKindsDataSetHolder(
  const Value: TReservoirKindsDataSetHolder);
begin

  SetDataSetHolder(Value);
  
end;

end.
