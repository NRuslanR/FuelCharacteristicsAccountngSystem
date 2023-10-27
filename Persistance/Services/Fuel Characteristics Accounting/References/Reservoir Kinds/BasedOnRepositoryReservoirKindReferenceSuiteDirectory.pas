unit BasedOnRepositoryReservoirKindReferenceSuiteDirectory;

interface

uses

  AbstractReservoirKindReferenceSuiteDirectory,
  ReservoirKindReferenceSuite,
  ReservoirKindReferenceSuiteRepository,
  SysUtils,
  Classes;

type

  TBasedOnRepositoryReservoirKindReferenceSuiteDirectory =
    class (TAbstractReservoirKindReferenceSuiteDirectory)

      private

        FReservoirKindReferenceSuiteRepository:
          IReservoirKindReferenceSuiteRepository;

      protected

        function InternalFindReservoirKindReferenceSuite(
          const ReservoirKindName: String
        ): TReservoirKindReferenceSuite; override;

        procedure InternalPutReservoirKindReferenceSuite(
          ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
        ); override;

        procedure InternalModifyReservoirKindReferenceSuite(
          ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
        ); override;

        procedure InternalRemoveReservoirKindReferenceSuite(
          ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
        ); override;
        
      public

        constructor Create(
          ReservoirKindReferenceSuiteRepository:
            IReservoirKindReferenceSuiteRepository
        );        

    end;
    
implementation

{ TBasedOnRepositoryReservoirKindReferenceSuiteDirectory }

constructor TBasedOnRepositoryReservoirKindReferenceSuiteDirectory.Create(
  ReservoirKindReferenceSuiteRepository: IReservoirKindReferenceSuiteRepository
);
begin

  inherited Create;

  FReservoirKindReferenceSuiteRepository :=
    ReservoirKindReferenceSuiteRepository;

end;

function TBasedOnRepositoryReservoirKindReferenceSuiteDirectory.
  InternalFindReservoirKindReferenceSuite(
    const ReservoirKindName: String
  ): TReservoirKindReferenceSuite;
begin

  Result :=
    FReservoirKindReferenceSuiteRepository.
      FindReservoirKindReferenceSuiteByIdentity(
        ReservoirKindName
      );

end;

procedure TBasedOnRepositoryReservoirKindReferenceSuiteDirectory.
  InternalModifyReservoirKindReferenceSuite(
    ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
  );
begin

  FReservoirKindReferenceSuiteRepository
    .UpdateReservoirKindReferenceSuite(ReservoirKindReferenceSuite);

end;

procedure TBasedOnRepositoryReservoirKindReferenceSuiteDirectory.
  InternalPutReservoirKindReferenceSuite(
    ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
  );
begin

  FReservoirKindReferenceSuiteRepository
    .AddReservoirKindReferenceSuite(ReservoirKindReferenceSuite);

end;

procedure TBasedOnRepositoryReservoirKindReferenceSuiteDirectory.
  InternalRemoveReservoirKindReferenceSuite(
    ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
  );
begin

  FReservoirKindReferenceSuiteRepository
    .RemoveReservoirKindReferenceSuite(ReservoirKindReferenceSuite);

end;

end.
