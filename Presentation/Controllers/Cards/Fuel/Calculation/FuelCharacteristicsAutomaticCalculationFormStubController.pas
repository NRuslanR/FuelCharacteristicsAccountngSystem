unit FuelCharacteristicsAutomaticCalculationFormStubController;

interface

uses

  BaseFuelCharacteristicsAutomaticCalculationFormController,
  FuelCharacteristicsAutomaticCalculationFormViewModel,
  Forms,
  AbstractFormController,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAutomaticCalculationFormStubController =
    class (TBaseFuelCharacteristicsAutomaticCalculationFormController)

      protected

        function CreateFormViewModel(FormData: TFormData):
          TFuelCharacteristicsAutomaticCalculationFormViewModel; override;
          
      protected

        procedure OnFuelCharacteristicsAutomaticCalculationRequestedEventHandler(
          Sender: TObject;
          var ViewModel: TFuelCharacteristicsAutomaticCalculationFormViewModel
        ); override;

    end;
  
implementation

{ TFuelCharacteristicsAutomaticCalculationFormStubController }

function TFuelCharacteristicsAutomaticCalculationFormStubController.
  CreateFormViewModel(FormData: TFormData):
    TFuelCharacteristicsAutomaticCalculationFormViewModel;
begin

  Result := TFuelCharacteristicsAutomaticCalculationFormViewModel.Create;

  Result.SubLayerKinds := TStringList.Create;

  Result.SubLayerKinds.AddObject('Лёд', TObject(skIce));
  Result.SubLayerKinds.AddObject('Подтоварная вода', TObject(skBottomWater));

  Result.SubLayerKindValue := skBottomWater;
  
end;

procedure TFuelCharacteristicsAutomaticCalculationFormStubController.
  OnFuelCharacteristicsAutomaticCalculationRequestedEventHandler(
    Sender: TObject;
    var ViewModel: TFuelCharacteristicsAutomaticCalculationFormViewModel
  );
begin

  inherited;

end;

end.
