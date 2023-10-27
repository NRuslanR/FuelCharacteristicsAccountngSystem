unit EmployeeDtoMapper;

interface

uses

  EmployeeDto,
  EmployeeAdministrationCardFormViewModel,
  EntityDtoMapper,
  CardFormViewModel,
  RoleDtoMapper,
  EntityDto,
  SysUtils,
  Classes;

type

  TEmployeeDtoMapper = class (TEntityDtoMapper)

    private

      FRoleDtoMapper: TRoleDtoMapper;

    protected

      function GetEntityDtoClass: TEntityDtoClass; override;

      procedure FillEntityDtoFrom(
        EntityDto: TEntityDto;
        CardFormViewModel: TCardFormViewModel
      ); override;
    
    public

      destructor Destroy; override;

      constructor Create;

      function MapEmployeeDtoFrom(

        EmployeeAdministrationCardFormViewModel:
          TEmployeeAdministrationCardFormViewModel

      ): TEmployeeDto;

      
  end;
  

implementation

{ TEmployeeDtoMapper }

constructor TEmployeeDtoMapper.Create;
begin

  inherited;

  FRoleDtoMapper := TRoleDtoMapper.Create;

end;

destructor TEmployeeDtoMapper.Destroy;
begin

  FreeAndNil(FRoleDtoMapper);
  
  inherited;

end;

procedure TEmployeeDtoMapper.FillEntityDtoFrom(
  EntityDto: TEntityDto;
  CardFormViewModel: TCardFormViewModel
);
var EmployeeDto: TEmployeeDto;
begin

  inherited;

  EmployeeDto := TEmployeeDto(EntityDto);

  with CardFormViewModel as TEmployeeAdministrationCardFormViewModel do begin

    EmployeeDto.Name := Name.Value;
    EmployeeDto.Surname := Surname.Value;
    EmployeeDto.Patronymic := Patronymic.Value;
    EmployeeDto.BirthDate := BirthDate.Value;
    EmployeeDto.Speciality := Speciality.Value;

    if CurrentRoleName.IsAssigned then begin

      EmployeeDto.RoleDto :=
        FRoleDtoMapper.MapRoleDtoFrom(
          RoleViewModels.FindRoleViewModelByName(CurrentRoleName.Value)
        );
        
    end;

  end;

end;

function TEmployeeDtoMapper.GetEntityDtoClass: TEntityDtoClass;
begin

  Result := TEmployeeDto;
  
end;

function TEmployeeDtoMapper.MapEmployeeDtoFrom(

  EmployeeAdministrationCardFormViewModel:
    TEmployeeAdministrationCardFormViewModel

): TEmployeeDto;
begin

  Result :=
    TEmployeeDto(MapEntityDtoFrom(EmployeeAdministrationCardFormViewModel));

end;

end.
