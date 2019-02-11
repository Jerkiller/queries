/* 
 * These are the T-SQL query parts I always forget...
 */


DECLARE @When DATE SET @When = '2018-12-14';
SELECT CONCAT(
      DATEPART(DAY,TimeStamp),'/',
      DATEPART(MONTH,TimeStamp),'/',
      DATEPART(YEAR,TimeStamp),' - ',
      DATEPART(HOUR,TimeStamp),':00') AS Ora,
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
### Database Size
SELECT 
      database_name = DB_NAME(database_id)
    , log_size_mb = CAST(SUM(CASE WHEN type_desc = 'LOG' THEN size END) * 8. / 1024 AS DECIMAL(8,2))
    , row_size_mb = CAST(SUM(CASE WHEN type_desc = 'ROWS' THEN size END) * 8. / 1024 AS DECIMAL(8,2))
    , total_size_mb = CAST(SUM(size) * 8. / 1024 AS DECIMAL(8,2))
FROM sys.master_files WITH(NOWAIT)
WHERE database_id = DB_ID() -- for current db 
GROUP BY database_id

							    
							    
### Last Slow Queries
							    
SELECT TOP 100 SUBSTRING(qt.TEXT, (qs.statement_start_offset/2)+1,
	((CASE qs.statement_end_offset
	WHEN -1 THEN DATALENGTH(qt.TEXT)
	ELSE qs.statement_end_offset
	END - qs.statement_start_offset)/2)+1),
	qs.execution_count,
	qs.total_logical_reads, qs.last_logical_reads,
	qs.total_logical_writes, qs.last_logical_writes,
	qs.total_worker_time,
	qs.last_worker_time,
	qs.total_elapsed_time/1000000 total_elapsed_time_in_S,
	qs.last_elapsed_time/1000000 last_elapsed_time_in_S,
	qs.last_execution_time,
	qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
-- ORDER BY qs.total_logical_reads DESC -- logical reads
-- ORDER BY qs.total_logical_writes DESC -- logical writes
 ORDER BY qs.total_worker_time DESC -- CPU time

												
### Table names										
SELECT *
FROM INFORMATION_SCHEMA.TABLES

												
### Table column	
 SELECT * 
  FROM INFORMATION_SCHEMA.COLUMNS 
  WHERE TABLE_NAME = 'myTableName'
