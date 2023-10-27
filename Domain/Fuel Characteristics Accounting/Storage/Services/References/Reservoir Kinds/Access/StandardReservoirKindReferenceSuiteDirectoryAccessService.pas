unit StandardReservoirKindReferenceSuiteDirectoryAccessService;

interface

uses

  ReservoirKindReferenceSuiteDirectoryAccessService,
  Employee,
  ReservoirKindReferenceSuiteDirectoryAccessRights,
  SysUtils,
  Classes;

type

  TStandardReservoirKindReferenceSuiteDirectoryAccessService =
    class (TInterfacedObject, IReservoirKindReferenceSuiteDirectoryAccessService)

      public

        function GetReservoirKindReferenceSuiteDirectoryAccessRightsForEmployee(
          Employee: TEmployee
        ): TReservoirKindReferenceSuiteDirectoryAccessRights; virtual;

        function EnsureAndGetReservoirKindReferenceSuiteDirectoryAccessRightsForEmployee(
          Employee: TEmployee
        ): TReservoirKindReferenceSuiteDirectoryAccessRights; virtual;

    end;
  
implementation

{ TStandardReservoirKindReferenceSuiteDirectoryAccessService }

function TStandardReservoirKindReferenceSuiteDirectoryAccessService.
  EnsureAndGetReservoirKindReferenceSuiteDirectoryAccessRightsForEmployee(
    Employee: TEmployee
  ): TReservoirKindReferenceSuiteDirectoryAccessRights;
begin

  Result :=
    GetReservoirKindReferenceSuiteDirectoryAccessRightsForEmployee(Employee);

  try

    if Result.AllAccessRightsAbsent then begin

      raise TReservoirKindReferenceSuiteDirectoryAccessServiceException.CreateFmt(
        '” сотрудника "%s" отсутствуют права ' +
        'на доступ к каталогу справочных данных ' +
        'типов резервуаров',
        [
          Employee.FullName
        ]
      );
      
    end;

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

function TStandardReservoirKindReferenceSuiteDirectoryAccessService.
  GetReservoirKindReferenceSuiteDirectoryAccessRightsForEmployee(
    Employee: TEmployee
  ): TReservoirKindReferenceSuiteDirectoryAccessRights;
begin

  Result := TReservoirKindReferenceSuiteDirectoryAccessRights.Create;

  try

    Result.ViewAllowed := Employee.IsWarehouseHead;
    Result.AlterationAllowed := Employee.IsWarehouseHead;
    Result.InPlacingAllowed := Employee.IsWarehouseHead;
    REsult.RemovingAllowed := Employee.IsWarehouseHead;
    
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

end.

