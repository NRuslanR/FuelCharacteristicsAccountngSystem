unit unBaseFuelCharacteristicsAccountingReferenceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBDataTableFormUnit, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, dxSkinsCore, dxSkinsDefaultPainters, cxControls,
  cxStyles, dxSkinscxPC3Painter, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxLocalization, ActnList, ImgList, PngImageList,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ComCtrls, ExtCtrls, StdCtrls,
  cxButtons, ToolWin, TableViewFilterFormUnit, unReferenceForm;

type
  TBaseFuelCharacteristicsAccountingReferenceForm = class(TReferenceForm)
  private

  protected

    procedure Init(
      const Caption: String = ''; ADataSet:
      TDataSet = nil
    ); override;

  public

    destructor Destroy; override;

  end;

var
  BaseFuelCharacteristicsAccountingReferenceForm: TBaseFuelCharacteristicsAccountingReferenceForm;

implementation

{$R *.dfm}

{ TBaseFuelCharacteristicsAccountingReferenceForm }

destructor TBaseFuelCharacteristicsAccountingReferenceForm.Destroy;
begin

  inherited;

end;

procedure TBaseFuelCharacteristicsAccountingReferenceForm.Init(
  const Caption: String; ADataSet: TDataSet);
begin

  inherited;

  SetUserLoginPanelVisible(False);
  SetDatabaseNamePanelVisible(False);
  
  //FocusedCellColor := SelectedRecordsColor;

end;

end.
