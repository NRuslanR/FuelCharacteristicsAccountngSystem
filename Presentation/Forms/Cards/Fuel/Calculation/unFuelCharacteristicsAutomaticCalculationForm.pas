unit unFuelCharacteristicsAutomaticCalculationForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCardForm, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  StdCtrls, cxButtons, ValidateEditUnit, RegExprValidateEditUnit, cxControls,
  cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit,
  cxMaskEdit, cxButtonEdit, ExtCtrls,
  FuelCharacteristicsAutomaticCalculationFormViewModel,
  CardFormViewModel, ValidateComboBoxDesign;

type

  TOnReservoirKindNameChooseRequestedEventHandler =
    procedure (
      Sender: TObject;
      var CurrentReservoirKindName: String;
      var ChangeReservoirKindName: Boolean
    ) of object;
    
  TOnFuelCharacteristicsAutomaticCalculationRequestedEventHandler =
    procedure (
      Sender: TObject;
      var ViewModel: TFuelCharacteristicsAutomaticCalculationFormViewModel
    ) of object;
    
  TFuelCharacteristicsAutomaticCalculationForm = class(TCardForm)
    TemperatureLabel: TLabel;
    TemperatureEdit: TRegExprValidateEdit;
    DensityEdit: TRegExprValidateEdit;
    DensityLabel: TLabel;
    FuelRiseLevelLabel: TLabel;
    FuelRiseLevelEdit: TRegExprValidateEdit;
    FuelMassLabel: TLabel;
    FuelMassEdit: TRegExprValidateEdit;
    FuelCharacteristicsGroupBox: TGroupBox;
    ReservoirInfoGroupBox: TGroupBox;
    ReservoirKindLabel: TLabel;
    ReservoirKindEdit: TcxButtonEdit;
    SubLayerInfoGroupBox: TGroupBox;
    SubLayerKindLabel: TLabel;
    SubLayerKindPanel: TPanel;
    SubLayerDataPanel: TPanel;
    ReservoirSubLayerCalculationCharacteristicValueLabel: TLabel;
    ReservoirSubLayerCalculationCharacteristicValueEdit: TRegExprValidateEdit;
    MakeCalculationButton: TcxButton;
    SubLayerKindComboBox: TValidateComboBox;
    OutputFuelCharacteristicsGroupBox: TGroupBox;
    procedure MakeCalculationButtonClick(Sender: TObject);
    procedure ReservoirKindEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure ReservoirKindEditPropertiesChange(Sender: TObject);
    procedure ReservoirKindEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure SubLayerKindComboBoxSelect(Sender: TObject);

  private

    FOnFuelCharacteristicsAutomaticCalculationRequestedEventHandler:
      TOnFuelCharacteristicsAutomaticCalculationRequestedEventHandler;

    FOnReservoirKindNameChooseRequestedEventHandler:
      TOnReservoirKindNameChooseRequestedEventHandler;

    procedure RaiseOnReservoirKindNameChooseRequestedEventHandler(
      var CurrentReservoirKindName: String;
      var ChangeReservoirKindName: Boolean
    );
    
  private

    function GetFuelCharacteristicsAutomaticCalculationFormViewModel:
      TFuelCharacteristicsAutomaticCalculationFormViewModel;

    procedure SetFuelCharacteristicsAutomaticCalculationFormViewModel(
      const Value: TFuelCharacteristicsAutomaticCalculationFormViewModel
    );

  private

    function GetSelectedSubLayerKind: TSubLayerKind;
    procedure SetSelectedSubLayerKind(const SubLayerKind: TSubLayerKind);

  private

    procedure SetExpandableToSubLayerDataPanel(const Expandable: Boolean);

    procedure AdjustHeightBy(const Delta: Integer);

  protected

    procedure Initialize; override;

  protected

    procedure FillControlsByViewModel(ViewModel: TCardFormViewModel); override;
    procedure FillViewModelByControls(ViewModel: TCardFormViewModel); override;

    procedure FillSubLayerKindComboBox(
      ViewModel: TFuelCharacteristicsAutomaticCalculationFormViewModel
    );

  protected

    function GetFloatStringFor(const Value: Single): String;
    
  protected

    procedure OnCardFormViewModelPropertyChangedEventHandler(
      Sender: TObject;
      const PropertyName: String;
      const PropertyValue: Variant
    ); override;
    
  protected

    function IsInputDataValid: Boolean; override;

    function IsInputDataForCalculationValid: Boolean;
    function IsInputFuelCharacteristicsValid: Boolean;
    
  public

    property ViewModel: TFuelCharacteristicsAutomaticCalculationFormViewModel
    read GetFuelCharacteristicsAutomaticCalculationFormViewModel
    write SetFuelCharacteristicsAutomaticCalculationFormViewModel;

    property OnFuelCharacteristicsAutomaticCalculationRequestedEventHandler:
      TOnFuelCharacteristicsAutomaticCalculationRequestedEventHandler
    read FOnFuelCharacteristicsAutomaticCalculationRequestedEventHandler
    write FOnFuelCharacteristicsAutomaticCalculationRequestedEventHandler;

    property OnReservoirKindNameChooseRequestedEventHandler:
      TOnReservoirKindNameChooseRequestedEventHandler
    read FOnReservoirKindNameChooseRequestedEventHandler
    write FOnReservoirKindNameChooseRequestedEventHandler;
    
  end;

var
  FuelCharacteristicsAutomaticCalculationForm: TFuelCharacteristicsAutomaticCalculationForm;

implementation

uses

  Disposable,
  AuxDebugFunctionsUnit,
  AuxWindowsFunctionsUnit;

{$R *.dfm}

{ TFuelCharacteristicsAutomaticCalculationForm }

procedure TFuelCharacteristicsAutomaticCalculationForm.AdjustHeightBy(
  const Delta: Integer);
var NewHeight: Integer;
begin

  FMinHeight := Height + Delta;
  FMaxHeight := FMinHeight;

  Height := Height + Delta;
            
end;

procedure TFuelCharacteristicsAutomaticCalculationForm.FillControlsByViewModel(
  ViewModel: TCardFormViewModel);
begin

  with ViewModel as TFuelCharacteristicsAutomaticCalculationFormViewModel
  do begin

    ReservoirKindEdit.Text := VarToStr(ReservoirKindName.Value);

    FillSubLayerKindComboBox(
      ViewModel as TFuelCharacteristicsAutomaticCalculationFormViewModel
    );

    if ReservoirSubLayerCalculationCharacteristicValue.IsAssigned then begin

      ReservoirSubLayerCalculationCharacteristicValueEdit.Text :=
        GetFloatStringFor(
          ReservoirSubLayerCalculationCharacteristicValue.Value
        );
        
    end;

    if FuelTemperature.IsAssigned then
      TemperatureEdit.Text := GetFloatStringFor(FuelTemperature.Value);

    if FuelDensity.IsAssigned then
      DensityEdit.Text := GetFloatStringFor(FuelDensity.Value);

    if FuelRiseLevel.IsAssigned then
      FuelRiseLevelEdit.Text := GetFloatStringFor(FuelRiseLevel.Value);

    if FuelMass.IsAssigned then
      FuelMassEdit.Text := GetFloatStringFor(FuelMass.Value);

  end;
  
end;

procedure TFuelCharacteristicsAutomaticCalculationForm.
  FillSubLayerKindComboBox(
    ViewModel: TFuelCharacteristicsAutomaticCalculationFormViewModel
  );
begin

  with ViewModel do begin

    if not Assigned(SubLayerKinds) or (SubLayerKinds.Count = 0)
    then begin

      SubLayerKindComboBox.Text := '';
      SubLayerKindComboBox.Clear;
      
      Exit;

    end;

    SubLayerKindComboBox.Items.Assign(SubLayerKinds);
    
    SetSelectedSubLayerKind(SubLayerKindValue);

  end;
  
end;

procedure TFuelCharacteristicsAutomaticCalculationForm.FillViewModelByControls(
  ViewModel: TCardFormViewModel);
var FuelRiseLevelValue, FuelTemperatureValue,
    FuelDensityValue, FuelMassValue, SubLayerParamValue: Single;
begin

  with ViewModel as TFuelCharacteristicsAutomaticCalculationFormViewModel
  do begin

    ReservoirKindName.Value := ReservoirKindEdit.Text;

    SubLayerKindValue := GetSelectedSubLayerKind;

    if
      TryStrToFloat(
        ReservoirSubLayerCalculationCharacteristicValueEdit.Text,
        SubLayerParamValue
      )
    then begin

      ReservoirSubLayerCalculationCharacteristicValue.Value :=
        SubLayerParamValue;

    end

    else ReservoirSubLayerCalculationCharacteristicValue.Value := 0;

    if TryStrToFloat(FuelRiseLevelEdit.Text, FuelRiseLevelValue) then
      FuelRiseLevel.Value := FuelRiseLevelValue

    else FuelRiseLevel.Value := 0;

    if TryStrToFloat(TemperatureEdit.Text, FuelTemperatureValue) then
      FuelTemperature.Value := FuelTemperatureValue

    else FuelTemperature.Value := 0;

    if TryStrToFloat(DensityEdit.Text, FuelDensityValue) then
      FuelDensity.Value := StrToFloat(DensityEdit.Text)

    else FuelDensity.Value := 0;

    if TryStrToFloat(FuelMassEdit.Text, FuelMassValue) then
      FuelMass.Value := StrToFloat(FuelMassEdit.Text)

    else FuelMass.Value := 0;
    
  end;

end;

function TFuelCharacteristicsAutomaticCalculationForm.GetFloatStringFor(
  const Value: Single): String;
begin

  Result := FormatFloat('0.###', Value);

end;

function TFuelCharacteristicsAutomaticCalculationForm.
  GetFuelCharacteristicsAutomaticCalculationFormViewModel:
    TFuelCharacteristicsAutomaticCalculationFormViewModel;
begin

  Result := FViewModel as TFuelCharacteristicsAutomaticCalculationFormViewModel;
  
end;

function TFuelCharacteristicsAutomaticCalculationForm.
  GetSelectedSubLayerKind: TSubLayerKind;
begin

  if SubLayerKindComboBox.ItemIndex = -1 then
    Result := skUnknown

  else begin

    Result :=
      TSubLayerKind(
        SubLayerKindComboBox.Items.Objects[
          SubLayerKindComboBox.ItemIndex
        ]
      );

  end;

end;

procedure TFuelCharacteristicsAutomaticCalculationForm.Initialize;

const

  FloatNumberRegExprPattern = '^\d+(\%s\d+)?$';
  NegativeFloatNumberRegExprPattern = '^-?\d+(\%s\d+)?$';

var

  FloatNumberRegExpr, NegativeFloatNumberRegExpr: String;
begin

  inherited;

  FloatNumberRegExpr := Format(FloatNumberRegExprPattern, [DecimalSeparator]);
  NegativeFloatNumberRegExpr := Format(NegativeFloatNumberRegExprPattern, [DecimalSeparator]);

  ReservoirSubLayerCalculationCharacteristicValueEdit.RegularExpression := FloatNumberRegExpr;
  
  TemperatureEdit.RegularExpression := NegativeFloatNumberRegExpr;
  DensityEdit.RegularExpression := FloatNumberRegExpr;
  FuelRiseLevelEdit.RegularExpression := FloatNumberRegExpr;
  FuelMassEdit.RegularExpression := FloatNumberRegExpr;
  
end;


function TFuelCharacteristicsAutomaticCalculationForm.
  IsInputDataForCalculationValid: Boolean;
var IsSubLayerCalculationParamValid,
    IsReservoirKindNameValid,
    IsSubLayerKindValid,
    IsFuelCharacteristicsValid: Boolean;
begin

  ReservoirKindEdit.ModifiedAfterEnter := True;

  ReservoirKindEdit.ValidateEdit(False);
  
  IsReservoirKindNameValid :=
    ReservoirKindEdit.Style.Color <>
    TemperatureEdit.InvalidColor;

  IsSubLayerKindValid :=
    SubLayerKindComboBox.Validate;

  IsSubLayerCalculationParamValid :=
    ReservoirSubLayerCalculationCharacteristicValueEdit.IsValid;

  IsFuelCharacteristicsValid := IsInputFuelCharacteristicsValid;

  Result :=
    IsSubLayerCalculationParamValid and
    IsReservoirKindNameValid and
    IsSubLayerKindValid and
    IsFuelCharacteristicsValid;

end;

function TFuelCharacteristicsAutomaticCalculationForm.IsInputDataValid: Boolean;
var IsFuelMassValid: Boolean;
begin

  IsFuelMassValid := FuelMassEdit.IsValid;

  Result := IsInputFuelCharacteristicsValid and IsFuelMassValid;
    
end;

function TFuelCharacteristicsAutomaticCalculationForm.
  IsInputFuelCharacteristicsValid: Boolean;
var IsFuelTemperatureValid, IsFuelDensityValid,
    IsFuelRiseLevelValid: Boolean;
begin

  IsFuelTemperatureValid := TemperatureEdit.IsValid;
  IsFuelRiseLevelValid := FuelRiseLevelEdit.IsValid;
  IsFuelDensityValid := DensityEdit.IsValid;

  Result :=
    IsFuelTemperatureValid and
    IsFuelRiseLevelValid and
    IsFuelDensityValid;

end;

procedure TFuelCharacteristicsAutomaticCalculationForm.MakeCalculationButtonClick(
  Sender: TObject);
var CurrentViewModelSnapshot:
      TFuelCharacteristicsAutomaticCalculationFormViewModel;
    Free: IDisposable;
begin

  if
    not
    Assigned(FOnFuelCharacteristicsAutomaticCalculationRequestedEventHandler)
  then Exit;

  if not IsInputDataForCalculationValid then begin

    ShowWarningMessage(
      Self.Handle,
      'Не все поля, необходимые для ' +
      'выполнения расчёта, заполнены корректно',
      'Сообщение'
    );
    
    Exit;

  end;

  CurrentViewModelSnapshot :=
    TFuelCharacteristicsAutomaticCalculationFormViewModel(FViewModel.Clone);

  Free := CurrentViewModelSnapshot;

  FillViewModelByControls(CurrentViewModelSnapshot);

  FOnFuelCharacteristicsAutomaticCalculationRequestedEventHandler(
    Self, CurrentViewModelSnapshot
  );

  FViewModel.CopyFrom(CurrentViewModelSnapshot);

  FillControlsByViewModel(FViewModel);

end;

procedure TFuelCharacteristicsAutomaticCalculationForm.
  OnCardFormViewModelPropertyChangedEventHandler(
    Sender: TObject;
    const PropertyName: String;
    const PropertyValue: Variant
  );
begin

  inherited;

  if PropertyName = 'ReservoirKindName' then
    ReservoirKindEdit.Text := VarToStr(PropertyValue)

  else if PropertyName = 'SubLayerKinds' then
    FillSubLayerKindComboBox(ViewModel)
                                     
  else if PropertyName = 'SubLayerKind' then
    SetSelectedSubLayerKind(TSubLayerKind(PropertyValue))

  else if PropertyName = 'ReservoirSubLayerCalculationCharacteristicValue'
  then begin

    ReservoirSubLayerCalculationCharacteristicValueEdit.Text :=
      GetFloatStringFor(PropertyValue)

  end

  else if PropertyName = 'FuelTemperature' then
    TemperatureEdit.Text := GetFloatStringFor(PropertyValue)

  else if PropertyName = 'FuelRiseLevel' then
    FuelRiseLevelEdit.Text := GetFloatStringFor(PropertyValue)

  else if PropertyName = 'FuelDensity' then
    DensityEdit.Text := GetFloatStringFor(PropertyValue)

  else if PropertyName = 'FuelMass' then
    FuelMassEdit.Text := GetFloatStringFor(PropertyValue);
    
end;

procedure TFuelCharacteristicsAutomaticCalculationForm.
  RaiseOnReservoirKindNameChooseRequestedEventHandler(
    var CurrentReservoirKindName: String;
    var ChangeReservoirKindName: Boolean
  );
begin

  if Assigned(FOnReservoirKindNameChooseRequestedEventHandler)
  then begin

    FOnReservoirKindNameChooseRequestedEventHandler(
      Self, CurrentReservoirKindName, ChangeReservoirKindName
    );
    
  end;
  
end;

procedure TFuelCharacteristicsAutomaticCalculationForm.
  ReservoirKindEditPropertiesButtonClick(
    Sender: TObject;
    AButtonIndex: Integer
  );
var CurrentReservoirKindName: String;
    ChangeReservoirKindName: Boolean;
begin

  CurrentReservoirKindName := ReservoirKindEdit.Text;
  ChangeReservoirKindName := True;

  RaiseOnReservoirKindNameChooseRequestedEventHandler(
    CurrentReservoirKindName, ChangeReservoirKindName
  );

  if ChangeReservoirKindName then
    ReservoirKindEdit.Text := CurrentReservoirKindName;
    
end;

procedure TFuelCharacteristicsAutomaticCalculationForm.ReservoirKindEditPropertiesChange(
  Sender: TObject);
begin

  inherited;

  ReservoirKindEdit.ModifiedAfterEnter := True;

  ReservoirKindEdit.ValidateEdit(False);
  
end;

procedure TFuelCharacteristicsAutomaticCalculationForm.ReservoirKindEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var Hint: String;
    ShowHint: Boolean;
    Color: TColor;
begin

  inherited;

  if Trim(DisplayValue) <> '' then begin

    Hint := '';
    ShowHint := False;
    Color := clWindow;

  end

  else begin

    Hint := 'Не указан тип резервуара';
    ShowHint := True;
    Color := TemperatureEdit.InvalidColor;

  end;

  ReservoirKindEdit.Hint := Hint;
  ReservoirKindEdit.ShowHint := ShowHint;
  ReservoirKindEdit.Style.Color := Color;
  
end;

procedure TFuelCharacteristicsAutomaticCalculationForm.
  SetExpandableToSubLayerDataPanel(
    const Expandable: Boolean
  );
var Multiplier, Delta: Integer;

begin

  if SubLayerDataPanel.Visible = Expandable then
    Exit;

  if Expandable then Multiplier := 1 else Multiplier := -1;

  Delta := Multiplier * SubLayerDataPanel.Height;

  SubLayerDataPanel.Visible := Expandable;

  SubLayerInfoGroupBox.Height := SubLayerInfoGroupBox.Height + Delta;

  AdjustHeightBy(Delta);
  
end;

procedure TFuelCharacteristicsAutomaticCalculationForm.
  SetFuelCharacteristicsAutomaticCalculationFormViewModel(
    const Value: TFuelCharacteristicsAutomaticCalculationFormViewModel
  );
begin

  SetViewModel(Value);
  
end;

procedure TFuelCharacteristicsAutomaticCalculationForm.SetSelectedSubLayerKind(
  const SubLayerKind: TSubLayerKind);
begin

  SubLayerKindComboBox.ItemIndex :=
    SubLayerKindComboBox.Items.IndexOfObject(
      TObject(SubLayerKind)
    );

  if SubLayerKindComboBox.ItemIndex = -1 then
    SubLayerKindComboBox.ItemIndex := 0;

  SubLayerKindComboBox.OnSelect(SubLayerKindComboBox);
    
end;

procedure TFuelCharacteristicsAutomaticCalculationForm.
  SubLayerKindComboBoxSelect(Sender: TObject);
var SubLayerKind: TSubLayerKind;
begin

  case GetSelectedSubLayerKind of

    skIce:
    begin

      ReservoirSubLayerCalculationCharacteristicValueLabel.Caption :=
        'ВТФ (мм):';
        
    end;

    skBottomWater:
    begin

      ReservoirSubLayerCalculationCharacteristicValueLabel.Caption :=
        'Уровень (мм):';
        
    end;

    else begin

      raise Exception.Create(
        'Программная ошибка. Не удалось ' +
        'определить тип резервуарного подслоя ' +
        'для корректного отображения формы'
      );
      
    end;

  end;

  ReservoirSubLayerCalculationCharacteristicValueLabel.Left :=
    SubLayerKindLabel.Left + SubLayerKindLabel.Width -
    ReservoirSubLayerCalculationCharacteristicValueLabel.Width;

end;

end.
