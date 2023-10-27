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

  ShowInfoMessage(0, '���������� ����� �������� ����������', '���������');

end;

procedure TStubEmployeeAdministrationCardFormController.ModifyCard(
  ViewModel: TCardFormViewModel; var Success: Boolean);
begin

  ShowInfoMessage(0, '��������� �������� ����������', '���������');

end;

procedure TStubEmployeeAdministrationCardFormController.RemoveCard(
  ViewModel: TCardFormViewModel);
begin

  ShowInfoMessage(0, '�������� �������� ����������', '���������');

end;

end.
