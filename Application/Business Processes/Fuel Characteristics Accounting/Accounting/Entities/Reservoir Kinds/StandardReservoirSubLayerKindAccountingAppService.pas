unit StandardReservoirSubLayerKindAccountingAppService;

interface

uses

  ReservoirSubLayerKindAccountingAppService,
  ReservoirSubLayerKindAccountingService,
  ReservoirSubLayerKindDto,
  ReservoirSubLayerKindIdResolver,
  ReservoirSubLayerKind,
  SysUtils,
  Classes;

type

  TStandardReservoirSubLayerKindAccountingAppService =
    class (TInterfacedObject, IReservoirSubLayerKindAccountingAppService)

      private

        FReservoirSubLayerKindAccountingService:
          IReservoirSubLayerKindAccountingService;

        FReservoirSubLayerKindIdResolver: IReservoirSubLayerKindIdResolver;
        
      private

        function MapReservoirSubLayerKindDtosFrom(
          ReservoirSubLayerKinds: TReservoirSubLayerKinds
        ): TReservoirSubLayerKindDtos;
        
        function MapReservoirSubLayerKindDtoFrom(
          ReservoirSubLayerKind: TReservoirSubLayerKind
        ): TReservoirSubLayerKindDto;
        
      public

        constructor Create(

          ReservoirSubLayerKindAccountingService:
            IReservoirSubLayerKindAccountingService;

          ReservoirSubLayerKindIdResolver: IReservoirSubLayerKindIdResolver
          
        );
        
        function GetAllReservoirSubLayerKinds: TReservoirSubLayerKindDtos;

        function GetReservoirSubLayerKindByName(
          const ReservoirSubLayerKindName: String
        ): TReservoirSubLayerKindDto;

    end;

implementation

uses

  IDomainObjectBaseUnit,
  IDomainObjectBaseListUnit;
  
{ TStandardReservoirSubLayerKindAccountingAppService }

constructor TStandardReservoirSubLayerKindAccountingAppService.Create(

  ReservoirSubLayerKindAccountingService:
    IReservoirSubLayerKindAccountingService;

  ReservoirSubLayerKindIdResolver: IReservoirSubLayerKindIdResolver

);
begin

  inherited Create;

  FReservoirSubLayerKindAccountingService :=
    ReservoirSubLayerKindAccountingService;

  FReservoirSubLayerKindIdResolver := ReservoirSubLayerKindIdResolver;
  
end;

function TStandardReservoirSubLayerKindAccountingAppService.
  MapReservoirSubLayerKindDtoFrom(
    ReservoirSubLayerKind: TReservoirSubLayerKind
  ): TReservoirSubLayerKindDto;
begin

  Result := TReservoirSubLayerKindDto.Create;

  Result.Id :=
    FReservoirSubLayerKindIdResolver
      .ResolveReservoirSubLayerKindIdFrom(ReservoirSubLayerKind);
      
  Result.Name := ReservoirSubLayerKind.Name;
  
end;

function TStandardReservoirSubLayerKindAccountingAppService.
  MapReservoirSubLayerKindDtosFrom(
    ReservoirSubLayerKinds: TReservoirSubLayerKinds
  ): TReservoirSubLayerKindDtos;
var ReservoirSubLayerKind: TReservoirSubLayerKind;
begin

  Result := TReservoirSubLayerKindDtos.Create;

  try

    for ReservoirSubLayerKind in ReservoirSubLayerKinds do
      Result.Add(MapReservoirSubLayerKindDtoFrom(ReservoirSubLayerKind));

  except

    on E: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

function TStandardReservoirSubLayerKindAccountingAppService.
  GetAllReservoirSubLayerKinds: TReservoirSubLayerKindDtos;
var ReservoirSubLayerKinds: TReservoirSubLayerKinds;
    Free: IDomainObjectBaseList;
begin

  ReservoirSubLayerKinds :=
    FReservoirSubLayerKindAccountingService
      .TakeAllReservoirSubLayerKinds;

  Free := ReservoirSubLayerKinds;

  Result := MapReservoirSubLayerKindDtosFrom(ReservoirSubLayerKinds);

end;

function TStandardReservoirSubLayerKindAccountingAppService.
  GetReservoirSubLayerKindByName(
    const ReservoirSubLayerKindName: String
  ): TReservoirSubLayerKindDto;
var ReservoirSubLayerKind: TReservoirSubLayerKind;
    Free: IDomainObjectBase;
begin

  ReservoirSubLayerKind :=
    FReservoirSubLayerKindAccountingService
      .TakeReservoirSubLayerKind(ReservoirSubLayerKindName);

  Free := ReservoirSubLayerKind;
  
  Result := MapReservoirSubLayerKindDtoFrom(ReservoirSubLayerKind);

end;

end.
