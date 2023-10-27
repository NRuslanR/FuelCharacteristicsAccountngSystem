unit ReservoirKindReferenceSuiteCardFormViewModel;

interface

uses

  CardFormViewModel,
  SysUtils,
  Classes;

type

  TReservoirKindReferenceSuiteIdProperty = class (TCardIdProperty)

    private
    
      function GetReservoirKindReferenceSuiteId: String;
      procedure SetReservoirKindReferenceSuiteId(const Value: String);
    
    protected

      function AreValuesEquals(
        PropertyValue, AssignableValue: Variant
      ): Boolean; override;

    public

      constructor Create(const Name: String); override;
      
      property Value: String
      read GetReservoirKindReferenceSuiteId
      write SetReservoirKindReferenceSuiteId;
    
  end;

  TReservoirKindReferenceSuiteCardFormViewModel =
    class (TCardFormViewModel)

      private

        FHSCValue: TCardFormViewModelProperty;
        FCalibrationChartLocation: TCardFormViewModelProperty;

        function GetReservoirKindName: TCardFormViewModelProperty;
        function GetReservoirKindReferenceSuiteId: TReservoirKindReferenceSuiteIdProperty;

      protected

        function CreateIdProperty: TCardIdProperty; override;

        procedure RestoreProperties; override;
        
      public

        constructor Create; override;

        property Id: TReservoirKindReferenceSuiteIdProperty
        read GetReservoirKindReferenceSuiteId;
        
        property ReservoirKindName: TCardFormViewModelProperty
        read GetReservoirKindName;
        
        property HSCValue: TCardFormViewModelProperty
        read FHSCValue;
        
        property CalibrationChartLocation: TCardFormViewModelProperty
        read FCalibrationChartLocation;

    end;
  
implementation

uses

  Variants;
  
{ TReservoirKindReferenceSuiteCardFormViewModel }

function TReservoirKindReferenceSuiteCardFormViewModel.
  CreateIdProperty: TCardIdProperty;
begin

  Result := TReservoirKindReferenceSuiteIdProperty.Create('ReservoirKindName');

  Result.Value := '';
  Result.IsSurrogate := False;
  Result.Visible := True;
  
end;

constructor TReservoirKindReferenceSuiteCardFormViewModel.Create;
begin

  inherited;

  FHSCValue := AddProperty('HSCValue');
  FCalibrationChartLocation := AddProperty('CalibrationChartLocation');
  
end;

function TReservoirKindReferenceSuiteCardFormViewModel.
  GetReservoirKindName: TCardFormViewModelProperty;
begin

  Result := Id;
  
end;

function TReservoirKindReferenceSuiteCardFormViewModel.
  GetReservoirKindReferenceSuiteId: TReservoirKindReferenceSuiteIdProperty;
begin

  Result := TReservoirKindReferenceSuiteIdProperty(inherited Id);
  
end;

procedure TReservoirKindReferenceSuiteCardFormViewModel.RestoreProperties;
begin

  FId := TCardIdProperty(FindProperty('ReservoirKindName'));
  FHSCValue := FindProperty('HSCValue');
  FCalibrationChartLocation := FindProperty('CalibrationChartLocation');

end;

{ TReservoirKindReferenceSuiteIdProperty }

function TReservoirKindReferenceSuiteIdProperty.
  AreValuesEquals(
    PropertyValue, AssignableValue: Variant
  ): Boolean;
begin

  if not VarIsType(AssignableValue, varString) then begin

    raise Exception.Create(
      'Программная ошибка. Попытка назначить ' +
      'идентификатору справочных данных ' +
      'типа резервуаров НЕ строковое значение'
    );
    
  end;

  Result := inherited AreValuesEquals(PropertyValue, AssignableValue);

end;

constructor TReservoirKindReferenceSuiteIdProperty.Create(const Name: String);
begin

  inherited;

end;

function TReservoirKindReferenceSuiteIdProperty.
  GetReservoirKindReferenceSuiteId: String;
begin

  Result := inherited Value;
  
end;

procedure TReservoirKindReferenceSuiteIdProperty.
  SetReservoirKindReferenceSuiteId(
    const Value: String
  );
begin

  SetValue(Value);

end;

end.
