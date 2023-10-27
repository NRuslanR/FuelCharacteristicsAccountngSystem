unit BaseReservoirKindReferenceSuiteCardFormController;

interface

uses

  unCardForm,
  AbstractCardFormController,
  EventBus,
  Event,
  EventHandler,
  AbstractFormController,
  unReservoirKindReferenceSuiteCardForm,
  ReservoirKindsFormControllerEvents,
  AbstractCardFormControllerEvents,
  AbstractReferenceFormControllerEvents,
  ReservoirKindReferenceSuitesFormControllerEvents,
  ReservoirKindReferenceSuiteCardFormControllerEvents,
  SysUtils,
  CardFormViewModel,
  Classes,
  Forms;

type

  TBaseReservoirKindReferenceSuiteCardFormController =
    class abstract (TAbstractCardFormController)
        
      protected

        function GetFormClass: TFormClass; override;

        procedure SubscribeOnFormEvents(Form: TForm); override;

        procedure CustomizeForm(Form: TForm; FormData: TFormData); override;
        
        procedure OnCalibrationChartLocationChooseRequestedEventHandler(
          Sender: TObject;
          var CurrentCalibrationChartLocation: String;
          var ChangeCalibrationChartLocation: Boolean
        ); virtual;

      protected

        function GetCardCreatedEventClass: TCardCreatedEventClass; override;
        function GetCardModifiedEventClass: TCardModifiedEventClass; override;
        function GetCardRemovedEventClass: TCardRemovedEventClass; override;

      protected

        function GetAddingReferenceRecordRequestedEventClass: TAddingReferenceRecordRequestedEventClass; override;
        function GetChangingReferenceRecordRequestedEventClass: TChangingReferenceRecordRequestedEventClass; override;
        function GetRemovingReferenceRecordRequestedEventClass: TRemovingReferenceRecordRequestedEventClass; override;

    end;

implementation

uses

  Dialogs;

{ TBaseReservoirKindReferenceSuiteCardFormController }

procedure TBaseReservoirKindReferenceSuiteCardFormController.
  CustomizeForm(
    Form: TForm;
    FormData: TFormData
  );
begin

  inherited;

  Form.Caption := 'Справочные данные типа резервуаров';
  
end;

function TBaseReservoirKindReferenceSuiteCardFormController.
  GetAddingReferenceRecordRequestedEventClass:
    TAddingReferenceRecordRequestedEventClass;
begin

  Result := TAddingReservoirKindReferenceSuiteRecordRequestedEvent;
  
end;

function TBaseReservoirKindReferenceSuiteCardFormController.
  GetCardCreatedEventClass: TCardCreatedEventClass;
begin

  Result := TReservoirKindReferenceSuiteCardCreatedEvent;
  
end;

function TBaseReservoirKindReferenceSuiteCardFormController.
  GetCardModifiedEventClass: TCardModifiedEventClass;
begin

  Result := TReservoirKindReferenceSuiteCardModifiedEvent;
  
end;

function TBaseReservoirKindReferenceSuiteCardFormController.
  GetCardRemovedEventClass: TCardRemovedEventClass;
begin

  Result := TReservoirKindReferenceSuiteCardRemovedEvent;

end;

function TBaseReservoirKindReferenceSuiteCardFormController.
  GetChangingReferenceRecordRequestedEventClass:
    TChangingReferenceRecordRequestedEventClass;
begin

  Result := TChangingReservoirKindReferenceSuiteRecordRequestedEvent;
  
end;

function TBaseReservoirKindReferenceSuiteCardFormController.
  GetFormClass: TFormClass;
begin

  Result := TReservoirKindReferenceSuiteCardForm;

end;

function TBaseReservoirKindReferenceSuiteCardFormController.
  GetRemovingReferenceRecordRequestedEventClass:
    TRemovingReferenceRecordRequestedEventClass;
begin

  Result := TRemovingReservoirKindReferenceSuiteRecordRequestedEvent;
  
end;

procedure TBaseReservoirKindReferenceSuiteCardFormController.
  OnCalibrationChartLocationChooseRequestedEventHandler(
    Sender: TObject;
    var CurrentCalibrationChartLocation: String;
    var ChangeCalibrationChartLocation: Boolean
  );
begin

  with TOpenDialog.Create(nil) do begin

    try

      Title := 'Выбор градуировочной таблицы';

      if Trim(CurrentCalibrationChartLocation) <> '' then
        FileName := CurrentCalibrationChartLocation;

      Filter := 'Табличные файлы (*.xls, *.xlsx)|*.xls;*.xlsx';

      if Execute then
        CurrentCalibrationChartLocation := FileName;

    finally

      Free;

    end;

  end;

end;

procedure TBaseReservoirKindReferenceSuiteCardFormController.
  SubscribeOnFormEvents(
    Form: TForm
  );
begin

  inherited;

  with Form as TReservoirKindReferenceSuiteCardForm do begin

    OnCalibrationChartLocationChooseRequestedEventHandler :=
      Self.OnCalibrationChartLocationChooseRequestedEventHandler;

  end;
  
end;

end.
