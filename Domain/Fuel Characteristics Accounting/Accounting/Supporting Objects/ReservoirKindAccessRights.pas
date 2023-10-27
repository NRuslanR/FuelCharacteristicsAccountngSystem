unit ReservoirKindAccessRights;

interface

uses

  DomainObjectValueUnit,
  SysUtils;

type

  TReservoirKindAccessRights = class (TDomainObjectValue)

    private

      FCanBeViewed: Boolean;
      FCanBeEdited: Boolean;
      FCanBeRemoved: Boolean;

    published

      property CanBeViewed: Boolean read FCanBeViewed write FCanBeViewed;
      
      property CanBeEdited: Boolean read FCanBeEdited write FCanBeEdited;
      
      property CanBeRemoved: Boolean read FCanBeRemoved write FCanBeRemoved;

    public

      function AllAccessRightsAbsent: Boolean;
      
  end;
  
implementation

{ TReservoirKindAccessRights }

function TReservoirKindAccessRights.AllAccessRightsAbsent: Boolean;
begin

  Result :=
    not (
      CanBeViewed or
      CanBeEdited or
      CanBeRemoved
    );
    
end;

end.
