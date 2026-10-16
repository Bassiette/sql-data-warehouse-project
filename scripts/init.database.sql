/* ============================================================================
   ini.datawarehouse.sql
   ----------------------------------------------------------------------------
   Purpose : Initialize the DataWareHouse database with the classic
             Medallion Architecture layers: bronze / silver / gold.

   ⚠️  WARNING ⚠️
   ----------------------------------------------------------------------------
   THIS SCRIPT DROPS THE ENTIRE [DataWareHouse] DATABASE IF IT EXISTS.
   ALL DATA, TABLES, VIEWS, PROCEDURES, SCHEMAS AND USERS INSIDE IT WILL BE
   PERMANENTLY DELETED. THIS ACTION CANNOT BE UNDONE.

   DO NOT RUN THIS SCRIPT IN PRODUCTION.
   ALWAYS TAKE A FULL BACKUP BEFORE RUNNING IT.

   Run at your own risk. You have been warned.
   ============================================================================ */

SET NOCOUNT ON;
GO

/* ----------------------------------------------------------------------------
   1. DROP THE DATABASE IF IT EXISTS (force close active connections first)
   ---------------------------------------------------------------------------- */
IF DB_ID(N'DataWareHouse') IS NOT NULL
BEGIN
    PRINT '⚠️  Dropping existing database [DataWareHouse] ...';

    -- Force the database into single-user mode to kill active connections
    ALTER DATABASE [DataWareHouse] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE [DataWareHouse];

    PRINT '✔ Existing database [DataWareHouse] dropped.';
END
ELSE
BEGIN
    PRINT 'ℹ️  Database [DataWareHouse] does not exist — nothing to drop.';
END
GO

/* ----------------------------------------------------------------------------
   2. CREATE THE DATABASE
   ---------------------------------------------------------------------------- */
PRINT 'Creating database [DataWareHouse] ...';
GO

CREATE DATABASE [DataWareHouse];
GO

PRINT '✔ Database [DataWareHouse] created.';
GO

/* ----------------------------------------------------------------------------
   3. SWITCH CONTEXT
   ---------------------------------------------------------------------------- */
USE [DataWareHouse];
GO

/* ----------------------------------------------------------------------------
   4. CREATE THE MEDALLION SCHEMAS
      bronze : raw / landing layer     (as-is ingestion)
      silver : cleansed / conformed    (validated, deduped)
      gold   : curated / business      (aggregated, analytics-ready)
   ---------------------------------------------------------------------------- */
PRINT 'Creating schemas: bronze, silver, gold ...';
GO

IF SCHEMA_ID(N'bronze') IS NULL
    EXEC('CREATE SCHEMA [bronze] AUTHORIZATION [dbo];');
GO

IF SCHEMA_ID(N'silver') IS NULL
    EXEC('CREATE SCHEMA [silver] AUTHORIZATION [dbo];');
GO

IF SCHEMA_ID(N'gold') IS NULL
    EXEC('CREATE SCHEMA [gold] AUTHORIZATION [dbo];');
GO

PRINT '✔ Schemas [bronze], [silver], [gold] are ready.';
GO

/* ----------------------------------------------------------------------------
   5. VERIFICATION
   ---------------------------------------------------------------------------- */
SELECT
      s.name        AS schema_name
    , u.name        AS owner_name
FROM sys.schemas AS s
JOIN sys.database_principals AS u
    ON u.principal_id = s.principal_id
WHERE s.name IN (N'bronze', N'silver', N'gold')
ORDER BY s.name;
GO

PRINT '============================================================';
PRINT ' DataWareHouse initialization completed successfully.';
PRINT ' Layers: bronze → silver → gold';
PRINT '============================================================';
GO
