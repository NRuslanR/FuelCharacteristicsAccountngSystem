unit ReservoirKindReferenceSuiteAccountingAppService;

interface

uses

  ReservoirKindReferenceSuiteInfo,
  ReservoirKindReferenceSuiteDto,
  ReservoirKindReferenceSuiteAccessRightsDto,
  ApplicationService;

type

  TReservoirKindReferenceSuiteAccountingAppServiceException =
    class (TApplicationServiceException)

    end;
    
  IReservoirKindReferenceSuiteAccountingAppService =
    interface (IApplicationService)

      function GetReservoirKindReferenceSuiteAccessRights(
        const RequestingEmployeeId: Variant;
        const ReferenceSuiteId: Variant
      ): TReservoirKindReferenceSuiteAccessRightsDto;
      
      function GetReservoirKindReferenceSuiteInfo(
        const RequestingEmployeeId: Variant;
        const ReferenceSuiteId: Variant
      ): TReservoirKindReferenceSuiteInfo;

      function AccountNewReservoirKindReferenceSuite(
        const RequestingEmployeeId: Variant;
        const ReservoirKindReferenceSuiteDto: TReservoirKindReferenceSuiteDto
      ): Variant;

      procedure AccountExistingReservoirKindReferenceSuite(
        const RequestingEmployeeId: Variant;
        const ReservoirKindReferenceSuiteDto: TReservoirKindReferenceSuiteDto
      );

      procedure RemoveReservoirKindReferenceSuite(
        const RequestingEmployeeId: Variant;
        const ReferenceSuiteId: Variant
      );
      
    end;
    
implementation

end.
