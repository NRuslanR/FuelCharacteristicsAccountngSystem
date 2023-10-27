unit StandardReservoirKindReferenceSuiteReferenceService;

interface

uses

  ReservoirKindReferenceSuiteReferenceService,
  ReservoirKindReferenceSuiteSetHolder,
  ReservoirKindReferenceSuiteDirectoryAccessService,
  ReservoirKindReferenceSuiteDirectoryAccessRights,
  ReservoirKindReferenceSuiteSetReadService,
  EmployeeRepository,
  Employee,
  SysUtils,
  Classes;

type

  TStandardReservoirKindReferenceSuiteReferenceService =
    class (TInterfacedObject, IReservoirKindReferenceSuiteReferenceService)

      protected

        FEmployeeRepository: IEmployeeRepository;

        FReservoirKindReferenceSuiteDirectoryAccessService:
          IReservoirKindReferenceSuiteDirectoryAccessService;

        FReservoirKindReferenceSuiteSetReadService:
          IReservoirKindReferenceSuiteSetReadService;

        function GetReservoirKindReferenceSuiteDirectoryAccessRightsForEmployee(
          const EmployeeId: Variant
        ): TReservoirKindReferenceSuiteDirectoryAccessRights; virtual;
        
      public

        constructor Create(
          EmployeeRepository: IEmployeeRepository;

          ReservoirKindReferenceSuiteDirectoryAccessService:
            IReservoirKindReferenceSuiteDirectoryAccessService;

          ReservoirKindReferenceSuiteSetReadService:
            IReservoirKindReferenceSuiteSetReadService
        );

        function HasEmployeeAccessRightsForReservoirKindReferenceSuites(
          const EmployeeId: Variant
        ): Boolean;
        
        function GetAllReservoirKindReferenceSuiteSetForEmployee(
          const EmployeeId: Variant
        ): TReservoirKindReferenceSuiteSetHolder; virtual;

    end;

implementation

uses

  Variants,
  IDomainObjectBaseUnit;
  
{ TStandardReservoirKindReferenceSuiteReferenceService }

constructor TStandardReservoirKindReferenceSuiteReferenceService.Create(
  EmployeeRepository: IEmployeeRepository;

  ReservoirKindReferenceSuiteDirectoryAccessService:
    IReservoirKindReferenceSuiteDirectoryAccessService;

  ReservoirKindReferenceSuiteSetReadService:
    IReservoirKindReferenceSuiteSetReadService
);
begin

  inherited Create;

  FEmployeeRepository := EmployeeRepository;

  FReservoirKindReferenceSuiteDirectoryAccessService :=
    ReservoirKindReferenceSuiteDirectoryAccessService;

  FReservoirKindReferenceSuiteSetReadService :=
    ReservoirKindReferenceSuiteSetReadService;

end;

function TStandardReservoirKindReferenceSuiteReferenceService.
  GetAllReservoirKindReferenceSuiteSetForEmployee(
    const EmployeeId: Variant
  ): TReservoirKindReferenceSuiteSetHolder;
var AccessRights: TReservoirKindReferenceSuiteDirectoryAccessRights;
    Free: IDomainObjectBase;
begin

  AccessRights :=
    GetReservoirKindReferenceSuiteDirectoryAccessRightsForEmployee(
      EmployeeId
    );

  Free := AccessRights;

  Result :=
    FReservoirKindReferenceSuiteSetReadService
      .GetAllReservoirKindReferenceSuiteSet;

  try

    Result.ViewAllowed := AccessRights.ViewAllowed;
    Result.AddingAllowed := AccessRights.InPlacingAllowed;
    Result.ModificationAllowed := AccessRights.AlterationAllowed;
    Result.RemovingAllowed := AccessRights.RemovingAllowed;

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

function TStandardReservoirKindReferenceSuiteReferenceService.
  GetReservoirKindReferenceSuiteDirectoryAccessRightsForEmployee(
    const EmployeeId: Variant
  ): TReservoirKindReferenceSuiteDirectoryAccessRights;
var Employee: TEmployee;
    Free: IDomainObjectBase;
begin

  if VarIsNull(EmployeeId) or VarIsEmpty(EmployeeId) then begin

    raise TReservoirKindReferenceSuiteReferenceServiceException.Create(
      'Недействительный идентификатор сотрудника ' +
      'обнаружен при попытке получения ' +
      'справочных данных типов резервуаров'
    );
    
  end;

  Employee := FEmployeeRepository.FindEmployeeById(EmployeeId);

  if not Assigned(Employee) then begin

    raise TReservoirKindReferenceSuiteReferenceServiceException.Create(
      'Информация о сотруднике ' +
      'для получения справочных данных ' +
      'типов резервуаров не найдена'
    );
    
  end;

  Free := Employee;
  
  Result :=
    FReservoirKindReferenceSuiteDirectoryAccessService
      .EnsureAndGetReservoirKindReferenceSuiteDirectoryAccessRightsForEmployee(
        Employee
      );
      
end;

function TStandardReservoirKindReferenceSuiteReferenceService.
  HasEmployeeAccessRightsForReservoirKindReferenceSuites(
    const EmployeeId: Variant
  ): Boolean;
var Employee: TEmployee;
    Free: IDomainObjectBase;
begin

  try

    GetReservoirKindReferenceSuiteDirectoryAccessRightsForEmployee(
      EmployeeId
    ).Free;

    Result := True;
    
  except

    on e: TReservoirKindReferenceSuiteDirectoryAccessServiceException
    do Result := False;

  end;

end;

end.
