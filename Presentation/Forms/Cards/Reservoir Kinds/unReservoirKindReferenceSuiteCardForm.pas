unit unReservoirKindReferenceSuiteCardForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCardForm, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  StdCtrls, cxButtons, cxControls, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxButtonEdit,
  ValidateEditUnit, RegExprValidateEditUnit,
  CardFormViewModel, ReservoirKindReferenceSuiteCardFormViewModel;

const

  CALIBRATION_CHART_LOCATION_INVALID_COLOR = $00A087FF;
  
type

  TOnCalibrationChartLocationChooseRequestedEventHandler =
    procedure (
      Sender: TObject;
      var CurrentCalibrationChartLocation: String;
      var ChangeCalibrationChartLocation: Boolean
    ) of object;
    
  TReservoirKindReferenceSuiteCardForm = class(TCardForm)
    ReservoirKindNameLabel: TLabel;
    HSCLabel: TLabel;
    CalibrationChartLocationLabel: TLabel;
    CalibrationChartLocationEdit: TcxButtonEdit;
    HSCEdit: TRegExprValidateEdit;
    ReservoirKindNameEdit: TRegExprValidateEdit;

    procedure CalibrationChartLocationEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure CalibrationChartLocationEditPropertiesChange(Sender: TObject);
    procedure CalibrationChartLocationEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private

    FOnCalibrationChartLocationChooseRequestedEventHandler:
      TOnCalibrationChartLocationChooseRequestedEventHandler;

    procedure RaiseOnCalibrationChartLocationChooseRequestedEventHandler(
      var CurrentCalibrationChartLocation: String;
      var ChangeCalibrationChartLocation: Boolean
    );

    function GetReservoirKindReferenceSuiteCardFormViewModel:
      TReservoirKindReferenceSuiteCardFormViewModel;

    procedure SetReservoirKindReferenceSuiteCardFormViewModel(
      const Value: TReservoirKindReferenceSuiteCardFormViewModel
    );
    
  protected

    procedure Initialize; override;

  protected

    procedure FillControlsByViewModel(ViewModel: TCardFormViewModel); override;
    procedure FillViewModelByControls(ViewModel: TCardFormViewModel); override;
    
  protected

    function IsInputDataValid: Boolean; override;
    
  public

    property ViewModel: TReservoirKindReferenceSuiteCardFormViewModel
    read GetReservoirKindReferenceSuiteCardFormViewModel
    write SetReservoirKindReferenceSuiteCardFormViewModel;

    property OnCalibrationChartLocationChooseRequestedEventHandler:
      TOnCalibrationChartLocationChooseRequestedEventHandler
    read FOnCalibrationChartLocationChooseRequestedEventHandler
    write FOnCalibrationChartLocationChooseRequestedEventHandler;
    
  end;

var
  ReservoirKindReferenceSuiteCardForm: TReservoirKindReferenceSuiteCardForm;

implementation

{$R *.dfm}

{ TReservoirKindReferenceSuiteCardForm }

procedure TReservoirKindReferenceSuiteCardForm.
  CalibrationChartLocationEditPropertiesButtonClick(
    Sender: TObject; AButtonIndex: Integer
  );
var CurrentCalibrationChartLocation: String;
    ChangeCalibrationChartLocation: Boolean;
begin

  CurrentCalibrationChartLocation := CalibrationChartLocationEdit.Text;
  ChangeCalibrationChartLocation := True;

  RaiseOnCalibrationChartLocationChooseRequestedEventHandler(
    CurrentCalibrationChartLocation, ChangeCalibrationChartLocation
  );

  if ChangeCalibrationChartLocation then
    CalibrationChartLocationEdit.Text := CurrentCalibrationChartLocation;

end;

procedure TReservoirKindReferenceSuiteCardForm.CalibrationChartLocationEditPropertiesChange(
  Sender: TObject);
begin

  inherited;

  CalibrationChartLocationEdit.ModifiedAfterEnter := True;

  CalibrationChartLocationEdit.ValidateEdit(False);
  
end;

procedure TReservoirKindReferenceSuiteCardForm.CalibrationChartLocationEditPropertiesValidate(
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

    Hint := 'Не указан файл градуировочной таблицы';
    ShowHint := True;
    Color := CALIBRATION_CHART_LOCATION_INVALID_COLOR;

  end;

  CalibrationChartLocationEdit.Hint := Hint;
  CalibrationChartLocationEdit.ShowHint := ShowHint;
  CalibrationChartLocationEdit.Style.Color := Color;

end;

procedure TReservoirKindReferenceSuiteCardForm.FillControlsByViewModel(
  ViewModel: TCardFormViewModel);
begin

  inherited;

  with ViewModel as TReservoirKindReferenceSuiteCardFormViewModel
  do begin

    ReservoirKindName.Visible := ReservoirKindName.Visible;

    if ReservoirKindName.Visible then begin

      ReservoirKindNameEdit.Text := VarToStr(ReservoirKindName.Value);
      ReservoirKindNameEdit.ReadOnly := ReservoirKindName.ReadOnly;

    end;

    HSCEdit.Visible := HSCValue.Visible;

    if HSCEdit.Visible then begin

      HSCEdit.Text := VarToStr(HSCValue.Value);
      HSCEdit.ReadOnly := HSCValue.ReadOnly;
      
    end;

    CalibrationChartLocationEdit.Visible := CalibrationChartLocation.Visible;

    if CalibrationChartLocationEdit.Visible then begin

      CalibrationChartLocationEdit.Text :=
        VarToStr(CalibrationChartLocation.Value);

      CalibrationChartLocationEdit.Properties.Buttons[0].Visible :=
        not CalibrationChartLocation.ReadOnly;

    end;
    
  end;
  
end;

procedure TReservoirKindReferenceSuiteCardForm.FillViewModelByControls(
  ViewModel: TCardFormViewModel);
var HSC: Single;
begin

  inherited;

  with ViewModel as TReservoirKindReferenceSuiteCardFormViewModel
  do begin

    ReservoirKindName.Value := ReservoirKindNameEdit.Text;

    if TryStrToFloat(HSCEdit.Text, HSC) then
      HSCValue.Value := HSC

    else HSCValue.Value := 0;

    CalibrationChartLocation.Value := CalibrationChartLocationEdit.Text;
    
  end;

end;

function TReservoirKindReferenceSuiteCardForm.
  GetReservoirKindReferenceSuiteCardFormViewModel:
    TReservoirKindReferenceSuiteCardFormViewModel;
begin

  Result :=
    FViewModel as TReservoirKindReferenceSuiteCardFormViewModel;
    
end;

procedure TReservoirKindReferenceSuiteCardForm.Initialize;
const

  HSCValueRegExpr = '^-?\d+(\%s\d+)?$';
begin

  inherited;

  HSCEdit.RegularExpression := Format(HSCValueRegExpr, [DecimalSeparator]);
  
end;

function TReservoirKindReferenceSuiteCardForm.IsInputDataValid: Boolean;
var IsReservoirKindNameValid, IsHSCValueValid,
    IsCalibrationChartLocationValid: Boolean;
begin

  IsReservoirKindNameValid := ReservoirKindNameEdit.IsValid;
  IsHSCValueValid := HSCEdit.IsValid;

  CalibrationChartLocationEdit.ModifiedAfterEnter := True;

  CalibrationChartLocationEdit.ValidateEdit(True);

  IsCalibrationChartLocationValid :=
    CalibrationChartLocationEdit.Style.Color <>
    CALIBRATION_CHART_LOCATION_INVALID_COLOR;
    
  Result :=
    IsReservoirKindNameValid and
    IsHSCValueValid and
    IsCalibrationChartLocationValid;

end;

procedure TReservoirKindReferenceSuiteCardForm.
  RaiseOnCalibrationChartLocationChooseRequestedEventHandler(
    var CurrentCalibrationChartLocation: String;
    var ChangeCalibrationChartLocation: Boolean
  );
begin

  if Assigned(FOnCalibrationChartLocationChooseRequestedEventHandler)
  then begin

    FOnCalibrationChartLocationChooseRequestedEventHandler(
      Self, CurrentCalibrationChartLocation, ChangeCalibrationChartLocation
    );
    
  end;
  
end;

procedure TReservoirKindReferenceSuiteCardForm.
  SetReservoirKindReferenceSuiteCardFormViewModel(
    const Value: TReservoirKindReferenceSuiteCardFormViewModel
  );
begin

  SetViewModel(Value);
  
end;

end.
