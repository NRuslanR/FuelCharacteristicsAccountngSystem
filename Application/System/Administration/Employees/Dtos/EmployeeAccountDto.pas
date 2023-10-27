unit EmployeeAccountDto;

interface

uses

  EmployeeDto,
  LogOnInfoDto,
  SysUtils,
  Classes;

type

  TEmployeeAccountDto = class

    public

      EmployeeDto: TEmployeeDto;
      LogOnInfoDto: TLogOnInfoDto;

      destructor Destroy; override;
      
  end;

implementation

{ TEmployeeAccountDto }

destructor TEmployeeAccountDto.Destroy;
begin

  FreeAndNil(EmployeeDto);
  FreeAndNil(LogOnInfoDto);
  
  inherited;

end;

end.
