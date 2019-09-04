USE WideWorldImporters
GO

DROP TABLE IF EXISTS #OrderLineDesc

-- Create a temporary table, note the IDENTITY
-- column that will be used to loop through
-- the rows of this table
SELECT 
	ROW_NUMBER() OVER (ORDER BY Description) as RowNum,
	Description
INTO #OrderLineDesc FROM Sales.OrderLines

	DECLARE 
		@OLNumberRecords INT, 
		@OLRowCount INT = 1,
		@OLDesc NVARCHAR (200)

	-- Get the number of records in the temporary table
	SELECT @OLNumberRecords = COUNT(*) FROM  #OrderLineDesc

	-- loop through all records in the temporary table
	-- using the WHILE loop construct
	WHILE @OLRowCount <= @OLNumberRecords
	BEGIN
		SELECT @OLDesc = Description FROM #OrderLineDesc WHERE RowNum = @OLNumberRecords

		SELECT ol.StockItemID, ol.Description, ol.UnitPrice,
			o.CustomerID, o.SalespersonPersonID
		FROM WideWorldImporters.Sales.OrderLines ol
		JOIN WideWorldImporters.Sales.Orders o
			ON ol.OrderID = o.OrderID
		WHERE ol.Description = @OLDesc;

	 SET @OLRowCount = @OLRowCount + 1
	END

DROP TABLE #OrderLineDesc;