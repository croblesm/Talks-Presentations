DECLARE @PackageTypeId INT;

WHILE 1=1
BEGIN

	SELECT @PackageTypeId = (
		SELECT TOP 1 PackageTypeID 
		FROM WideWorldImporters.Sales.OrderLines
		ORDER BY NEWID());

	EXEC WideWorldImporters.dbo.usp_GetAvgSales @PackageTypeId;
END