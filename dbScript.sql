USE [master]
GO
/****** Object:  Database [capstone]    Script Date: 12/12/2014 8:12:26 PM ******/
CREATE DATABASE [capstone]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'capstone', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\capstone.mdf' , SIZE = 6144KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'capstone_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\capstone_log.ldf' , SIZE = 32448KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [capstone] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [capstone].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [capstone] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [capstone] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [capstone] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [capstone] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [capstone] SET ARITHABORT OFF 
GO
ALTER DATABASE [capstone] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [capstone] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [capstone] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [capstone] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [capstone] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [capstone] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [capstone] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [capstone] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [capstone] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [capstone] SET  DISABLE_BROKER 
GO
ALTER DATABASE [capstone] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [capstone] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [capstone] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [capstone] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [capstone] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [capstone] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [capstone] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [capstone] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [capstone] SET  MULTI_USER 
GO
ALTER DATABASE [capstone] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [capstone] SET DB_CHAINING OFF 
GO
ALTER DATABASE [capstone] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [capstone] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [capstone] SET DELAYED_DURABILITY = DISABLED 
GO
USE [capstone]
GO
/****** Object:  Table [dbo].[appointments_table]    Script Date: 12/12/2014 8:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[appointments_table](
	[appointment_num] [int] IDENTITY(1,1) NOT NULL,
	[appointment_date] [date] NULL,
	[appointment_time] [time](7) NULL,
	[user_num_request] [int] NULL,
	[service_reason] [nvarchar](250) NULL,
	[approved] [nchar](10) NULL,
 CONSTRAINT [PK_appointments_table] PRIMARY KEY CLUSTERED 
(
	[appointment_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_table]    Script Date: 12/12/2014 8:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[car_table](
	[car_id] [int] IDENTITY(1,1) NOT NULL,
	[car_year] [int] NULL,
	[car_make] [varchar](50) NULL,
	[car_model] [varchar](50) NULL,
 CONSTRAINT [PK_car_table_1] PRIMARY KEY CLUSTERED 
(
	[car_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cart_table]    Script Date: 12/12/2014 8:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cart_table](
	[cart_name] [varchar](max) NULL,
	[cart_tied_to_user] [int] NULL,
	[part_number] [int] NULL,
	[part_quantity] [int] NULL,
	[DateCreated] [datetime] NULL,
	[cart_instance_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_cart_table_1] PRIMARY KEY CLUSTERED 
(
	[cart_instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[invoice_table]    Script Date: 12/12/2014 8:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[invoice_table](
	[invoice_num] [int] IDENTITY(1,1) NOT NULL,
	[invoice_total] [decimal](18, 0) NULL,
	[user_num] [int] NULL,
	[invoice_filled] [nchar](10) NULL,
	[invoice_date] [datetime] NULL,
 CONSTRAINT [PK_invoice_table] PRIMARY KEY CLUSTERED 
(
	[invoice_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[message_table]    Script Date: 12/12/2014 8:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[message_table](
	[message_id] [int] IDENTITY(1,1) NOT NULL,
	[created_by_user_num] [int] NULL,
	[user_message] [nvarchar](max) NULL,
	[message_time] [datetime] NULL,
	[message_status] [nvarchar](50) NULL,
 CONSTRAINT [PK_message_table] PRIMARY KEY CLUSTERED 
(
	[message_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[orders_table]    Script Date: 12/12/2014 8:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_table](
	[order_num] [int] IDENTITY(1,1) NOT NULL,
	[invoice_num] [int] NULL,
	[part_num] [int] NOT NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [PK_orders_table] PRIMARY KEY CLUSTERED 
(
	[order_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[parts_table]    Script Date: 12/12/2014 8:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[parts_table](
	[part_number] [int] NOT NULL,
	[part_description] [nvarchar](max) NULL,
	[car_id] [int] NULL,
	[part_category] [int] NULL,
	[part_stock] [int] NULL,
	[part_price] [float] NULL,
 CONSTRAINT [PK_parts_table] PRIMARY KEY CLUSTERED 
(
	[part_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users_table]    Script Date: 12/12/2014 8:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users_table](
	[user_num] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](max) NOT NULL,
	[user_email] [nvarchar](max) NOT NULL,
	[first_name] [nvarchar](max) NULL,
	[last_name] [nvarchar](max) NULL,
	[address] [nvarchar](max) NULL,
	[password] [nvarchar](max) NOT NULL,
	[car_year] [int] NULL,
	[car_brand] [nvarchar](max) NULL,
	[car_model] [nvarchar](max) NULL,
 CONSTRAINT [PK_users_table] PRIMARY KEY CLUSTERED 
(
	[user_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[appointments_table] ON 

INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92337, CAST(N'2014-12-11' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92338, CAST(N'2014-12-11' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92339, CAST(N'2014-12-11' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92340, CAST(N'2014-12-11' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92341, CAST(N'2014-12-11' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92342, CAST(N'2014-12-11' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92343, CAST(N'2014-12-11' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92344, CAST(N'2014-12-12' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92345, CAST(N'2014-12-12' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92346, CAST(N'2014-12-12' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92347, CAST(N'2014-12-12' AS Date), CAST(N'12:00:00' AS Time), 10, N'I want a faster car', N'Pending   ')
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92348, CAST(N'2014-12-12' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92349, CAST(N'2014-12-12' AS Date), CAST(N'14:00:00' AS Time), 10, N'Car exploded', N'Approved  ')
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92350, CAST(N'2014-12-12' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92351, CAST(N'2014-12-15' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92352, CAST(N'2014-12-15' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92353, CAST(N'2014-12-15' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92354, CAST(N'2014-12-15' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92355, CAST(N'2014-12-15' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92356, CAST(N'2014-12-15' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92357, CAST(N'2014-12-15' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92358, CAST(N'2014-12-16' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92359, CAST(N'2014-12-16' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92360, CAST(N'2014-12-16' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92361, CAST(N'2014-12-16' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92362, CAST(N'2014-12-16' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92363, CAST(N'2014-12-16' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92364, CAST(N'2014-12-16' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92365, CAST(N'2014-12-17' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92366, CAST(N'2014-12-17' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92367, CAST(N'2014-12-17' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92368, CAST(N'2014-12-17' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92369, CAST(N'2014-12-17' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92370, CAST(N'2014-12-17' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92371, CAST(N'2014-12-17' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92372, CAST(N'2014-12-18' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92373, CAST(N'2014-12-18' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92374, CAST(N'2014-12-18' AS Date), CAST(N'11:00:00' AS Time), 13, N'Hello', N'Approved  ')
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92375, CAST(N'2014-12-18' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92376, CAST(N'2014-12-18' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92377, CAST(N'2014-12-18' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92378, CAST(N'2014-12-18' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92379, CAST(N'2014-12-19' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92380, CAST(N'2014-12-19' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92381, CAST(N'2014-12-19' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92382, CAST(N'2014-12-19' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92383, CAST(N'2014-12-19' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92384, CAST(N'2014-12-19' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92385, CAST(N'2014-12-19' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92386, CAST(N'2014-12-22' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92387, CAST(N'2014-12-22' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92388, CAST(N'2014-12-22' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92389, CAST(N'2014-12-22' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92390, CAST(N'2014-12-22' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92391, CAST(N'2014-12-22' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92392, CAST(N'2014-12-22' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92393, CAST(N'2014-12-23' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92394, CAST(N'2014-12-23' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92395, CAST(N'2014-12-23' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92396, CAST(N'2014-12-23' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92397, CAST(N'2014-12-23' AS Date), CAST(N'13:00:00' AS Time), 11, N'my car''s engine fell out and i can''t put it back in by myself, plus i need to have winter tires put on, and the music on my radio is only coming in on the am dial', N'Pending   ')
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92398, CAST(N'2014-12-23' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92399, CAST(N'2014-12-23' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92400, CAST(N'2014-12-24' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92401, CAST(N'2014-12-24' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92402, CAST(N'2014-12-24' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92403, CAST(N'2014-12-24' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92404, CAST(N'2014-12-24' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92405, CAST(N'2014-12-24' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92406, CAST(N'2014-12-24' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92407, CAST(N'2014-12-25' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92408, CAST(N'2014-12-25' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92409, CAST(N'2014-12-25' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92410, CAST(N'2014-12-25' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92411, CAST(N'2014-12-25' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92412, CAST(N'2014-12-25' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92413, CAST(N'2014-12-25' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92414, CAST(N'2014-12-26' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92415, CAST(N'2014-12-26' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92416, CAST(N'2014-12-26' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92417, CAST(N'2014-12-26' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92418, CAST(N'2014-12-26' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92419, CAST(N'2014-12-26' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92420, CAST(N'2014-12-26' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92421, CAST(N'2014-12-29' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92422, CAST(N'2014-12-29' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92423, CAST(N'2014-12-29' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92424, CAST(N'2014-12-29' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92425, CAST(N'2014-12-29' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92426, CAST(N'2014-12-29' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92427, CAST(N'2014-12-29' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92428, CAST(N'2014-12-30' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92429, CAST(N'2014-12-30' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92430, CAST(N'2014-12-30' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92431, CAST(N'2014-12-30' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92432, CAST(N'2014-12-30' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92433, CAST(N'2014-12-30' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92434, CAST(N'2014-12-30' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92435, CAST(N'2014-12-31' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
GO
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92436, CAST(N'2014-12-31' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92437, CAST(N'2014-12-31' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92438, CAST(N'2014-12-31' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92439, CAST(N'2014-12-31' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92440, CAST(N'2014-12-31' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92441, CAST(N'2014-12-31' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92442, CAST(N'2015-01-01' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92443, CAST(N'2015-01-01' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92444, CAST(N'2015-01-01' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92445, CAST(N'2015-01-01' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92446, CAST(N'2015-01-01' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92447, CAST(N'2015-01-01' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92448, CAST(N'2015-01-01' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92449, CAST(N'2015-01-02' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92450, CAST(N'2015-01-02' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92451, CAST(N'2015-01-02' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92452, CAST(N'2015-01-02' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92453, CAST(N'2015-01-02' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92454, CAST(N'2015-01-02' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92455, CAST(N'2015-01-02' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92456, CAST(N'2015-01-05' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92457, CAST(N'2015-01-05' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92458, CAST(N'2015-01-05' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92459, CAST(N'2015-01-05' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92460, CAST(N'2015-01-05' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92461, CAST(N'2015-01-05' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92462, CAST(N'2015-01-05' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92463, CAST(N'2015-01-06' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92464, CAST(N'2015-01-06' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92465, CAST(N'2015-01-06' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92466, CAST(N'2015-01-06' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92467, CAST(N'2015-01-06' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92468, CAST(N'2015-01-06' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92469, CAST(N'2015-01-06' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92470, CAST(N'2015-01-07' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92471, CAST(N'2015-01-07' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92472, CAST(N'2015-01-07' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92473, CAST(N'2015-01-07' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92474, CAST(N'2015-01-07' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92475, CAST(N'2015-01-07' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92476, CAST(N'2015-01-07' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92477, CAST(N'2015-01-08' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92478, CAST(N'2015-01-08' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92479, CAST(N'2015-01-08' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92480, CAST(N'2015-01-08' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92481, CAST(N'2015-01-08' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92482, CAST(N'2015-01-08' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92483, CAST(N'2015-01-08' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92484, CAST(N'2015-01-09' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92485, CAST(N'2015-01-09' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92486, CAST(N'2015-01-09' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92487, CAST(N'2015-01-09' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92488, CAST(N'2015-01-09' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92489, CAST(N'2015-01-09' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92490, CAST(N'2015-01-09' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92491, CAST(N'2015-01-12' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92492, CAST(N'2015-01-12' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92493, CAST(N'2015-01-12' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92494, CAST(N'2015-01-12' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92495, CAST(N'2015-01-12' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92496, CAST(N'2015-01-12' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92497, CAST(N'2015-01-12' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92498, CAST(N'2015-01-13' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92499, CAST(N'2015-01-13' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92500, CAST(N'2015-01-13' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92501, CAST(N'2015-01-13' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92502, CAST(N'2015-01-13' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92503, CAST(N'2015-01-13' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92504, CAST(N'2015-01-13' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92505, CAST(N'2015-01-14' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92506, CAST(N'2015-01-14' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92507, CAST(N'2015-01-14' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92508, CAST(N'2015-01-14' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92509, CAST(N'2015-01-14' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92510, CAST(N'2015-01-14' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92511, CAST(N'2015-01-14' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92512, CAST(N'2015-01-15' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92513, CAST(N'2015-01-15' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92514, CAST(N'2015-01-15' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92515, CAST(N'2015-01-15' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92516, CAST(N'2015-01-15' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92517, CAST(N'2015-01-15' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92518, CAST(N'2015-01-15' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92519, CAST(N'2015-01-16' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92520, CAST(N'2015-01-16' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92521, CAST(N'2015-01-16' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92522, CAST(N'2015-01-16' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92523, CAST(N'2015-01-16' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92524, CAST(N'2015-01-16' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92525, CAST(N'2015-01-16' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92526, CAST(N'2015-01-19' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92527, CAST(N'2015-01-19' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92528, CAST(N'2015-01-19' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92529, CAST(N'2015-01-19' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92530, CAST(N'2015-01-19' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92531, CAST(N'2015-01-19' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92532, CAST(N'2015-01-19' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92533, CAST(N'2015-01-20' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92534, CAST(N'2015-01-20' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92535, CAST(N'2015-01-20' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
GO
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92536, CAST(N'2015-01-20' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92537, CAST(N'2015-01-20' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92538, CAST(N'2015-01-20' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92539, CAST(N'2015-01-20' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92540, CAST(N'2015-01-21' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92541, CAST(N'2015-01-21' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92542, CAST(N'2015-01-21' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92543, CAST(N'2015-01-21' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92544, CAST(N'2015-01-21' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92545, CAST(N'2015-01-21' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92546, CAST(N'2015-01-21' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92547, CAST(N'2015-01-22' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92548, CAST(N'2015-01-22' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92549, CAST(N'2015-01-22' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92550, CAST(N'2015-01-22' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92551, CAST(N'2015-01-22' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92552, CAST(N'2015-01-22' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92553, CAST(N'2015-01-22' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92554, CAST(N'2015-01-23' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92555, CAST(N'2015-01-23' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92556, CAST(N'2015-01-23' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92557, CAST(N'2015-01-23' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92558, CAST(N'2015-01-23' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92559, CAST(N'2015-01-23' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92560, CAST(N'2015-01-23' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92561, CAST(N'2015-01-26' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92562, CAST(N'2015-01-26' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92563, CAST(N'2015-01-26' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92564, CAST(N'2015-01-26' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92565, CAST(N'2015-01-26' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92566, CAST(N'2015-01-26' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92567, CAST(N'2015-01-26' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92568, CAST(N'2015-01-27' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92569, CAST(N'2015-01-27' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92570, CAST(N'2015-01-27' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92571, CAST(N'2015-01-27' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92572, CAST(N'2015-01-27' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92573, CAST(N'2015-01-27' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92574, CAST(N'2015-01-27' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92575, CAST(N'2015-01-28' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92576, CAST(N'2015-01-28' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92577, CAST(N'2015-01-28' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92578, CAST(N'2015-01-28' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92579, CAST(N'2015-01-28' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92580, CAST(N'2015-01-28' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92581, CAST(N'2015-01-28' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92582, CAST(N'2015-01-29' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92583, CAST(N'2015-01-29' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92584, CAST(N'2015-01-29' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92585, CAST(N'2015-01-29' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92586, CAST(N'2015-01-29' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92587, CAST(N'2015-01-29' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92588, CAST(N'2015-01-29' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92589, CAST(N'2015-01-30' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92590, CAST(N'2015-01-30' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92591, CAST(N'2015-01-30' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92592, CAST(N'2015-01-30' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92593, CAST(N'2015-01-30' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92594, CAST(N'2015-01-30' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92595, CAST(N'2015-01-30' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92596, CAST(N'2015-02-02' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92597, CAST(N'2015-02-02' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92598, CAST(N'2015-02-02' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92599, CAST(N'2015-02-02' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92600, CAST(N'2015-02-02' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92601, CAST(N'2015-02-02' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92602, CAST(N'2015-02-02' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92603, CAST(N'2015-02-03' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92604, CAST(N'2015-02-03' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92605, CAST(N'2015-02-03' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92606, CAST(N'2015-02-03' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92607, CAST(N'2015-02-03' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92608, CAST(N'2015-02-03' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92609, CAST(N'2015-02-03' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92610, CAST(N'2015-02-04' AS Date), CAST(N'09:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92611, CAST(N'2015-02-04' AS Date), CAST(N'10:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92612, CAST(N'2015-02-04' AS Date), CAST(N'11:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92613, CAST(N'2015-02-04' AS Date), CAST(N'12:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92614, CAST(N'2015-02-04' AS Date), CAST(N'13:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92615, CAST(N'2015-02-04' AS Date), CAST(N'14:00:00' AS Time), NULL, NULL, NULL)
INSERT [dbo].[appointments_table] ([appointment_num], [appointment_date], [appointment_time], [user_num_request], [service_reason], [approved]) VALUES (92616, CAST(N'2015-02-04' AS Date), CAST(N'15:00:00' AS Time), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[appointments_table] OFF
SET IDENTITY_INSERT [dbo].[car_table] ON 

INSERT [dbo].[car_table] ([car_id], [car_year], [car_make], [car_model]) VALUES (1, 2009, N'Mitsubishi', N'Lancer')
INSERT [dbo].[car_table] ([car_id], [car_year], [car_make], [car_model]) VALUES (2, 2011, N'Ford', N'Mustang')
INSERT [dbo].[car_table] ([car_id], [car_year], [car_make], [car_model]) VALUES (3, 2013, N'Toyota', N'Corolla')
SET IDENTITY_INSERT [dbo].[car_table] OFF
SET IDENTITY_INSERT [dbo].[cart_table] ON 

INSERT [dbo].[cart_table] ([cart_name], [cart_tied_to_user], [part_number], [part_quantity], [DateCreated], [cart_instance_id]) VALUES (N'38ef1328-51d9-49f1-9ccd-7aa671ee06e0', 0, 10301, 1, CAST(N'2014-10-11 17:13:55.123' AS DateTime), 1)
INSERT [dbo].[cart_table] ([cart_name], [cart_tied_to_user], [part_number], [part_quantity], [DateCreated], [cart_instance_id]) VALUES (N'ea6997f0-7ee4-4175-a50d-ef10e1edac62', NULL, 10301, 1, CAST(N'2014-10-11 20:04:45.943' AS DateTime), 2)
INSERT [dbo].[cart_table] ([cart_name], [cart_tied_to_user], [part_number], [part_quantity], [DateCreated], [cart_instance_id]) VALUES (N'f094ca6a-6abb-4374-ab3b-593ce87a4439', NULL, 10301, 1, CAST(N'2014-10-11 20:09:22.187' AS DateTime), 3)
INSERT [dbo].[cart_table] ([cart_name], [cart_tied_to_user], [part_number], [part_quantity], [DateCreated], [cart_instance_id]) VALUES (N'12f74337-8aab-4eb4-8084-cec826fea7c6', NULL, 10301, 4, CAST(N'2014-10-11 20:10:11.937' AS DateTime), 4)
INSERT [dbo].[cart_table] ([cart_name], [cart_tied_to_user], [part_number], [part_quantity], [DateCreated], [cart_instance_id]) VALUES (N'f3d21652-b5e0-4431-a6d0-78986003478d', NULL, 10301, 1, CAST(N'2014-10-11 20:55:46.847' AS DateTime), 5)
INSERT [dbo].[cart_table] ([cart_name], [cart_tied_to_user], [part_number], [part_quantity], [DateCreated], [cart_instance_id]) VALUES (N'6f51d2dd-f513-48c5-b5f1-9c7248cb6fb8', NULL, 10301, 1, CAST(N'2014-10-11 21:01:58.477' AS DateTime), 6)
INSERT [dbo].[cart_table] ([cart_name], [cart_tied_to_user], [part_number], [part_quantity], [DateCreated], [cart_instance_id]) VALUES (N'e2b980e8-d5a0-4da1-ae20-6ad3fd99ee86', NULL, 10301, 1, CAST(N'2014-10-12 16:12:00.177' AS DateTime), 7)
INSERT [dbo].[cart_table] ([cart_name], [cart_tied_to_user], [part_number], [part_quantity], [DateCreated], [cart_instance_id]) VALUES (N'admin', NULL, 10301, 3, CAST(N'2014-10-20 19:18:07.083' AS DateTime), 8)
INSERT [dbo].[cart_table] ([cart_name], [cart_tied_to_user], [part_number], [part_quantity], [DateCreated], [cart_instance_id]) VALUES (N'58108856-625e-4414-9187-b0cdcbcd5f61', NULL, 20201, 1, CAST(N'2014-11-04 11:22:01.723' AS DateTime), 21)
INSERT [dbo].[cart_table] ([cart_name], [cart_tied_to_user], [part_number], [part_quantity], [DateCreated], [cart_instance_id]) VALUES (N'58108856-625e-4414-9187-b0cdcbcd5f61', NULL, 10301, 1, CAST(N'2014-11-04 11:39:09.190' AS DateTime), 22)
INSERT [dbo].[cart_table] ([cart_name], [cart_tied_to_user], [part_number], [part_quantity], [DateCreated], [cart_instance_id]) VALUES (N'2f67b249-ba03-4663-b6df-7d838c0759b0', NULL, 20101, 1, CAST(N'2014-11-07 22:36:45.917' AS DateTime), 23)
INSERT [dbo].[cart_table] ([cart_name], [cart_tied_to_user], [part_number], [part_quantity], [DateCreated], [cart_instance_id]) VALUES (N'e2c5aa59-c0cd-4f8c-a6dc-a8a57d59bb66', NULL, 20101, 1, CAST(N'2014-11-07 22:42:52.793' AS DateTime), 24)
INSERT [dbo].[cart_table] ([cart_name], [cart_tied_to_user], [part_number], [part_quantity], [DateCreated], [cart_instance_id]) VALUES (N'1262df79-11d0-4c73-a93b-c45de1ad462d', NULL, 20101, 1, CAST(N'2014-11-14 20:18:42.133' AS DateTime), 33)
SET IDENTITY_INSERT [dbo].[cart_table] OFF
SET IDENTITY_INSERT [dbo].[invoice_table] ON 

INSERT [dbo].[invoice_table] ([invoice_num], [invoice_total], [user_num], [invoice_filled], [invoice_date]) VALUES (2, CAST(29 AS Decimal(18, 0)), 9, N'Pending   ', CAST(N'2014-12-10 15:37:55.890' AS DateTime))
INSERT [dbo].[invoice_table] ([invoice_num], [invoice_total], [user_num], [invoice_filled], [invoice_date]) VALUES (3, CAST(27 AS Decimal(18, 0)), 10, N'Ready     ', CAST(N'2014-10-10 16:35:38.783' AS DateTime))
INSERT [dbo].[invoice_table] ([invoice_num], [invoice_total], [user_num], [invoice_filled], [invoice_date]) VALUES (4, CAST(15 AS Decimal(18, 0)), 10, N'Ready     ', CAST(N'2014-12-10 17:13:16.687' AS DateTime))
INSERT [dbo].[invoice_table] ([invoice_num], [invoice_total], [user_num], [invoice_filled], [invoice_date]) VALUES (5, CAST(60 AS Decimal(18, 0)), 11, N'Ready     ', CAST(N'2014-12-10 18:32:26.553' AS DateTime))
INSERT [dbo].[invoice_table] ([invoice_num], [invoice_total], [user_num], [invoice_filled], [invoice_date]) VALUES (7, CAST(62 AS Decimal(18, 0)), 10, N'Ready     ', CAST(N'2014-12-11 16:39:51.003' AS DateTime))
SET IDENTITY_INSERT [dbo].[invoice_table] OFF
SET IDENTITY_INSERT [dbo].[message_table] ON 

INSERT [dbo].[message_table] ([message_id], [created_by_user_num], [user_message], [message_time], [message_status]) VALUES (1, 10, N'Hi i have a question', CAST(N'2014-11-26 20:41:31.000' AS DateTime), N'Responded')
INSERT [dbo].[message_table] ([message_id], [created_by_user_num], [user_message], [message_time], [message_status]) VALUES (6, 10, N'test 1242', CAST(N'2014-11-28 00:42:27.000' AS DateTime), N'Responded')
INSERT [dbo].[message_table] ([message_id], [created_by_user_num], [user_message], [message_time], [message_status]) VALUES (7, 11, N'how much do you think this might cost?', CAST(N'2014-12-10 18:27:04.000' AS DateTime), N'Unreplied')
INSERT [dbo].[message_table] ([message_id], [created_by_user_num], [user_message], [message_time], [message_status]) VALUES (8, 11, N'how much do you think this might cost?', CAST(N'2014-12-10 18:27:04.000' AS DateTime), N'Responded')
INSERT [dbo].[message_table] ([message_id], [created_by_user_num], [user_message], [message_time], [message_status]) VALUES (9, 10, N'I have a question for you', CAST(N'2014-12-11 15:13:08.000' AS DateTime), N'Unreplied')
INSERT [dbo].[message_table] ([message_id], [created_by_user_num], [user_message], [message_time], [message_status]) VALUES (10, 10, N'Are you open on saturday?', CAST(N'2014-12-11 16:44:19.000' AS DateTime), N'Responded')
SET IDENTITY_INSERT [dbo].[message_table] OFF
SET IDENTITY_INSERT [dbo].[orders_table] ON 

INSERT [dbo].[orders_table] ([order_num], [invoice_num], [part_num], [quantity]) VALUES (2, 2, 20104, 1)
INSERT [dbo].[orders_table] ([order_num], [invoice_num], [part_num], [quantity]) VALUES (3, 3, 10105, 1)
INSERT [dbo].[orders_table] ([order_num], [invoice_num], [part_num], [quantity]) VALUES (4, 4, 20205, 1)
INSERT [dbo].[orders_table] ([order_num], [invoice_num], [part_num], [quantity]) VALUES (5, 5, 10110, 1)
INSERT [dbo].[orders_table] ([order_num], [invoice_num], [part_num], [quantity]) VALUES (6, 5, 20205, 1)
INSERT [dbo].[orders_table] ([order_num], [invoice_num], [part_num], [quantity]) VALUES (7, 5, 20203, 1)
INSERT [dbo].[orders_table] ([order_num], [invoice_num], [part_num], [quantity]) VALUES (8, 5, 20303, 1)
INSERT [dbo].[orders_table] ([order_num], [invoice_num], [part_num], [quantity]) VALUES (10, 7, 20302, 1)
INSERT [dbo].[orders_table] ([order_num], [invoice_num], [part_num], [quantity]) VALUES (11, 7, 10102, 1)
SET IDENTITY_INSERT [dbo].[orders_table] OFF
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10101, N'Basic Air Filter for 2009 Mitsubishi Lancer', 1, 101, 17, 25)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10102, N'Performance Air Filter for 2009 Mitsubishi Lancer', 1, 101, 19, 40)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10103, N'Basic Oil Filter for 2009 Mitsubishi Lancer', 1, 101, 15, 10)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10104, N'Performance Oil Filter for 2009 Mitsubishi Lancer', 1, 101, 13, 15)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10105, N'Basic Air Filter for 2011 Ford Mustang', 2, 101, 8, 27)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10106, N'Performance Air Filter for 2011 Ford Mustang', 2, 101, 14, 42)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10107, N'Basic Oil Filter for 2011 Ford Mustang', 2, 101, 18, 7)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10108, N'Performance Oil Filter for 2011 Ford Mustang', 2, 101, 9, 12)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10109, N'Basic Air Filter for 2013 Toyota Corolla', 3, 101, 12, 15)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10110, N'Performance Air Filter for 2013 Toyota Corolla', 3, 101, 4, 25)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10111, N'Basic Oil Filter for 2013 Toyota Corolla', 3, 101, 7, 5)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10112, N'Performance Oil Filter for 2013 Toyota Corolla', 3, 101, 15, 12)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10201, N'Performance Rotors for 2009 Mitsubishi Lancer', 1, 102, 4, 80)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10202, N'Basic Rotors for 2009 Mitsubishi Lancer', 1, 102, 3, 50)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10203, N'Performance Brake Pads for 2009 Mitsubishi Lancer', 1, 102, 7, 120)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10204, N'Basic Brake Pads for 2009 Mitsubishi Lancer', 1, 102, 9, 100)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10205, N'Brembo Rotors for 2011 Ford Mustang', 2, 102, 14, 1000)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10206, N'Performance Rotors for 2011 Ford Mustang', 2, 102, 11, 200)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10207, N'Basic Rotors for 2011 Ford Mustang', 2, 102, 2, 120)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10208, N'Brembo Brake Pads for 2011 Ford Mustang', 2, 102, 1, 1500)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10209, N'Performance Brake Pads for 2011 Ford Mustang', 2, 102, 5, 300)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10210, N'Performance Rotors for 2013 Toyota Corolla', 3, 102, 7, 80)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10211, N'Basic Rotors for 2013 Toyota Corolla', 3, 102, 10, 50)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10212, N'Performance Brake Pads for 2013 Toyota Corolla', 3, 102, 12, 100)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10213, N'Basic Brake Pads for 2013 Toyota Corolla', 3, 102, 5, 70)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10301, N'Battery for 2009 Mitsubishi Lancer', 1, 103, 17, 120)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10302, N'Tail Light Assembly for 2009 Mitsubishi Lancer', 1, 103, 19, 250)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10303, N'Headlight Assembly for 2009 Mitsubishi Lancer', 1, 103, 20, 300)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10304, N'Headlight Bulb for 2009 Mitsubishi Lancer', 1, 103, 5, 20)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10305, N'Turn Signal Bulb for 2009 Mitsubishi Lancer', 1, 103, 3, 25)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10306, N'Parking Light Bulb for 2009 Mitsubishi Lancer', 1, 103, 9, 15)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10307, N'Reverse Light Bulb for 2009 Mitsubishi Lancer', 1, 103, 11, 15)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10308, N'Brake Light Bulb for 2009 Mitsubishi Lancer', 1, 103, 13, 10)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10309, N'Battery for 2011 Ford Mustang', 2, 103, 15, 130)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10310, N'Tail Lights for 2011 Ford Mustang', 2, 103, 17, 300)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10311, N'Headlights for 2011 Ford Mustang', 2, 103, 20, 350)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10312, N'Headlight Bulb for 2011 Ford Mustang', 2, 103, 35, 40)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10313, N'Turn Signal Bulb for 2011 Ford Mustang', 2, 103, 12, 15)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10314, N'Parking Light Bulb for 2011 Ford Mustang', 2, 103, 62, 10)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10315, N'Reverse Light Bulb for 2011 Ford Mustang', 2, 103, 11, 20)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10316, N'Brake Light Bulb for 2011 Ford Mustang', 2, 103, 31, 25)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10317, N'Battery for 2013 Toyota Corolla', 3, 103, 15, 110)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10318, N'Tail Lights for 2013 Toyota Corolla', 3, 103, 13, 250)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10319, N'Headlights for 2013 Toyota Corolla', 3, 103, 9, 300)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10320, N'Headlight Bulb for 2013 Toyota Corolla', 3, 103, 7, 20)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10321, N'Turn Signal Bulb for 2013 Toyota Corolla', 3, 103, 5, 15)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10322, N'Parking Light Bulb for 2013 Toyota Corolla', 3, 103, 16, 30)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10323, N'Reverse Light Bulb for 2013 Toyota Corolla', 3, 103, 17, 15)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10324, N'Brake Light Bulb for 2013 Toyota Corolla', 3, 103, 13, 10)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10401, N'All Season 16" Tires for 2009 Mitsubishi Lancer', 1, 104, 5, 750)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10402, N'Winter 16" Tires for 2009 Mitsubishi Lancer', 1, 104, 3, 700)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10403, N'Summer 16" Tires for 2009 Mitsubishi Lancer', 1, 104, 7, 600)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10404, N'All Season 18" Tires for 2009 Mitsubishi Lancer', 1, 104, 8, 850)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10405, N'Winter 18" Tires for 2009 Mitsubishi Lancer', 1, 104, 12, 800)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10406, N'Summer 18" Tires for 2009 Mitsubishi Lancer', 1, 104, 8, 750)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10407, N'16" Steel Wheel for 2009 Mitsubishi Lancer', 1, 104, 4, 400)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10408, N'16" Alloy Wheel for 2009 Mitsubishi Lancer', 1, 104, 6, 600)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10409, N'18" Steel Wheel for 2009 Mitsubishi Lancer', 1, 104, 10, 500)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10410, N'18" Alloy Wheel for 2009 Mitsubishi Lancer', 1, 104, 11, 700)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10411, N'All Season 19" Tires for 2011 Ford Mustang', 2, 104, 2, 900)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10412, N'Winter 19" Tires for 2011 Ford Mustang', 2, 104, 1, 850)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10413, N'Summer 19" Tires for 2011 Ford Mustang', 2, 104, 5, 750)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10414, N'All Season 20" Tires for 2011 Ford Mustang', 2, 104, 8, 1100)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10415, N'Winter 20" Tires for 2011 Ford Mustang', 2, 104, 16, 1050)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10416, N'Summer 20" Tires for 2011 Ford Mustang', 2, 104, 15, 1000)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10417, N'19" Steel Wheel for 2011 Ford Mustang', 2, 104, 3, 600)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10418, N'19" Alloy Wheel for 2011 Ford Mustang', 2, 104, 7, 800)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10419, N'20" Steel Wheel for 2011 Ford Mustang', 2, 104, 12, 850)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10420, N'20" Alloy Wheel for 2011 Ford Mustang', 2, 104, 9, 1100)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10421, N'All Season 16" Tires for 2013 Toyota Corolla', 3, 104, 3, 700)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10422, N'Winter 16" Tires for 2013 Toyota Corolla', 3, 104, 7, 650)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10423, N'Summer 16" Tires for 2013 Toyota Corolla', 3, 104, 4, 550)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10424, N'All Season 17" Tires for 2013 Toyota Corolla', 3, 104, 2, 750)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10425, N'Winter 17" Tires for 2013 Toyota Corolla', 3, 104, 18, 700)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10426, N'Summer 17" Tires for 2013 Toyota Corolla', 3, 104, 1, 650)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10427, N'16" Steel Wheel for 2013 Toyota Corolla', 3, 104, 3, 350)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10428, N'16" Alloy Wheel for 2013 Toyota Corolla', 3, 104, 15, 600)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10429, N'17" Steel Wheel for 2013 Toyota Corolla', 3, 104, 4, 450)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10430, N'17" Alloy Wheel for 2013 Toyota Corolla', 3, 104, 11, 700)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10501, N'Basic Wiper Blades for 2009 Mitsubishi Lancer', 1, 105, 24, 12)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10502, N'Long-lasting Wiper Blades for 2009 Mitsubishi Lancer for 2009 Mitsubishi Lancer', 1, 105, 18, 18)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10503, N'Basic Wiper Blades for 2011 Ford Mustang', 2, 105, 46, 13)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10504, N'Long-lasting Wiper Blades for 2011 Ford Mustang', 2, 105, 42, 20)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10505, N'Basic Wiper Blades for 2013 Toyota Corolla', 3, 105, 37, 12)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (10506, N'Long-lasting Wiper Blades', 3, 105, 34, 19)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20101, N'Dual Action Polisher', NULL, 201, 4, 120)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20102, N'Automotive Polish', NULL, 201, 16, 15)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20103, N'Clay Bar Kit', NULL, 201, 14, 25)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20104, N'Automotive Wax', NULL, 201, 12, 29)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20105, N'Paint Sealant', NULL, 201, 17, 35)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20106, N'Tire Shine', NULL, 201, 15, 15)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20107, N'Microfibre towel kit', NULL, 201, 7, 15)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20108, N'Car Wash soap', NULL, 201, 12, 20)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20201, N'Air Freshener - New Car', NULL, 202, 71, 5)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20202, N'Air Freshener - Vanilla', NULL, 202, 62, 5)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20203, N'Air Freshener - Coffee', NULL, 202, 74, 5)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20204, N'GPS System', NULL, 202, 15, 200)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20205, N'Sticky Dash Holder', NULL, 202, 52, 15)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20206, N'Dash cam + SD Card', NULL, 202, 3, 70)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20301, N'Windshield Wiper Fluid', NULL, 203, 27, 20)
GO
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20302, N'Antifreeze', NULL, 203, 24, 22)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20303, N'Brake Fluid', NULL, 203, 14, 15)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20304, N'5w20 Synthetic oil', NULL, 203, 3, 45)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20305, N'0w20 Synthetic Oil', NULL, 203, 6, 50)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20306, N'5w20 Conventional Oil', NULL, 203, 4, 35)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20307, N'10w20 Conventional Oil', NULL, 203, 7, 40)
INSERT [dbo].[parts_table] ([part_number], [part_description], [car_id], [part_category], [part_stock], [part_price]) VALUES (20308, N'5w30 Conventional Oil', NULL, 203, 5, 40)
SET IDENTITY_INSERT [dbo].[users_table] ON 

INSERT [dbo].[users_table] ([user_num], [username], [user_email], [first_name], [last_name], [address], [password], [car_year], [car_brand], [car_model]) VALUES (8, N'admin', N'stevecoautoparts@gmail.com', N'admin', N'Account', N'135 Fennell Ave W, Hamilton, ON, L9C 1E9', N'dd3005e3abdb918695bbe300792616a1', NULL, NULL, NULL)
INSERT [dbo].[users_table] ([user_num], [username], [user_email], [first_name], [last_name], [address], [password], [car_year], [car_brand], [car_model]) VALUES (9, N'owner', N'stevecoautoparts@gmail.com', N'owner', N'account', N'135 Fennell Ave W, Hamilton, ON, L9C 1E9', N'dd3005e3abdb918695bbe300792616a1', NULL, NULL, NULL)
INSERT [dbo].[users_table] ([user_num], [username], [user_email], [first_name], [last_name], [address], [password], [car_year], [car_brand], [car_model]) VALUES (10, N'steve30avs', N'ericcartman1234@msn.com', N'Steven', N'Rodrigues', N'135 Fennell Ave W, Hamilton, ON, L9C 1E9', N'dd3005e3abdb918695bbe300792616a1', 2009, N'Mitsubishi', N'Lancer')
INSERT [dbo].[users_table] ([user_num], [username], [user_email], [first_name], [last_name], [address], [password], [car_year], [car_brand], [car_model]) VALUES (11, N'ardnas', N'sdsm88@gmail.com', N'sandra', N'Rodrigues', N'100 kensington palace, london england, l0r1p0', N'dd3005e3abdb918695bbe300792616a1', NULL, NULL, NULL)
INSERT [dbo].[users_table] ([user_num], [username], [user_email], [first_name], [last_name], [address], [password], [car_year], [car_brand], [car_model]) VALUES (13, N'steveco', N'stevenrodrigues91@gmail.com', N'Steve', N'Co', N'123 fake street, hamilton, ON, L9A 2P4', N'dd3005e3abdb918695bbe300792616a1', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[users_table] OFF
ALTER TABLE [dbo].[appointments_table]  WITH CHECK ADD  CONSTRAINT [FK_appointments_table_users_table] FOREIGN KEY([user_num_request])
REFERENCES [dbo].[users_table] ([user_num])
GO
ALTER TABLE [dbo].[appointments_table] CHECK CONSTRAINT [FK_appointments_table_users_table]
GO
ALTER TABLE [dbo].[cart_table]  WITH CHECK ADD  CONSTRAINT [FK_cart_table_parts_table] FOREIGN KEY([part_number])
REFERENCES [dbo].[parts_table] ([part_number])
GO
ALTER TABLE [dbo].[cart_table] CHECK CONSTRAINT [FK_cart_table_parts_table]
GO
ALTER TABLE [dbo].[invoice_table]  WITH CHECK ADD  CONSTRAINT [FK_invoice_table_users_table] FOREIGN KEY([user_num])
REFERENCES [dbo].[users_table] ([user_num])
GO
ALTER TABLE [dbo].[invoice_table] CHECK CONSTRAINT [FK_invoice_table_users_table]
GO
ALTER TABLE [dbo].[message_table]  WITH CHECK ADD  CONSTRAINT [FK_message_by_user] FOREIGN KEY([created_by_user_num])
REFERENCES [dbo].[users_table] ([user_num])
GO
ALTER TABLE [dbo].[message_table] CHECK CONSTRAINT [FK_message_by_user]
GO
ALTER TABLE [dbo].[orders_table]  WITH CHECK ADD  CONSTRAINT [FK_orders_table_invoice_table] FOREIGN KEY([invoice_num])
REFERENCES [dbo].[invoice_table] ([invoice_num])
GO
ALTER TABLE [dbo].[orders_table] CHECK CONSTRAINT [FK_orders_table_invoice_table]
GO
ALTER TABLE [dbo].[orders_table]  WITH CHECK ADD  CONSTRAINT [FK_orders_table_orders_table] FOREIGN KEY([part_num])
REFERENCES [dbo].[parts_table] ([part_number])
GO
ALTER TABLE [dbo].[orders_table] CHECK CONSTRAINT [FK_orders_table_orders_table]
GO
ALTER TABLE [dbo].[parts_table]  WITH CHECK ADD  CONSTRAINT [FK_parts_table_car_table] FOREIGN KEY([car_id])
REFERENCES [dbo].[car_table] ([car_id])
GO
ALTER TABLE [dbo].[parts_table] CHECK CONSTRAINT [FK_parts_table_car_table]
GO
USE [master]
GO
ALTER DATABASE [capstone] SET  READ_WRITE 
GO
