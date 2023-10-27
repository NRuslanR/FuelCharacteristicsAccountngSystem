unit ReservoirKindReferenceSuiteRecordViewModel;

interface

uses

  ReferenceFormRecordViewModel,
  SysUtils;

type

  TReservoirKindReferenceSuiteRecordViewModel =
    class (TReferenceFormRecordViewModel)

      private
      
        function GetReservoirKindName: String;
        procedure SetReservoirKindName(const Value: String);

      public

        HSCValue: Single;
        CalibrationChartLocation: Variant;

      public

        constructor Create; override;
        
        property ReservoirKindName: String
        read GetReservoirKindName write SetReservoirKindName;

    end;
  
implementation

uses

  Variants;
  
{ TReservoirKindReferenceSuiteRecordViewModel }

constructor TReservoirKindReferenceSuiteRecordViewModel.Create;
begin

  inherited;

  CalibrationChartLocation := Null;

end;

function TReservoirKindReferenceSuiteRecordViewModel.
  GetReservoirKindName: String;
begin

  if VarIsNull(Id) then
    Result := ''

  else Result := Id;
  
end;

procedure TReservoirKindReferenceSuiteRecordViewModel.
  SetReservoirKindName(
    const Value: String
  );
begin

  Id := Value;

end;

end.
