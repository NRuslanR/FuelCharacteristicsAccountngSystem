unit StandardFuelCharacteristicsCalculationCardAccessService;

interface

uses

  FuelCharacteristicsCalculationCardAccessService,
  Employee,
  AbstractDomainService,
  FuelCharacteristicsCalculationCard,
  FuelCharacteristicsCalculationCardAccessRights,
  EmployeeFuelCharacteristicsCalculationCardWorkingRules,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsCalculationCardAccessService =
    class (
      TAbstractStandardDomainService,
      IFuelCharacteristicsCalculationCardAccessService
    )

      protected

        function MayCardBeRemovedByEmployee(
          Card: TFuelCharacteristicsCalculationCard;
          Employee: TEmployee
        ): Boolean; virtual;

        function MayCardCalculationContextInfoBeViewedByEmployee(
          Card: TFuelCharacteristicsCalculationCard;
          Employee: TEmployee
        ): Boolean; virtual;

        function MayCardCalculationContextInfoBeEditedByEmployee(
          Card: TFuelCharacteristicsCalculationCard;
          Employee: TEmployee
        ): Boolean; virtual;

        function MayCardFuelInfoBeViewedByEmployee(
          Card: TFuelCharacteristicsCalculationCard;
          Employee: TEmployee
        ): Boolean; virtual;

        function MayCardFuelInfoBeEditedByEmployee(
          Card: TFuelCharacteristicsCalculationCard;
          Employee: TEmployee
        ): Boolean; virtual;
        
      public

        function GetFuelCharacteristicsCalculationCardAccessRightsForEmployee(
          FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
          Employee: TEmployee
        ): TFuelCharacteristicsCalculationCardAccessRights; virtual;

        function EnsureAndGetFuelCharacteristicsCalculationCardAccessRightsForEmployee(
          FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
          Employee: TEmployee
        ): TFuelCharacteristicsCalculationCardAccessRights; virtual;

        procedure EnsureFuelCharacteristicsCalculationCardAccessRightsForEmployee(
          FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
          Employee: TEmployee
        ); virtual;

    end;
  

implementation

uses

  IDomainObjectBaseUnit;

{ TStandardFuelCharacteristicsCalculationCardAccessService }

function TStandardFuelCharacteristicsCalculationCardAccessService.
  EnsureAndGetFuelCharacteristicsCalculationCardAccessRightsForEmployee(
    FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
    Employee: TEmployee
  ): TFuelCharacteristicsCalculationCardAccessRights;
begin

  Result :=
    GetFuelCharacteristicsCalculationCardAccessRightsForEmployee(
      FuelCharacteristicsCalculationCard, Employee
    );

  try

    if Result.AllAccessRightsAbsent then begin

      raise TFuelCharacteristicsCalculationCardAccessServiceException.CreateFmt(
        '” сотрудника "%s" отсутствует ' +
        'доступ к карточке',
        [
          Employee.FullName
        ]
      );
      
    end;

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

procedure TStandardFuelCharacteristicsCalculationCardAccessService.
  EnsureFuelCharacteristicsCalculationCardAccessRightsForEmployee(
    FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
    Employee: TEmployee
  );
var FreeCardAccessRights: IDomainObjectBase;
begin

  FreeCardAccessRights :=
    EnsureAndGetFuelCharacteristicsCalculationCardAccessRightsForEmployee(
      FuelCharacteristicsCalculationCard, Employee
    );
  
end;

function TStandardFuelCharacteristicsCalculationCardAccessService.
  GetFuelCharacteristicsCalculationCardAccessRightsForEmployee(
    FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
    Employee: TEmployee
  ): TFuelCharacteristicsCalculationCardAccessRights;
begin

  Result := TFuelCharacteristicsCalculationCardAccessRights.Create;

  try

    Result.CanBeRemoved :=
      MayCardBeRemovedByEmployee(FuelCharacteristicsCalculationCard, Employee);

    Result.CalculationContextInfoCanBeViewed :=
      MayCardCalculationContextInfoBeViewedByEmployee(
        FuelCharacteristicsCalculationCard, Employee
      );

    Result.CalculationContextInfoCanBeEdited :=
      MayCardCalculationContextInfoBeEditedByEmployee(
        FuelCharacteristicsCalculationCard, Employee
      );

    Result.FuelInfoCanBeViewed :=
      MayCardFuelInfoBeViewedByEmployee(
        FuelCharacteristicsCalculationCard, Employee
      );

    Result.FuelInfoCanBeEdited :=
      MayCardFuelInfoBeEditedByEmployee(
        FuelCharacteristicsCalculationCard, Employee
      );
      
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

function TStandardFuelCharacteristicsCalculationCardAccessService.
  MayCardBeRemovedByEmployee(
    Card: TFuelCharacteristicsCalculationCard;
    Employee: TEmployee
  ): Boolean;
begin

  Result :=
    Card
      .WorkingRules
      .RemovingRule
      .MayEmployeeRemoveFuelCharacteristicsCalculationCard(
        Employee, Card
      );
      
end;

function TStandardFuelCharacteristicsCalculationCardAccessService.
  MayCardCalculationContextInfoBeEditedByEmployee(
    Card: TFuelCharacteristicsCalculationCard;
    Employee: TEmployee
  ): Boolean;
begin

  Result :=
    Card
      .WorkingRules
      .ContextInfoEditingRule
      .MayEmployeeEditFuelCharacteristicsCalculationCardContextInfo(
        Employee, Card
      );

end;

function TStandardFuelCharacteristicsCalculationCardAccessService.
  MayCardCalculationContextInfoBeViewedByEmployee(
    Card: TFuelCharacteristicsCalculationCard;
    Employee: TEmployee
  ): Boolean;
begin

  Result :=
    Card
      .WorkingRules
      .ContextInfoViewingRule
      .MayEmployeeViewFuelCharacteristicsCalculationCardContextInfo(
        Employee, Card
      );

end;

function TStandardFuelCharacteristicsCalculationCardAccessService.
  MayCardFuelInfoBeEditedByEmployee(
    Card: TFuelCharacteristicsCalculationCard;
    Employee: TEmployee
  ): Boolean;
begin

  Result :=
    Card
      .WorkingRules
      .FuelInfoEditingRule
      .MayEmployeeEditFuelCharacteristicsCalculationCardFuelInfo(
        Employee, Card
      );
      
end;

function TStandardFuelCharacteristicsCalculationCardAccessService.
  MayCardFuelInfoBeViewedByEmployee(
    Card: TFuelCharacteristicsCalculationCard;
    Employee: TEmployee
  ): Boolean;
begin

  Result :=
    Card
      .WorkingRules
      .FuelInfoViewingRule
      .MayEmployeeViewFuelCharacteristicsCalculationCardFuelInfo(
        Employee, Card
      );
      
end;

end.
