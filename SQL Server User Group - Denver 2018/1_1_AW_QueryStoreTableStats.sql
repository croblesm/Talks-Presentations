
-- Data skewness, graphical representation throught line graphic
DECLARE @TableName      VARCHAR(128)
DECLARE @StatisticsName VARCHAR(128)

SET @TableName = 'Production.TransactionHistory'
SET @StatisticsName = 'IX_TransactionHistory_ProductID'

DECLARE @SQLCmd         VARCHAR(2048)
DECLARE @ScaleFactor    NUMERIC(8,8)
DECLARE @StatH          VARCHAR(MAX)

--This script will draw a graphical histrogram for the given statistics.

CREATE TABLE #histogram
(
    ID INT IDENTITY(1,1),
    [RANGE_HI_KEY] SQL_VARIANT,
    [RANGE_ROWS] SQL_VARIANT,
    [EQ_ROWS] SQL_VARIANT,
    [DISTINCT_RANGE_ROWS] SQL_VARIANT,
    [AVG_RANGE_ROWS] SQL_VARIANT
)

SET @SQLCmd = 'DBCC SHOW_STATISTICS ("'+ @TableName + '","' + @StatisticsName + '") WITH HISTOGRAM'

    INSERT INTO #histogram EXEC(@SQLCmd);

--== To keep things visible I scale the RANGE_ROWS value
--== down if needed
SET @ScaleFactor = (SELECT CASE WHEN MAX(CAST(RANGE_ROWS AS BIGINT) + CAST(EQ_ROWS AS BIGINT)) > 100 THEN 100.0/(MAX(CAST(RANGE_ROWS AS BIGINT) + CAST(EQ_ROWS AS BIGINT))) ELSE 1 END FROM #histogram)


SET @StatH =
STUFF(
    (SELECT ',((' +
CAST( ID AS VARCHAR(30) ) + ' 0,' +   -- Bottom left
CAST( ID AS VARCHAR(30) ) + ' ' +	CAST( CAST(RANGE_ROWS AS BIGINT) + CAST(EQ_ROWS AS BIGINT) * @ScaleFactor AS VARCHAR(30) ) + ',' + -- Top Left
CAST( ID + .75 AS VARCHAR(30) ) + ' ' + CAST( CAST(RANGE_ROWS AS BIGINT) + CAST(EQ_ROWS AS BIGINT) * @ScaleFactor AS VARCHAR(30) ) + ',' + -- Top Right
CAST( ID + .75 AS VARCHAR(30) ) + ' 0,' + --Bottom Right
CAST( ID AS VARCHAR(30) ) + ' 0))' -- Back to the start, bottom left
FROM #histogram
ORDER BY ID
FOR XML PATH('')), 1, 1, '');


--== Dumping the raw histogram data as well
SELECT
    --ID,
    ISNULL(RANGE_HI_KEY,0) AS "High range key",
    --RANGE_ROWS,
    ISNULL(EQ_ROWS,0) AS "Number of eq rows"
FROM #histogram;

DROP TABLE #histogram;