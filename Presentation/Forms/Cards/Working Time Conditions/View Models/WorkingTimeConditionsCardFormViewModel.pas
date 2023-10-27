unit WorkingTimeConditionsCardFormViewModel;

interface

uses

  CardFormViewModel,
  SysUtils,
  Classes;

type

  TWorkingTimeConditionsCardFormViewModel = class (TCardFormViewModel)

    private

      FIsActive: TCardFormViewModelProperty;
      FName: TCardFormViewModelProperty;
      FWorkingDayBeginningTime: TCardFormViewModelProperty;
      FWorkingDayEndingTime: TCardFormViewModelProperty;

    protected

      procedure RestoreProperties; override;

    public

      constructor Create; override;

      property IsActive: TCardFormViewModelProperty read FIsActive;
      property Name: TCardFormViewModelProperty read FName;

      property WorkingDayBeginningTime: TCardFormViewModelProperty
      read FWorkingDayBeginningTime;
      
      property WorkingDayEndingTime: TCardFormViewModelProperty
      read FWorkingDayEndingTime;
      
  end;

implementation

{ TWorkingTimeConditionsCardFormViewModel }

constructor TWorkingTimeConditionsCardFormViewModel.Create;
begin

  inherited;

  FIsActive := AddProperty('IsActive');
  FName := AddProperty('Name');
  FWorkingDayBeginningTime := AddProperty('WorkingDayBeginningTime');
  FWorkingDayEndingTime := AddProperty('WorkingDayEndingTime');
  
end;

procedure TWorkingTimeConditionsCardFormViewModel.RestoreProperties;
begin

  inherited;

  FIsActive := FindProperty('IsActive');
  FName := FindProperty('Name');
  FWorkingDayBeginningTime := FindProperty('WorkingDayBeginningTime');
  FWorkingDayEndingTime := FindProperty('WorkingDayEndingTime');
  
end;

end.
