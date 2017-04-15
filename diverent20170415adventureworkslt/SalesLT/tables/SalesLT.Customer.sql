USE [adventureworkslt]
GO

/****** Object: Table [SalesLT].[Customer] Script Date: 4/15/2017 9:57:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SalesLT].[Customer] (
    [CustomerID]   INT               IDENTITY (1, 1) NOT NULL,
    [NameStyle]    [dbo].[NameStyle] NOT NULL,
    [Title]        NVARCHAR (8)      NULL,
    [FirstName]    [dbo].[Name]      NOT NULL,
    [MiddleName]   [dbo].[Name]      NULL,
    [LastName]     [dbo].[Name]      NOT NULL,
    [Suffix]       NVARCHAR (10)     NULL,
    [CompanyName]  NVARCHAR (128)    NULL,
    [SalesPerson]  NVARCHAR (256)    NULL,
    [EmailAddress] NVARCHAR (50)     NULL,
    [Phone]        [dbo].[Phone]     NULL,
    [PasswordHash] VARCHAR (128)     NOT NULL,
    [PasswordSalt] VARCHAR (10)      NOT NULL,
    [rowguid]      UNIQUEIDENTIFIER  NOT NULL,
    [ModifiedDate] DATETIME          NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_Customer_EmailAddress]
    ON [SalesLT].[Customer]([EmailAddress] ASC);


GO
ALTER TABLE [SalesLT].[Customer]
    ADD CONSTRAINT [PK_Customer_CustomerID] PRIMARY KEY CLUSTERED ([CustomerID] ASC);


GO
ALTER TABLE [SalesLT].[Customer]
    ADD CONSTRAINT [AK_Customer_rowguid] UNIQUE NONCLUSTERED ([rowguid] ASC);


GO
ALTER TABLE [SalesLT].[Customer]
    ADD CONSTRAINT [DF_Customer_NameStyle] DEFAULT ((0)) FOR [NameStyle];


GO
ALTER TABLE [SalesLT].[Customer]
    ADD CONSTRAINT [DF_Customer_rowguid] DEFAULT (newid()) FOR [rowguid];


GO
ALTER TABLE [SalesLT].[Customer]
    ADD CONSTRAINT [DF_Customer_ModifiedDate] DEFAULT (getdate()) FOR [ModifiedDate];


