unit ReservoirKindsFormControllerEvents;

interface

uses

  Event,
  AbstractReferenceFormControllerEvents,
  ReservoirKindRecordViewModel;

type

  TReservoirKindChooseRequestedEvent =
    class (TReferenceRecordChooseRequestedEvent)

      private

        function GetCurrentReservoirKindName: String;

      public

        constructor Create(const CurrentReservoirKindName: String);

        property CurrentReservoirKindName: String
        read GetCurrentReservoirKindName;

    end;

  TReservoirKindChoosenEvent = class (TReferenceRecordChoosenEvent)

    private

      function GetReservoirKindRecordViewModel: TReservoirKindRecordViewModel;

    public

      property ReservoirKindRecordViewModel:
        TReservoirKindRecordViewModel
      read GetReservoirKindRecordViewModel;

  end;
  
implementation

{ TOnReservoirKindChooseRequestedEvent }

constructor TReservoirKindChooseRequestedEvent.Create(
  const CurrentReservoirKindName: String);
begin

  inherited Create(CurrentReservoirKindName);
  
end;

function TReservoirKindChooseRequestedEvent.GetCurrentReservoirKindName: String;
begin

  Result := SelectedRecordId;

end;

{ TReservoirKindChoosenEvent }

function TReservoirKindChoosenEvent.GetReservoirKindRecordViewModel: TReservoirKindRecordViewModel;
begin

  Result := TReservoirKindRecordViewModel(ReferenceRecordViewModel);
  
end;

end.
