unit unWorkingTimeConditionsCardForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCardForm, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  StdCtrls, cxButtons, ComCtrls,
  CardFormViewModel,
  WorkingTimeConditionsCardFormViewModel;

type
  TWorkingTimeConditionsCardForm = class(TCardForm)
  
    WorkingDayBeginningTimeLabel: TLabel;
    WorkingDayEndingTimeLabel: TLabel;
    WorkingDayBeginningTimePicker: TDateTimePicker;
    WorkingDayEndingTimePicker: TDateTimePicker;

  private

    function GetWorkingTimeConditionsCardFormViewModel:
      TWorkingTimeConditionsCardFormViewModel;

    procedure SetWorkingTimeConditionsCardFormViewModel(
      const Value: TWorkingTimeConditionsCardFormViewModel
    );

  protected

    protected

    procedure FillControlsByViewModel(ViewModel: TCardFormViewModel); override;
    procedure FillViewModelByControls(ViewModel: TCardFormViewModel); override;
    
  protected

    function IsInputDataValid: Boolean; override;

    function GetInputDataNotValidMessage: String; override;
    
  public

    property ViewModel: TWorkingTimeConditionsCardFormViewModel
    read GetWorkingTimeConditionsCardFormViewModel
    write SetWorkingTimeConditionsCardFormViewModel;
    
  end;

var
  WorkingTimeConditionsCardForm: TWorkingTimeConditionsCardForm;

implementation

{$R *.dfm}

{ TWorkingTimeConditionsCardForm }

procedure TWorkingTimeConditionsCardForm.FillControlsByViewModel(
  ViewModel: TCardFormViewModel);
begin

  inherited;

  with ViewModel as TWorkingTimeConditionsCardFormViewModel do begin

    WorkingDayBeginningTimePicker.DateTime := WorkingDayBeginningTime.AsDateTime;
    WorkingDayBeginningTimePicker.Enabled := not WorkingDayBeginningTime.ReadOnly;

    WorkingDayEndingTimePicker.DateTime := WorkingDayEndingTime.AsDateTime;
    WorkingDayEndingTimePicker.Enabled := not WorkingDayEndingTime.ReadOnly;
    
  end;

end;

procedure TWorkingTimeConditionsCardForm.FillViewModelByControls(
  ViewModel: TCardFormViewModel);
begin

  inherited;

  with ViewModel as TWorkingTimeConditionsCardFormViewModel do begin

    WorkingDayBeginningTime.Value := WorkingDayBeginningTimePicker.DateTime;
    WorkingDayEndingTime.Value := WorkingDayEndingTimePicker.DateTime;
    
  end;

end;

function TWorkingTimeConditionsCardForm.IsInputDataValid: Boolean;
begin

  Result :=
    WorkingDayBeginningTimePicker.DateTime <
    WorkingDayEndingTimePicker.DateTime;

end;

function TWorkingTimeConditionsCardForm.GetInputDataNotValidMessage: String;
begin

  Result :=
    'Режим рабочего времени определён некорректно';

end;

function TWorkingTimeConditionsCardForm.
  GetWorkingTimeConditionsCardFormViewModel:
    TWorkingTimeConditionsCardFormViewModel;
begin

  Result := FViewModel as TWorkingTimeConditionsCardFormViewModel;
  
end;

procedure TWorkingTimeConditionsCardForm.SetWorkingTimeConditionsCardFormViewModel(
  const Value: TWorkingTimeConditionsCardFormViewModel);
begin

  SetViewModel(Value);
  
end;

end.
