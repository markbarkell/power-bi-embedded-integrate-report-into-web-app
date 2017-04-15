USE [adventureworkslt]
GO

/****** Object: Table [SalesLT].[ProductDescription] Script Date: 4/15/2017 9:58:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SalesLT].[ProductDescription] (
    [ProductDescriptionID] INT              IDENTITY (1, 1) NOT NULL,
    [Description]          NVARCHAR (400)   NOT NULL,
    [rowguid]              UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate]         DATETIME         NOT NULL
);


