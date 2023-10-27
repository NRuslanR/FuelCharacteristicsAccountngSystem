unit ReservoirSubLayerKindIdResolver;

interface

uses

  ReservoirSubLayerKind,
  SysUtils;

type

  TReservoirSubLayerKindIdResolverException = class (Exception)

  end;
  
  IReservoirSubLayerKindIdResolver = interface

    function ResolveReservoirSubLayerKindIdFrom(
      ReservoirSubLayerKind: TReservoirSubLayerKind
    ): Variant;
    
  end;

implementation

end.
