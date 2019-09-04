
-- Checking a normal sproc with 2 different execution plans, let focus in the logical reads
SET STATISTICS IO ON;
EXEC usp_getProdHist 712 WITH RECOMPILE; --2,348 rows
EXEC usp_getProdHist 437 WITH RECOMPILE; --28 rows
EXEC usp_getProdHist 849 WITH RECOMPILE; --1 row
SET STATISTICS IO OFF;
-- ⚠️ Show XML query plan after Plan Guide ⚠️

-- Let's create a plan guide for an object
    --object, sql, template
EXEC sp_create_plan_guide   
    @name =  N'ProductHist_PlanGuide',
    @stmt = N'SELECT
                p.name,
                tha.TransactionDate,
                tha.TransactionType,
                tha.Quantity,
                tha.ActualCost
            FROM Production.TransactionHistory tha
                JOIN Production.Product p
                ON tha.ProductID = p.ProductID
            WHERE p.ProductID = @ProdID;',
    @type = N'OBJECT',  
    @module_or_batch = N'dbo.usp_getProdHist',  
    @params = NULL,  
    @hints = N'OPTION (OPTIMIZE FOR (@ProdId = 849))'; 

-- Check plan guide and then RUN stored procedures again
SELECT * FROM [sys].[plan_guides];

-- Checking errors for plan guide
SELECT * FROM sys.fn_validate_plan_guide(65536)

-- Disable plan guide
EXEC sp_control_plan_guide @operation='DISABLE', @name='ProductHist_PlanGuide';

-- Drop plan guide
EXEC sp_control_plan_guide @operation='DROP', @name='ProductHist_PlanGuide';