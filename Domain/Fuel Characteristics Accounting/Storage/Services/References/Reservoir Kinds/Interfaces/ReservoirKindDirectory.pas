unit ReservoirKindDirectory;

interface

uses

  ReservoirKind;

type

  IReservoirKindDirectory = interface

    function FindReservoirKind(const ReservoirKindName: String): TReservoirKind;

    procedure PutReservoirKind(ReservoirKind: TReservoirKind);

    procedure ModifyReservoirKind(ReservoirKind: TReservoirKind);

    procedure RemoveReservoirKind(ReservoirKind: TReservoirKind);
    
  end;

implementation

end.
