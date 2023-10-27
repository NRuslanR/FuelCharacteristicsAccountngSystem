unit EmployeeAccountDtoMapper;

interface

uses

  EmployeeAdministrationCardFormViewModel,
  EmployeeDtoMapper,
  LogOnInfoDtoMapper,
  EmployeeAccountDto,
  SysUtils,
  Classes;

type

  TEmployeeAccountDtoMapper = class

    private

      FEmployeeDtoMapper: TEmployeeDtoMapper;
      FLogOnInfoDtoMapper: TLogOnInfoDtoMapper;
      
    public

      destructor Destroy; override;

      constructor Create;

      function MapEmployeeAccountDtoFrom(

        EmployeeAdministrationCardFormViewModel:
          TEmployeeAdministrationCardFormViewModel
          
      ): TEmployeeAccountDto; virtual;

  end;
  
implementation

{ TEmployeeAccountDtoMapper }

constructor TEmployeeAccountDtoMapper.Create;
begin

  inherited;

  FEmployeeDtoMapper := TEmployeeDtoMapper.Create;
  FLogOnInfoDtoMapper := TLogOnInfoDtoMapper.Create;
  
end;

destructor TEmployeeAccountDtoMapper.Destroy;
begin

  FreeAndNil(FEmployeeDtoMapper);
  FreeAndNil(FLogOnInfoDtoMapper);
  
  inherited;

end;

function TEmployeeAccountDtoMapper.MapEmployeeAccountDtoFrom(

    EmployeeAdministrationCardFormViewModel:
      TEmployeeAdministrationCardFormViewModel

): TEmployeeAccountDto;
begin

  Result := TEmployeeAccountDto.Create;

  try

    Result.EmployeeDto :=
      FEmployeeDtoMapper.MapEmployeeDtoFrom(
        EmployeeAdministrationCardFormViewModel
      );

    Result.LogOnInfoDto :=
      FLogOnInfoDtoMapper.MapLogOnInfoDtoFrom(
        EmployeeAdministrationCardFormViewModel
      );

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

end.
