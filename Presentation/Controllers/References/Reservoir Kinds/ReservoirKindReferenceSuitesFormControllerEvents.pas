unit ReservoirKindReferenceSuitesFormControllerEvents;

interface

uses

  Event,
  ReservoirKindReferenceSuiteRecordViewModel,
  AbstractReferenceFormControllerEvents;

type

  TReservoirKindReferenceSuiteChooseRequestedEvent =
    class (TReferenceRecordChooseRequestedEvent)

    end;

  TReservoirKindReferenceSuiteChoosenEvent = class (TReferenceRecordChoosenEvent)

    private

      function GetReferenceRecordViewModel: TReservoirKindReferenceSuiteRecordViewModel;
      
    public

      property ReferenceRecordViewModel:
        TReservoirKindReferenceSuiteRecordViewModel
      read GetReferenceRecordViewModel;

  end;

  TReservoirKindReferenceSuitesReferenceRequestedEvent = class (TEvent)

  end;

  TAddingReservoirKindReferenceSuiteRecordRequestedEvent =
    class (TAddingReferenceRecordRequestedEvent)

    end;

  TChangingReservoirKindReferenceSuiteRecordRequestedEvent =
    class (TChangingReferenceRecordRequestedEvent)

    end;

  TRemovingReservoirKindReferenceSuiteRecordRequestedEvent =
    class (TRemovingReferenceRecordRequestedEvent)

    end;

implementation

{ TReservoirKindReferenceSuiteChoosenEvent }

function TReservoirKindReferenceSuiteChoosenEvent.
  GetReferenceRecordViewModel: TReservoirKindReferenceSuiteRecordViewModel;
begin

  Result :=
    TReservoirKindReferenceSuiteRecordViewModel(
      inherited ReferenceRecordViewModel
    );
    
end;

end.
