USE AdventureWorks2016
GO

EXEC usp_getProductSales 897; --few rows
EXEC usp_getProductSales 870; --large rows

--Remove query plan from cache
DBCC FREEPROCCACHE (0x03000500DD931004301D1E0105A9000001000000000000000000000000000000000000000000000000000000)

--Run store procedure again
EXEC usp_getProductSales 870; --large rows
EXEC usp_getProductSales 897; --few rows