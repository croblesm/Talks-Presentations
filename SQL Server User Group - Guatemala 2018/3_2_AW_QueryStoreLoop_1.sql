USE AdventureWorks2016
GO

DECLARE @ProductId INT;

WHILE 1=1
BEGIN

	SELECT @ProductId = (
		SELECT TOP 1 ProductID 
		FROM AdventureWorks2016.Production.Product
		ORDER BY NEWID());

	EXEC AdventureWorks2016.dbo.usp_getProductSales @ProductId;
END