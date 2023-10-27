unit StandardReservoirKindDirectoryAccessService;

interface

uses

  ReservoirKindDirectoryAccessService,
  Employee,
  ReservoirKindDirectoryAccessRights,
  SysUtils,
  Classes;

type

  TStandardReservoirKindDirectoryAccessService =
    class (TInterfacedObject, IReservoirKindDirectoryAccessService)

      public

        function GetReservoirKindDirectoryAccessRightsForEmployee(
          Employee: TEmployee
        ): TReservoirKindDirectoryAccessRights; virtual;

        function EnsureAndGetReservoirKindDirectoryAccessRightsForEmployee(
          Employee: TEmployee
        ): TReservoirKindDirectoryAccessRights; virtual;

    end;
  
implementation

{ TStandardReservoirKindDirectoryAccessService }

function TStandardReservoirKindDirectoryAccessService.
  EnsureAndGetReservoirKindDirectoryAccessRightsForEmployee(
    Employee: TEmployee
  ): TReservoirKindDirectoryAccessRights;
begin

  Result :=
    GetReservoirKindDirectoryAccessRightsForEmployee(Employee);

  try

    if Result.AllAccessRightsAbsent then begin

      raise TReservoirKindDirectoryAccessServiceException.CreateFmt(
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

function TStandardReservoirKindDirectoryAccessService.
  GetReservoirKindDirectoryAccessRightsForEmployee(
    Employee: TEmployee
  ): TReservoirKindDirectoryAccessRights;
begin

  Result := TReservoirKindDirectoryAccessRights.Create;

  try

    Result.ViewAllowed :=
      Employee.IsWarehouseHead or Employee.IsAircraftTechnician;
      
    Result.AlterationAllowed := False;
    Result.InPlacingAllowed := False;
    REsult.RemovingAllowed := False;
    
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

end.
