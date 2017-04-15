USE [adventureworkslt]
GO

/****** Object: Table [SalesLT].[CustomerAddress] Script Date: 4/15/2017 9:58:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SalesLT].[CustomerAddress] (
    [CustomerID]   INT              NOT NULL,
    [AddressID]    INT              NOT NULL,
    [AddressType]  [dbo].[Name]     NOT NULL,
    [rowguid]      UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate] DATETIME         NOT NULL
);


