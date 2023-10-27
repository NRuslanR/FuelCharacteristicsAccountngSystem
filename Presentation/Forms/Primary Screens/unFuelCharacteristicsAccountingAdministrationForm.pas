unit unFuelCharacteristicsAccountingAdministrationForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unSystemAdministrationForm, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL, cxMaskEdit,
  cxTLdxBarBuiltInMenu, dxSkinsCore, dxSkinsDefaultPainters, DB,
  cxInplaceContainer, cxDBTL, cxTLData, ExtCtrls;

type
  TFuelCharacteristicsAccountingAdministrationForm = class(TSystemAdministrationForm)
    procedure SectionsTreeListFocusedNodeChanged(Sender: TcxCustomTreeList;
      APrevFocusedNode, AFocusedNode: TcxTreeListNode);
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;

  end;

var
  FuelCharacteristicsAccountingAdministrationForm: TFuelCharacteristicsAccountingAdministrationForm;

implementation

uses

  GlobalErrorHandler;

{$R *.dfm}

{ TFuelCharacteristicsAccountingAdministrationForm }

destructor TFuelCharacteristicsAccountingAdministrationForm.Destroy;
begin

  inherited;

end;

procedure TFuelCharacteristicsAccountingAdministrationForm.SectionsTreeListFocusedNodeChanged(
  Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin

  try

    inherited;

  except

    on E: Exception do begin

      TGlobalErrorHandler.Current.HandleException(E);
      
    end;

  end;

end;

end.
