unit StandardEmployeeAccountingAppService;

interface

uses

  EmployeeAccountingAppService,
  EmployeeRepository,
  ISessionUnit,
  EmployeeDto,
  EmployeeMapper,
  Employee,
  SysUtils,
  Classes;

type

  TStandardEmployeeAccountingAppService =
    class (TInterfacedObject, IEmployeeAccountingAppService)

      private

        FEmployeeMapper: TEmployeeMapper;
        
      private

        FSession: ISession;
        FEmployeeRepository: IEmployeeRepository;

      public

        constructor Create(
          Session: ISession;
          EmployeeRepository: IEmployeeRepository
        );

        function GetEmployeeInfo(const EmployeeId: Variant): TEmployeeDto;

        function AddEmployeeInfo(EmployeeDto: TEmployeeDto): Variant;

        procedure ChangeEmployeeInfo(EmployeeDto: TEmployeeDto);

        procedure RemoveEmployeeInfo(const EmployeeId: Variant);
        
    end;
  
implementation

uses

  IDomainObjectBaseUnit;
  
{ TStandardEmployeeAccountingAppService }

constructor TStandardEmployeeAccountingAppService.Create(Session: ISession;
  EmployeeRepository: IEmployeeRepository);
begin

  inherited Create;

  FSession := Session;
  FEmployeeRepository := EmployeeRepository;

  FEmployeeMapper := TEmployeeMapper.Create;
  
end;

function TStandardEmployeeAccountingAppService.AddEmployeeInfo(
  EmployeeDto: TEmployeeDto): Variant;
var Employee: TEmployee;
    Free: IDomainObjectBase;
begin

  Employee := FEmployeeMapper.ToEntity(EmployeeDto);

  Free := Employee;
  
  FSession.Start;

  try

    FEmployeeRepository.AddEmployee(Employee);

    FSession.Commit;

    Result := Employee.Identity;
    
  except

    on e: Exception do begin

      FSession.Rollback;

      raise;

    end;

  end;

end;

procedure TStandardEmployeeAccountingAppService.ChangeEmployeeInfo(
  EmployeeDto: TEmployeeDto);
var Employee: TEmployee;
    Free: IDomainObjectBase;
begin

  Employee := FEmployeeMapper.ToEntity(EmployeeDto);

  Free := Employee;

  FSession.Start;

  try

    FEmployeeRepository.UpdateEmployee(Employee);

    FSession.Commit;
    
  except

    on e: Exception do begin

      FSession.Rollback;

      raise;
      
    end;

  end;

end;

function TStandardEmployeeAccountingAppService.GetEmployeeInfo(
  const EmployeeId: Variant): TEmployeeDto;
var Employee: TEmployee;
    Free: IDomainObjectBase;
begin

  Employee := FEmployeeRepository.FindEmployeeById(EmployeeId);

  if Assigned(Employee) then begin

    Free := Employee;

    Result := FEmployeeMapper.ToDto(Employee);

  end

  else Result := nil;

end;

procedure TStandardEmployeeAccountingAppService.RemoveEmployeeInfo(
  const EmployeeId: Variant);
var Employee: TEmployee;
    Free: IDomainObjectBase;
begin

  Employee := FEmployeeRepository.FindEmployeeById(EmployeeId);

  Free := Employee;

  FEmployeeRepository.RemoveEmployee(Employee);
  
end;

end.
