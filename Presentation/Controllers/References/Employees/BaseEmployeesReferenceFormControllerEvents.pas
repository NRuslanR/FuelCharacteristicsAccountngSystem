unit BaseEmployeesReferenceFormControllerEvents;

interface

uses

  AbstractReferenceFormControllerEvents,
  EmployeesReferenceRecordViewModel,
  Event;

type

  TEmployeeChooseRequestedEvent =
    class (TReferenceRecordChooseRequestedEvent)

    end;

  TEmployeeChoosenEvent =
    class (TReferenceRecordChoosenEvent)

      protected

        function GetEmployeesReferenceRecordViewModel:
          TEmployeesReferenceRecordViewModel;
        
      public

        property EmployeeRecordViewModel: TEmployeesReferenceRecordViewModel
        read GetEmployeesReferenceRecordViewModel;

    end;

  TAddingEmployeesReferenceRecordRequestedEvent =
    class (TAddingReferenceRecordRequestedEvent)

    end;

  TChangingEmployeesReferenceRecordRequestedEvent =
    class (TChangingReferenceRecordRequestedEvent)

    end;

  TRemovingEmployeesReferenceRecordRequestedEvent =
    class (TRemovingReferenceRecordRequestedEvent)

    end;
  
implementation

{ TEmployeeChoosenEvent }

function TEmployeeChoosenEvent.
  GetEmployeesReferenceRecordViewModel: TEmployeesReferenceRecordViewModel;
begin

  Result := TEmployeesReferenceRecordViewModel(ReferenceRecordViewModel);

end;

end.
