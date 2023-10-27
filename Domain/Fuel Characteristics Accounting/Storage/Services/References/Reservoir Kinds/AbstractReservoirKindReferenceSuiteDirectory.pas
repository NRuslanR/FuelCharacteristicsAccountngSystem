unit AbstractReservoirKindReferenceSuiteDirectory;

interface

uses

  ReservoirKindReferenceSuiteDirectory,
  ReservoirKindReferenceSuite,
  SysUtils,
  Classes;

type

  TAbstractReservoirKindReferenceSuiteDirectory =
    class abstract (TInterfacedObject, IReservoirKindReferenceSuiteDirectory)

      protected

        function InternalFindReservoirKindReferenceSuite(
          const ReservoirKindName: String
        ): TReservoirKindReferenceSuite; virtual; abstract;

        procedure InternalPutReservoirKindReferenceSuite(
          ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
        ); virtual; abstract;

        procedure InternalModifyReservoirKindReferenceSuite(
          ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
        ); virtual; abstract;

        procedure InternalRemoveReservoirKindReferenceSuite(
          ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
        ); virtual; abstract;

      public

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

uses

  StandardEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry;
  
{ TAbstractReservoirKindReferenceSuiteDirectory }

function TAbstractReservoirKindReferenceSuiteDirectory.
  FindReservoirKindReferenceSuite(
    const ReservoirKindName: String
  ): TReservoirKindReferenceSuite;
begin

  Result :=
    InternalFindReservoirKindReferenceSuite(ReservoirKindName);

  try

    Result.WorkingRules :=
      TEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry
        .Current
          .GetEmployeeReservoirKindReferenceSuiteWorkingRules;

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

procedure TAbstractReservoirKindReferenceSuiteDirectory.
  ModifyReservoirKindReferenceSuite(
    ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
  );
begin

  InternalModifyReservoirKindReferenceSuite(ReservoirKindReferenceSuite);
  
end;

procedure TAbstractReservoirKindReferenceSuiteDirectory.
  PutReservoirKindReferenceSuite(
    ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
  );
begin

  InternalPutReservoirKindReferenceSuite(ReservoirKindReferenceSuite);

end;

procedure TAbstractReservoirKindReferenceSuiteDirectory.
  RemoveReservoirKindReferenceSuite(
    ReservoirKindReferenceSuite: TReservoirKindReferenceSuite
  );
begin

  InternalRemoveReservoirKindReferenceSuite(ReservoirKindReferenceSuite);
  
end;

end.
