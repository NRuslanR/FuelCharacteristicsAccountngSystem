unit AbstractWorkingTimeConditionsDirectory;

interface

uses

  unIWorkingTimeConditions,
  WorkingTimeConditions,
  AbstractDomainService,
  WorkingTimeConditionsDirectory,
  SysUtils,
  Classes;

type

  TAbstractWorkingTimeConditionsDirectory =
    class abstract
      (TAbstractStandardDomainService, IWorkingTimeConditionsDirectory)

      protected

        function InternalFindActiveWorkingTimeConditions:
          TWorkingTimeConditions; virtual; abstract;

        function InternalFindWorkingTimeConditions(
          const WorkingTimeConditionsId: Variant
        ): TWorkingTimeConditions; virtual; abstract;

        procedure InternalPutWorkingTimeConditions(
          WorkingTimeConditions: TWorkingTimeConditions
        ); virtual; abstract;

        procedure InternalModifyWorkingTimeConditions(
          WorkingTimeConditions: TWorkingTimeConditions
        ); virtual; abstract;

        procedure InternalRemoveWorkingTimeConditions(
          WorkingTimeConditions: TWorkingTimeConditions
        ); virtual; abstract;

      public

        function FindActiveWorkingTimeConditions: TWorkingTimeConditions;
        
        function FindWorkingTimeConditions(
          const WorkingTimeConditionsId: Variant
        ): TWorkingTimeConditions;  

        procedure PutWorkingTimeConditions(
          WorkingTimeConditions: TWorkingTimeConditions
        );

        procedure ModifyWorkingTimeConditions(
          WorkingTimeConditions: TWorkingTimeConditions
        );

        procedure RemoveWorkingTimeConditions(
          WorkingTimeConditions: TWorkingTimeConditions
        ); 

    end;

implementation

uses

  StandardWorkingTimeConditionsRuleRegistry;

{ TAbstractWorkingTimeConditionsDirectory }

function TAbstractWorkingTimeConditionsDirectory.
  FindActiveWorkingTimeConditions: TWorkingTimeConditions;
begin

  Result := InternalFindActiveWorkingTimeConditions;

  Result.Rules :=
    TWorkingTimeConditionsRuleRegistry.Current.GetWorkingTimeConditionsRules;
    
end;

function TAbstractWorkingTimeConditionsDirectory.FindWorkingTimeConditions(
  const WorkingTimeConditionsId: Variant
): TWorkingTimeConditions;
begin

  Result := InternalFindWorkingTimeConditions(WorkingTimeConditionsId);

  Result.Rules :=
    TWorkingTimeConditionsRuleRegistry.Current.GetWorkingTimeConditionsRules;
    
end;

procedure TAbstractWorkingTimeConditionsDirectory.ModifyWorkingTimeConditions(
  WorkingTimeConditions: TWorkingTimeConditions);
var PreviousActiveWorkingTimeConditions: TWorkingTimeConditions;
    FreePreviousActiveWorkingTimeConditions: IWorkingTimeConditions;
begin

  if WorkingTimeConditions.IsActive then begin

    PreviousActiveWorkingTimeConditions :=
      FindActiveWorkingTimeConditions;

    FreePreviousActiveWorkingTimeConditions := PreviousActiveWorkingTimeConditions;

    if
      Assigned(PreviousActiveWorkingTimeConditions) and
      not PreviousActiveWorkingTimeConditions.IsSameAs(WorkingTimeConditions)
    then begin

      PreviousActiveWorkingTimeConditions.InvariantsComplianceRequested := False;

      try

        PreviousActiveWorkingTimeConditions.IsActive := False;

        ModifyWorkingTimeConditions(PreviousActiveWorkingTimeConditions);
        
      finally

        PreviousActiveWorkingTimeConditions.InvariantsComplianceRequested := True;
        
      end;

    end;

  end;

  InternalModifyWorkingTimeConditions(WorkingTimeConditions);
  
end;

procedure TAbstractWorkingTimeConditionsDirectory.PutWorkingTimeConditions(
  WorkingTimeConditions: TWorkingTimeConditions);
var PreviousActiveWorkingTimeConditions: TWorkingTimeConditions;
    FreePreviousActiveWorkingTimeConditions: IWorkingTimeConditions;
begin

  if WorkingTimeConditions.IsActive then begin

    PreviousActiveWorkingTimeConditions :=
      FindActiveWorkingTimeConditions;

    FreePreviousActiveWorkingTimeConditions := PreviousActiveWorkingTimeConditions;

    if Assigned(PreviousActiveWorkingTimeConditions) then begin

      if PreviousActiveWorkingTimeConditions.IsSameAs(WorkingTimeConditions)
      then begin

        raise TWorkingTimeConditionsDirectoryException.CreateFmt(
          'Попытка поместить в каталог уже ' +
          'существующий режим рабочего времени "%s"',
          [WorkingTimeConditions.Name]
        );
        
      end;

      PreviousActiveWorkingTimeConditions.InvariantsComplianceRequested := False;

      try

        PreviousActiveWorkingTimeConditions.IsActive := False;

        ModifyWorkingTimeConditions(PreviousActiveWorkingTimeConditions);
        
      finally

        PreviousActiveWorkingTimeConditions.InvariantsComplianceRequested := True;

      end;
      
    end;

  end;

  InternalPutWorkingTimeConditions(WorkingTimeConditions);
  
end;

procedure TAbstractWorkingTimeConditionsDirectory.RemoveWorkingTimeConditions(
  WorkingTimeConditions: TWorkingTimeConditions);
begin

  InternalRemoveWorkingTimeConditions(WorkingTimeConditions);
  
end;

end.
