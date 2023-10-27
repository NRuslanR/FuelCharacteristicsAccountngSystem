unit unWorkingTimeConditionsAdministrationCardForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unWorkingTimeConditionsCardForm, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, ComCtrls, StdCtrls, cxButtons;

type
  TWorkingTimeConditionsAdministrationCardForm = class(TWorkingTimeConditionsCardForm)
  private

  protected

    procedure DefaultOKButtonClickedHandle; override;
    procedure OnOKButtonClicked; override;
    
  public

  end;

var
  WorkingTimeConditionsAdministrationCardForm: TWorkingTimeConditionsAdministrationCardForm;

implementation

uses

  AuxWindowsFunctionsUnit;
  
{$R *.dfm}

{ TWorkingTimeConditionsAdministrationCardForm }

procedure TWorkingTimeConditionsAdministrationCardForm.
  DefaultOKButtonClickedHandle;
begin

end;

procedure TWorkingTimeConditionsAdministrationCardForm.OnOKButtonClicked;
begin

  inherited;

  ShowInfoMessage(
    Self.Handle, 'Режим рабочего времени был изменён', 'Сообщение'
  );
  
end;

end.
