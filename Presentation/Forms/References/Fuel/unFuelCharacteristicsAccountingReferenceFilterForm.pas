unit unFuelCharacteristicsAccountingReferenceFilterForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TableViewFilterFormUnit, StdCtrls, cxGridDBTableView, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons;

type
  TFuelCharacteristicsAccountingReferenceFilterForm = class(TTableViewFilterForm)
  private
    { Private declarations }
  protected

    procedure Init(
      const ACaption: String = '';
      ADataSetTableView: TcxGridDBTableView = nil
    ); override;

  public
    { Public declarations }
  end;

var
  FuelCharacteristicsAccountingReferenceFilterForm: TFuelCharacteristicsAccountingReferenceFilterForm;

implementation

{$R *.dfm}

{ TFuelCharacteristicsAccountingReferenceFilterForm }

procedure TFuelCharacteristicsAccountingReferenceFilterForm.Init(
  const ACaption: String; ADataSetTableView: TcxGridDBTableView);
begin

  inherited;

  Caption := 'Отбор расчётов по заданным характеристикам';

end;

end.
