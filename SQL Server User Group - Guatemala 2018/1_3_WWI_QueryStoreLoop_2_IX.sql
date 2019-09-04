USE [WideWorldImporters]
GO

DROP INDEX [MI_IL_DEMO] ON [Sales].[InvoiceLines]
GO
CREATE NONCLUSTERED INDEX [MI_IL_DEMO]
ON [Sales].[InvoiceLines] ([Description])
INCLUDE ([InvoiceID],[UnitPrice])
GO

DROP INDEX [MI_OL_DEMO] ON [Sales].[OrderLines]
GO
CREATE NONCLUSTERED INDEX [MI_OL_DEMO]
ON [Sales].[OrderLines] ([Description])
INCLUDE ([OrderID],[StockItemID],[UnitPrice])