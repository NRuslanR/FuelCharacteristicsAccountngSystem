unit ReservoirKindRecordViewModel;

interface

uses

  ReferenceFormRecordViewModel,
  SysUtils;

type

  TReservoirKindRecordViewModel = class (TReferenceFormRecordViewModel)

    private

      function GetReservoirKindName: String;
      procedure SetReservoirKindName(const Value: String);

    public

      property ReservoirKindName: String
      read GetReservoirKindName write SetReservoirKindName;
      
  end;
  

implementation

uses

  Variants;
  
{ TReservoirKindRecordViewModel }

function TReservoirKindRecordViewModel.GetReservoirKindName: String;
begin

  if VarIsNull(Id) then
    Result := ''

  else Result := Id;
  
end;

procedure TReservoirKindRecordViewModel.SetReservoirKindName(
  const Value: String);
begin

  Id := Value;
  
end;

end.
