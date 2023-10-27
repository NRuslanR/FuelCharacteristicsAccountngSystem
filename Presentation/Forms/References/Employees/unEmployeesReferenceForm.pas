unit unEmployeesReferenceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxControls, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPC3Painter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxLocalization, ActnList, ImgList,
  PngImageList, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ComCtrls, ExtCtrls, StdCtrls,
  cxButtons, ToolWin, EmployeesReferenceFormViewModel, EmployeesReferenceDataSetHolder,
  EmployeesReferenceRecordViewModel, TableViewFilterFormUnit,
  unEmployeesReferenceFilterForm,
  unBaseFuelCharacteristicsAccountingReferenceForm,
  ReferenceFormDataSetHolder, ReferenceFormViewModel, ReferenceFormRecordViewModel;

type

  TOnEmployeeSpecialityStringsRequestedEventHandler =
    procedure (
      Sender: TObject;
      var EmployeeSpecialities: TStrings
    ) of object;

  TEmployeesReferenceForm = class(TBaseFuelCharacteristicsAccountingReferenceForm)
      NameColumn: TcxGridDBColumn;
      SurnameColumn: TcxGridDBColumn;
      PatronymicColumn: TcxGridDBColumn;
      SpecialityColumn: TcxGridDBColumn;
      BirthDateColumn: TcxGridDBColumn;
    private

      FOnEmployeeSpecialityStringsRequestedEventHandler:
        TOnEmployeeSpecialityStringsRequestedEventHandler;
        
    protected

      procedure CreateTableColumnLayoutFrom(
        DataSetFieldDefs: TReferenceFormDataSetFieldDefs
      ); override;

      function DataSetHolder: TEmployeesReferenceDataSetHolder;

      function GetTotalRecordCountPanelLabel: String; override;

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

      property OnEmployeeSpecialityStringsRequestedEventHandler:
        TOnEmployeeSpecialityStringsRequestedEventHandler
      read FOnEmployeeSpecialityStringsRequestedEventHandler
      write FOnEmployeeSpecialityStringsRequestedEventHandler;
      
    end;

implementation

uses

  AuxWindowsFunctionsUnit;
  
{$R *.dfm}


{ TEmployeesReferenceForm }

procedure TEmployeesReferenceForm.CreateTableColumnLayoutFrom(
  DataSetFieldDefs: TReferenceFormDataSetFieldDefs);
begin

  inherited;

  with DataSetFieldDefs as TEmployeesReferenceDataSetFieldDefs do begin

    NameColumn.DataBinding.FieldName := NameFieldName;
    SurnameColumn.DataBinding.FieldName := SurnameFieldName;
    PatronymicColumn.DataBinding.FieldName := PatronymicFieldName;
    BirthDateColumn.DataBinding.FieldName := BirthDateFieldName;
    SpecialityColumn.DataBinding.FieldName := SpecialityFieldName;
    
  end;

end;

procedure TEmployeesReferenceForm.CustomizeTableViewFilterForm(
  ATableViewFilterForm: TTableViewFilterForm);
var EmployeeSpecialityStrings: TStrings;
begin

  with ATableViewFilterForm as TEmployeesReferenceFilterForm
  do begin

    if not Assigned(FOnEmployeeSpecialityStringsRequestedEventHandler) then begin

      raise Exception.Create(
        'OnEmployeeSpecialityStringsRequestedEventHandler implementation ' +
        'not found'
      );

    end;
    
    FOnEmployeeSpecialityStringsRequestedEventHandler(
      Self, EmployeeSpecialityStrings
    );

    EmployeeSpecialities := EmployeeSpecialityStrings;
    EmployeeSetFieldDefs := DataSetHolder.FieldDefs;

  end;

end;

function TEmployeesReferenceForm.DataSetHolder: TEmployeesReferenceDataSetHolder;
begin

  Result := TEmployeesReferenceDataSetHolder(inherited DataSetHolder);
  
end;

procedure TEmployeesReferenceForm.FillRecordViewModelFromGridRecord(
  RecordViewModel: TReferenceFormRecordViewModel;
  GridRecord: TcxCustomGridRecord);
begin

  inherited;

  with GridRecord, RecordViewModel as TEmployeesReferenceRecordViewModel do begin

    Name := Values[NameColumn.Index];
    Surname := Values[SurnameColumn.Index];
    Patronymic := Values[PatronymicColumn.Index];
    BirthDate := Values[BirthDateColumn.Index];
    Speciality := Values[SpecialityColumn.Index];
    
  end;

end;

function TEmployeesReferenceForm.GetReferenceFormRecordViewModelClass: TReferenceFormRecordViewModelClass;
begin

  Result := TEmployeesReferenceRecordViewModel;
  
end;

function TEmployeesReferenceForm.GetTableViewFilterFormClass: TTableViewFilterFormClass;
begin

  Result := TEmployeesReferenceFilterForm;

end;

function TEmployeesReferenceForm.GetTotalRecordCountPanelLabel: String;
begin

  Result := 'Количество сотрудников: ';
  
end;

procedure TEmployeesReferenceForm.
  InternalSetCurrentDataSetRecordFieldValuesFromViewModel(
    RecordViewModel: TReferenceFormRecordViewModel
  );
begin

  inherited;

  with DataSetHolder, RecordViewModel as TEmployeesReferenceRecordViewModel do begin

    NameFieldValue := Name;
    SurnameFieldValue := Surname;
    PatronymicFieldValue := Patronymic;
    BirthDateFieldValue := BirthDate;
    SpecialityFieldValue := Speciality;

  end;

end;

end.
