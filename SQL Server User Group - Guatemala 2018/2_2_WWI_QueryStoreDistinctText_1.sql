USE [WideWorldImporters];
GO

SET NOCOUNT ON;
DECLARE @RowNum INT = 1;
DECLARE @Description NVARCHAR(100);
DECLARE @RandomDescription NVARCHAR(8);
DECLARE @SQLstring NVARCHAR(MAX);

DROP TABLE IF EXISTS #OrderLinesList;
DROP TABLE IF EXISTS #InvoiceLinesList;

SELECT 
	DISTINCT [Description], 
	DENSE_RANK() OVER (ORDER BY [Description]) AS RowNum
INTO #OrderLinesList
FROM [Sales].[OrderLines]

SELECT 
	DISTINCT [Description], 
	DENSE_RANK() OVER (ORDER BY [Description]) AS RowNum
INTO #InvoiceLinesList
FROM [Sales].[InvoiceLines]

WHILE 1=1
BEGIN

	SELECT @RandomDescription = (SELECT SUBSTRING(CONVERT(VARCHAR(255), NEWID()), 0, 7))

	SELECT @Description = (SELECT [Description] FROM #OrderLinesList WHERE RowNum = @RowNum)

	SET @SQLstring = '
	SELECT [ol].[StockItemID], [ol].[Description], [ol].[UnitPrice],
		[o].[CustomerID], [o].[SalespersonPersonID]
	FROM [Sales].[OrderLines] [ol]
	JOIN [Sales].[Orders] [o]
		ON [ol].[OrderID] = [o].[OrderID]
	WHERE [ol].[Description] = ''' + @Description + ''''

	EXEC (@SQLstring)

	SET @SQLstring = '
	SELECT [ol].[StockItemID], [ol].[Description], [ol].[UnitPrice],
		[o].[CustomerID], [o].[SalespersonPersonID]
	FROM [Sales].[OrderLines] [ol]
	JOIN [Sales].[Orders] [o]
		ON [ol].[OrderID] = [o].[OrderID]
	WHERE [ol].[Description] = ''' + @RandomDescription + ''''

	EXEC (@SQLstring)

	SELECT @Description = (SELECT [Description] FROM #InvoiceLinesList WHERE RowNum = @RowNum)

	SET @SQLstring = '
		SELECT [il].[InvoiceLineID], [il].[Description], [il].[UnitPrice],
			[i].[CustomerID], [i].[SalespersonPersonID]
		FROM [Sales].[InvoiceLines] [il]
		JOIN [Sales].[Invoices] [i]
			ON [il].[InvoiceID] = [i].[InvoiceID]
		WHERE [il].[Description] = ''' + @Description + ''''

	EXEC (@SQLstring)

	SET @SQLstring = '
		SELECT [il].[InvoiceLineID], [il].[Description], [il].[UnitPrice],
			[i].[CustomerID], [i].[SalespersonPersonID]
		FROM [Sales].[InvoiceLines] [il]
		JOIN [Sales].[Invoices] [i]
			ON [il].[InvoiceID] = [i].[InvoiceID]
		WHERE [il].[Description] = ''' + @RandomDescription + ''''

	EXEC (@SQLstring)

END