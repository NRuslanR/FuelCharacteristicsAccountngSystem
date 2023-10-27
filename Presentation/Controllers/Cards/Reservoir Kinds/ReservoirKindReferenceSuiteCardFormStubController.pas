unit ReservoirKindReferenceSuiteCardFormStubController;

interface

uses

  BaseReservoirKindReferenceSuiteCardFormController,
  CardFormViewModel,
  ReservoirKindReferenceSuiteCardFormViewModel,
  Forms,
  SysUtils;

type

  TReservoirKindReferenceSuiteCardFormStubController =
    class (TBaseReservoirKindReferenceSuiteCardFormController)

      protected

        procedure CreateNewCard(ViewModel: TCardFormViewModel; var Success: Boolean); override;
        procedure ModifyCard(ViewModel: TCardFormViewModel; var Success: Boolean); override;
        procedure RemoveCard(ViewModel: TCardFormViewModel); override;
        
    end;

implementation

uses

  AuxWindowsFunctionsUnit;
  
{ TReservoirKindReferenceSuiteCardFormStubController }

procedure TReservoirKindReferenceSuiteCardFormStubController.CreateNewCard(
  ViewModel: TCardFormViewModel;
  var Success: Boolean
);
begin

  with ViewModel as TReservoirKindReferenceSuiteCardFormViewModel do begin

    ShowInfoMessage(
      Application.Handle,
      'Тест на создание карточки справочных данных ' +
      'для типа резервуаров "' + ReservoirKindName.Value + '"',
      'Сообщение'
      );

  end;

end;

procedure TReservoirKindReferenceSuiteCardFormStubController.ModifyCard(
  ViewModel: TCardFormViewModel;
  var Success: Boolean
);
begin

  with ViewModel as TReservoirKindReferenceSuiteCardFormViewModel do begin

    ShowInfoMessage(
      Application.Handle,
      'Тест на изменение карточки справочных данных ' +
      'для типа резервуаров "' + ReservoirKindName.Value + '"',
      'Сообщение'
      );

  end;

end;

procedure TReservoirKindReferenceSuiteCardFormStubController.RemoveCard(
  ViewModel: TCardFormViewModel
);
begin

  with ViewModel as TReservoirKindReferenceSuiteCardFormViewModel do begin

    ShowInfoMessage(
      Application.Handle,
      'Тест на удаление карточки справочных данных ' +
      'для типа резервуаров "' + ReservoirKindName.Value + '"',
      'Сообщение'
      );

  end;

end;

end.
