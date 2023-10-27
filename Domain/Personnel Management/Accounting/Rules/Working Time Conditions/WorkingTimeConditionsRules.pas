unit WorkingTimeConditionsRules;

interface

uses

  WorkingTimeConditionsAccessingRule,
  SysUtils;

type

  TWorkingTimeConditionsRules = class

    private

      FAccessingRule: IWorkingTimeConditionsAccessingRule;

    public

      constructor Create; overload;
      constructor Create(
        AccessingRule: IWorkingTimeConditionsAccessingRule
      ); overload;

      property AccessingRule: IWorkingTimeConditionsAccessingRule
      read FAccessingRule
      write FAccessingRule;

  end;

implementation

{ TWorkingTimeConditionsRules }

constructor TWorkingTimeConditionsRules.Create;
begin

  inherited;
  
end;

constructor TWorkingTimeConditionsRules.Create(
  AccessingRule: IWorkingTimeConditionsAccessingRule
);
begin

  inherited Create;

  FAccessingRule := AccessingRule;
  
end;

end.
