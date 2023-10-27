unit NGEReservoirCalibrationChart;

interface

uses

  TableData,
  ReservoirCalibrationChart,
  SysUtils,
  Classes;

type

  TNGEReservoirCalibrationChart = class (TAbstractReservoirCalibrationChart)

    private

      type

        TVolumeByRiseLevelSearchResult = record

          ExactMatch: Boolean;

          Volume: Single;

          LowerRiseLevel, LowerVolume: Single;
          UpperRiseLevel, UpperVolume: Single;
          
        end;

    private

      FStartNumberRowIndex: Integer;

    protected
      
      procedure EnsureTableDataValid(TableData: ITableData); override;

      procedure EnsureTableCellValuesOrdered(
        TableData: ITableData;
        const Order: TTableCellValuesOrder = voAscending;
        StartRowIndex: Integer = 0;
        StartColumnIndex: Integer = 0;
        EndRowIndex: Integer = 0;
        EndColumnIndex: Integer = 0
      ); override;

    protected

      function IsNGETableHeaderExists(TableData: ITableData): Boolean;

      procedure EnsureColumnCountIsEvenNumber(TableData: ITableData);

    protected

      function FindVolumeByRiseLevel(
        const RiseLevel: Single
      ): TNGEReservoirCalibrationChart.TVolumeByRiseLevelSearchResult;
      
    public

      function GetVolume(Input: TReservoirCalibrationChartInput): Single; override;
      
  end;

implementation

uses

  Variants,
  NumericInterpolation,
  AuxDebugFunctionsUnit;

{ TNGEReservoirCalibrationChart }

function TNGEReservoirCalibrationChart.IsNGETableHeaderExists(
  TableData: ITableData
): Boolean;
var J: Integer;
    StringCellCount, RestTypeCellCount: Integer;
begin

  StringCellCount := 0;
  RestTypeCellCount := 0;

  for J := 0 to TableData.ColumnCount - 1 do begin

    if
      VarIsType(TableData[0, J], varString) or
      VarIsType(TableData[0, J], varOleStr)
    then
      Inc(StringCellCount)

    else Inc(RestTypeCellCount);

  end;

  if (StringCellCount > 0) and (RestTypeCellCount > 0) then begin

    raise TReservoirCalibrationChartException.Create(
      'Некорректный заголовок ' +
      'градуировочной таблицы'
    );
    
  end;

  Result := RestTypeCellCount = 0;

end;

procedure TNGEReservoirCalibrationChart.EnsureColumnCountIsEvenNumber(
  TableData: ITableData);
begin

  if TableData.ColumnCount mod 2 <> 0 then begin

    raise TReservoirCalibrationChartException.Create(
      'Градуировочная таблица должна ' +
      'содержать чётное количество столбцов'
    );
    
  end;

end;

procedure TNGEReservoirCalibrationChart.EnsureTableCellValuesOrdered(
  TableData: ITableData;
  const Order: TTableCellValuesOrder;
  StartRowIndex, StartColumnIndex, EndRowIndex, EndColumnIndex: Integer
);
var OrderedCellValue, CurrentCellValue: Variant;
    StartEvenColumnIndex, StartOddColumnIndex: Integer;
    I, J, K: Integer;
begin

  StartEvenColumnIndex := 0;
  StartOddColumnIndex := 1;

  for K := StartEvenColumnIndex to StartOddColumnIndex do begin

    J := K;

    OrderedCellValue := TableData[StartRowIndex, J];

    I := StartRowIndex + 1;
    
    while J < TableData.ColumnCount do begin

      while I < TableData.RowCount do begin

        CurrentCellValue := TableData[I, J];

        RaiseExceptionIfCellValuesNotOrdered(
          OrderedCellValue, CurrentCellValue, voDescending
        );

        OrderedCellValue := CurrentCellValue;

        Inc(I);
        
      end;

      I := StartRowIndex;
      
      Inc(J, 2);

    end;

  end;

  for I := StartRowIndex to TableData.RowCount - 1 do begin

    J := 0;

    while J < TableData.ColumnCount - 1 do begin

      RaiseExceptionIfCellValuesNotOrdered(
        TableData[I, J], TableData[I, J + 1], voAscending
      );

      Inc(J, 2);
      
    end;

  end;

end;

procedure TNGEReservoirCalibrationChart.EnsureTableDataValid(
  TableData: ITableData
);
var StartNumberColumnIndex: Integer;
    StartEvenColumnIndex, StartOddColumnIndex, HalfColumnCount: Integer;
    I, J: Integer;
begin

  inherited;

  EnsureColumnCountIsEvenNumber(TableData);
  
  if IsNGETableHeaderExists(TableData) then
    FStartNumberRowIndex := 1

  else
    FStartNumberRowIndex := 0;

  StartNumberColumnIndex := 0;

  EnsureTableCellValuesTypeCastingToType(
    TableData, varSingle, FStartNumberRowIndex, StartNumberColumnIndex
  );

  EnsureTableCellValuesOrdered(
    TableData, voDescending, FStartNumberRowIndex, StartNumberColumnIndex
  );

end;

function TNGEReservoirCalibrationChart.FindVolumeByRiseLevel(
  const RiseLevel: Single
): TNGEReservoirCalibrationChart.TVolumeByRiseLevelSearchResult;
var

    RiseLevelColumnIndex: Integer;

    LowerRiseLevelRowIndex, NearestRiseLevelRowIndex, UpperRiseLevelRowIndex: Integer;
    LowerRiseLevelColumnIndex, UpperRiseLevelColumnIndex: Integer;

  procedure EnsureRiseLevelIsNotOutOfBound(const RiseLevel: Single);
  begin

    if
      (RiseLevel > FTableData[FStartNumberRowIndex, 0]) or
      (FTableData[FTableData.RowCount - 1, FTableData.ColumnCount - 2] > RiseLevel)
    then begin

      raise TReservoirCalibrationChartException.Create(
        'Уровень взлива топлива или высота подслоя ' +
        'вне диапазона граудировочной таблицы'
      );

    end;

  end;

  function GetRiseLevelColumnIndex(const RiseLevel: Single): Integer;
    const

      StartEvenColumnIndex = 0;
  begin

    Result := StartEvenColumnIndex;

    while
      (Result < FTableData.ColumnCount) and
      (RiseLevel < FTableData[FTableData.RowCount - 1, Result])

    do Inc(Result, 2);

  end;

  function GetRiseLevelRowLocation(
    const RiseLevel: Single;
    const ColumnIndex: Integer;
    var NearestRowIndex: Integer;
    var LowerRowIndex: Integer;
    var UpperRowIndex: Integer
  ): Boolean;
  var
     CellValue: Variant;
  begin

    LowerRiseLevelRowIndex := FStartNumberRowIndex;
    UpperRiseLevelRowIndex := FTableData.RowCount - 1;
    
    while True do begin

      NearestRowIndex := (LowerRowIndex + UpperRowIndex) div 2;

      if
        (NearestRowIndex < LowerRowIndex) or
        (NearestRowIndex > UpperRowIndex)
      then begin

        Result := False;
        Exit;
        
      end;

      CellValue := FTableData[NearestRowIndex, ColumnIndex];

      if RiseLevel > CellValue then
        UpperRowIndex := NearestRowIndex - 1

      else if RiseLevel < CellValue then
        LowerRowIndex := NearestRowIndex + 1

      else begin

        Result := True;
        Exit;

      end;

    end;

  end;

  function CreateSuccessSearchResultFrom(
    const RiseLevelColumnIndex: Integer;
    const NearestRiseLevelRowIndex: Integer
  ): TVolumeByRiseLevelSearchResult;
  begin

    Result.ExactMatch := True;

    Result.Volume :=
      FTableData[
        NearestRiseLevelRowIndex,
        RiseLevelColumnIndex + 1
      ];

    Result.LowerRiseLevel := 0;
    Result.LowerVolume := 0;
    Result.UpperRiseLevel := 0;
    Result.UpperVolume := 0;
    
  end;
  
  function CreatePartialSearchResultFrom(
    const RiseLevelColumnIndex: Integer;
    NearestRiseLevelRowIndex: Integer;
    LowerRiseLevelRowIndex: Integer;
    UpperRiseLevelRowIndex: Integer
  ): TVolumeByRiseLevelSearchResult;
  begin

    Result.ExactMatch := False;
    Result.Volume := 0;
    
    if NearestRiseLevelRowIndex < LowerRiseLevelRowIndex then begin

      LowerRiseLevelColumnIndex := RiseLevelColumnIndex;

      UpperRiseLevelRowIndex := NearestRiseLevelRowIndex;

      if UpperRiseLevelRowIndex < FStartNumberRowIndex then begin

        UpperRiseLevelRowIndex := FTableData.RowCount - 1;
        UpperRiseLevelColumnIndex := RiseLevelColumnIndex - 2;

      end

      else UpperRiseLevelColumnIndex := RiseLevelColumnIndex;

    end

    else begin

      LowerRiseLevelRowIndex := NearestRiseLevelRowIndex;

      if LowerRiseLevelRowIndex = FTableData.RowCount then begin

        LowerRiseLevelRowIndex := FStartNumberRowIndex;
        LowerRiseLevelColumnIndex := RiseLevelColumnIndex + 2;

      end

      else LowerRiseLevelColumnIndex := RiseLevelColumnIndex;

    end;

    Result.LowerRiseLevel :=
      FTableData[LowerRiseLevelRowIndex, LowerRiseLevelColumnIndex];

    Result.LowerVolume :=
      FTableData[LowerRiseLevelRowIndex, LowerRiseLevelColumnIndex + 1];

    Result.UpperRiseLevel :=
      FTableData[UpperRiseLevelRowIndex, UpperRiseLevelColumnIndex];

    Result.UpperVolume :=
      FTableData[UpperRiseLevelRowIndex, UpperRiseLevelColumnIndex + 1];

  end;

begin

  EnsureRiseLevelIsNotOutOfBound(RiseLevel);

  RiseLevelColumnIndex := GetRiseLevelColumnIndex(RiseLevel);

  if
    GetRiseLevelRowLocation(
      RiseLevel,
      RiseLevelColumnIndex,
      NearestRiseLevelRowIndex,
      LowerRiseLevelRowIndex,
      UpperRiseLevelRowIndex
    )
  then begin

    Result :=
      CreateSuccessSearchResultFrom(
        RiseLevelColumnIndex, NearestRiseLevelRowIndex
      );
      
  end

  else begin

    Result :=
      CreatePartialSearchResultFrom(
        RiseLevelColumnIndex,
        NearestRiseLevelRowIndex,
        LowerRiseLevelRowIndex,
        UpperRiseLevelRowIndex
      );
      
  end;

end;

function TNGEReservoirCalibrationChart.GetVolume(
  Input: TReservoirCalibrationChartInput
): Single;
var SearchResult: TVolumeByRiseLevelSearchResult;
    RiseLevel_cm: Single;
begin

  RiseLevel_cm := Input.RiseLevel / 10;
  
  SearchResult := FindVolumeByRiseLevel(RiseLevel_cm);

  if SearchResult.ExactMatch then
    Result := SearchResult.Volume

  else begin

    with SearchResult do begin

      Result :=
        TNumericInterpolation.LinearlyInterpolateY(
          LowerRiseLevel, LowerVolume,
          UpperRiseLevel, UpperVolume,
          RiseLevel_cm
        );

    end;
    
  end;

  Result := Result / 1000;

end;

end.
