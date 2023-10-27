unit unFuelCharacteristicsCalculationCardForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogFormUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Menus, dxSkinsCore, dxSkinsDefaultPainters, StdCtrls, cxButtons,
  ValidateEditUnit, RegExprValidateEditUnit, ComCtrls,
  FuelCharacteristicsCalculationCardFormViewModel, Disposable, unCardForm,
  CardFormViewModel, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxButtonEdit;

type

  TOnPerformedCalculationEmployeeChooseRequestedEventHandler =
    procedure (
      Sender: TObject;
      var CurrentPerformerId: Variant;
      var CurrentPerformerName: String;
      var ChangeCurrentPerformerInfo: Boolean
    ) of object;
    
  TOnFuelCharacteristicsCalculationRequestedEventHandler =
    procedure (
      Sender: TObject;
      var ViewModel: TFuelCharacteristicsCalculationCardFormViewModel;
      var Success: Boolean
    ) of object;

  TFuelCharacteristicsCalculationCardForm = class(TCardForm)
    TemperatureLabel: TLabel;
    TemperatureEdit: TRegExprValidateEdit;
    DensityLabel: TLabel;
    DensityEdit: TRegExprValidateEdit;
    FuelRiseLevelLabel: TLabel;
    FuelRiseLevelEdit: TRegExprValidateEdit;
    PerformedCalculationEmployeeNameLabel: TLabel;
    FuelInfoGroupBox: TGroupBox;
    FuelMassLabel: TLabel;
    CalculationPerformingInfoGroupBox: TGroupBox;
    CalculationPerformingDateTimeLabel: TLabel;
    CalculationPerformingDateTimePicker: TDateTimePicker;
    FuelKindLabel: TLabel;
    FuelKindEdit: TRegExprValidateEdit;
    ReservoirNumberEdit: TRegExprValidateEdit;
    ReservoirNumberLabel: TLabel;
    PerformedCalculationEmployeeNameEdit: TcxButtonEdit;
    FuelMassEdit: TcxButtonEdit;
    procedure PerformedCalculationEmployeeNameEditPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PerformedCalculationEmployeeNameEditPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure PerformedCalculationEmployeeNameEditPropertiesChange(
      Sender: TObject);
    procedure FuelMassEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FuelMassEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure FuelMassEditPropertiesChange(Sender: TObject);

  private

    FCurrentPerformedCalculationEmployeeId: Variant;

  private

    FOnFuelCharacteristicsCalculationRequestedEventHandler:
      TOnFuelCharacteristicsCalculationRequestedEventHandler;

    FOnPerformedCalculationEmployeeChooseRequestedEventHandler:
      TOnPerformedCalculationEmployeeChooseRequestedEventHandler;

    procedure RaiseOnPerformedCalculationEmployeeChooseRequestedEventHandler(
      var CurrentPerformerId: Variant;
      var CurrentPerformerName: String;
      var ChangeCurrentPerformerInfo: Boolean
    );
    
    procedure RaiseOnFuelCharacteristicsCalculationRequestedEventHandler(
      var ViewModel: TFuelCharacteristicsCalculationCardFormViewModel;
      var Success: Boolean
    );

    function GetFuelCharacteristicsCalculationCardFormViewModel:
      TFuelCharacteristicsCalculationCardFormViewModel;

    procedure SetFuelCharacteristicsCalculationCardFormViewModel(
      const Value: TFuelCharacteristicsCalculationCardFormViewModel
    );

    function GetPerformedCalculationEmployeeId: Variant;
    function GetPerformedCalculationEmployeeName: String;

    procedure SetPerformedCalculationEmployeeId(const Value: Variant);
    procedure SetPerformedCalculationEmployeeName(const Value: String);

  protected

    procedure Initialize; override;
    
    procedure FillControlsByViewModel(
      ViewModel: TCardFormViewModel
    ); override;

    procedure FillViewModelByControls(ViewModel: TCardFormViewModel); override;

    procedure SetCalculationPerformingInfoAreaVisible;
    procedure SetFuelCharacteristicsCalculationToolVisible;
    
    procedure AdjustHeightBy(const HeightDelta: Integer);

  protected

    function IsInputDataValid: Boolean; override;

    function GetFloatStringFor(const Value: Single): String;
     
  protected

    procedure OnCardFormViewModelPropertyChangedEventHandler(
      Sender: TObject;
      const PropertyName: String;
      const PropertyValue: Variant
    ); override;

  public

    destructor Destroy; override;

    property PerformedCalculationEmployeeId: Variant
    read GetPerformedCalculationEmployeeId
    write SetPerformedCalculationEmployeeId;

    property PerformedCalculationEmployeeName: String
    read GetPerformedCalculationEmployeeName
    write SetPerformedCalculationEmployeeName;

    property ViewModel: TFuelCharacteristicsCalculationCardFormViewModel
    read GetFuelCharacteristicsCalculationCardFormViewModel
    write SetFuelCharacteristicsCalculationCardFormViewModel;
    
    property OnFuelCharacteristicsCalculationRequestedEventHandler:
      TOnFuelCharacteristicsCalculationRequestedEventHandler
    read FOnFuelCharacteristicsCalculationRequestedEventHandler
    write FOnFuelCharacteristicsCalculationRequestedEventHandler;

    property OnPerformedCalculationEmployeeChooseRequestedEventHandler:
      TOnPerformedCalculationEmployeeChooseRequestedEventHandler
    read FOnPerformedCalculationEmployeeChooseRequestedEventHandler
    write FOnPerformedCalculationEmployeeChooseRequestedEventHandler;

  end;

var
  FuelCharacteristicsCalculationCardForm: TFuelCharacteristicsCalculationCardForm;

implementation

uses

  StrUtils,
  AuxDebugFunctionsUnit,
  AuxWindowsFunctionsUnit;

{$R *.dfm}

procedure TFuelCharacteristicsCalculationCardForm.AdjustHeightBy(
  const HeightDelta: Integer);
begin

  FMinHeight := FMinHeight + HeightDelta;
  FMaxHeight := FMinHeight;

  Height := FMaxHeight;
  
end;

destructor TFuelCharacteristicsCalculationCardForm.Destroy;
begin

  inherited;

end;

procedure TFuelCharacteristicsCalculationCardForm.FillControlsByViewModel(
  ViewModel: TCardFormViewModel);
begin

  with ViewModel as TFuelCharacteristicsCalculationCardFormViewModel do begin

    TemperatureEdit.Visible := FuelTemperature.Visible;

    if TemperatureEdit.Visible then begin

      if FuelTemperature.IsAssigned then
        TemperatureEdit.Text := GetFloatStringFor(FuelTemperature.Value);

      TemperatureEdit.ReadOnly := FuelTemperature.ReadOnly;

    end;

    DensityEdit.Visible := FuelDensity.Visible;

    if DensityEdit.Visible then begin

      if FuelDensity.IsAssigned then
        DensityEdit.Text := GetFloatStringFor(FuelDensity.Value);

      DensityEdit.ReadOnly := FuelDensity.ReadOnly;

    end;

    FuelRiseLevelEdit.Visible := FuelRiseLevel.Visible;

    if FuelRiseLevelEdit.Visible then begin

      if FuelRiseLevel.IsAssigned then
        FuelRiseLevelEdit.Text := GetFloatStringFor(FuelRiseLevel.Value);

      FuelRiseLevelEdit.ReadOnly := FuelRiseLevel.ReadOnly;

    end;

    FuelMassEdit.Visible := FuelMass.Visible;

    if FuelMassEdit.Visible then begin

      if FuelMass.IsAssigned then
        FuelMassEdit.Text := GetFloatStringFor(FuelMass.Value);
        
      FuelMassEdit.Properties.ReadOnly := FuelMass.ReadOnly;

    end;

    PerformedCalculationEmployeeNameEdit.Visible :=
      PerformedCalculationEmployeeName.Visible;

    PerformedCalculationEmployeeNameLabel.Visible :=
      PerformedCalculationEmployeeName.Visible;

    if PerformedCalculationEmployeeNameEdit.Visible then begin

      FCurrentPerformedCalculationEmployeeId :=
        PerformedCalculationEmployeeId.Value;
        
      PerformedCalculationEmployeeNameEdit.Text :=
        PerformedCalculationEmployeeName.ToString;
        
      PerformedCalculationEmployeeNameEdit.Properties.Buttons[0].Visible :=
        not PerformedCalculationEmployeeName.ReadOnly;

    end;

    CalculationPerformingDateTimePicker.Visible :=
      CalculationPerformingDateTime.Visible;

    CalculationPerformingDateTimeLabel.Visible :=
      CalculationPerformingDateTime.Visible;

    if CalculationPerformingDateTimePicker.Visible then begin

      CalculationPerformingDateTimePicker.DateTime :=
        CalculationPerformingDateTime.AsDateTime;

      CalculationPerformingDateTimePicker.Enabled :=
        not CalculationPerformingDateTime.ReadOnly;

      CalculationPerformingDateTimePicker.Checked :=
        CalculationPerformingDateTimeChangingEnabled;
        
    end;

    FuelKindEdit.Visible := FuelKind.Visible;

    if FuelKindEdit.Visible then begin

      FuelKindEdit.Text := FuelKind.ToString;
      FuelKindEdit.ReadOnly := FuelKind.ReadOnly;

    end;

    ReservoirNumberEdit.Visible := ReservoirNumber.Visible;

    if ReservoirNumberEdit.Visible then begin

      ReservoirNumberEdit.Text := ReservoirNumber.ToString;
      ReservoirNumberEdit.ReadOnly := ReservoirNumber.ReadOnly;
      
    end;

    SetCalculationPerformingInfoAreaVisible;
    SetFuelCharacteristicsCalculationToolVisible;
    
  end;

end;

procedure TFuelCharacteristicsCalculationCardForm.FillViewModelByControls(
  ViewModel: TCardFormViewModel
);
var TemperatureValue, RiseLevelValue, DensityValue, MassValue: Single;
    ReservoirNumberValue: Integer;
begin

  if not Assigned(ViewModel) then Exit;

  with ViewModel as TFuelCharacteristicsCalculationCardFormViewModel do begin
    
    if FuelTemperature.Visible then begin

      if TryStrToFloat(TemperatureEdit.Text, TemperatureValue) then
        FuelTemperature.Value := TemperatureValue

    end;

    if FuelDensity.Visible then begin

      if TryStrToFloat(DensityEdit.Text, DensityValue) then
        FuelDensity.Value := DensityValue;

    end;

    if FuelRiseLevel.Visible then begin

      if TryStrToFloat(FuelRiseLevelEdit.Text, RiseLevelValue) then
        FuelRiseLevel.Value := RiseLevelValue;

    end;

    if FuelMass.Visible then begin

      if  TryStrToFloat(FuelMassEdit.Text, MassValue) then
        FuelMass.Value := MassValue;

    end;

    if FuelKind.Visible then
      FuelKind.Value := FuelKindEdit.Text;

    if ReservoirNumber.Visible then begin

      if TryStrToInt(ReservoirNumberEdit.Text, ReservoirNumberValue) then
        ReservoirNumber.Value :=  ReservoirNumberValue;

    end;

    if PerformedCalculationEmployeeName.Visible then begin

      PerformedCalculationEmployeeId.Value :=
        FCurrentPerformedCalculationEmployeeId;

      PerformedCalculationEmployeeName.Value :=
        PerformedCalculationEmployeeNameEdit.Text;

    end;

    if CalculationPerformingDateTime.Visible then begin

      CalculationPerformingDateTime.Value :=
        CalculationPerformingDateTimePicker.DateTime;

      CalculationPerformingDateTimeChangingEnabled :=
        CalculationPerformingDateTimePicker.Checked;

    end;

  end;

end;

procedure TFuelCharacteristicsCalculationCardForm.FuelMassEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var CurrentCardViewModelSnapshot: TFuelCharacteristicsCalculationCardFormViewModel;
    CalculationRequestSuccess: Boolean;
begin

  CurrentCardViewModelSnapshot :=
    ViewModel.Clone as TFuelCharacteristicsCalculationCardFormViewModel;

  try

    FillViewModelByControls(CurrentCardViewModelSnapshot);
    
    CalculationRequestSuccess := True;

    RaiseOnFuelCharacteristicsCalculationRequestedEventHandler(
      CurrentCardViewModelSnapshot, CalculationRequestSuccess
    );

    if CalculationRequestSuccess then
      FillControlsByViewModel(CurrentCardViewModelSnapshot);

  finally

    FreeAndNil(CurrentCardViewModelSnapshot);
    
  end;

end;

procedure TFuelCharacteristicsCalculationCardForm.FuelMassEditPropertiesChange(
  Sender: TObject);
begin

  FuelMassEdit.ModifiedAfterEnter := True;

  FuelMassEdit.ValidateEdit(False);
  
end;

procedure TFuelCharacteristicsCalculationCardForm.FuelMassEditPropertiesValidate(
  Sender: TObject;
  var DisplayValue: Variant;
  var ErrorText: TCaption;
  var Error: Boolean
);
var MassValue: Single;
    ShowHint: Boolean;
    Hint: String;
    Color: TColor;
begin

  Error := False;

  if not TryStrToFloat(FuelMassEdit.Text, MassValue) then begin

    ShowHint := True;
    Hint := 'Некорректное значение массы топлива';
    Color := TemperatureEdit.InvalidColor;

  end

  else begin

    ShowHint := False;
    Hint := '';
    Color := clWindow;
    
  end;
  
  FuelMassEdit.ShowHint := ShowHint;
  FuelMassEdit.Hint := Hint;
  FuelMassEdit.Style.Color := Color;
  
end;

function TFuelCharacteristicsCalculationCardForm.
  GetFuelCharacteristicsCalculationCardFormViewModel:
    TFuelCharacteristicsCalculationCardFormViewModel;
begin

  Result :=
    TFuelCharacteristicsCalculationCardFormViewModel(inherited ViewModel);
    
end;

function TFuelCharacteristicsCalculationCardForm.
  GetPerformedCalculationEmployeeId: Variant;
begin

  Result := FCurrentPerformedCalculationEmployeeId;

end;

function TFuelCharacteristicsCalculationCardForm.
  GetPerformedCalculationEmployeeName: String;
begin

  Result := PerformedCalculationEmployeeNameEdit.Text;
  
end;

function TFuelCharacteristicsCalculationCardForm.GetFloatStringFor(
  const Value: Single): String;
var FloatString: String;
begin

  Result := FormatFloat('0.###', Value);

end;

procedure TFuelCharacteristicsCalculationCardForm.
  RaiseOnFuelCharacteristicsCalculationRequestedEventHandler(
    var ViewModel: TFuelCharacteristicsCalculationCardFormViewModel;
    var Success: Boolean
  );
begin

  if Assigned(FOnFuelCharacteristicsCalculationRequestedEventHandler)
  then begin

    FOnFuelCharacteristicsCalculationRequestedEventHandler(
      Self, ViewModel, Success
    );

  end;

end;

procedure TFuelCharacteristicsCalculationCardForm.
  RaiseOnPerformedCalculationEmployeeChooseRequestedEventHandler(
    var CurrentPerformerId: Variant;
    var CurrentPerformerName: String;
    var ChangeCurrentPerformerInfo: Boolean
  );
begin

  if Assigned(FOnPerformedCalculationEmployeeChooseRequestedEventHandler)
  then begin

    FOnPerformedCalculationEmployeeChooseRequestedEventHandler(
      Self, CurrentPerformerId, CurrentPerformerName, ChangeCurrentPerformerInfo
    );

  end;

end;

procedure TFuelCharacteristicsCalculationCardForm.
  SetCalculationPerformingInfoAreaVisible;
var HeightDelta: Integer;
begin

  HeightDelta := 0;

  if
    not PerformedCalculationEmployeeNameEdit.Visible and
    not CalculationPerformingDateTimePicker.Visible
  then begin

    if CalculationPerformingInfoGroupBox.Visible then begin

      CalculationPerformingInfoGroupBox.Hide;

      HeightDelta := -CalculationPerformingInfoGroupBox.Height;

    end;

  end

  else begin

    if not CalculationPerformingInfoGroupBox.Visible then begin

      CalculationPerformingInfoGroupBox.Show;

      HeightDelta := CalculationPerformingInfoGroupBox.Height;

    end;

  end;

  AdjustHeightBy(HeightDelta);
  
end;

procedure TFuelCharacteristicsCalculationCardForm.
  SetFuelCharacteristicsCalculationCardFormViewModel(
    const Value: TFuelCharacteristicsCalculationCardFormViewModel
  );
begin

  SetViewModel(Value);

end;

procedure TFuelCharacteristicsCalculationCardForm.
  SetFuelCharacteristicsCalculationToolVisible;
begin

  FuelMassEdit.Properties.Buttons[0].Visible :=
    not FuelMassEdit.Properties.ReadOnly;

end;

procedure TFuelCharacteristicsCalculationCardForm.
  SetPerformedCalculationEmployeeId(
    const Value: Variant
  );
begin

  FCurrentPerformedCalculationEmployeeId := Value;

end;

procedure TFuelCharacteristicsCalculationCardForm.
  SetPerformedCalculationEmployeeName(
    const Value: String
  );
begin

  PerformedCalculationEmployeeNameEdit.Text := Value;
  
end;

procedure TFuelCharacteristicsCalculationCardForm.Initialize;
const

  FloatNumberRegExprPattern = '\d+(\%s\d+)?$';
  NegativeFloatNumberRegExprPattern = '-?\d+(\%s\d+)?$';

var FloatNumberRegExpr, NegativeFloatNumberRegExpr: String;
begin

  inherited;

  FloatNumberRegExpr := Format(FloatNumberRegExprPattern, [DecimalSeparator]);
  NegativeFloatNumberRegExpr := Format(NegativeFloatNumberRegExprPattern, [DecimalSeparator]);

  TemperatureEdit.RegularExpression := '^' + NegativeFloatNumberRegExpr;
  DensityEdit.RegularExpression := '^' + FloatNumberRegExpr;
  FuelRiseLevelEdit.RegularExpression := '^' + FloatNumberRegExpr;
  FuelMassEdit.Properties.EditMask := FloatNumberRegExpr;
  
end;

function TFuelCharacteristicsCalculationCardForm.IsInputDataValid: Boolean;
var IsTemperatureValid, IsDensityValid, IsFuelRiseLevelValid,
    IsFuelMassValid, IsPerformedCalculationEmployeeNameValid,
    IsFuelKindValid, IsReservoirNumberValid: Boolean;
begin

  IsTemperatureValid := TemperatureEdit.IsValid;
  IsDensityValid := DensityEdit.IsValid;
  IsFuelRiseLevelValid := FuelRiseLevelEdit.IsValid;

  FuelMassEdit.ModifiedAfterEnter := True;

  FuelMassEdit.ValidateEdit(False);

  IsFuelMassValid := FuelMassEdit.Style.Color <> TemperatureEdit.InvalidColor;

  IsFuelKindValid := FuelKindEdit.IsValid;
  IsReservoirNumberValid := ReservoirNumberEdit.IsValid;

  PerformedCalculationEmployeeNameEdit.ModifiedAfterEnter := True;

  PerformedCalculationEmployeeNameEdit.ValidateEdit(False);

  IsPerformedCalculationEmployeeNameValid :=
    not PerformedCalculationEmployeeNameEdit.Visible
    or (
      PerformedCalculationEmployeeNameEdit.Style.Color <>
      TemperatureEdit.InvalidColor
    );
    
  Result :=
    IsTemperatureValid and
    IsDensityValid and
    IsFuelRiseLevelValid and
    IsFuelMassValid and
    IsPerformedCalculationEmployeeNameValid and
    IsFuelKindValid and
    IsReservoirNumberValid;

end;

procedure TFuelCharacteristicsCalculationCardForm.
  OnCardFormViewModelPropertyChangedEventHandler(
    Sender: TObject;
    const PropertyName: String;
    const PropertyValue: Variant
  );
begin

  if PropertyName = 'PerformedCalculationEmployeeId' then
    FCurrentPerformedCalculationEmployeeId := PropertyValue

  else if PropertyName = 'PerformedCalculationEmployeeName' then
    PerformedCalculationEmployeeNameEdit.Text := PropertyValue

  else if PropertyName = 'FuelTemperature' then
    TemperatureEdit.Text := GetFloatStringFor(PropertyValue)

  else if PropertyName = 'FuelRiseLevel' then
    FuelRiseLevelEdit.Text := GetFloatStringFor(PropertyValue)

  else if PropertyName = 'FuelDensity' then
    DensityEdit.Text := GetFloatStringFor(PropertyValue)

  else if PropertyName = 'FuelMass' then
    FuelMassEdit.Text := GetFloatStringFor(PropertyValue);

end;

procedure TFuelCharacteristicsCalculationCardForm.
  PerformedCalculationEmployeeNameEditPropertiesButtonClick(
    Sender: TObject;
    AButtonIndex: Integer
  );
var
    CurrentPerformerName: String;
    ChangeCurrentPerformerInfo: Boolean;
begin

  ChangeCurrentPerformerInfo := True;

  RaiseOnPerformedCalculationEmployeeChooseRequestedEventHandler(
    FCurrentPerformedCalculationEmployeeId,
    CurrentPerformerName,
    ChangeCurrentPerformerInfo
  );

  if ChangeCurrentPerformerInfo then begin

    PerformedCalculationEmployeeNameEdit.Text :=
      CurrentPerformerName;
      
  end;

end;

procedure TFuelCharacteristicsCalculationCardForm.
  PerformedCalculationEmployeeNameEditPropertiesChange(
    Sender: TObject
  );
begin

  inherited;

  PerformedCalculationEmployeeNameEdit.ModifiedAfterEnter := True;

  PerformedCalculationEmployeeNameEdit.ValidateEdit(False);

end;

procedure TFuelCharacteristicsCalculationCardForm.
  PerformedCalculationEmployeeNameEditPropertiesValidate(
    Sender: TObject;
    var DisplayValue: Variant;
    var ErrorText: TCaption;
    var Error: Boolean
  );
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

    Hint := 'Не указан выполнивший расчёт сотрудник';
    ShowHint := True;
    Color := TemperatureEdit.InvalidColor;
    
  end;

  PerformedCalculationEmployeeNameEdit.Hint := Hint;
  PerformedCalculationEmployeeNameEdit.ShowHint := ShowHint;
  PerformedCalculationEmployeeNameEdit.Style.Color := Color;
  
end;

end.
