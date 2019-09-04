DECLARE @ProductId INT;

WHILE 1=1
BEGIN

	SELECT @ProductId = (
		SELECT TOP 1 ProductID 
		FROM Production.Product
		ORDER BY NEWID());

	EXEC dbo.usp_getProductSales @ProductId;
END
GO 10000