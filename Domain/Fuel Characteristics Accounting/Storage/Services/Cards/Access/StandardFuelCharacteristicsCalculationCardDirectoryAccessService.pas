unit StandardFuelCharacteristicsCalculationCardDirectoryAccessService;

interface

uses

  AbstractDomainService,
  FuelCharacteristicsCalculationCardDirectoryAccessService,
  FuelCharacteristicsCalculationCardDirectoryAccessRights,
  Employee,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsCalculationCardDirectoryAccessService =
    class (
      TAbstractStandardDomainService,
      IFuelCharacteristicsCalculationCardDirectoryAccessService
    )

      public

        function GetFuelCharacteristicsCalculationCardDirectoryAccessRightsForEmployee(
          Employee: TEmployee
        ): TFuelCharacteristicsCalculationCardDirectoryAccessRights; virtual;

        function EnsureAndGetFuelCharacteristicsCalculationCardDirectoryAccessRightsForEmployee(
          Employee: TEmployee
        ): TFuelCharacteristicsCalculationCardDirectoryAccessRights; virtual;

    end;


implementation

{ TStandardFuelCharacteristicsCalculationCardDirectoryAccessService }

function TStandardFuelCharacteristicsCalculationCardDirectoryAccessService.
  EnsureAndGetFuelCharacteristicsCalculationCardDirectoryAccessRightsForEmployee(
    Employee: TEmployee
  ): TFuelCharacteristicsCalculationCardDirectoryAccessRights;
begin

  Result :=
    GetFuelCharacteristicsCalculationCardDirectoryAccessRightsForEmployee(Employee);

  try

    if Result.AllAccessRightsAbsent then begin

      raise
      TFuelCharacteristicsCalculationCardDirectoryAccessServiceException.
        CreateFmt(
          'У сотрудника "%s" отсутствует ' +
          'доступ к каталогу расчётов',
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

function TStandardFuelCharacteristicsCalculationCardDirectoryAccessService.
  GetFuelCharacteristicsCalculationCardDirectoryAccessRightsForEmployee(
    Employee: TEmployee
  ): TFuelCharacteristicsCalculationCardDirectoryAccessRights;
begin

  Result := TFuelCharacteristicsCalculationCardDirectoryAccessRights.Create;

  try

    Result.ViewAllowed := Employee.HasRole;

    Result.InPlacingAllowed :=
      Employee.IsAircraftTechnician or Employee.IsWarehouseHead;
    Result.AlterationAllowed := Result.InPlacingAllowed;
    Result.RemovingAllowed := Result.InPlacingAllowed;

    if Employee.IsAircraftTechnician then
      Result.AllowedPerformerIdentities.Add(Employee.Identity);
    
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

end.
