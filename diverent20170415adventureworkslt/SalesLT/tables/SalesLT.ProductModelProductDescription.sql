USE [adventureworkslt]
GO

/****** Object: Table [SalesLT].[ProductModelProductDescription] Script Date: 4/15/2017 9:58:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SalesLT].[ProductModelProductDescription] (
    [ProductModelID]       INT              NOT NULL,
    [ProductDescriptionID] INT              NOT NULL,
    [Culture]              NCHAR (6)        NOT NULL,
    [rowguid]              UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate]         DATETIME         NOT NULL
);


