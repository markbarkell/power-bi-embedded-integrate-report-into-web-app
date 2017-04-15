USE [adventureworkslt]
GO

/****** Object: Table [SalesLT].[ProductModel] Script Date: 4/15/2017 9:58:46 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SalesLT].[ProductModel] (
    [ProductModelID]     INT              IDENTITY (1, 1) NOT NULL,
    [Name]               [dbo].[Name]     NOT NULL,
    [CatalogDescription] XML              NULL,
    [rowguid]            UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate]       DATETIME         NOT NULL
);


