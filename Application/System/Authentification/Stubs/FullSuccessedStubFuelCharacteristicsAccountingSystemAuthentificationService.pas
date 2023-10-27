unit FullSuccessedStubFuelCharacteristicsAccountingSystemAuthentificationService;

interface

uses

  ClientAccount,
  FullSuccessedStubSystemAuthentificationService;

type

  TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthentificationService =
    class (TFullSuccessedStubSystemAuthentificationService)

      protected

        function CreateClientAccount: TClientAccount; virtual;

        procedure FillClientAccount(ClientAccount: TClientAccount); virtual;
      
    end;
  
implementation

uses

  Variants;
  
{ TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthentificationService }

function TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthentificationService.
  CreateClientAccount: TClientAccount;
begin

  Result := TUserAccount.Create;
  
end;

procedure TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthentificationService.
FillClientAccount(ClientAccount: TClientAccount);
begin

  with ClientAccount as TUserAccount do begin

    Identity := Null;
    UserName := 'TestUser';
    UserFriendlyName := 'Тестовый пользователь';
    
  end;

end;

end.
