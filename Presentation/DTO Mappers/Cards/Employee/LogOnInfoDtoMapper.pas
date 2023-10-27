unit LogOnInfoDtoMapper;

interface

uses

  LogOnInfoDto,
  EmployeeAdministrationCardFormViewModel,
  SysUtils,
  Classes;

type

  TLogOnInfoDtoMapper = class

    public

      function MapLogOnInfoDtoFrom(

        EmployeeAdministrationCardFormViewModel:
          TEmployeeAdministrationCardFormViewModel

      ): TLogOnInfoDto;
      
  end;

implementation

{ TLogOnInfoDtoMapper }

function TLogOnInfoDtoMapper.MapLogOnInfoDtoFrom(

  EmployeeAdministrationCardFormViewModel:
    TEmployeeAdministrationCardFormViewModel

): TLogOnInfoDto;
begin

  Result := TLogOnInfoDto.Create;

  try

    Result.Login := EmployeeAdministrationCardFormViewModel.Login.Value;
    Result.Password := EmployeeAdministrationCardFormViewModel.Password.Value;

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;

    end;

  end;

end;

end.
