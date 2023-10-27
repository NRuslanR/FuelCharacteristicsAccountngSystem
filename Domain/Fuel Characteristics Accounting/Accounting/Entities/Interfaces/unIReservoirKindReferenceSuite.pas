unit unIReservoirKindReferenceSuite;

interface

uses

  IGetSelfUnit,
  Employee;

type

  IReservoirKindReferenceSuite = interface (IGetSelf)

    function GetReservoirKindName: String;
    function GetAltitudinalConstantStencil: Variant;
    function GetCalibrationChartLocation: Variant;
    
    procedure SetAltitudinalConstantStencil(const Value: Variant);
    procedure SetCalibrationChartLocation(const Value: Variant);
    procedure SetReservoirKindName(const Value: String);

    function GetEditingEmployee: TEmployee;
    procedure SetEditingEmployee(const Value: TEmployee);
    
    property ReservoirKindName: String
    read GetReservoirKindName write SetReservoirKindName;

    property AltitudinalConstantStencil: Variant
    read GetAltitudinalConstantStencil write SetAltitudinalConstantStencil;
      
    property CalibrationChartLocation: Variant
    read GetCalibrationChartLocation write SetCalibrationChartLocation;

    property EditingEmployee: TEmployee
    read GetEditingEmployee write SetEditingEmployee;
    
  end;

implementation

end.
