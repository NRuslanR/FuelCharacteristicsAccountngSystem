unit WorkingTimeConditionsCardFormViewModelMapper;

interface

uses

  AbstractCardFormViewModelMapper,
  WorkingTimeConditionsCardFormViewModel,
  WorkingTimeConditionsDto,
  WorkingTimeConditionsInfo,
  WorkingTimeConditionsAccessRightsDto,
  CardFormViewModel,
  SysUtils,
  Classes;

type

  TWorkingTimeConditionsCardFormViewModelMapper =
    class (TAbstractCardFormViewModelMapper)

      protected

        function GetCardFormViewModelClass: TCardFormViewModelClass; override;

      public

        function MapWorkingTimeConditionsCardFormViewModelFrom(
          WorkingTimeConditionsInfo: TWorkingTimeConditionsInfo
        ): TWorkingTimeConditionsCardFormViewModel;
        
    end;

  
implementation

{ TWorkingTimeConditionsCardFormViewModelMapper }

function TWorkingTimeConditionsCardFormViewModelMapper.
  GetCardFormViewModelClass: TCardFormViewModelClass;
begin

  Result := TWorkingTimeConditionsCardFormViewModel;
  
end;

function TWorkingTimeConditionsCardFormViewModelMapper.
  MapWorkingTimeConditionsCardFormViewModelFrom(
    WorkingTimeConditionsInfo: TWorkingTimeConditionsInfo
  ): TWorkingTimeConditionsCardFormViewModel;
begin

  Result := TWorkingTimeConditionsCardFormViewModel.Create;

  try

    with WorkingTimeConditionsInfo do begin

      Result.Id.Value := WorkingTimeConditionsDto.Id;
      Result.IsActive.Value := WorkingTimeConditionsDto.IsActive;
      Result.Name.Value := WorkingTimeConditionsDto.Name;
      Result.WorkingDayBeginningTime.Value := WorkingTimeConditionsDto.WorkingDayBeginningTime;;
      Result.WorkingDayEndingTime.Value := WorkingTimeConditionsDto.WorkingDayEndingTime;

      Result.IsActive.ReadOnly := not AccessRightsDto.CanBeEdited;
      Result.Name.ReadOnly := not AccessRightsDto.CanBeEdited;
      Result.WorkingDayBeginningTime.ReadOnly := not AccessRightsDto.CanBeEdited;
      Result.WorkingDayEndingTime.ReadOnly := not AccessRightsDto.CanBeEdited;
      
    end;

  except

    on E: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

end.
