unit StandardReservoirKindReferenceService;

interface

uses

  ReservoirKindDirectoryAccessService,
  ReservoirKindSetReadService,
  ReservoirKindReferenceService,
  ReservoirKindDirectoryAccessRights,
  ReservoirKindSetHolder,
  EmployeeRepository,
  Employee,
  SysUtils,
  Classes;

type

  TStandardReservoirKindReferenceService =
    class (TInterfacedObject, IReservoirKindReferenceService)

      protected

        FEmployeeRepository: IEmployeeRepository;
        FReservoirKindDirectoryAccessService: IReservoirKindDirectoryAccessService;
        FReservoirKindSetReadService: IReservoirKindSetReadService;
        
        function GetReservoirKindDirectoryAccessRightsForEmployee(
          const EmployeeId: Variant
        ): TReservoirKindDirectoryAccessRights; virtual;
        
      public

        constructor Create(
          EmployeeRepository: IEmployeeRepository;
          ReservoirKindDirectoryAccessService: IReservoirKindDirectoryAccessService;
          ReservoirKindSetReadService: IReservoirKindSetReadService
        );

        function GetAllReservoirKindsForEmployee(
          const EmployeeId: Variant
        ): TReservoirKindSetHolder; virtual;

    end;

implementation

uses

  Variants,
  IDomainObjectBaseUnit;
  
{ TStandardReservoirKindReferenceService }

constructor TStandardReservoirKindReferenceService.Create(
  EmployeeRepository: IEmployeeRepository;
  ReservoirKindDirectoryAccessService: IReservoirKindDirectoryAccessService;
  ReservoirKindSetReadService: IReservoirKindSetReadService
);
begin

  inherited Create;

  FEmployeeRepository := EmployeeRepository;
  FReservoirKindDirectoryAccessService := ReservoirKindDirectoryAccessService;
  FReservoirKindSetReadService := ReservoirKindSetReadService;

end;

function TStandardReservoirKindReferenceService.
  GetAllReservoirKindsForEmployee(
    const EmployeeId: Variant
  ): TReservoirKindSetHolder;

var ReservoirKindDirectoryAccessRights: TReservoirKindDirectoryAccessRights;
    Free: IDomainObjectBase;
begin

  ReservoirKindDirectoryAccessRights :=
    GetReservoirKindDirectoryAccessRightsForEmployee(EmployeeId);

  Free := ReservoirKindDirectoryAccessRights;

  Result := FReservoirKindSetReadService.GetAllReservoirKindSet;

  try

    Result.ViewAllowed := ReservoirKindDirectoryAccessRights.ViewAllowed;
    Result.AddingAllowed := ReservoirKindDirectoryAccessRights.InPlacingAllowed;
    Result.ModificationAllowed := ReservoirKindDirectoryAccessRights.AlterationAllowed;
    Result.RemovingAllowed := ReservoirKindDirectoryAccessRights.RemovingAllowed;
    
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

function TStandardReservoirKindReferenceService.
  GetReservoirKindDirectoryAccessRightsForEmployee(
    const EmployeeId: Variant
  ): TReservoirKindDirectoryAccessRights;
var Employee: TEmployee;
    Free: IDomainObjectBase;
begin

  if VarIsNull(EmployeeId) or VarIsEmpty(EmployeeId) then begin

    raise TReservoirKindReferenceServiceException.Create(
      'Недействительный идентификатор ' +
      'сотрудника обнаружен при попытке ' +
      'получения типов резервуаров'
    );
    
  end;

  Employee := FEmployeeRepository.FindEmployeeById(EmployeeId);

  if not Assigned(Employee) then begin

    raise TReservoirKindReferenceServiceException.Create(
      'Информация о сотруднике для получения ' +
      'типов резервуаров не найдена'
    );
    
  end;

  Free := Employee;

  Result :=
    FReservoirKindDirectoryAccessService
      .EnsureAndGetReservoirKindDirectoryAccessRightsForEmployee(
        Employee
      );

end;

end.
