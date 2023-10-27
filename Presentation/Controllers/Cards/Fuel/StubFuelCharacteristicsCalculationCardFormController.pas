unit StubFuelCharacteristicsCalculationCardFormController;

interface

uses

  Forms,
  AbstractCardFormController,
  AbstractFormController,
  CardFormViewModel,
  BaseFuelCharacteristicsCalculationCardFormController,
  FuelCharacteristicsCalculationCardFormViewModel,
  SysUtils,
  Classes;

type

  TStubFuelCharacteristicsCalculationCardFormController =
    class (TBaseFuelCharacteristicsCalculationCardFormController)
        
      protected

        procedure OnFuelCharacteristicsCalculationRequestedEventHandler(
          Sender: TObject;
          var ViewModel: TFuelCharacteristicsCalculationCardFormViewModel;
          var Success: Boolean
        ); override;

      protected

        procedure CreateNewCard(ViewModel: TCardFormViewModel; var Success: Boolean); override;
        procedure ModifyCard(ViewModel: TCardFormViewModel; var Success: Boolean); override;
        procedure RemoveCard(ViewModel: TCardFormViewModel); override;
        
    end;


implementation

uses

  Variants,
  AuxWindowsFunctionsUnit;
  
{ TStubFuelCharacteristicsCalculationCardFormController }

procedure TStubFuelCharacteristicsCalculationCardFormController.CreateNewCard(
  ViewModel: TCardFormViewModel;
  var Success: Boolean
);
begin

  ShowInfoMessage(Application.Handle, 'Тест на создание нового расчёта', 'Message');

end;

procedure TStubFuelCharacteristicsCalculationCardFormController.ModifyCard(
  ViewModel: TCardFormViewModel;
  var Success: Boolean
);
begin

  ShowInfoMessage(Application.Handle, 'Тест на изменении нового расчёта', 'Message');

end;

procedure TStubFuelCharacteristicsCalculationCardFormController.
  OnFuelCharacteristicsCalculationRequestedEventHandler(
    Sender: TObject;
    var ViewModel: TFuelCharacteristicsCalculationCardFormViewModel;
    var Success: Boolean
  );
begin

  inherited;
  
  {
  ShowInfoMessage(Application.Handle, 'Обращение к ЭМ должны быть !', 'Сообщение');

  ViewModel.FuelTemperature.Value := 17.45;
  ViewModel.FuelDensity.Value := 100.23;
  ViewModel.FuelRiseLevel.Value := 44.24;
  ViewModel.FuelVolume.Value := 176.097;
  }

end;

procedure TStubFuelCharacteristicsCalculationCardFormController.RemoveCard(
  ViewModel: TCardFormViewModel);
begin

  ShowInfoMessage(Application.Handle, 'Тест на удаление нового расчёта', 'Message');

end;

end.
