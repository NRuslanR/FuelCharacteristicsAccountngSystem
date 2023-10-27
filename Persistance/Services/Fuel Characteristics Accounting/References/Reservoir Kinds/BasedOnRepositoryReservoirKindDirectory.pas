unit BasedOnRepositoryReservoirKindDirectory;

interface

uses

  AbstractReservoirKindDirectory,
  ReservoirKind,
  ReservoirKindRepository,
  SysUtils,
  Classes;

type

  TBasedOnRepositoryReservoirKindDirectory =
    class (TAbstractReservoirKindDirectory)

      private

        FReservoirKindRepository: IReservoirKindRepository;

      protected

        function InternalFindReservoirKind(
          const ReservoirKindName: String
        ): TReservoirKind; override;

        procedure InternalPutReservoirKind(
          ReservoirKind: TReservoirKind
        ); override;

        procedure InternalModifyReservoirKind(
          ReservoirKind: TReservoirKind
        ); override;

        procedure InternalRemoveReservoirKind(
          ReservoirKind: TReservoirKind
        ); override;

      public

        constructor Create(ReservoirKindRepository: IReservoirKindRepository);
        
    end;
  
implementation

{ TBasedOnRepositoryReservoirKindDirectory }

constructor TBasedOnRepositoryReservoirKindDirectory.Create(
  ReservoirKindRepository: IReservoirKindRepository);
begin

  inherited Create;

  FReservoirKindRepository := ReservoirKindRepository;
  
end;

function TBasedOnRepositoryReservoirKindDirectory.InternalFindReservoirKind(
  const ReservoirKindName: String): TReservoirKind;
begin

  Result :=
    FReservoirKindRepository.FindReservoirKindByIdentity(ReservoirKindName);

end;

procedure TBasedOnRepositoryReservoirKindDirectory.InternalModifyReservoirKind(
  ReservoirKind: TReservoirKind);
begin

  FReservoirKindRepository.UpdateReservoirKind(ReservoirKind);

end;

procedure TBasedOnRepositoryReservoirKindDirectory.InternalPutReservoirKind(
  ReservoirKind: TReservoirKind);
begin

  FReservoirKindRepository.AddReservoirKind(ReservoirKind);

end;

procedure TBasedOnRepositoryReservoirKindDirectory.InternalRemoveReservoirKind(
  ReservoirKind: TReservoirKind);
begin

  FReservoirKindRepository.RemoveReservoirKind(ReservoirKind);

end;

end.
