unit unReservoirKindsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unBaseFuelCharacteristicsAccountingReferenceForm, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxControls, cxStyles,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPC3Painter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxLocalization,
  ActnList, ImgList, PngImageList, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  ComCtrls, ExtCtrls, StdCtrls, cxButtons, ToolWin,
  ReferenceFormViewModel, ReferenceFormRecordViewModel,
  ReservoirKindsFormViewModel, ReservoirKindRecordViewModel,
  ReservoirKindsDataSetHolder;


type
  TReservoirKindsForm = class(TBaseFuelCharacteristicsAccountingReferenceForm)
  
  private

    function GetReservoirKindsFormViewModel: TReservoirKindsFormViewModel;

    procedure SetReservoirKindsFormViewModel(
      const Value: TReservoirKindsFormViewModel
    );

  protected

    function GetReferenceFormRecordViewModelClass:
      TReferenceFormRecordViewModelClass; override;


    function DataSetHolder: TReservoirKindsDataSetHolder;

  protected

    function GetTotalRecordCountPanelLabel: String; override;

  public

    function LocateByReservoirKindName(const ReservoirKindName: String): Boolean;
    
    property ViewModel: TReservoirKindsFormViewModel
    read GetReservoirKindsFormViewModel write SetReservoirKindsFormViewModel;
    
  end;

var
  ReservoirKindsForm: TReservoirKindsForm;

implementation

{$R *.dfm}

{ TReservoirKindsForm }

function TReservoirKindsForm.DataSetHolder: TReservoirKindsDataSetHolder;
begin

  Result := TReservoirKindsDataSetHolder(inherited DataSetHolder);
  
end;

function TReservoirKindsForm.
  GetReferenceFormRecordViewModelClass: TReferenceFormRecordViewModelClass;
begin

  Result := TReservoirKindRecordViewModel;
  
end;

function TReservoirKindsForm.
  GetReservoirKindsFormViewModel: TReservoirKindsFormViewModel;
begin

  Result := inherited ViewModel as TReservoirKindsFormViewModel;

end;

function TReservoirKindsForm.GetTotalRecordCountPanelLabel: String;
begin

  Result := 'Количество типов резервуаров: ';

end;

function TReservoirKindsForm.LocateByReservoirKindName(
  const ReservoirKindName: String): Boolean;
begin

  Result :=
    LocateRecord(
      DataSetHolder.ReservoirKindNameFieldName, ReservoirKindName, []
    );

end;

procedure TReservoirKindsForm.SetReservoirKindsFormViewModel(
  const Value: TReservoirKindsFormViewModel);
begin

  SetViewModel(Value);
  
end;

end.
