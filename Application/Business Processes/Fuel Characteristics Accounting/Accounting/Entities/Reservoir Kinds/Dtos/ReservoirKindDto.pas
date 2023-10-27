unit ReservoirKindDto;

interface

uses

  EntityDto;

type

  TReservoirKindDto = class (TEntityDto)

    private
    
      function GetName: String;
      procedure SetName(const Value: String);

    protected

      procedure SetId(const Value: Variant); override;
      
    public

      constructor Create; override;
      
      property Name: String
      read GetName write SetName;

  end;

implementation

uses

  Variants;

{ TReservoirKindDto }

constructor TReservoirKindDto.Create;
begin

  inherited;

end;

function TReservoirKindDto.GetName: String;
begin

  Result := Id;

end;

procedure TReservoirKindDto.SetId(const Value: Variant);
begin

  inherited;

end;

procedure TReservoirKindDto.SetName(const Value: String);
begin

  Id := Value;

end;

end.
