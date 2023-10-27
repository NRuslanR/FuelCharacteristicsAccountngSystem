unit AbstractReservoirKindDirectory;

interface

uses

  ReservoirKindDirectory,
  ReservoirKind,
  SysUtils,
  Classes;

type

  TAbstractReservoirKindDirectory =
    class abstract (TInterfacedObject, IReservoirKindDirectory)

      protected

        function InternalFindReservoirKind(
          const ReservoirKindName: String
        ): TReservoirKind; virtual; abstract;

        procedure InternalPutReservoirKind(
          ReservoirKind: TReservoirKind
        ); virtual; abstract;

        procedure InternalModifyReservoirKind(
          ReservoirKind: TReservoirKind
        ); virtual; abstract;

        procedure InternalRemoveReservoirKind(
          ReservoirKind: TReservoirKind
        ); virtual; abstract;

      public

        function FindReservoirKind(const ReservoirKindName: String): TReservoirKind;

        procedure PutReservoirKind(ReservoirKind: TReservoirKind);

        procedure ModifyReservoirKind(ReservoirKind: TReservoirKind);

        procedure RemoveReservoirKind(ReservoirKind: TReservoirKind);

    end;

implementation

uses

  StandardEmployeeReservoirKindWorkingRuleRegistry;

{ TAbstractReservoirKindDirectory }

function TAbstractReservoirKindDirectory.FindReservoirKind(
  const ReservoirKindName: String): TReservoirKind;
begin

  Result := InternalFindReservoirKind(ReservoirKindName);

  try

    Result.WorkingRules :=
      TEmployeeReservoirKindWorkingRuleRegistry
        .Current
          .GetEmployeeReservoirKindWorkingRules;
          
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

procedure TAbstractReservoirKindDirectory.ModifyReservoirKind(
  ReservoirKind: TReservoirKind);
begin

  InternalModifyReservoirKind(ReservoirKind);
  
end;

procedure TAbstractReservoirKindDirectory.PutReservoirKind(
  ReservoirKind: TReservoirKind);
begin

  InternalPutReservoirKind(ReservoirKind);
  
end;

procedure TAbstractReservoirKindDirectory.RemoveReservoirKind(
  ReservoirKind: TReservoirKind);
begin

  InternalRemoveReservoirKind(ReservoirKind);
  
end;

end.
