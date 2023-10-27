unit ReservoirKindReferenceSuiteDirectory;

interface
  
uses

  ReservoirKindReferenceSuite;

type

  IReservoirKindReferenceSuiteDirectory = interface

    function FindReservoirKindReferenceSuite(
      const ReservoirKindName: String
    ): TReservoirKindReferenceSuite;

    procedure PutReservoirKindReferenceSuite(
      ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
    );

    procedure ModifyReservoirKindReferenceSuite(
      ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
    );

    procedure RemoveReservoirKindReferenceSuite(
      ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
    );
    
  end;
  
implementation

end.
