unit StandardReservoirSubLayerKindAccountingService;

interface

uses

  AbstractDomainService,
  ReservoirSubLayerKindAccountingService,
  ReservoirSubLayerKind,
  SysUtils,
  Classes;

type

  TStandardReservoirSubLayerKindAccountingService =
    class (
      TAbstractStandardDomainService,
      IReservoirSubLayerKindAccountingService
    )

      public

        function TakeAllReservoirSubLayerKinds: TReservoirSubLayerKinds; virtual;

        function TakeReservoirSubLayerKind(
          const ReservoirSubLayerKindName: String
        ): TReservoirSubLayerKind; virtual;

    end;

implementation

{ TStandardReservoirSubLayerKindAccountingService }

function TStandardReservoirSubLayerKindAccountingService.
  TakeAllReservoirSubLayerKinds: TReservoirSubLayerKinds;
begin

  Result := TReservoirSubLayerKinds.Create;

  try

    Result.Add(TReservoirBottomWater.Create);
    Result.Add(TReservoirIce.Create);
    
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

function TStandardReservoirSubLayerKindAccountingService.
  TakeReservoirSubLayerKind(
    const ReservoirSubLayerKindName: String
  ): TReservoirSubLayerKind;
begin

  if Trim(ReservoirSubLayerKindName) = '' then begin

    raise TReservoirSubLayerKindAccountingServiceException.Create(
      '�� ������ ������������ ' +
      '���� ������������� ������� ' +
      '��� ��������� ���������� �� ����'
    );
    
  end;

  if ReservoirSubLayerKindName = ICE_SUB_LAYER_KIND_NAME then
    Result := TReservoirIce.Create

  else if ReservoirSubLayerKindName = BOTTOM_WATER_SUB_LAYER_KIND_NAME
  then Result := TReservoirBottomWater.Create

  else begin

    raise TReservoirSubLayerKindAccountingServiceException.CreateFmt(
      '���������� � ���� ������������� ������� ' +
      '"%s" �� �������',
      [
        ReservoirSubLayerKindName
      ]
    );

  end;
  
end;

end.
