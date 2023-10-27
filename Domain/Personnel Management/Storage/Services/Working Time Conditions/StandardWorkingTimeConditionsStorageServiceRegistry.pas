unit StandardWorkingTimeConditionsStorageServiceRegistry;

interface

uses

  WorkingTimeConditionsStorageServiceRegistry,
  WorkingTimeConditionsDirectory,
  SysUtils;

type

  TWorkingTimeConditionsStorageServiceRegistry =
    class (TInterfacedObject, IWorkingTimeConditionsStorageServiceRegistry)

      private

        class var FInstance: IWorkingTimeConditionsStorageServiceRegistry;
        
        class function GetInstance: IWorkingTimeConditionsStorageServiceRegistry; static;

      protected

        FWorkingTimeConditionsDirectory: IWorkingTimeConditionsDirectory;

        procedure RaiseExceptionIfWorkingTimeConditionsDirectoryRegistrationOrderIsNotValid;
      
      public

        procedure RegisterWorkingTimeConditionsDirectory(
          WorkingTimeConditionsDirectory: IWorkingTimeConditionsDirectory
        );

        function GetWorkingTimeConditionsDirectory:
          IWorkingTimeConditionsDirectory;

      public

        procedure Clear;

        class property Current: IWorkingTimeConditionsStorageServiceRegistry
        read GetInstance write FInstance;
      
    end;
  
implementation

uses

  StandardWorkingTimeConditionsAccountingServiceRegistry;
  
{ TWorkingTimeConditionsStorageServiceRegistry }

procedure TWorkingTimeConditionsStorageServiceRegistry.Clear;
begin

  FWorkingTimeConditionsDirectory := nil;
  
end;

class function TWorkingTimeConditionsStorageServiceRegistry.
  GetInstance: IWorkingTimeConditionsStorageServiceRegistry;
begin

  if not Assigned(FInstance) then
    FInstance := TWorkingTimeConditionsStorageServiceRegistry.Create;
    
  Result := FInstance;

end;

function TWorkingTimeConditionsStorageServiceRegistry.
  GetWorkingTimeConditionsDirectory: IWorkingTimeConditionsDirectory;
begin

  Result := FWorkingTimeConditionsDirectory;

end;

procedure TWorkingTimeConditionsStorageServiceRegistry.
  RaiseExceptionIfWorkingTimeConditionsDirectoryRegistrationOrderIsNotValid;
begin

  if
    Assigned(
      TWorkingTimeConditionsAccountingServiceRegistry
        .Current
          .GetWorkingTimeConditionsAccountingService
    )
  then begin

    raise TWorkingTimeConditionsStorageServiceRegistryException.Create(
      'Неправильный порядок регистрации ' +
      'предметной службы'
    );

  end;

end;

procedure TWorkingTimeConditionsStorageServiceRegistry.
  RegisterWorkingTimeConditionsDirectory(
    WorkingTimeConditionsDirectory: IWorkingTimeConditionsDirectory
  );
begin

  RaiseExceptionIfWorkingTimeConditionsDirectoryRegistrationOrderIsNotValid;
  
  FWorkingTimeConditionsDirectory := WorkingTimeConditionsDirectory;

end;

end.
