unit ReservoirKindRepository;

interface

uses

  VariantListUnit,
  DomainObjectRepository,
  ReservoirKind;

type

  IReservoirKindRepository =
    interface (IDomainObjectRepository)

      function AddReservoirKind(
        ReservoirKind: TReservoirKind
      ): Boolean;
      
      function AddReservoirKinds(
        ReservoirKinds: TReservoirKinds
      ): Boolean;
      
      function UpdateReservoirKind(
        ReservoirKind: TReservoirKind
      ): Boolean;

      function UpdateReservoirKinds(
        ReservoirKinds: TReservoirKinds
      ): Boolean;

      function RemoveReservoirKind(
        ReservoirKind: TReservoirKind
      ): Boolean;

      function RemoveReservoirKinds(
        ReservoirKinds: TReservoirKinds
      ): Boolean;
      
      function FindReservoirKindByIdentity(
        Identity: Variant
      ): TReservoirKind;
      
      function FindReservoirKindsByIdentities(
        const Identities: TVariantList
      ): TReservoirKinds;
      
      function LoadAllReservoirKinds:
        TReservoirKinds;

    end;

implementation

end.

