CREATE DATABASE [SakuraSushi]
GO
USE [SakuraSushi]
GO
/****** Object:  Table [dbo].[CartItems]    Script Date: 8/21/2024 10:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CartItems]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CartItems](
	[Id] [uniqueidentifier] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[ItemId] [uniqueidentifier] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[TotalPrice] [decimal](18, 2) NOT NULL,
	[AddedAt] [datetimeoffset](7) NOT NULL,
 CONSTRAINT [PK_CartItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 8/21/2024 10:26:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categories]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Categories](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Items]    Script Date: 8/21/2024 10:26:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Items]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Items](
	[Id] [uniqueidentifier] NOT NULL,
	[CategoryId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](200) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[ImageUrl] [nvarchar](200) NULL,
	[Available] [bit] NOT NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 8/21/2024 10:26:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderItems]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrderItems](
	[Id] [uniqueidentifier] NOT NULL,
	[OrderId] [uniqueidentifier] NOT NULL,
	[ItemId] [uniqueidentifier] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Status] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_OrderItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 8/21/2024 10:26:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Orders]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Orders](
	[Id] [uniqueidentifier] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[OrderedAt] [datetimeoffset](7) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Tables]    Script Date: 8/21/2024 10:26:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tables](
	[Id] [uniqueidentifier] NOT NULL,
	[TableNumber] [nvarchar](10) NOT NULL,
	[Capacity] [int] NOT NULL,
 CONSTRAINT [PK_Tables] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 8/21/2024 10:26:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Transactions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Transactions](
	[Id] [uniqueidentifier] NOT NULL,
	[TableId] [uniqueidentifier] NOT NULL,
	[CashierId] [uniqueidentifier] NULL,
	[UniqueCode] [nvarchar](10) NOT NULL,
	[OpenedAt] [datetimeoffset](7) NOT NULL,
	[ClosedAt] [datetimeoffset](7) NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Transactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/21/2024 10:26:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Users](
	[Id] [uniqueidentifier] NOT NULL,
	[Username] [nvarchar](20) NOT NULL,
	[PasswordHash] [nvarchar](100) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NULL,
	[PhoneNumber] [nvarchar](15) NULL,
	[Role] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (N'53a623ac-0c22-4102-abd0-45709ea55cf9', N'Udon', N'Thick wheat noodles served in a savory broth')
INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (N'4264c574-c75c-4703-be5b-7419ee6362de', N'Sashimi', N'Fresh slices of raw fish or seafood')
INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (N'60d39a77-2d33-472b-9341-847472339dd5', N'Nigiri', N'Hand-pressed sushi rice topped with slices of raw fish or seafood')
INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (N'ab2b9e1f-ac5b-404b-b69a-cfd1aef52fcb', N'Maki', N'Sushi rolls wrapped in seaweed with various fillings')
INSERT [dbo].[Categories] ([Id], [Name], [Description]) VALUES (N'80df3e11-1774-4297-9489-db1f21375371', N'Tempura', N'Deep-fried battered seafood or vegetables')
GO
INSERT [dbo].[Items] ([Id], [CategoryId], [Name], [Description], [Price], [ImageUrl], [Available]) VALUES (N'6e274b13-128a-4c0b-9b21-3110f54566ae', N'53a623ac-0c22-4102-abd0-45709ea55cf9', N'Chicken Udon', N'Thick wheat noodles served in a savory broth with chicken', CAST(8.99 AS Decimal(18, 2)), NULL, 1)
INSERT [dbo].[Items] ([Id], [CategoryId], [Name], [Description], [Price], [ImageUrl], [Available]) VALUES (N'96d79353-b498-4766-895a-32ffd25e13b9', N'53a623ac-0c22-4102-abd0-45709ea55cf9', N'Vegetable Udon', N'Thick wheat noodles served in a savory broth with mixed vegetables', CAST(7.99 AS Decimal(18, 2)), NULL, 0)
INSERT [dbo].[Items] ([Id], [CategoryId], [Name], [Description], [Price], [ImageUrl], [Available]) VALUES (N'0f55d90e-707b-4afb-a9fe-53a437deec80', N'4264c574-c75c-4703-be5b-7419ee6362de', N'Tuna Sashimi', N'Fresh slices of raw tuna', CAST(9.99 AS Decimal(18, 2)), NULL, 1)
INSERT [dbo].[Items] ([Id], [CategoryId], [Name], [Description], [Price], [ImageUrl], [Available]) VALUES (N'3bce0d1d-4ad5-49af-9653-77fe98f716cd', N'60d39a77-2d33-472b-9341-847472339dd5', N'Yellowtail Nigiri', N'Hand-pressed sushi rice topped with fresh yellowtail', CAST(4.99 AS Decimal(18, 2)), NULL, 1)
INSERT [dbo].[Items] ([Id], [CategoryId], [Name], [Description], [Price], [ImageUrl], [Available]) VALUES (N'c2b6d555-b440-42d1-bc99-7d0d054282af', N'60d39a77-2d33-472b-9341-847472339dd5', N'Salmon Nigiri', N'Hand-pressed sushi rice topped with fresh salmon', CAST(2.99 AS Decimal(18, 2)), NULL, 1)
INSERT [dbo].[Items] ([Id], [CategoryId], [Name], [Description], [Price], [ImageUrl], [Available]) VALUES (N'42be1567-f58d-4e40-9c4b-884dbea04d5c', N'4264c574-c75c-4703-be5b-7419ee6362de', N'Yellowtail Sashimi', N'Fresh slices of raw yellowtail', CAST(10.99 AS Decimal(18, 2)), NULL, 0)
INSERT [dbo].[Items] ([Id], [CategoryId], [Name], [Description], [Price], [ImageUrl], [Available]) VALUES (N'77b18aea-f0f4-438b-86ee-8c56e855eb39', N'60d39a77-2d33-472b-9341-847472339dd5', N'Tuna Nigiri', N'Hand-pressed sushi rice topped with fresh tuna', CAST(3.99 AS Decimal(18, 2)), NULL, 1)
INSERT [dbo].[Items] ([Id], [CategoryId], [Name], [Description], [Price], [ImageUrl], [Available]) VALUES (N'1b320ee6-b91f-4d98-b01e-8c93645c4d9c', N'ab2b9e1f-ac5b-404b-b69a-cfd1aef52fcb', N'Spicy Salmon Roll', N'Sushi roll with spicy salmon and cucumber', CAST(7.99 AS Decimal(18, 2)), NULL, 1)
INSERT [dbo].[Items] ([Id], [CategoryId], [Name], [Description], [Price], [ImageUrl], [Available]) VALUES (N'cb1bca78-5bd5-4f26-8671-94573412d05d', N'ab2b9e1f-ac5b-404b-b69a-cfd1aef52fcb', N'California Roll', N'Sushi roll with crab, avocado, and cucumber', CAST(6.99 AS Decimal(18, 2)), NULL, 1)
INSERT [dbo].[Items] ([Id], [CategoryId], [Name], [Description], [Price], [ImageUrl], [Available]) VALUES (N'671906a1-8bbf-4843-b48a-98c419357e02', N'80df3e11-1774-4297-9489-db1f21375371', N'Mixed Tempura', N'Deep-fried battered mixed seafood and vegetables', CAST(6.99 AS Decimal(18, 2)), NULL, 1)
INSERT [dbo].[Items] ([Id], [CategoryId], [Name], [Description], [Price], [ImageUrl], [Available]) VALUES (N'99f2995e-9cc4-4c66-9a1c-d47e9fe1136e', N'53a623ac-0c22-4102-abd0-45709ea55cf9', N'Beef Udon', N'Thick wheat noodles served in a savory broth with beef', CAST(9.99 AS Decimal(18, 2)), NULL, 1)
INSERT [dbo].[Items] ([Id], [CategoryId], [Name], [Description], [Price], [ImageUrl], [Available]) VALUES (N'8c0c634b-26ba-42a7-aa57-d550ce587ddc', N'4264c574-c75c-4703-be5b-7419ee6362de', N'Salmon Sashimi', N'Fresh slices of raw salmon', CAST(8.99 AS Decimal(18, 2)), NULL, 1)
INSERT [dbo].[Items] ([Id], [CategoryId], [Name], [Description], [Price], [ImageUrl], [Available]) VALUES (N'9dc482db-8498-497b-8e71-d74abfd4f144', N'ab2b9e1f-ac5b-404b-b69a-cfd1aef52fcb', N'Spicy Tuna Roll', N'Sushi roll with spicy tuna and cucumber', CAST(7.99 AS Decimal(18, 2)), NULL, 1)
INSERT [dbo].[Items] ([Id], [CategoryId], [Name], [Description], [Price], [ImageUrl], [Available]) VALUES (N'7f668248-64ee-479a-aec9-ed6295458098', N'80df3e11-1774-4297-9489-db1f21375371', N'Shrimp Tempura', N'Deep-fried battered shrimp', CAST(4.99 AS Decimal(18, 2)), NULL, 1)
INSERT [dbo].[Items] ([Id], [CategoryId], [Name], [Description], [Price], [ImageUrl], [Available]) VALUES (N'501b86ca-d141-4877-a31d-f4734985a3e1', N'80df3e11-1774-4297-9489-db1f21375371', N'Vegetable Tempura', N'Deep-fried battered mixed vegetables', CAST(3.99 AS Decimal(18, 2)), NULL, 1)
GO
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'a4ea4fb2-d3f1-4d7f-83ad-2474b823fd7f', N'Table 2', 4)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'31e0e03e-573f-4cc3-afea-3972834f1cce', N'Table 6', 4)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'274ba59f-17b6-418c-b488-431b6b1ca128', N'Table 10', 4)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'febe6aaa-b21c-493b-9e78-4f852a5f1412', N'Table 4', 4)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'c890a523-8dbd-4325-ba59-5b468cea67e1', N'Table 12', 2)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'0ca5abc7-ac2a-4140-b5b3-67a4d5f36cc9', N'Table 17', 8)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'84e4708e-9fc7-4068-8a5c-699f0d4310df', N'Table 13', 2)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'ea86f02d-a500-4e3e-abcf-6b309f406330', N'Table 8', 4)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'a0cd92f4-0100-447c-9425-8ac9ba7284af', N'Table 18', 8)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'6aa64c81-5be3-405e-874d-963996f2b05a', N'Table 9', 4)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'12536030-e103-43f2-87a5-9a952259fca7', N'Table 3', 4)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'aaa1c738-8efa-4ab4-9134-af8d994c2183', N'Table 16', 2)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'1f0cfab5-f2d3-4773-b945-c5b55594c02e', N'Table 15', 2)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'83ef61a0-aea3-459d-aef8-cf119798ca05', N'Table 11', 2)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'bd7806cc-16a7-4943-a3e6-d7ff2a41b61b', N'Table 7', 4)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'4885ae1b-940b-448f-9596-e2ac5bfed627', N'Table 1', 4)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'b8e8051f-2985-455f-9947-f6a0cfacf508', N'Table 14', 2)
INSERT [dbo].[Tables] ([Id], [TableNumber], [Capacity]) VALUES (N'22dd4bd8-829e-433c-9e97-fe55451bd4ec', N'Table 5', 4)
GO
INSERT [dbo].[Transactions] ([Id], [TableId], [CashierId], [UniqueCode], [OpenedAt], [ClosedAt], [TotalAmount]) VALUES (N'd5c490a7-45b6-4d62-9efb-006577e38fd0', N'a4ea4fb2-d3f1-4d7f-83ad-2474b823fd7f', NULL, N'ASDF', CAST(N'2024-08-21T22:06:28.0334339+07:00' AS DateTimeOffset), NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Transactions] ([Id], [TableId], [CashierId], [UniqueCode], [OpenedAt], [ClosedAt], [TotalAmount]) VALUES (N'ab1b82b9-4edd-4c0e-b264-d14f29ffd6a4', N'4885ae1b-940b-448f-9596-e2ac5bfed627', NULL, N'ABCD', CAST(N'2024-08-21T21:51:28.0333124+07:00' AS DateTimeOffset), NULL, CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Users] ([Id], [Username], [PasswordHash], [FullName], [Email], [PhoneNumber], [Role]) VALUES (N'49c5894b-951f-4d6d-9ae0-2ffdbf1d19b9', N'darmell2', N'da6f2bdaa8186f8e5c464678e37fa4225cd3bcba48e81562f1b518323bcc63be', N'Donielle Armell', N'darmell2@gmail.com', N'383-749-5047', N'Chef')
INSERT [dbo].[Users] ([Id], [Username], [PasswordHash], [FullName], [Email], [PhoneNumber], [Role]) VALUES (N'6107b787-9ebc-4464-8fe8-68557a40ad13', N'odearing1', N'ff5e5db1bb52183fac9db72f4c96bb7edff976bc415b526a0702604592eba3d6', N'Odey Dearing', N'odearing1@gmail.com', N'252-886-1273', N'Waiter')
INSERT [dbo].[Users] ([Id], [Username], [PasswordHash], [FullName], [Email], [PhoneNumber], [Role]) VALUES (N'e291d947-0898-424a-8762-df96c2e5a5d3', N'fcerith0', N'a1680e1dc3d5a55b6fe4d92bd38cbff27e5fcd31d9931d512d936f8cf60ee299', N'Felisha Cerith', N'fcerith0@live.com', N'142-618-1999', N'Cashier')
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CartItems_Items_ItemId]') AND parent_object_id = OBJECT_ID(N'[dbo].[CartItems]'))
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_Items_ItemId] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Items] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CartItems_Items_ItemId]') AND parent_object_id = OBJECT_ID(N'[dbo].[CartItems]'))
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_CartItems_Items_ItemId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CartItems_Transactions_TransactionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[CartItems]'))
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_Transactions_TransactionId] FOREIGN KEY([TransactionId])
REFERENCES [dbo].[Transactions] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CartItems_Transactions_TransactionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[CartItems]'))
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_CartItems_Transactions_TransactionId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Items_Categories_CategoryId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Items]'))
ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_Categories_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Items_Categories_CategoryId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Items]'))
ALTER TABLE [dbo].[Items] CHECK CONSTRAINT [FK_Items_Categories_CategoryId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderItems_Items_ItemId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderItems]'))
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Items_ItemId] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Items] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderItems_Items_ItemId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderItems]'))
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Items_ItemId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderItems_Orders_OrderId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderItems]'))
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Orders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderItems_Orders_OrderId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderItems]'))
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Orders_OrderId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Orders_Transactions_TransactionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Orders]'))
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Transactions_TransactionId] FOREIGN KEY([TransactionId])
REFERENCES [dbo].[Transactions] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Orders_Transactions_TransactionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Orders]'))
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Transactions_TransactionId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Transactions_Tables_TableId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Transactions]'))
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_Tables_TableId] FOREIGN KEY([TableId])
REFERENCES [dbo].[Tables] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Transactions_Tables_TableId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Transactions]'))
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_Tables_TableId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Transactions_Users_CashierId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Transactions]'))
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_Users_CashierId] FOREIGN KEY([CashierId])
REFERENCES [dbo].[Users] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Transactions_Users_CashierId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Transactions]'))
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_Users_CashierId]
GO
