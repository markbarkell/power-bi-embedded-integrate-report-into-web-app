USE [adventureworkslt]
GO

/****** Object: Table [SalesLT].[Product] Script Date: 4/15/2017 9:58:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SalesLT].[Product] (
    [ProductID]              INT              IDENTITY (1, 1) NOT NULL,
    [Name]                   [dbo].[Name]     NOT NULL,
    [ProductNumber]          NVARCHAR (25)    NOT NULL,
    [Color]                  NVARCHAR (15)    NULL,
    [StandardCost]           MONEY            NOT NULL,
    [ListPrice]              MONEY            NOT NULL,
    [Size]                   NVARCHAR (5)     NULL,
    [Weight]                 DECIMAL (8, 2)   NULL,
    [ProductCategoryID]      INT              NULL,
    [ProductModelID]         INT              NULL,
    [SellStartDate]          DATETIME         NOT NULL,
    [SellEndDate]            DATETIME         NULL,
    [DiscontinuedDate]       DATETIME         NULL,
    [ThumbNailPhoto]         VARBINARY (MAX)  NULL,
    [ThumbnailPhotoFileName] NVARCHAR (50)    NULL,
    [rowguid]                UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate]           DATETIME         NOT NULL
);


