unit StandardEmployeeAccountsManagementService;

interface

uses

  EmployeeAccountsManagementService,
  EmployeeAccountingAppService,
  EmployeeAccountsAccessRightsService,
  EmployeeLogOnInfoService,
  EmployeeAccountDto,
  ISessionUnit,
  SysUtils,
  Classes;

type

  TStandardEmployeeAccountsManagementService =
    class (TInterfacedObject, IEmployeeAccountsManagementService)

      private

        FSession: ISession;
        FEmployeeAccountsAccessRightsService: IEmployeeAccountsAccessRightsService;
        FEmployeeAccountingAppService: IEmployeeAccountingAppService;
        FEmployeeLogOnInfoService: IEmployeeLogOnInfoService;
        
      public

        constructor Create(
          Session: ISession;
          EmployeeAccountsAccessRightsService: IEmployeeAccountsAccessRightsService;
          EmployeeAccountingAppService: IEmployeeAccountingAppService;
          EmployeeLogOnInfoService: IEmployeeLogOnInfoService
        );

        function GetEmployeeAccount(
          const ClientIdentity: Variant;
          const EmployeeAccountId: Variant
        ): TEmployeeAccountDto;

        function AddEmployeeAccount(
          const ClientIdentity: Variant;
          const EmployeeAccountDto: TEmployeeAccountDto
        ): Variant;

        procedure ChangeEmployeeAccount(
          const ClientIdentity: Variant;
          const EmployeeAccountDto: TEmployeeAccountDto
        );

        procedure RemoveEmployeeAccount(
          const ClientIdentity: Variant;
          const EmployeeAccountId: Variant
        );

    end;
  
implementation

{ TStandardEmployeeAccountsManagementService }

constructor TStandardEmployeeAccountsManagementService.Create(
  Session: ISession;
  EmployeeAccountsAccessRightsService: IEmployeeAccountsAccessRightsService;
  EmployeeAccountingAppService: IEmployeeAccountingAppService;
  EmployeeLogOnInfoService: IEmployeeLogOnInfoService
);
begin

  inherited Create;

  FSession := Session;
  FEmployeeAccountsAccessRightsService := EmployeeAccountsAccessRightsService;
  FEmployeeAccountingAppService := EmployeeAccountingAppService;
  FEmployeeLogOnInfoService := EmployeeLogOnInfoService;
  
end;

function TStandardEmployeeAccountsManagementService.AddEmployeeAccount(
  const ClientIdentity: Variant;
  const EmployeeAccountDto: TEmployeeAccountDto
): Variant;
var AddedEmployeeId: Variant;
begin

  FSession.Start;

  try
                               
    FEmployeeAccountsAccessRightsService.
      EnsureClientHasAccessRightsForEmployeeAccounts(ClientIdentity);

    AddedEmployeeId :=
      FEmployeeAccountingAppService.AddEmployeeInfo(
        EmployeeAccountDto.EmployeeDto
      );

    FEmployeeLogOnInfoService.AddEmployeeLogOnInfo(
      ClientIdentity,
      AddedEmployeeId,
      EmployeeAccountDto.LogOnInfoDto
    );

    FSession.Commit;

    Result := AddedEmployeeId;
    
  except

    on e: Exception do begin

      FSession.Rollback;

      raise;

    end;

  end;

end;

procedure TStandardEmployeeAccountsManagementService.ChangeEmployeeAccount(
  const ClientIdentity: Variant;
  const EmployeeAccountDto: TEmployeeAccountDto
);
begin

  FSession.Start;

  try

    FEmployeeAccountsAccessRightsService
      .EnsureClientHasAccessRightsForEmployeeAccounts(ClientIdentity);

    FEmployeeAccountingAppService.ChangeEmployeeInfo(
      EmployeeAccountDto.EmployeeDto
    );

    FEmployeeLogOnInfoService.ChangeEmployeeLogOnInfo(
      ClientIdentity,
      EmployeeAccountDto.EmployeeDto.Id,
      EmployeeAccountDto.LogOnInfoDto
    );

    FSession.Commit;

  except

    on e: Exception do begin

      FSession.Rollback;

      raise;

    end;

  end;

end;

function TStandardEmployeeAccountsManagementService.GetEmployeeAccount(
  const ClientIdentity, EmployeeAccountId: Variant
): TEmployeeAccountDto;
begin

  FEmployeeAccountsAccessRightsService
    .EnsureClientHasAccessRightsForEmployeeAccounts(ClientIdentity);

  Result := TEmployeeAccountDto.Create;

  try

    Result.EmployeeDto :=
      FEmployeeAccountingAppService.GetEmployeeInfo(EmployeeAccountId);

    Result.LogOnInfoDto :=
      FEmployeeLogOnInfoService.GetEmployeeLogOnInfo(
        ClientIdentity, EmployeeAccountId
      );
      
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

procedure TStandardEmployeeAccountsManagementService.RemoveEmployeeAccount(
  const ClientIdentity, EmployeeAccountId: Variant
);
begin

  FSession.Start;

  try

    FEmployeeAccountsAccessRightsService
      .EnsureClientHasAccessRightsForEmployeeAccounts(ClientIdentity);

    FEmployeeLogOnInfoService.RemoveEmployeeLogOnInfo(
      ClientIdentity, EmployeeAccountId
    );

    FEmployeeAccountingAppService.RemoveEmployeeInfo(
      EmployeeAccountId
    );

    FSession.Commit;
    
  except

    on e: Exception do begin

      FSession.Rollback;

      raise;
      
    end;

  end;

end;

end.
