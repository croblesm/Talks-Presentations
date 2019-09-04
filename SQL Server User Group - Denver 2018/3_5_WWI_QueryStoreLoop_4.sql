DROP TABLE IF EXISTS #InvoiceLineDesc

-- Create a temporary table, note the IDENTITY
-- column that will be used to loop through
-- the rows of this table
SELECT 
	ROW_NUMBER() OVER (ORDER BY Description) as RowNum,
	Description
INTO #InvoiceLineDesc FROM Sales.InvoiceLines

	DECLARE 
	@ILNumberRecords INT, 
	@ILRowCount INT,
	@ILDesc NVARCHAR (200)

	-- Get the number of records in the temporary table
	SELECT @ILNumberRecords = COUNT(*) FROM  #InvoiceLineDesc
	SET @ILRowCount = 1

	-- loop through all records in the temporary table
	-- using the WHILE loop construct
	WHILE @ILRowCount <= @ILNumberRecords
	BEGIN
		SELECT @ILDesc = Description FROM #InvoiceLineDesc WHERE RowNum = @ILRowCount

		SELECT il.InvoiceLineID, il.Description, il.UnitPrice,
			i.CustomerID, i.SalespersonPersonID
		FROM WideWorldImporters.Sales.InvoiceLines il
		JOIN WideWorldImporters.Sales.Invoices i
			ON il.InvoiceID = i.InvoiceID
		WHERE il.Description = @ILDesc

	 SET @ILRowCount = @ILRowCount + 1
	END

DROP TABLE #InvoiceLineDesc;