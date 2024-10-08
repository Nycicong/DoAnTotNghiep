USE [Fashion_DoAn]
GO
/****** Object:  Table [dbo].[Brands]    Script Date: 9/15/2024 10:48:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brands](
	[BrandID] [int] IDENTITY(1,1) NOT NULL,
	[BrandName] [nvarchar](250) NULL,
 CONSTRAINT [PK_Brands] PRIMARY KEY CLUSTERED 
(
	[BrandID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartItems]    Script Date: 9/15/2024 10:48:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItems](
	[CartItemID] [int] NOT NULL,
	[QuantityProductSale] [int] NULL,
	[Product_SizeID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CartItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 9/15/2024 10:48:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](255) NULL,
	[Images] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 9/15/2024 10:48:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderQuantity] [int] NULL,
	[TotalPrice] [float] NULL,
	[OrderID] [int] NULL,
	[Product_SizeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 9/15/2024 10:48:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [datetime] NULL,
	[OrderStatus] [nvarchar](255) NULL,
	[OrderTotalPrice] [float] NULL,
	[Address_Delivery] [nvarchar](255) NULL,
	[TypePayment] [int] NULL,
	[CustomerName] [varchar](255) NULL,
	[PhoneCustomer] [varchar](255) NULL,
	[OrderCode] [varchar](255) NULL,
	[UserID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_Size]    Script Date: 9/15/2024 10:48:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Size](
	[Product_SizeID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[SizeID] [int] NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Product_SizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 9/15/2024 10:48:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductName] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[BrandID] [int] NULL,
	[Images] [varchar](255) NULL,
	[SaleOff] [float] NULL,
	[Price] [float] NULL,
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rates]    Script Date: 9/15/2024 10:48:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rates](
	[RateID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[RateValue] [int] NULL,
	[Comment] [nvarchar](max) NULL,
	[DateRate] [datetime] NULL,
	[ProductID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 9/15/2024 10:48:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] NOT NULL,
	[RoleName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sizes]    Script Date: 9/15/2024 10:48:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sizes](
	[SizeID] [int] NOT NULL,
	[NameSize] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[SizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Slide]    Script Date: 9/15/2024 10:48:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slide](
	[SlideID] [int] IDENTITY(1,1) NOT NULL,
	[Images] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[SlideID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 9/15/2024 10:48:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Username] [nvarchar](255) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[Gender] [nvarchar](10) NULL,
	[RoleID] [int] NOT NULL,
	[UserID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Brands] ON 

INSERT [dbo].[Brands] ([BrandID], [BrandName]) VALUES (1, N'Apple')
INSERT [dbo].[Brands] ([BrandID], [BrandName]) VALUES (2, N'SamSung')
SET IDENTITY_INSERT [dbo].[Brands] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Images]) VALUES (2, N'Iphone', N'iphone.jpeg')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Images]) VALUES (3, N'SamSung', N'samsung.jpeg')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Images]) VALUES (4, N'VSmart', N'vsmart.jpeg')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([OrderDetailId], [OrderQuantity], [TotalPrice], [OrderID], [Product_SizeID]) VALUES (1, 1, 2000000000, 1, 1)
INSERT [dbo].[OrderDetails] ([OrderDetailId], [OrderQuantity], [TotalPrice], [OrderID], [Product_SizeID]) VALUES (2, 3, 6000000000, 2, 1)
INSERT [dbo].[OrderDetails] ([OrderDetailId], [OrderQuantity], [TotalPrice], [OrderID], [Product_SizeID]) VALUES (3, 3, 6000000000, 3, 1)
INSERT [dbo].[OrderDetails] ([OrderDetailId], [OrderQuantity], [TotalPrice], [OrderID], [Product_SizeID]) VALUES (4, 3, 810000000, 4, 3)
INSERT [dbo].[OrderDetails] ([OrderDetailId], [OrderQuantity], [TotalPrice], [OrderID], [Product_SizeID]) VALUES (5, 3, 540000, 5, 4)
INSERT [dbo].[OrderDetails] ([OrderDetailId], [OrderQuantity], [TotalPrice], [OrderID], [Product_SizeID]) VALUES (6, 2, 360000, 6, 4)
INSERT [dbo].[OrderDetails] ([OrderDetailId], [OrderQuantity], [TotalPrice], [OrderID], [Product_SizeID]) VALUES (7, 1, 270000000, 7, 3)
INSERT [dbo].[OrderDetails] ([OrderDetailId], [OrderQuantity], [TotalPrice], [OrderID], [Product_SizeID]) VALUES (8, 1, 270000000, 8, 3)
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [OrderDate], [OrderStatus], [OrderTotalPrice], [Address_Delivery], [TypePayment], [CustomerName], [PhoneCustomer], [OrderCode], [UserID]) VALUES (1, CAST(N'2024-09-15T01:13:47.733' AS DateTime), N'3', 2000000000, N'Ha Noi', 0, N'Tien Viet Nguyen', N'0815767495', N'DH2160', 3)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [OrderStatus], [OrderTotalPrice], [Address_Delivery], [TypePayment], [CustomerName], [PhoneCustomer], [OrderCode], [UserID]) VALUES (2, CAST(N'2024-09-15T01:30:56.357' AS DateTime), N'0', 6000000000, N'Ha Noi', 1, N'Tien Viet Nguyen', N'0815767495', N'DH0827', 3)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [OrderStatus], [OrderTotalPrice], [Address_Delivery], [TypePayment], [CustomerName], [PhoneCustomer], [OrderCode], [UserID]) VALUES (3, CAST(N'2024-09-15T01:31:31.433' AS DateTime), N'2', 6000000000, N'Ha Noi', 0, N'Tien Viet Nguyen', N'0815767495', N'DH6438', 3)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [OrderStatus], [OrderTotalPrice], [Address_Delivery], [TypePayment], [CustomerName], [PhoneCustomer], [OrderCode], [UserID]) VALUES (4, CAST(N'2024-09-15T01:32:32.917' AS DateTime), N'0', 810000000, N'Ha Noi', 1, N'sadDSADD', N'0815767495', N'DH4082', 3)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [OrderStatus], [OrderTotalPrice], [Address_Delivery], [TypePayment], [CustomerName], [PhoneCustomer], [OrderCode], [UserID]) VALUES (5, CAST(N'2024-09-15T01:42:54.457' AS DateTime), N'2', 540000, N'Ha Noi', 0, N'test2', N'0815767495', N'DH3470', 2)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [OrderStatus], [OrderTotalPrice], [Address_Delivery], [TypePayment], [CustomerName], [PhoneCustomer], [OrderCode], [UserID]) VALUES (6, CAST(N'2024-09-15T01:49:06.677' AS DateTime), N'0', 360000, N'Haà Nam', 0, N'Chi Cong', N'0815767495', N'DH8445', 2)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [OrderStatus], [OrderTotalPrice], [Address_Delivery], [TypePayment], [CustomerName], [PhoneCustomer], [OrderCode], [UserID]) VALUES (7, CAST(N'2024-09-15T09:10:41.437' AS DateTime), N'0', 270000000, N'Haà Nam', 0, N'Chi Cong2', N'0815767495', N'DH0346', 2)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [OrderStatus], [OrderTotalPrice], [Address_Delivery], [TypePayment], [CustomerName], [PhoneCustomer], [OrderCode], [UserID]) VALUES (8, CAST(N'2024-09-15T09:21:22.913' AS DateTime), N'0', 270000000, N'Haà Nam', 0, N'Chi Cong3', N'0815767495', N'DH5618', 2)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Product_Size] ON 

INSERT [dbo].[Product_Size] ([Product_SizeID], [ProductID], [SizeID], [Quantity]) VALUES (1, 1, NULL, 103)
INSERT [dbo].[Product_Size] ([Product_SizeID], [ProductID], [SizeID], [Quantity]) VALUES (2, 2, NULL, 2)
INSERT [dbo].[Product_Size] ([Product_SizeID], [ProductID], [SizeID], [Quantity]) VALUES (3, 3, NULL, 150)
INSERT [dbo].[Product_Size] ([Product_SizeID], [ProductID], [SizeID], [Quantity]) VALUES (4, 4, NULL, 230)
SET IDENTITY_INSERT [dbo].[Product_Size] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductName], [Description], [BrandID], [Images], [SaleOff], [Price], [ProductID], [CategoryID]) VALUES (N'Iphone16 ProMax', N'ggffghfghfdh', 1, N'iphone16.jpeg', 0, 2000000000, 1, 2)
INSERT [dbo].[Products] ([ProductName], [Description], [BrandID], [Images], [SaleOff], [Price], [ProductID], [CategoryID]) VALUES (N'Iphone15 ProMax', N'hgdhfdhfghfhfh', 1, NULL, 1200007, 2000000000, 2, 2)
INSERT [dbo].[Products] ([ProductName], [Description], [BrandID], [Images], [SaleOff], [Price], [ProductID], [CategoryID]) VALUES (N'Ultra', N'dgsdfgsdfgdsfg', 2, N'iphone.jpeg', 10, 300000000, 3, 2)
INSERT [dbo].[Products] ([ProductName], [Description], [BrandID], [Images], [SaleOff], [Price], [ProductID], [CategoryID]) VALUES (N'test', N'test', 2, N'samsung.jpeg', 10, 200000, 4, 3)
INSERT [dbo].[Products] ([ProductName], [Description], [BrandID], [Images], [SaleOff], [Price], [ProductID], [CategoryID]) VALUES (N'Vsmart', N'adfgdfgsdf', 2, N'vsmartphone.jpeg', 20, 200000, 5, 4)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (2, N'Khách hàng')
GO
INSERT [dbo].[Sizes] ([SizeID], [NameSize]) VALUES (1, N'S')
INSERT [dbo].[Sizes] ([SizeID], [NameSize]) VALUES (2, N'M')
INSERT [dbo].[Sizes] ([SizeID], [NameSize]) VALUES (3, N'L')
GO
SET IDENTITY_INSERT [dbo].[Slide] ON 

INSERT [dbo].[Slide] ([SlideID], [Images]) VALUES (1, N'vsmart.jpeg')
INSERT [dbo].[Slide] ([SlideID], [Images]) VALUES (2, NULL)
INSERT [dbo].[Slide] ([SlideID], [Images]) VALUES (3, N'iphone.jpeg')
SET IDENTITY_INSERT [dbo].[Slide] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Username], [Email], [Password], [Gender], [RoleID], [UserID]) VALUES (N'admin', N'admin123@gmail.com', N'admin123', N'nam', 1, 2)
INSERT [dbo].[Users] ([Username], [Email], [Password], [Gender], [RoleID], [UserID]) VALUES (N'khach1', N'khach1@gmail.com', N'khach1', N'nữ', 2, 3)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E4D24EB239]    Script Date: 9/15/2024 10:48:30 AM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D10534F87E1632]    Script Date: 9/15/2024 10:48:30 AM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD FOREIGN KEY([Product_SizeID])
REFERENCES [dbo].[Product_Size] ([Product_SizeID])
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD FOREIGN KEY([Product_SizeID])
REFERENCES [dbo].[Product_Size] ([Product_SizeID])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([Product_SizeID])
REFERENCES [dbo].[Product_Size] ([Product_SizeID])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([Product_SizeID])
REFERENCES [dbo].[Product_Size] ([Product_SizeID])
GO
ALTER TABLE [dbo].[Product_Size]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Product_Size]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Product_Size]  WITH CHECK ADD FOREIGN KEY([SizeID])
REFERENCES [dbo].[Sizes] ([SizeID])
GO
ALTER TABLE [dbo].[Product_Size]  WITH CHECK ADD FOREIGN KEY([SizeID])
REFERENCES [dbo].[Sizes] ([SizeID])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Rates]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Rates]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Rates]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Rates]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
