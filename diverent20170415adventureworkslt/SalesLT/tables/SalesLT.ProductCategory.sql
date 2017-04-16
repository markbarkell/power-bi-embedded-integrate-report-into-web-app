USE [adventureworkslt]
GO

/****** Object: Table [SalesLT].[ProductCategory] Script Date: 4/15/2017 9:58:25 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SalesLT].[ProductCategory] (
    [ProductCategoryID]       INT              IDENTITY (1, 1) NOT NULL,
    [ParentProductCategoryID] INT              NULL,
    [Name]                    [dbo].[Name]     NOT NULL,
    [rowguid]                 UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate]            DATETIME         NOT NULL
);


