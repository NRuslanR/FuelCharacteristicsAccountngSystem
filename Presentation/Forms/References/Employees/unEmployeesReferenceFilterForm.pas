unit unEmployeesReferenceFilterForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TableViewFilterFormUnit, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, StdCtrls, cxButtons, cxGridDBTableView,
  AbstractDataSetHolder, EmployeesReferenceDataSetHolder;

type
  TEmployeesReferenceFilterForm = class(TTableViewFilterForm)
  private

    FEmployeeSpecialitites: TStrings;
    FEmployeeSetFieldDefs: TEmployeesReferenceDataSetFieldDefs;

  protected
  
    procedure SetEmployeeSpecialities(const Value: TStrings);

    procedure SetEmployeeSetFieldDefs(
      const Value: TEmployeesReferenceDataSetFieldDefs);
    
  protected

    procedure Init(
      const ACaption: String = '';
      ADataSetTableView: TcxGridDBTableView = nil
    ); override;

  protected

    function CreateFilterFieldValueControl(Parent: TWinControl; const Field: TcxGridDBColumn): TControl; override;

    function CreateAndFillEmployeeSpecialityComboBox(ParentControl: TWinControl): TComboBox;
    procedure FillEmployeeSpecialityComboBox(ComboBox: TComboBox); virtual;
    
  public

    destructor Destroy; override;
    
    property EmployeeSpecialities: TStrings
    read FEmployeeSpecialitites write SetEmployeeSpecialities;

    property EmployeeSetFieldDefs: TEmployeesReferenceDataSetFieldDefs
    read FEmployeeSetFieldDefs write SetEmployeeSetFieldDefs;
    
  end;

var
  EmployeesReferenceFilterForm: TEmployeesReferenceFilterForm;

implementation

{$R *.dfm}

{ TEmployeesReferenceFilterForm }

function TEmployeesReferenceFilterForm.CreateAndFillEmployeeSpecialityComboBox(
  ParentControl: TWinControl): TComboBox;
begin

  Result := TComboBox.Create(ParentControl);

  Result.Parent := ParentControl;
  Result.Style := csDropDownList;

  FillEmployeeSpecialityComboBox(Result);
  
end;

function TEmployeesReferenceFilterForm.
  CreateFilterFieldValueControl(
    Parent: TWinControl;
    const Field: TcxGridDBColumn
  ): TControl;
begin

  if Field.DataBinding.FieldName = EmployeeSetFieldDefs.SpecialityFieldName
  then begin

    Result := CreateAndFillEmployeeSpecialityComboBox(Parent);

  end

  else
    Result := inherited CreateFilterFieldValueControl(Parent, Field);

end;

destructor TEmployeesReferenceFilterForm.Destroy;
begin

  FreeAndNil(FEmployeeSpecialitites);
  
  inherited;

end;

procedure TEmployeesReferenceFilterForm.FillEmployeeSpecialityComboBox(
  ComboBox: TComboBox);
var Speciality: String;
begin

  for Speciality in EmployeeSpecialities  do
    ComboBox.AddItem(Speciality, nil);

  ComboBox.ItemIndex := 0;
  
end;

procedure TEmployeesReferenceFilterForm.Init(const ACaption: String;
  ADataSetTableView: TcxGridDBTableView);
begin

  inherited;

  Caption := 'Отбор сотрудников по заданным характеристикам';

end;

procedure TEmployeesReferenceFilterForm.SetEmployeeSetFieldDefs(
  const Value: TEmployeesReferenceDataSetFieldDefs);
begin
  
  FEmployeeSetFieldDefs := Value;

end;

procedure TEmployeesReferenceFilterForm.SetEmployeeSpecialities(
  const Value: TStrings);
begin

  FreeAndNil(FEmployeeSpecialitites);
  
  FEmployeeSpecialitites := Value;

end;

end.
