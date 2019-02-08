/* 
 * These are the T-SQL query parts I always forget...
 */


DECLARE @When DATE SET @When = '2018-12-14';

SELECT 
		concat(
      datepart(DAY,TimeStamp),'/',
      datepart(MONTH,TimeStamp),'/',
      datepart(YEAR,TimeStamp),' - ',
      datepart(HOUR,TimeStamp),':00') AS Ora,
		SUM([Count]) as Numeriche,
		REPLACE(REPLACE(CONVERT(VARCHAR,CONVERT(MONEY,SUM([Count])),1), '.00',''),',','.') as NumericheMigliaiaSeparate
  FROM [udmstat].[tbl_CountTypes]
  WHERE @When <= TimeStamp AND TimeStamp < DATEADD(DAY,1,@When)
  GROUP BY datepart(YEAR,TimeStamp),datepart(MONTH,TimeStamp),datepart(DAY,TimeStamp),datepart(HOUR,TimeStamp)
  ORDER BY datepart(YEAR,TimeStamp),datepart(MONTH,TimeStamp),datepart(DAY,TimeStamp),datepart(HOUR,TimeStamp)


### Concat e Date Format

CONCAT(
  RTRIM(Serial),'/',
  (Ty+2000),'/',
  DATEPART(YEAR,DATEADD(second,ISNULL(Dd,0)/1000, CAST('1970-01-01 00:00:00' AS datetime))),'/',
  FORMAT(DATEADD(second,ISNULL(Dd,0)/1000,CAST('1970-01-01 00:00:00' AS datetime)),'yyyyMMddHHmmss'), 
  '_noName.json')
  AS json
  
  ### https://stackoverflow.com/questions/18014392/select-sql-server-database-size
  ### DB SIZE
  
  SELECT 
      database_name = DB_NAME(database_id)
    , log_size_mb = CAST(SUM(CASE WHEN type_desc = 'LOG' THEN size END) * 8. / 1024 AS DECIMAL(8,2))
    , row_size_mb = CAST(SUM(CASE WHEN type_desc = 'ROWS' THEN size END) * 8. / 1024 AS DECIMAL(8,2))
    , total_size_mb = CAST(SUM(size) * 8. / 1024 AS DECIMAL(8,2))
FROM sys.master_files WITH(NOWAIT)
WHERE database_id = DB_ID() -- for current db 
GROUP BY database_id
