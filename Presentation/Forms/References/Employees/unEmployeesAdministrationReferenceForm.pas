unit unEmployeesAdministrationReferenceForm;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unEmployeesReferenceForm, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxControls, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPC3Painter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxLocalization, ActnList, ImgList,
  PngImageList, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, ComCtrls, ExtCtrls,
  StdCtrls, cxButtons, ToolWin, ReferenceFormRecordViewModel,
  EmployeesReferenceDataSetHolder, TableViewFilterFormUnit,
  ReferenceFormDataSetHolder, EmployeesAdministrationReferenceDataSetHolder,
  EmployeesAdministrationReferenceFormViewModel,
  EmployeesAdministrationReferenceRecordViewModel,
  unEmployeesAdministrationReferenceFilterForm;

type

  TOnEmployeeRoleNamesRequestedEventHandler =
    procedure (
      Sender: TObject;
      var EmployeeRoleNames: TStrings
    ) of object;
    
  TEmployeesAdministrationReferenceForm = class(TEmployeesReferenceForm)
    LoginColumn: TcxGridDBColumn;
    RoleNameColumn: TcxGridDBColumn;

  protected

    FOnEmployeeRoleNamesRequestedEventHandler: TOnEmployeeRoleNamesRequestedEventHandler;

  protected

    procedure CreateTableColumnLayoutFrom(
      DataSetFieldDefs: TReferenceFormDataSetFieldDefs
    ); override;

    function DataSetHolder: TEmployeesAdministrationReferenceDataSetHolder;

    procedure CustomizeTableViewFilterForm(ATableViewFilterForm: TTableViewFilterForm); override;

    function GetTableViewFilterFormClass: TTableViewFilterFormClass; override;
      
  protected

    function GetReferenceFormRecordViewModelClass: TReferenceFormRecordViewModelClass; override;

    procedure FillRecordViewModelFromGridRecord(
      RecordViewModel: TReferenceFormRecordViewModel;
      GridRecord: TcxCustomGridRecord
    ); override;

    procedure InternalSetCurrentDataSetRecordFieldValuesFromViewModel(
      RecordViewModel: TReferenceFormRecordViewModel
    ); override;

  public

    property OnEmployeeRoleNamesRequestedEventHandler:
      TOnEmployeeRoleNamesRequestedEventHandler
    read FOnEmployeeRoleNamesRequestedEventHandler
    write FOnEmployeeRoleNamesRequestedEventHandler;

  end;

var
  EmployeesAdministrationReferenceForm: TEmployeesAdministrationReferenceForm;

implementation

{$R *.dfm}

{ TEmployeesAdministrationReferenceForm }

procedure TEmployeesAdministrationReferenceForm.CreateTableColumnLayoutFrom(
  DataSetFieldDefs: TReferenceFormDataSetFieldDefs);
begin

  inherited;

  with DataSetFieldDefs as TEmployeesAdministrationReferenceDataSetFieldDefs
  do begin

    RoleNameColumn.DataBinding.FieldName := RoleNameFieldName;
    LoginColumn.DataBinding.FieldName := LoginFieldName;
    
  end;

end;

procedure TEmployeesAdministrationReferenceForm.CustomizeTableViewFilterForm(
  ATableViewFilterForm: TTableViewFilterForm);
var EmployeeRoleNameList: TStrings;
begin

  inherited;

  with ATableViewFilterForm as TEmployeesAdministrationReferenceFilterForm
  do begin

    if not Assigned(FOnEmployeeRoleNamesRequestedEventHandler) then begin

      raise Exception.Create(
        'OnEmployeeRoleNamesRequestedEventHandler implementation ' +
        'not found'
      );
      
    end;

    FOnEmployeeRoleNamesRequestedEventHandler(Self, EmployeeRoleNameList);

    EmployeeRoleNames := EmployeeRoleNameList;
    
  end;
  
end;

function TEmployeesAdministrationReferenceForm.DataSetHolder: TEmployeesAdministrationReferenceDataSetHolder;
begin

  Result := TEmployeesAdministrationReferenceDataSetHolder(inherited DataSetHolder);
  
end;

procedure TEmployeesAdministrationReferenceForm.FillRecordViewModelFromGridRecord(
  RecordViewModel: TReferenceFormRecordViewModel;
  GridRecord: TcxCustomGridRecord);
begin

  inherited;

  with GridRecord, RecordViewModel as TEmployeesAdministrationReferenceRecordViewModel
  do begin

    RoleName := Values[RoleNameColumn.Index];
    Login := Values[LoginColumn.Index];
    
  end;

end;

function TEmployeesAdministrationReferenceForm.GetReferenceFormRecordViewModelClass: TReferenceFormRecordViewModelClass;
begin

  Result := TEmployeesAdministrationReferenceRecordViewModel;
  
end;

function TEmployeesAdministrationReferenceForm.GetTableViewFilterFormClass: TTableViewFilterFormClass;
begin

  Result := TEmployeesAdministrationReferenceFilterForm;

end;

procedure TEmployeesAdministrationReferenceForm.InternalSetCurrentDataSetRecordFieldValuesFromViewModel(
  RecordViewModel: TReferenceFormRecordViewModel);
begin

  inherited;

  with DataSetHolder, RecordViewModel as TEmployeesAdministrationReferenceRecordViewModel
  do begin

    RoleNameFieldValue := RoleName;
    LoginFieldValue := Login;

  end;

end;

end.
