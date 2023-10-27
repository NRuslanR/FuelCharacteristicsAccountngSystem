unit unFuelCharacteristicsAccountingMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, StdCtrls;

type
  TFuelCharacteristicsAccountingMainForm = class(TForm)
    TopLevelMenu: TMainMenu;
    UseCaseActionList: TActionList;
    actExitProgram: TAction;
    actAdministration: TAction;
    actFontSettings: TAction;
    actChangeUserAccount: TAction;
    FileMenuItem: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    UserAppearanceSettingsMenuItem: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    actReservoirKindsReferenceData: TAction;
    ReferenceDataMenuItem: TMenuItem;
    ReservoirsReferenceDataMenuItem: TMenuItem;

  private

  public

    destructor Destroy; override;

  end;

implementation

uses

  DBDataTableFormUnit;

{$R *.dfm}

{ TFuelCharacteristicsAccountingSystemForm }

destructor TFuelCharacteristicsAccountingMainForm.Destroy;
begin

  inherited;

end;

end.


