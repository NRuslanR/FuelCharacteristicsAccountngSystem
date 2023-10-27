unit unEmployeesAdministrationReferenceFilterForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unEmployeesReferenceFilterForm, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, StdCtrls, cxButtons, cxGridDBTableView,
  EmployeesAdministrationReferenceDataSetHolder;

type
  TEmployeesAdministrationReferenceFilterForm = class(TEmployeesReferenceFilterForm)

  private

    FEmployeeRoleNames: TStrings;

    procedure SetEmployeeRoleNames(const Value: TStrings);
    function GetEmployeesAdministrationReferenceDataSetFieldDefs: TEmployeesAdministrationReferenceDataSetFieldDefs;
    procedure SetEmployeesAdministrationReferenceDataSetFieldDefs(
      const Value: TEmployeesAdministrationReferenceDataSetFieldDefs);
    
  protected

    function CreateFilterFieldValueControl(Parent: TWinControl; const Field: TcxGridDBColumn): TControl; override;

    function CreateAndFillEmployeeRoleComboBox(ParentControl: TWinControl): TComboBox;
    procedure FillEmployeeRoleComboBox(ComboBox: TComboBox); virtual;

  public

    property EmployeeRoleNames: TStrings
    read FEmployeeRoleNames write SetEmployeeRoleNames;

    property EmployeeSetFieldDefs: TEmployeesAdministrationReferenceDataSetFieldDefs
    read GetEmployeesAdministrationReferenceDataSetFieldDefs
    write SetEmployeesAdministrationReferenceDataSetFieldDefs;
    
  end;

implementation

{$R *.dfm}

{ TEmployeesAdministrationReferenceFilterForm }

function TEmployeesAdministrationReferenceFilterForm.CreateAndFillEmployeeRoleComboBox(
  ParentControl: TWinControl): TComboBox;
begin

  Result := TComboBox.Create(ParentControl);

  Result.Parent := ParentControl;
  Result.Style := csDropDownList;

  FillEmployeeRoleComboBox(Result);
  
end;

function TEmployeesAdministrationReferenceFilterForm.CreateFilterFieldValueControl(
  Parent: TWinControl; const Field: TcxGridDBColumn): TControl;

begin

  if Field.DataBinding.FieldName = EmployeeSetFieldDefs.RoleNameFieldName
  then
    Result := CreateAndFillEmployeeRoleComboBox(Parent)

  else
    Result := inherited CreateFilterFieldValueControl(Parent, Field);
    
end;

procedure TEmployeesAdministrationReferenceFilterForm.FillEmployeeRoleComboBox(
  ComboBox: TComboBox);
var EmployeeRoleName: String;
begin

  for EmployeeRoleName in EmployeeRoleNames do
    ComboBox.AddItem(EmployeeRoleName, nil);

  ComboBox.ItemIndex := 0;
  
end;

function TEmployeesAdministrationReferenceFilterForm.
  GetEmployeesAdministrationReferenceDataSetFieldDefs: TEmployeesAdministrationReferenceDataSetFieldDefs;
begin

  Result := TEmployeesAdministrationReferenceDataSetFieldDefs(inherited EmployeeSetFieldDefs);

end;

procedure TEmployeesAdministrationReferenceFilterForm.SetEmployeeRoleNames(
  const Value: TStrings);
begin

  FreeAndNil(FEmployeeRoleNames);
  
  FEmployeeRoleNames := Value;

end;

procedure TEmployeesAdministrationReferenceFilterForm.
  SetEmployeesAdministrationReferenceDataSetFieldDefs(
    const Value: TEmployeesAdministrationReferenceDataSetFieldDefs
  );
begin

  SetEmployeeSetFieldDefs(Value);

end;

end.
