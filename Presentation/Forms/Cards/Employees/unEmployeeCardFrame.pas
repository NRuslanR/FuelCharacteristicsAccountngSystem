unit unEmployeeCardFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ComCtrls, StdCtrls, ValidateEditUnit, RegExprValidateEditUnit;

type
  TEmployeeCardFrame = class(TFrame)
    NameEdit: TRegExprValidateEdit;
    SurnameLabel: TLabel;
    SurnameEdit: TRegExprValidateEdit;
    PatronymicLabel: TLabel;
    PatronymicEdit: TRegExprValidateEdit;
    BirthDateLabel: TLabel;
    SpecialityLabel: TLabel;
    BirthDateTimePicker: TDateTimePicker;
    SpecialityComboBox: TComboBox;
    NameLabel: TLabel;
    EmployeePersonnelInfoGroupBox: TGroupBox;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


end.
