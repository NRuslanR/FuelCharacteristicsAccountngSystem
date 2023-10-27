unit WorkingTimeConditionsRepository;

interface

uses

  DomainObjectRepository,
  WorkingTimeConditions,
  VariantListUnit,
  SysUtils;

type

  TWorkingTimeConditionsRepositoryException = class (Exception)

  end;

  IWorkingTimeConditionsRepository = interface (IDomainObjectRepository)

    function AddWorkingTimeConditions(WorkingTimeConditions: TWorkingTimeConditions): Boolean;
    function AddWorkingTimeConditionsList(WorkingTimeConditionsList: TWorkingTimeConditionsList): Boolean;
    function UpdateWorkingTimeConditions(WorkingTimeConditions: TWorkingTimeConditions): Boolean;
    function UpdateWorkingTimeConditionsList(WorkingTimeConditionsList: TWorkingTimeConditionsList): Boolean;
    function RemoveWorkingTimeConditions(WorkingTimeConditions: TWorkingTimeConditions): Boolean;
    function RemoveWorkingTimeConditionsList(WorkingTimeConditionsList: TWorkingTimeConditionsList): Boolean;
    function FindActiveWorkingTimeConditions: TWorkingTimeConditions;
    function FindWorkingTimeConditionsByIdentity(Identity: Variant): TWorkingTimeConditions;
    function FindWorkingTimeConditionsListByIdentities(const Identities: TVariantList): TWorkingTimeConditionsList;
    function LoadAllWorkingTimeConditionsList: TWorkingTimeConditionsList;

  end;

implementation

end.
