unit BaseFuelCharacteristicsAccountingReferenceFormControllerEvents;

interface

uses

  AbstractReferenceFormControllerEvents,
  FuelCharacteristicsAccountingReferenceRecordViewModel;

type

  TFuelCharacteristicsAccountingReferenceRecordChooseRequestedEvent =
    class (TReferenceRecordChooseRequestedEvent)

    end;

  TFuelCharacteristicsAccountingReferenceRecordChoosenEvent =
    class (TReferenceRecordChoosenEvent)

      private

        function GetReferenceRecordViewModel:
          TFuelCharacteristicsAccountingReferenceRecordViewModel;
        
      public

        property ReferenceRecordViewModel:
          TFuelCharacteristicsAccountingReferenceRecordViewModel
        read GetReferenceRecordViewModel;
        
    end;

  TAddingFuelCharacteristicsAccountingReferenceRecordRequestedEvent =
    class (TAddingReferenceRecordRequestedEvent)
    
    end;

  TChangingFuelCharacteristicsAccountingReferenceRecordRequestedEvent =
    class (TChangingReferenceRecordRequestedEvent)

    end;

  TRemovingFuelCharacteristicsAccountingReferenceRecordRequestedEvent =
    class (TRemovingReferenceRecordRequestedEvent)
    
    end;
    
implementation

{ TFuelCharacteristicsAccountingReferenceRecordChoosenEvent }

function TFuelCharacteristicsAccountingReferenceRecordChoosenEvent.
  GetReferenceRecordViewModel:
    TFuelCharacteristicsAccountingReferenceRecordViewModel;
begin

  Result :=
    TFuelCharacteristicsAccountingReferenceRecordViewModel(
      inherited ReferenceRecordViewModel
    );

end;

end.
