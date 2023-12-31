unit StubEmployeeCardFormController;

interface

uses

  BaseEmployeeCardFormController,
  CardFormViewModel,
  SysUtils,
  Classes;

type

  TStubEmployeeCardFormController = class (TBaseEmployeeCardFormController)

    protected

      procedure CreateNewCard(ViewModel: TCardFormViewModel; var Success: Boolean); override;
      procedure ModifyCard(ViewModel: TCardFormViewModel; var Success: Boolean); override;
      procedure RemoveCard(ViewModel: TCardFormViewModel); override;
    
  end;
  
implementation

uses

  AuxWindowsFunctionsUnit;
  
{ TStubEmployeeCardFormController }

procedure TStubEmployeeCardFormController.CreateNewCard(
  ViewModel: TCardFormViewModel; var Success: Boolean);
begin

  ShowInfoMessage(0, '���� �� �������� �������� ����������', 'Message');

end;

procedure TStubEmployeeCardFormController.ModifyCard(
  ViewModel: TCardFormViewModel; var Success: Boolean);
begin

  ShowInfoMessage(0, '���� �� ��������� �������� ����������', 'Message');

end;

procedure TStubEmployeeCardFormController.RemoveCard(
  ViewModel: TCardFormViewModel);
begin

  ShowInfoMessage(0, '���� �� �������� �������� ����������', 'Message');

end;

end.
