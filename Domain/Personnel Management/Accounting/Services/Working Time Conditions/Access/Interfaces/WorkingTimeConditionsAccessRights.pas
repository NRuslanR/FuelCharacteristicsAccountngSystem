unit WorkingTimeConditionsAccessRights;

interface

uses

  DomainObjectValueUnit,
  SysUtils;

type

  TWorkingTimeConditionsAccessRights = class (TDomainObjectValue)

    private

      FCanBeViewed: Boolean;
      FCanBeEdited: Boolean;
      FCanBeRemoved: Boolean;

    public

      function AllAccessRightsAbsent: Boolean;
      
      property CanBeViewed: Boolean read FCanBeViewed write FCanBeViewed;
      property CanBeEdited: Boolean read FCanBeEdited write FCanBeEdited;
      property CanBeRemoved: Boolean read FCanBeRemoved write FCanBeRemoved;

  end;

implementation

{ TWorkingTimeConditionsAccessRights }

function TWorkingTimeConditionsAccessRights.AllAccessRightsAbsent: Boolean;
begin

  Result :=
    not (
      CanBeViewed or
      CanBeEdited or
      CanBeRemoved
    );
    
end;

end.
