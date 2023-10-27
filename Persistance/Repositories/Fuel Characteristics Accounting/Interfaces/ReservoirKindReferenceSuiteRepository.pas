unit ReservoirKindReferenceSuiteRepository;

interface

uses

  VariantListUnit,
  DomainObjectRepository,
  ReservoirKindReferenceSuite;

type

  IReservoirKindReferenceSuiteRepository =
    interface (IDomainObjectRepository)

      function AddReservoirKindReferenceSuite(
        ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
      ): Boolean;
      
      function AddReservoirKindReferenceSuites(
        ReservoirKindReferenceSuites: TReservoirKindReferenceSuites
      ): Boolean;
      
      function UpdateReservoirKindReferenceSuite(
        ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
      ): Boolean;

      function UpdateReservoirKindReferenceSuites(
        ReservoirKindReferenceSuites: TReservoirKindReferenceSuites
      ): Boolean;

      function RemoveReservoirKindReferenceSuite(
        ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
      ): Boolean;

      function RemoveReservoirKindReferenceSuites(
        ReservoirKindReferenceSuites: TReservoirKindReferenceSuites
      ): Boolean;
      
      function FindReservoirKindReferenceSuiteByIdentity(
        Identity: Variant
      ): TReservoirKindReferenceSuite;
      
      function FindReservoirKindReferenceSuitesByIdentities(
        const Identities: TVariantList
      ): TReservoirKindReferenceSuites;
      
      function LoadAllReservoirKindReferenceSuites:
        TReservoirKindReferenceSuites;

    end;

implementation

end.
