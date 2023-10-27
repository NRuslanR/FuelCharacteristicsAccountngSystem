unit DirectoryAccessRights;

interface

uses

  DomainObjectValueUnit,
  SysUtils,
  Classes;

type

  TDirectoryAccessRights =
    class (TDomainObjectValue)

      protected

        FViewAllowed: Boolean;
        FInPlacingAllowed: Boolean;
        FAlterationAllowed: Boolean;
        FRemovingAllowed: Boolean;

      public

        constructor Create; override;

      public

        function AllAccessRightsAbsent: Boolean; virtual;
        
      published

        property ViewAllowed: Boolean read FViewAllowed write FViewAllowed;

        property InPlacingAllowed: Boolean
        read FInPlacingAllowed write FInPlacingAllowed;
        
        property AlterationAllowed: Boolean
        read FAlterationAllowed write FAlterationAllowed;
        
        property RemovingAllowed: Boolean
        read FRemovingAllowed write FRemovingAllowed;

    end;

implementation

{ TDirectoryAccessRights }

function TDirectoryAccessRights.AllAccessRightsAbsent: Boolean;
begin

  Result :=
    not (
      ViewAllowed or
      InPlacingAllowed or
      AlterationAllowed or
      RemovingAllowed
    );
    
end;

constructor TDirectoryAccessRights.Create;
begin

  inherited;

end;

end.
