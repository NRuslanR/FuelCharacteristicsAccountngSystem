unit ReservoirCalibrationChart;

interface

uses

  DomainService,
  AbstractDomainService,
  DomainObjectValueUnit,
  TableData,
  DomainException;

type

  TReservoirCalibrationChartException = class (TDomainException)

  end;

  TReservoirCalibrationChartInput = class (TDomainObjectValue)

    private

      FRiseLevel: Single;

      procedure SetRiseLevel(const Value: Single);

    public

      constructor Create; overload; override;
      constructor Create(const RiseLevel: Single); overload;

      property RiseLevel: Single read FRiseLevel write SetRiseLevel;

  end;
  
  IReservoirCalibrationChart = interface (IDomainService)

    function GetVolume(Input: TReservoirCalibrationChartInput): Single;

  end;

  TTableCellValuesOrder = (voAscending, voDescending);
  
  TAbstractReservoirCalibrationChart =
    class abstract (TAbstractDomainService, IReservoirCalibrationChart)

      protected

        FTableData: ITableData;
        
      protected

        procedure EnsureTableDataValid(TableData: ITableData); virtual; abstract;

        procedure EnsureTableCellValuesTypeCastingToType(
          TableData: ITableData;
          const CastedCellValueType: Word;
          StartRowIndex: Integer = 0;
          StartColumnIndex: Integer = 0;
          EndRowIndex: Integer = 0;
          EndColumnIndex: Integer = 0
        ); virtual;

        procedure EnsureTableCellValuesOrdered(
          TableData: ITableData;
          const Order: TTableCellValuesOrder = voAscending;
          StartRowIndex: Integer = 0;
          StartColumnIndex: Integer = 0;
          EndRowIndex: Integer = 0;
          EndColumnIndex: Integer = 0
        ); virtual;

      protected

        function IsCellValuesOrdered(
          LeftCellValue, RightCellValue: Variant;
          const Order: TTableCellValuesOrder
        ): Boolean; virtual;

        procedure RaiseExceptionIfCellValuesNotOrdered(
          LeftCellValue, RightCellValue: Variant;
          const Order: TTableCellValuesOrder
        ); virtual;

      public

        constructor Create(TableData: ITableData);

        function GetVolume(Input: TReservoirCalibrationChartInput): Single;
          virtual; abstract;
      
    end;

implementation

uses

  Variants;
  
{ TReservoirCalibrationChartInput }

constructor TReservoirCalibrationChartInput.Create(const RiseLevel: Single);
begin

  inherited Create;

  Self.RiseLevel := RiseLevel;
  
end;

constructor TReservoirCalibrationChartInput.Create;
begin

  inherited;

end;

procedure TReservoirCalibrationChartInput.SetRiseLevel(const Value: Single);
begin

  FRiseLevel := Value;

end;

{ TAbstractReservoirCalibrationChart }

constructor TAbstractReservoirCalibrationChart.Create(TableData: ITableData);
begin

  inherited Create;

  EnsureTableDataValid(TableData);

  FTableData := TableData;

end;

procedure TAbstractReservoirCalibrationChart.EnsureTableCellValuesOrdered(
  TableData: ITableData;
  const Order: TTableCellValuesOrder;
  StartRowIndex, StartColumnIndex, EndRowIndex, EndColumnIndex: Integer
);
var I, J: Integer;
    OrderedCellValue, CurrentCellValue: Variant;
begin

  if EndRowIndex = 0 then
    EndRowIndex := TableData.RowCount - 1;

  if EndColumnIndex = 0 then
    EndColumnIndex := TableData.ColumnCount - 1;

  OrderedCellValue := TableData[StartRowIndex, StartColumnIndex];

  for I := StartRowIndex to TableData.RowCount - 1 do begin

    for J := StartColumnIndex + 1 to TableData.ColumnCount - 1 do begin

      CurrentCellValue := TableData[I, J];

      RaiseExceptionIfCellValuesNotOrdered(
        OrderedCellValue, CurrentCellValue, Order
      );

      OrderedCellValue := CurrentCellValue;

    end;

  end;

end;

procedure TAbstractReservoirCalibrationChart.
  EnsureTableCellValuesTypeCastingToType(
    TableData: ITableData;
    const CastedCellValueType: Word;
    StartRowIndex: Integer;
    StartColumnIndex: Integer;
    EndRowIndex: Integer;
    EndColumnIndex: Integer
  );
var I, J: Integer;
    CellValue: Variant;
begin

  if EndRowIndex = 0 then
    EndRowIndex := TableData.RowCount - 1;

  if EndColumnIndex = 0 then
    EndColumnIndex := TableData.ColumnCount - 1;
    
  for I := StartRowIndex to EndRowIndex do begin

    for J := StartColumnIndex to EndColumnIndex do begin

      CellValue := TableData[I, J];
      
      try

        VarAsType(CellValue, CastedCellValueType);

      except

        on e: EVariantTypeCastError do begin

          raise TReservoirCalibrationChartException.Create(
            'ќдна из €чеек градуировочной таблицы ' +
            'содержала значение недействительного типа'
          );

        end;

      end;

    end;

  end;

end;

function TAbstractReservoirCalibrationChart.IsCellValuesOrdered(
  LeftCellValue, RightCellValue: Variant;
  const Order: TTableCellValuesOrder
): Boolean;

  function IfThenElse(
    const Condition: Boolean;
    const TrueBoolExpression: Boolean;
    const FalseBoolExpression: Boolean
  ): Boolean;
  begin

    if Condition then
      Result := TrueBoolExpression

    else Result := FalseBoolExpression

  end;

begin

  Result :=
    IfThenElse(
      Order = voAscending,
      LeftCellValue <= RightCellValue,
      LeftCellValue >= RightCellValue
    );

end;

procedure TAbstractReservoirCalibrationChart.
  RaiseExceptionIfCellValuesNotOrdered(
    LeftCellValue, RightCellValue: Variant;
    const Order: TTableCellValuesOrder
);
begin

  if not IsCellValuesOrdered(LeftCellValue, RightCellValue, Order)
  then begin

    raise TReservoirCalibrationChartException.Create(
      'ячейки градуировочной таблицы ' +
      'не упор€дочены'
    );

  end;
  
end;

end.
