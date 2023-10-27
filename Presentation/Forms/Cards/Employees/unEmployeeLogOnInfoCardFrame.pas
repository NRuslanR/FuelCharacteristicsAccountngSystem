unit unEmployeeLogOnInfoCardFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unEmployeeCardFrame, StdCtrls, ValidateEditUnit,
  RegExprValidateEditUnit, ComCtrls;

type
  TEmployeeLogOnInfoCardFrame = class(TFrame)
    LogOnInfoGroupBox: TGroupBox;
    LoginLabel: TLabel;
    LoginEdit: TRegExprValidateEdit;
    PasswordEdit: TRegExprValidateEdit;
    PasswordLabel: TLabel;
    RoleLabel: TLabel;
    RoleComboBox: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EmployeeLogOnInfoCardFrame: TEmployeeLogOnInfoCardFrame;

implementation

{$R *.dfm}

end.
