unit StubEmployeeAdministrationCardFormController;

interface

uses

  BaseEmployeeAdministrationCardFormController,
  CardFormViewModel,
  SysUtils,
  Classes;

type

  TStubEmployeeAdministrationCardFormController =
    class (TBaseEmployeeAdministrationCardFormController)

      protected

        procedure CreateNewCard(ViewModel: TCardFormViewModel; var Success: Boolean); override;
        procedure ModifyCard(ViewModel: TCardFormViewModel; var Success: Boolean); override;
        procedure RemoveCard(ViewModel: TCardFormViewModel); override;
      
    end;

implementation

uses

  AuxWindowsFunctionsUnit;
  
{ TStubEmployeeAdministrationCardFormController }

procedure TStubEmployeeAdministrationCardFormController.CreateNewCard(
  ViewModel: TCardFormViewModel; var Success: Boolean);
begin

  ShowInfoMessage(0, 'Добавление новой карточки сотрудника', 'Сообщение');

end;

procedure TStubEmployeeAdministrationCardFormController.ModifyCard(
  ViewModel: TCardFormViewModel; var Success: Boolean);
begin

  ShowInfoMessage(0, 'Изменение карточки сотрудника', 'Сообщение');

end;

procedure TStubEmployeeAdministrationCardFormController.RemoveCard(
  ViewModel: TCardFormViewModel);
begin

  ShowInfoMessage(0, 'Удаление карточки сотрудника', 'Сообщение');

end;

end.
