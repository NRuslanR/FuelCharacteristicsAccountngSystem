unit BasedOnRepositoryWorkingTimeConditionsDirectory;

interface

uses

  AbstractWorkingTimeConditionsDirectory,
  WorkingTimeConditions,
  WorkingTimeConditionsRepository,
  SysUtils,
  Classes;

type

  TBasedOnRepositoryWorkingTimeConditionsDirectory =
    class (TAbstractWorkingTimeConditionsDirectory)

      private

        FWorkingTimeConditionsRepository: IWorkingTimeConditionsRepository;
        
      protected

        function InternalFindActiveWorkingTimeConditions:
          TWorkingTimeConditions; override;

        function InternalFindWorkingTimeConditions(
          const WorkingTimeConditionsId: Variant
        ): TWorkingTimeConditions; override;

        procedure InternalPutWorkingTimeConditions(
          WorkingTimeConditions: TWorkingTimeConditions
        ); override;

        procedure InternalModifyWorkingTimeConditions(
          WorkingTimeConditions: TWorkingTimeConditions
        ); override;

        procedure InternalRemoveWorkingTimeConditions(
          WorkingTimeConditions: TWorkingTimeConditions
        ); override;

      public

        constructor Create(
          WorkingTimeConditionsRepository: IWorkingTimeConditionsRepository
        );
        
    end;

  
implementation

{ TBasedOnRepositoryWorkingTimeConditionsDirectory }

constructor TBasedOnRepositoryWorkingTimeConditionsDirectory.Create(
  WorkingTimeConditionsRepository: IWorkingTimeConditionsRepository);
begin

  inherited Create;

  FWorkingTimeConditionsRepository := WorkingTimeConditionsRepository;
  
end;

function TBasedOnRepositoryWorkingTimeConditionsDirectory.
  InternalFindActiveWorkingTimeConditions: TWorkingTimeConditions;
begin

  Result :=
    FWorkingTimeConditionsRepository.FindActiveWorkingTimeConditions;
    
end;

function TBasedOnRepositoryWorkingTimeConditionsDirectory.
  InternalFindWorkingTimeConditions(
    const WorkingTimeConditionsId: Variant
  ): TWorkingTimeConditions;
begin

  Result :=
    FWorkingTimeConditionsRepository.FindWorkingTimeConditionsByIdentity(
      WorkingTimeConditionsId
    );

end;

procedure TBasedOnRepositoryWorkingTimeConditionsDirectory.
  InternalModifyWorkingTimeConditions(
    WorkingTimeConditions: TWorkingTimeConditions
  );
begin

  FWorkingTimeConditionsRepository.UpdateWorkingTimeConditions(
    WorkingTimeConditions
  );

end;

procedure TBasedOnRepositoryWorkingTimeConditionsDirectory.
  InternalPutWorkingTimeConditions(
    WorkingTimeConditions: TWorkingTimeConditions
  );
begin

  FWorkingTimeConditionsRepository.AddWorkingTimeConditions(
    WorkingTimeConditions
  );

end;

procedure TBasedOnRepositoryWorkingTimeConditionsDirectory.
  InternalRemoveWorkingTimeConditions(
    WorkingTimeConditions: TWorkingTimeConditions
  );
begin

  FWorkingTimeConditionsRepository.RemoveWorkingTimeConditions(
    WorkingTimeConditions
  );

end;

end.
