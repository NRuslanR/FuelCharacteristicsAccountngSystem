unit WorkingTimeConditionsCardFormServiceController;

interface

uses

  BaseWorkingTimeConditionsCardFormController,
  CardFormViewModel,
  WorkingTimeConditionsAccountingAppService,
  WorkingTimeConditionsCardFormViewModelMapper,
  WorkingTimeConditionsDto,
  WorkingTimeConditionsInfo,
  WorkingTimeConditionsDtoMapper,
  WorkingTimeConditionsCardFormViewModel,
  Forms,
  Controls,
  EventBus,
  SysUtils;

type

  TWorkingTimeConditionsCardFormServiceController =
    class (TBaseWorkingTimeConditionsCardFormController)

      protected

        FClientIdentity: Variant;

        FWorkingTimeConditionsAccountingAppService:
          IWorkingTimeConditionsAccountingAppService;

        FViewModelMapper: TWorkingTimeConditionsCardFormViewModelMapper;

        FWorkingTimeConditionsDtoMapper: TWorkingTimeConditionsDtoMapper;
        
      protected

        procedure CreateNewCard(ViewModel: TCardFormViewModel; var Success: Boolean); override;
        procedure ModifyCard(ViewModel: TCardFormViewModel; var Success: Boolean); override;
        procedure RemoveCard(ViewModel: TCardFormViewModel); override;

      protected

        function GetActiveWorkingTimeConditionsInfo: TWorkingTimeConditionsInfo;

        function CreateViewModelForWorkingTimeConditions(
          const WorkingTimeConditionsId: Variant
        ): TWorkingTimeConditionsCardFormViewModel;

        function CreateViewModelForActiveWorkingTimeConditions:
          TWorkingTimeConditionsCardFormViewModel;
        
      public

        destructor Destroy; override;
        
        constructor Create(

          const ClientIdentity: Variant;

          WorkingTimeConditionsAccountingAppService:
            IWorkingTimeConditionsAccountingAppService;

          ViewModelMapper: TWorkingTimeConditionsCardFormViewModelMapper;
          EventBus: IEventBus
        );

    end;
    
implementation

{ TWorkingTimeConditionsCardFormServiceController }

constructor TWorkingTimeConditionsCardFormServiceController.Create(
  const ClientIdentity: Variant;
  WorkingTimeConditionsAccountingAppService: IWorkingTimeConditionsAccountingAppService;
  ViewModelMapper: TWorkingTimeConditionsCardFormViewModelMapper;
  EventBus: IEventBus
);
begin

  inherited Create(ViewModelMapper, EventBus);

  FClientIdentity := ClientIdentity;

  FWorkingTimeConditionsAccountingAppService :=
    WorkingTimeConditionsAccountingAppService;

  FWorkingTimeConditionsDtoMapper := TWorkingTimeConditionsDtoMapper.Create;
    
end;

procedure TWorkingTimeConditionsCardFormServiceController.CreateNewCard(
  ViewModel: TCardFormViewModel;
  var Success: Boolean
);
begin

  raise Exception.Create(
    'Не реализована операция ' +
    'создания нового режима рабочего времени'
  );

end;

function TWorkingTimeConditionsCardFormServiceController.
  CreateViewModelForActiveWorkingTimeConditions:
    TWorkingTimeConditionsCardFormViewModel;
var WorkingTimeConditionsInfo: TWorkingTimeConditionsInfo;
begin

  WorkingTimeConditionsInfo :=
    FWorkingTimeConditionsAccountingAppService
      .GetActiveWorkingTimeConditionsInfo(FClientIdentity);

  try

    Result :=
      FViewModelMapper.MapWorkingTimeConditionsCardFormViewModelFrom(
        WorkingTimeConditionsInfo
      );
      
  finally

    FreeAndNil(WorkingTimeConditionsInfo);

  end;

end;

function TWorkingTimeConditionsCardFormServiceController.
  CreateViewModelForWorkingTimeConditions(
    const WorkingTimeConditionsId: Variant
  ): TWorkingTimeConditionsCardFormViewModel;
var WorkingTimeConditionsInfo: TWorkingTimeConditionsInfo;
begin

  WorkingTimeConditionsInfo :=
    FWorkingTimeConditionsAccountingAppService
      .GetWorkingTimeConditionsInfo(FClientIdentity, WorkingTimeConditionsId);

  try

    Result :=
      FViewModelMapper.MapWorkingTimeConditionsCardFormViewModelFrom(
        WorkingTimeConditionsInfo
      );
      
  finally

    FreeAndNil(WorkingTimeConditionsInfo);

  end;

end;

destructor TWorkingTimeConditionsCardFormServiceController.Destroy;
begin

  FreeAndNil(FWorkingTimeConditionsDtoMapper);
  
  inherited;

end;

function TWorkingTimeConditionsCardFormServiceController.
  GetActiveWorkingTimeConditionsInfo: TWorkingTimeConditionsInfo;
begin

  Result :=
    FWorkingTimeConditionsAccountingAppService
      .GetActiveWorkingTimeConditionsInfo(FClientIdentity);

end;

procedure TWorkingTimeConditionsCardFormServiceController.ModifyCard(
  ViewModel: TCardFormViewModel;
  var Success: Boolean
);
var WorkingTimeConditionsDto: TWorkingTimeConditionsDto;
begin

  WorkingTimeConditionsDto :=
    FWorkingTimeConditionsDtoMapper.MapWorkingTimeConditionsDtoFrom(
      TWorkingTimeConditionsCardFormViewModel(ViewModel)
    );

  try

    Screen.Cursor := crHourGlass;

    FWorkingTimeConditionsAccountingAppService
      .AccountExistingWorkingTimeConditions(
        FClientIdentity,
        WorkingTimeConditionsDto
      );
      
  finally

    FreeAndNil(WorkingTimeConditionsDto);

  end;

end;

procedure TWorkingTimeConditionsCardFormServiceController.RemoveCard(
  ViewModel: TCardFormViewModel
);
begin

  raise Exception.Create(
    'Не реализована операция ' +
    'удаления режима рабочего времени'
  );

end;

end.
