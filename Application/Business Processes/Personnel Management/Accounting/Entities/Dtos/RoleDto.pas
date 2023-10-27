unit RoleDto;

interface

uses

  EntityDto;

type

  TRoleDto = class (TEntityDto)

    public

      Name: String;
      DisplayName: String;

      constructor Create; override;

  end;

  TRoleDtos = class;

  TRoleDtosEnumerator = class (TEntityDtosEnumerator)

    protected

      function GetCurrentRoleDto: TRoleDto;

    public

      constructor Create(RoleDtos: TRoleDtos);

      property Current: TRoleDto read GetCurrentRoleDto;

  end;
   
  TRoleDtos = class (TEntityDtos)

    protected

      function GetRoleDtoByIndex(Index: Integer): TRoleDto;
      procedure SetRoleDtoByIndex(Index: Integer; const Value: TRoleDto);
      
    public

      function Add(RoleDto: TRoleDto): Integer;
      procedure Remove(RoleDto: TRoleDto);

      function FindById(const Id: Variant): TRoleDto;

      function GetEnumerator: TRoleDtosEnumerator;

      property Items[Index: Integer]: TRoleDto
      read GetRoleDtoByIndex write SetRoleDtoByIndex;
      
  end;

implementation

{ TRoleDtosEnumerator }

constructor TRoleDtosEnumerator.Create(RoleDtos: TRoleDtos);
begin

  inherited Create(RoleDtos);

end;

function TRoleDtosEnumerator.GetCurrentRoleDto: TRoleDto;
begin

  Result := TRoleDto(GetCurrentEntityDto);
  
end;

{ TRoleDtos }

function TRoleDtos.Add(RoleDto: TRoleDto): Integer;
begin

  Result := inherited Add(RoleDto);

end;

function TRoleDtos.FindById(const Id: Variant): TRoleDto;
begin

  Result := TRoleDto(inherited FindById(Id));
  
end;

function TRoleDtos.GetEnumerator: TRoleDtosEnumerator;
begin

  Result := TRoleDtosEnumerator.Create(Self);
  
end;

function TRoleDtos.GetRoleDtoByIndex(Index: Integer): TRoleDto;
begin

  Result := TRoleDto(GetEntityDtoByIndex(Index));
  
end;

procedure TRoleDtos.Remove(RoleDto: TRoleDto);
begin

  inherited Remove(RoleDto);
  
end;

procedure TRoleDtos.SetRoleDtoByIndex(Index: Integer; const Value: TRoleDto);
begin

  SetEntityDtoByIndex(Index, Value);

end;

{ TRoleDto }

constructor TRoleDto.Create;
begin

  inherited;

end;

end.
