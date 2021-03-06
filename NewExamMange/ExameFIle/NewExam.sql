USE [master]
GO
/****** Object:  Database [NewExam]    Script Date: 2018/7/8 20:11:20 ******/
CREATE DATABASE [NewExam]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NewExam', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\NewExam.mdf' , SIZE = 12480KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'NewExam_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\NewExam_log.ldf' , SIZE = 245440KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [NewExam] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NewExam].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NewExam] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NewExam] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NewExam] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NewExam] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NewExam] SET ARITHABORT OFF 
GO
ALTER DATABASE [NewExam] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NewExam] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NewExam] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NewExam] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NewExam] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NewExam] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NewExam] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NewExam] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NewExam] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NewExam] SET  ENABLE_BROKER 
GO
ALTER DATABASE [NewExam] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NewExam] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NewExam] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NewExam] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NewExam] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NewExam] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NewExam] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NewExam] SET RECOVERY FULL 
GO
ALTER DATABASE [NewExam] SET  MULTI_USER 
GO
ALTER DATABASE [NewExam] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NewExam] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NewExam] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NewExam] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [NewExam] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'NewExam', N'ON'
GO
USE [NewExam]
GO
/****** Object:  Table [dbo].[Authority]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Authority](
	[AuthorityId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[AuhorityName] [varchar](30) NULL,
	[OrderNo] [int] NULL,
	[ImgUrl] [varchar](100) NULL,
	[AothorityLink] [varchar](100) NULL,
	[ParentId] [int] NULL,
	[Leval] [int] NULL,
	[AuthorityType] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Class]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Class](
	[ClassId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[ClassName] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[ExamId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[TheExamId] [numeric](18, 0) NULL,
	[ExamBegTime] [datetime] NULL,
	[ExamEndTime] [datetime] NULL,
	[ExamPeriod] [int] NULL,
	[NowPeriod] [int] NULL,
	[PaperNumber] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FirstPoint]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FirstPoint](
	[FirstPointId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[FirstPointName] [varchar](50) NULL,
	[FirstPointOrder] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Invigilate]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Invigilate](
	[ExamId] [numeric](18, 0) NOT NULL,
	[TId] [varchar](50) NOT NULL,
	[ExamRoomName] [varchar](50) NULL,
	[ExamRoomPosition] [varchar](50) NULL,
	[OtherTeacher] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ExamId] ASC,
	[TId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Paper]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paper](
	[PaperId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[ExamId] [numeric](18, 0) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PaperDetail]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaperDetail](
	[TopicId] [numeric](18, 0) NOT NULL,
	[PaperId] [numeric](18, 0) NOT NULL,
	[TopicScore] [int] NULL,
 CONSTRAINT [PK_PAPERDETAIL] PRIMARY KEY CLUSTERED 
(
	[TopicId] ASC,
	[PaperId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SecondPoint]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SecondPoint](
	[SecondPointId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[FIrstPointId] [numeric](18, 0) NULL,
	[SecondPointName] [varchar](50) NULL,
	[SecondPointOrder] [int] NULL,
	[IsChose] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sort]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sort](
	[SortId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[SortOrder] [int] NULL,
	[SortName] [varchar](100) NULL,
	[TopicSortScore] [int] NULL,
	[TopicSortNumber] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Student]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Student](
	[StudentId] [varchar](30) NOT NULL,
	[StudentName] [varchar](30) NULL,
	[StudentPhone] [varchar](30) NULL,
	[StuImage] [varchar](200) NULL,
	[Class] [varchar](100) NULL,
	[RegisterTime] [datetime] NULL,
	[StudentState] [int] NULL,
	[StuExamState] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StuExam]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StuExam](
	[StudentId] [varchar](30) NOT NULL,
	[PaperId] [numeric](18, 0) NOT NULL,
	[TId] [varchar](50) NOT NULL,
	[IPAddress] [varchar](50) NULL,
	[Score] [int] NULL,
	[ReplyEndTime] [datetime] NULL,
	[BeginExamTIme] [datetime] NULL,
 CONSTRAINT [PK_STUEXAM] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC,
	[PaperId] ASC,
	[TId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StuPaper]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StuPaper](
	[TopicId] [numeric](18, 0) NOT NULL,
	[StudentId] [varchar](30) NOT NULL,
	[StuAnswer] [varchar](200) NULL,
	[ExamId] [numeric](18, 0) NOT NULL,
 CONSTRAINT [primary_key] PRIMARY KEY CLUSTERED 
(
	[TopicId] ASC,
	[StudentId] ASC,
	[ExamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TeaAuthority]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TeaAuthority](
	[TId] [varchar](50) NOT NULL,
	[AuthorityId] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_TEAAUTHORITY] PRIMARY KEY CLUSTERED 
(
	[TId] ASC,
	[AuthorityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Teacher](
	[TId] [varchar](50) NOT NULL,
	[TPwd] [varchar](50) NULL,
	[TName] [varchar](20) NULL,
	[TPhone] [varchar](20) NULL,
	[IsAdmin] [int] NULL,
	[TeacherState] [int] NULL,
	[TeacherCreateDate] [datetime] NULL,
	[isExamTeacher] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TheExam]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TheExam](
	[TheExamId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[TheExamName] [varchar](80) NULL,
	[IsNowTheExam] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Topic]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Topic](
	[TopicId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[SortId] [numeric](18, 0) NULL,
	[SecondPointId] [numeric](18, 0) NULL,
	[TopicTitle] [varchar](200) NULL,
	[OptionA] [varchar](100) NULL,
	[OptionB] [varchar](100) NULL,
	[OptionC] [varchar](100) NULL,
	[OptionD] [varchar](100) NULL,
	[TitleAnswer] [varchar](200) NULL,
	[TopicType] [varchar](20) NULL,
	[NumberOfUse] [int] NULL,
	[TopicCreateDate] [datetime] NULL,
	[TopicState] [int] NULL,
	[TopicSourceId] [numeric](18, 0) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TopicSource]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TopicSource](
	[TopicSourceId] [int] IDENTITY(1,1) NOT NULL,
	[TopicSourceName] [varchar](20) NULL,
	[IsChose] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TopicSourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Authority] ON 

INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(19 AS Numeric(18, 0)), N'个人信息管理', 15, N'glyphicon glyphicon-user', N'/Public/PersonInfo.aspx', NULL, NULL, 0)
INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(9 AS Numeric(18, 0)), N'教师信息管理', 1, N'glyphicon  glyphicon-tower', N'/TeacherManage/ManageTeacher.aspx', NULL, NULL, 1)
INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(4 AS Numeric(18, 0)), N'成绩管理', 8, N'glyphicon glyphicon-list-alt', N'/GradeManger/ExamList.aspx', NULL, NULL, 1)
INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(18 AS Numeric(18, 0)), N'考生信息管理', 3, N'glyphicon glyphicon-plus-sign', N'/ManageStu/WaitAuditManage.aspx', NULL, NULL, 1)
INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(6 AS Numeric(18, 0)), N'题库管理', 3, N'glyphicon glyphicon-book', N'/TopicManage/TopicInfo.aspx', NULL, NULL, 1)
INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(23 AS Numeric(18, 0)), N'考场管理', 3, N'glyphicon glyphicon-edit', N'/InvigilateTeacher/TeacherExamManage.aspx', NULL, NULL, 2)
INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(10 AS Numeric(18, 0)), N'正在进行的考试', 7, N'glyphicon glyphicon-hourglass', N'/ExamManage/NowExam.aspx', NULL, NULL, 1)
INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(11 AS Numeric(18, 0)), N'管理员权限管理', 11, N'glyphicon glyphicon-star', N'/Authority/TeacherList.aspx', NULL, NULL, 1)
INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(12 AS Numeric(18, 0)), N'基础信息设置', 10, N'glyphicon glyphicon-edit', N'/BasicInfo/PointInfo.aspx', NULL, NULL, 1)
INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(15 AS Numeric(18, 0)), N'考生登记', 2, N'glyphicon glyphicon-check', N'/InvigilateTeacher/WaitCheckStu.aspx', NULL, NULL, 2)
INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(16 AS Numeric(18, 0)), N'考试异常处理', 4, N'glyphicon glyphicon-warning-sign', N'/InvigilateTeacher/UnusualManage.aspx', NULL, NULL, 2)
INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(17 AS Numeric(18, 0)), N'考试管理', 6, N'glyphicon glyphicon-inbox', N'/ExamManage/AllExam.aspx', NULL, NULL, 1)
INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(20 AS Numeric(18, 0)), N'考试基础信息设置', 4, N'glyphicon glyphicon-edit', N'/Exam/ExamTopicScource.aspx', NULL, NULL, 1)
INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(21 AS Numeric(18, 0)), N'考场登记', 1, N'glyphicon glyphicon-inbox', N'/InvigilateTeacher/SingInExamRoom.aspx', NULL, NULL, 2)
INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(22 AS Numeric(18, 0)), N'考生注册', 5, N'glyphicon glyphicon-plus-sign', N'/InvigilateTeacher/TeacherAddStu.aspx', NULL, NULL, 2)
INSERT [dbo].[Authority] ([AuthorityId], [AuhorityName], [OrderNo], [ImgUrl], [AothorityLink], [ParentId], [Leval], [AuthorityType]) VALUES (CAST(24 AS Numeric(18, 0)), N'考试分析', 9, NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Authority] OFF
SET IDENTITY_INSERT [dbo].[Exam] ON 

INSERT [dbo].[Exam] ([ExamId], [TheExamId], [ExamBegTime], [ExamEndTime], [ExamPeriod], [NowPeriod], [PaperNumber]) VALUES (CAST(143 AS Numeric(18, 0)), CAST(97 AS Numeric(18, 0)), CAST(N'2018-07-08 11:50:00.000' AS DateTime), CAST(N'2018-07-08 23:10:00.000' AS DateTime), 1, 1, 100)
INSERT [dbo].[Exam] ([ExamId], [TheExamId], [ExamBegTime], [ExamEndTime], [ExamPeriod], [NowPeriod], [PaperNumber]) VALUES (CAST(144 AS Numeric(18, 0)), CAST(98 AS Numeric(18, 0)), CAST(N'2018-07-08 15:25:00.000' AS DateTime), CAST(N'2018-07-08 20:25:00.000' AS DateTime), 1, 0, 100)
INSERT [dbo].[Exam] ([ExamId], [TheExamId], [ExamBegTime], [ExamEndTime], [ExamPeriod], [NowPeriod], [PaperNumber]) VALUES (CAST(145 AS Numeric(18, 0)), CAST(98 AS Numeric(18, 0)), CAST(N'2018-07-08 12:45:00.000' AS DateTime), CAST(N'2018-07-08 14:55:00.000' AS DateTime), 2, 1, 100)
SET IDENTITY_INSERT [dbo].[Exam] OFF
SET IDENTITY_INSERT [dbo].[FirstPoint] ON 

INSERT [dbo].[FirstPoint] ([FirstPointId], [FirstPointName], [FirstPointOrder]) VALUES (CAST(1 AS Numeric(18, 0)), N'关系数据库', 6)
INSERT [dbo].[FirstPoint] ([FirstPointId], [FirstPointName], [FirstPointOrder]) VALUES (CAST(2 AS Numeric(18, 0)), N'关系数据库标准语言', 4)
INSERT [dbo].[FirstPoint] ([FirstPointId], [FirstPointName], [FirstPointOrder]) VALUES (CAST(3 AS Numeric(18, 0)), N'数据库设计', 3)
INSERT [dbo].[FirstPoint] ([FirstPointId], [FirstPointName], [FirstPointOrder]) VALUES (CAST(20 AS Numeric(18, 0)), N'数据库安全性', 7)
INSERT [dbo].[FirstPoint] ([FirstPointId], [FirstPointName], [FirstPointOrder]) VALUES (CAST(21 AS Numeric(18, 0)), N'数据库编程', 5)
INSERT [dbo].[FirstPoint] ([FirstPointId], [FirstPointName], [FirstPointOrder]) VALUES (CAST(22 AS Numeric(18, 0)), N'绪论', 1)
INSERT [dbo].[FirstPoint] ([FirstPointId], [FirstPointName], [FirstPointOrder]) VALUES (CAST(23 AS Numeric(18, 0)), N'数据库完整性', 8)
INSERT [dbo].[FirstPoint] ([FirstPointId], [FirstPointName], [FirstPointOrder]) VALUES (CAST(24 AS Numeric(18, 0)), N'关系数据理论', 2)
SET IDENTITY_INSERT [dbo].[FirstPoint] OFF
SET IDENTITY_INSERT [dbo].[SecondPoint] ON 

INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(1 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'关系数据库结构及形式化定义', 1, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'关系操作', 2, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(3 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'数据库系统的组成', 3, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(4 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), N'数据定义', 1, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(28 AS Numeric(18, 0)), CAST(22 AS Numeric(18, 0)), N'数据库系统概论', 1, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(29 AS Numeric(18, 0)), CAST(22 AS Numeric(18, 0)), N'数据模型', 2, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(7 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), N'数据库设计的概述', 1, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(30 AS Numeric(18, 0)), CAST(22 AS Numeric(18, 0)), N'数据库系统的结构', 3, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(9 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), N'概念结构设计', 3, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(17 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), N'数据更新', 2, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(31 AS Numeric(18, 0)), CAST(22 AS Numeric(18, 0)), N'数据库系统的组成', 3, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(32 AS Numeric(18, 0)), CAST(24 AS Numeric(18, 0)), N'问题的提出', 1, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(33 AS Numeric(18, 0)), CAST(24 AS Numeric(18, 0)), N'规范化', 1, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(34 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), N'需求分析', 2, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(35 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), N'概念结构设计', 3, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(36 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), N'逻辑结构设计', 4, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(37 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), N'物理结构设计', 5, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(38 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), N'数据库的实施与维护', 6, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(39 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), N'数据查询', 2, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(40 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), N'数据更新', 3, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(41 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), N'空置处理', 4, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(42 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), N'视图', 5, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(52 AS Numeric(18, 0)), CAST(23 AS Numeric(18, 0)), N'用户定义的完整性', 1, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(53 AS Numeric(18, 0)), CAST(23 AS Numeric(18, 0)), N'完整性约束名子句', 2, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(54 AS Numeric(18, 0)), CAST(23 AS Numeric(18, 0)), N'域中的完整性限制', 3, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(55 AS Numeric(18, 0)), CAST(23 AS Numeric(18, 0)), N'断言', 4, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(56 AS Numeric(18, 0)), CAST(23 AS Numeric(18, 0)), N'触发器', 5, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(43 AS Numeric(18, 0)), CAST(21 AS Numeric(18, 0)), N'嵌入式SQL', 1, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(44 AS Numeric(18, 0)), CAST(21 AS Numeric(18, 0)), N'过程化SQL', 2, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(45 AS Numeric(18, 0)), CAST(21 AS Numeric(18, 0)), N'存储过程和函数', 3, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(46 AS Numeric(18, 0)), CAST(21 AS Numeric(18, 0)), N'ODBC编程', 4, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(47 AS Numeric(18, 0)), CAST(20 AS Numeric(18, 0)), N'数据库安全性概述', 1, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(48 AS Numeric(18, 0)), CAST(20 AS Numeric(18, 0)), N'数据库安全性控制', 2, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(49 AS Numeric(18, 0)), CAST(20 AS Numeric(18, 0)), N'视图机制', 3, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(50 AS Numeric(18, 0)), CAST(20 AS Numeric(18, 0)), N'审计', 4, 1)
INSERT [dbo].[SecondPoint] ([SecondPointId], [FIrstPointId], [SecondPointName], [SecondPointOrder], [IsChose]) VALUES (CAST(51 AS Numeric(18, 0)), CAST(20 AS Numeric(18, 0)), N'数据加密', 5, 1)
SET IDENTITY_INSERT [dbo].[SecondPoint] OFF
SET IDENTITY_INSERT [dbo].[Sort] ON 

INSERT [dbo].[Sort] ([SortId], [SortOrder], [SortName], [TopicSortScore], [TopicSortNumber]) VALUES (CAST(1 AS Numeric(18, 0)), 1, N'基础知识', 2, 10)
INSERT [dbo].[Sort] ([SortId], [SortOrder], [SortName], [TopicSortScore], [TopicSortNumber]) VALUES (CAST(3 AS Numeric(18, 0)), 3, N'数据库分析与设计', 10, 5)
INSERT [dbo].[Sort] ([SortId], [SortOrder], [SortName], [TopicSortScore], [TopicSortNumber]) VALUES (CAST(7 AS Numeric(18, 0)), 2, N'SQL', 5, 10)
SET IDENTITY_INSERT [dbo].[Sort] OFF
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450101', N'刘强', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.403' AS DateTime), 2, 1)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450142', N'王越', N'13995975900', NULL, N'15级软件工程(1)班', CAST(N'2018-07-08 11:38:56.213' AS DateTime), 1, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450102', N'周云虎', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.760' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450103', N'李新安', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.810' AS DateTime), 2, 1)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450104', N'程涛', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.813' AS DateTime), 2, 1)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450106', N'韩建国', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.820' AS DateTime), 2, 1)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450107', N'赵娜', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.823' AS DateTime), 2, 1)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450108', N'许仁园', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.830' AS DateTime), 2, 1)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450109', N'洪宇', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.833' AS DateTime), 2, 1)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450111', N'翟光美', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.840' AS DateTime), 2, 1)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450112', N'张林浩', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.843' AS DateTime), 2, 1)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450113', N'乐顺', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.850' AS DateTime), 2, 1)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450114', N'陈攀', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.860' AS DateTime), 2, 1)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450115', N'韩思思', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.867' AS DateTime), 2, 1)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450116', N'王越', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.873' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450117', N'郑梓天', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.883' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450118', N'黄耀祖', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.887' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450119', N'李昶', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.893' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450120', N'雷双龙', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.897' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450122', N'胡炜', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.903' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450123', N'翟光美', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.907' AS DateTime), 2, 1)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450124', N'李楚引', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.983' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450125', N'邓武胜', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.987' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450126', N'梅建明', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.990' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450127', N'代鹏', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:08.997' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450128', N'艾佳伟', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.000' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450129', N'宋子祥', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.003' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450130', N'戴智泓', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.007' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450131', N'石孝康', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.013' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450132', N'饶成兵', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.017' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450133', N'罗源', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.020' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450134', N'刘炎', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.023' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450135', N'李杨', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.030' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450136', N'熊长成', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.033' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450137', N'仇凯', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.037' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450138', N'王宇杰', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.040' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450139', N'彭席', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.043' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540450140', N'齐永杰', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.047' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540820144', N'管闯', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.050' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540130129', N'夏应星', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.053' AS DateTime), 2, 1)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540520138', N'刘聪', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.057' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540330107', N'张巍', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.060' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540905104', N'魏小兵', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.067' AS DateTime), 2, 0)
INSERT [dbo].[Student] ([StudentId], [StudentName], [StudentPhone], [StuImage], [Class], [RegisterTime], [StudentState], [StuExamState]) VALUES (N'201540820206', N'陈新周', N'13995975911', NULL, N'15级软件工程(1)班', CAST(N'2018-07-06 20:59:09.070' AS DateTime), 2, 0)
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(1 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(4 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(5 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(6 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'01', CAST(9 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(9 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'01', CAST(10 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(10 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(14 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'01', CAST(15 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(15 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'01', CAST(16 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(16 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(17 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(18 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'01', CAST(19 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(19 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(20 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'01', CAST(21 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(21 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'01', CAST(22 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(22 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'01', CAST(23 AS Numeric(18, 0)))
INSERT [dbo].[TeaAuthority] ([TId], [AuthorityId]) VALUES (N'admin', CAST(23 AS Numeric(18, 0)))
INSERT [dbo].[Teacher] ([TId], [TPwd], [TName], [TPhone], [IsAdmin], [TeacherState], [TeacherCreateDate], [isExamTeacher]) VALUES (N'admin', N'251621336568182581431182316624237115518', N'管理员', N'1399', 1, 1, CAST(N'2018-06-11 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Teacher] ([TId], [TPwd], [TName], [TPhone], [IsAdmin], [TeacherState], [TeacherCreateDate], [isExamTeacher]) VALUES (N'01', N'20611253215155104214118136136771226162140', N'徐严', N'1399', 1, 1, CAST(N'2018-06-11 00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[TheExam] ON 

INSERT [dbo].[TheExam] ([TheExamId], [TheExamName], [IsNowTheExam]) VALUES (CAST(97 AS Numeric(18, 0)), N'湖北理工学院数据库系统概论第一次考试', 0)
INSERT [dbo].[TheExam] ([TheExamId], [TheExamName], [IsNowTheExam]) VALUES (CAST(98 AS Numeric(18, 0)), N'湖北理工学院数据库系统概论第二次考试', 1)
SET IDENTITY_INSERT [dbo].[TheExam] OFF
SET IDENTITY_INSERT [dbo].[Topic] ON 

INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(169 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(28 AS Numeric(18, 0)), N'E-R图是数据库设计的工具之一，它适用于建立数据库的。', N'概念模型', N'逻辑模型', N'逻辑模型', N'结构模型', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.480' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(170 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(28 AS Numeric(18, 0)), N'概念模型独立于?<br/>', N'E-R模型', N'硬件设备和DBMS', N'硬件设备和DBMS', N'操作系统和DBMS', N'BC', N'多选题', NULL, CAST(N'2018-07-08 19:54:31.613' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(171 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(28 AS Numeric(18, 0)), N'模式和内模式', N'只能有一个', N'最多只能有一个', N'最多只能有一个', N'至少两个', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.623' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(172 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(28 AS Numeric(18, 0)), N'数据库三级模式中，真正存在的是', N'外模式', N'子模式', N'子模式', N'模式', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.640' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(173 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(28 AS Numeric(18, 0)), N'在数据库的概念设计中，最常用的数据模型是 。', N'形象模型', N'物理模型', N'物理模型', N'逻辑模型', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.680' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(174 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(30 AS Numeric(18, 0)), N'关系模式R中的属性全部是主属性，则R的最高范式必定是     。', N'2NF', N'3NF', N'4NF', N'BCNF', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.693' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(175 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(30 AS Numeric(18, 0)), N'关系模式的任何属性（）', N'不可再分', N'可再分', N'可再分', N'命名在该关系模式中可以不唯一', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.710' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(176 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(30 AS Numeric(18, 0)), N'关系模式中，满足2NF的模式', N'可能是1NF', N'必定是1NF', N'必定是3NF', N'必定是BCNF', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.723' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(177 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(30 AS Numeric(18, 0)), N'假定学生关系是S(S#，SNAME,SEX,AGE),课程关系是C(Ci,CNAME,TEACHER),学生选课关系是SC(S#,C#,GRADE).要查找选修COMPUTER课程的女学生姓名，将涉及到关系。', N'S', N'SC,C', N'SC,C', N'S,SC', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.740' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(178 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(30 AS Numeric(18, 0)), N'检索选修4门以上课程的学生总成绩（不统计不及格的课程），并要求按总成绩的降序排列出来。正确的SELECT 语句是。', N'SELECT S#，SUM (GRADE) FROM SC WHERE GRADE>= 60 GROUP BY S# ORDER BY 2 DESC HAVING COUNT (*) >=4', N'SELECT S#，SUM (GRADE) FROM SC WHERE GRADE>=60 GROUP BY S# HAVING COUNT (* )>=4 ORDER BY 2 DESC', N'SELECT S#，SUM (GRADE) FROM SC WHERE GRADE>=60 GROUP BY S# HAVING COUNT (* )>=4 ORDER BY 2 DESC', N'SELECT S#,SUM (GRADE) FROM SC WHERE GRADE>= 60 HAVING COUNT (*) >=4 GROUP BY S# ORDER BY 2 DESC', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.757' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(179 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(30 AS Numeric(18, 0)), N'下列关于数据库运行和维护的叙述中，正确的是???? 。', N'只要数据库正式投入运行，就标志着数据库设计工作的结束', N'数据库的维护工作就是维持数据库系统的正常运行', N'数据库的维护工作就是维持数据库系统的正常运行', N'数据库的维护工作就是维持数据库系统的正常运行', N'D', N'多选题', NULL, CAST(N'2018-07-08 19:54:31.787' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(180 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(30 AS Numeric(18, 0)), N'下面不属于数据库物理设计工作的是。', N'存取方法的选择', N'索引与入口设计', N'索引与入口设计', N'与安全性，完整性，一致性有关的问题', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.800' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(181 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(32 AS Numeric(18, 0)), N'关系数据库管理系统与网状系统相比。', N'前者运行效率较高', N'前者的数据模型更为简洁', N'前者的数据模型更为简洁', N'前者比后者产生得早一些', N'BD', N'多选题', NULL, CAST(N'2018-07-08 19:54:31.813' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(182 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(32 AS Numeric(18, 0)), N'取出关系中的某些列，并消去重复元组的关系代数运算称为（）', N'取列运算', N'投影运算', N'投影运算', N'连接运算', N'BD', N'多选题', NULL, CAST(N'2018-07-08 19:54:31.830' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(183 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(32 AS Numeric(18, 0)), N'下列有关范式的叙述中正确的是。', N'如果关系模式R?1NF,且R中主属姓完全函数依赖于码，则R是2NF', N'如果关系视式R?3NF,X,YíU,考X→Y, 则R是BCNF', N'如果关系模式R?BCNF，若X→→Y(Y?X)是平凡的多值依赖，则R是4NF', N'一个关系模式如果属于4NF，则一定属于BCNF，反之不成立', N'BD', N'多选题', NULL, CAST(N'2018-07-08 19:54:31.843' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(184 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(32 AS Numeric(18, 0)), N'有关系模式学生（学号，课程号，名次），若每一名学生每门课程有一定的名次，每门课程每一名次只有一名学生，则以下叙述错误的是。', N'（学号，课程号）和（课程号，名次）都可以作为候选码', N'只有（学号，课程号）能作为候选码', N'关系模式属于第三范式', N'关系模式属于BCNF', N'D', N'多选题', NULL, CAST(N'2018-07-08 19:54:31.853' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(185 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(33 AS Numeric(18, 0)), N'在数据管理技术的发展过程中，经历了人工管理阶段、文件系统阶及和数据系统阶段。在这几个阶段中，数据独立性最高的是___阶段。', N'数据库系统', N'文件系统', N'文件系统', N'人工管理', N'D', N'多选题', NULL, CAST(N'2018-07-08 19:54:31.867' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(186 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), N'层次模型不能直接表示。', N'1:1联系', N'1:n联系', N'1:n联系', N'm:n联系', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.883' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(187 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), N'关系数据模型', N'只能表示实体间的1:1联系', N'只能表示实体间的1:n联系', N'只能表示实体间的1:n联系', N'只能表示实体间的m：n 联系', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.900' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(188 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), N'数据库概念设计的E-R图中，用属性描述实体的特征，属性在E-R图中用表示。', N'矩形', N'四边形', N'四边形', N'菱形', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.930' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(189 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), N'自然连接是构成新关系的有效方法。一般情况下，当对关系R和S使用自然连接时，要求R和S含有一个或多个共有的（）', N'元组', N'行', N'行', N'记录', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.943' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(190 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(34 AS Numeric(18, 0)), N'X→Ai（i=1,2,...,k）成立是X→A1A2...AK成立的。', N'充分条件', N'必要条件', N'充要条件', N'既不充分也不必要', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.957' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(191 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(34 AS Numeric(18, 0)), N'根据关系模式的完整性规则，一个关系中的主码（）', N'不能有两个', N'不能成为另一个关系的主码', N'不能成为另一个关系的主码', N'不允许为空', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.977' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(192 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(34 AS Numeric(18, 0)), N'能够消除多值依赖引起的冗余的是 。', N'2NF', N'3NF', N'4NF', N'BCNF', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:31.990' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(193 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(34 AS Numeric(18, 0)), N'设关系模式R<U,F>U,U为R的属性集合，F为U上的函数依赖集，如果X→Y为F所蕴涵，且ZíU,则XZ→YZ为F所蕴涵。这是函数依赖的。', N'传递律', N'合并律', N'自反律', N'增广律', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.003' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(194 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(34 AS Numeric(18, 0)), N'数据库的三级模式之间存在的映象关系正确的是.', N'外模式/内模式', N'外模式/模式', N'外模式/模式', N'外模式/外模式', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.017' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(195 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(34 AS Numeric(18, 0)), N'数据模型的要素是。', N'外模式、模式和内模式', N'关系模型、层次模型、网状模型', N'关系模型、层次模型、网状模型', N'实体、属性和联系', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.027' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(196 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(34 AS Numeric(18, 0)), N'在关系模式R（A,B,C,D）中，有函数依赖集F={B→C,C→D,D→A}，则R能达到。', N'1NF', N'2NF', N'3NF', N'以上三者都不行', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.040' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(197 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(9 AS Numeric(18, 0)), N'层次模型、网状模型和关系模型的划分原则是.', N'记录长度', N'文件的大小', N'文件的大小', N'联系的复杂程度', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.053' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(198 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(9 AS Numeric(18, 0)), N'关系模型中，一个码是（）', N'可由多个任意属性组成', N'至多由一个属性组成', N'至多由一个属性组成', N'可由一个或多个其值能唯一标识该模式中如何元组的属性组成', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.067' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(199 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(9 AS Numeric(18, 0)), N'数据库的网状模型应满足的条件是。', N'允许一个以上的结点无父结点，也允许一个结点有多个父结点', N'必须有两个以上的结点', N'必须有两个以上的结点', N'有且仅有一个结点无父结点，其余结点都只有一个父结点', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.077' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(200 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(9 AS Numeric(18, 0)), N'在关系R（R#，RN，S#）和S（S#，SN，SD）中，R的主码是R#，S的主码是S#，则S#在R中称为（）', N'外码', N'候选码', N'候选码', N'主码', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.110' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(201 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(9 AS Numeric(18, 0)), N'在关系数据库设计中，设计关系模式是&nbsp; 的任务。<br/>', N'需求分析阶段', N'概念设计阶段', N'概念设计阶段', N'逻辑设计阶段', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.143' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(202 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(36 AS Numeric(18, 0)), N'检家学生姓名及其所选修课程的课程号和成绩。正确SELECT语句是。', N'SELECT S.SN,SC.C#,SC.GRADE FROM S WHERE S.S#=SC.S#', N'SELECT S.SN,SC.C#,SC.GRADE FROM SC WHERE S.S#=SC.GRADE', N'SELECT S.SN,SC.C#,SC.GRADE FROM SC WHERE S.S#=SC.GRADE', N'SELECT S.SN,SC.C#,SC.GRADE FROM S,SC WHERE S.S#=SC.S#', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.173' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(203 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(36 AS Numeric(18, 0)), N'检索所有比王华年龄大的学生姓名、年龄和性别。正确的SELECT语句是。', N'SELECT SN,AGE.SEX FROM S WHERE AGE>(SELECT AGE FROM SWHERE SN=王华 )', N'SELECT SN,AGE,SEX FROM SWHERE SN=王华', N'SELECT SN,AGE,SEX FROM SWHERE SN=王华', N'SELECT SN,AGE,SEX FROM S WHERE AGE>(SELECT AGE WHERE SN= 王华 )', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.193' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(204 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(36 AS Numeric(18, 0)), N'检索选修课程C2的学生中成绩最高的学生的学号。正确的SELECT语句是。', N'SELECT S# FROM SC WHERE C#=C2 AND GRADE >=(SELECT GRADE FROM SC WHERE C#=C2)', N'SELECT S# FROM SC WHERE C#=C2 AND GRADE IN (SELECT GRADE FROM SC WHERE C#=C2)', N'SELECT S# FROM SC WHERE C#=C2 AND GRADE IN (SELECT GRADE FROM SC WHERE C#=C2)', N'SELECT S# FROM SC WHERE C#=C2 AND GRADE NOT IN (SELECT GRADE FROM SC WHERE C#=C2)', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.213' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(205 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(36 AS Numeric(18, 0)), N'下列属于数据库物理设计工作的是&nbsp;&nbsp;', N'将E-R图转换为关系模式', N'选择存储路径', N'选择存储路径', N'建立数据流图', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.227' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(207 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(37 AS Numeric(18, 0)), N'关系模式中各级范式之间的关系为。', N'3NFì2NFì1NF', N'3NFì1NFì2NF', N'2NFì1NFì3NF', N'2NFì1NFì3NF', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.260' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(208 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(37 AS Numeric(18, 0)), N'候选码中的属性称为。', N'非主属性', N'主属性', N'复合属性', N'关键属性', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.273' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(209 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(4 AS Numeric(18, 0)), N'关系模式的候选码可以有  ①   ，主码有   ②   。', N'0个', N'1个', N'1个或多个', N'多个', N'BC', N'多选题', NULL, CAST(N'2018-07-08 19:54:32.287' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(210 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(4 AS Numeric(18, 0)), N'下列关于数据库系统的正确叙述是。', N'数据库系统减少了数据冗余', N'数据库系统避免了一切兀余', N'数据库系统避免了一切兀余', N'数据库系统中数据的一致性是指数据类型一致', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.303' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(211 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(4 AS Numeric(18, 0)), N'在数据管理技术的发展过程中，经历了人工管理阶段、文件系统阶及和数据系统阶段。在这几个阶段中，数据独立性最高的是阶段。', N'数据库系统', N'文件系统', N'文件系统', N'人工管理', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.320' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(212 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(39 AS Numeric(18, 0)), N'E-R图中的联系可以与实体有关。<br/>', N'0个', N'1个', N'1个', N'1个或多个', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.333' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(213 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(17 AS Numeric(18, 0)), N'关系模式STJ(S#,T,J#)中，存在函数依赖：（S#,J#）→T，（S#,T）→J#,T→J#，则    。', N'关系STJ满足1NF，但不满足2NF', N'关系STJ满足2NF，但不满足3NF', N'关系STJ满足3NF，但不满足BCNF', N'关系STJ满足BCNF，但不满足4NF', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.350' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(214 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(39 AS Numeric(18, 0)), N'关系运算中花费时间可能最长的运算是（）', N'投影', N'选择', N'选择', N'笛卡尔积', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.363' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(215 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(39 AS Numeric(18, 0)), N'如果两个实体之间的联系是m：n，则引入第三个交叉关系。', N'.需要', N'不需要', N'不需要', N'可有可无', N'AC', N'多选题', NULL, CAST(N'2018-07-08 19:54:32.377' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(216 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(17 AS Numeric(18, 0)), N'设关系模式R(ABC)上成立的函数依赖集F为{B→C,C→A},r={AB,AC}为R的一个分解，那么分解r。', N'保持函数依赖', N'丢失了B→C', N'丢失了C→A', N'是否保持函数依赖由R的当前值确定', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.390' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(217 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(39 AS Numeric(18, 0)), N'设有属性A，B，C，D，以下表示中不是关系的是（）', N'R（A）', N'R（A，B，C，D）', N'R（A，B，C，D）', N'R（AxBxCxD’）', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.407' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(218 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(17 AS Numeric(18, 0)), N'下列规则中正确的是    。', N'若X→Y，WY→Z,则WX→Z', N'若XíY,则X→Y', N'若XY→Z，则X→Z,Y→Z', N'若X?Y=f,则X→Y', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.417' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(219 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(17 AS Numeric(18, 0)), N'以下叙述正确的是    。', N'函数依赖X→Y的特效性仅决定于两属性集的值；而多值依赖X→→Y的有效性与属性集的范围有关', N'函数依赖X→Y与多值依赖X→→Y的有效性都决定于两属性集的值', N'多值依赖X→→Y若在R（U）上成立，则对任何Y’ìY都有X→→Y’成立', N'对于函数依赖X→Y在R上成立，不能断言对任何Y’ìY均有X→Y’成立', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.447' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(220 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(41 AS Numeric(18, 0)), N'数据库三级结构从内到外的三个层次为', N'外模式、模式、内模式', N'内模式、模式、外模式', N'内模式、模式、外模式', N'模式、外模式、内模式', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.463' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(221 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(43 AS Numeric(18, 0)), N'规范化理论是关系数据库中进行逻辑设计的理论依据。根据这个理论，关系数据库中的关系必须满足：其每一属性都是    。', N'互不相关的', N'不可分解的', N'长度可变的', N'互相关联的', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.480' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(222 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(43 AS Numeric(18, 0)), N'设计性能较优的关系模式称为规范化，规范化主要的理论依据是    。', N'关系规范化理论', N'关系运算理论', N'系代数理论', N'数理逻辑', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.497' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(223 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(43 AS Numeric(18, 0)), N'数据库需求分析时，数据字典的含义是', N'数据库中所涉及的属性和文件的名称集合', N'数据库中所涉及到字母，字符及汉字的集合', N'数据库中所涉及到字母，字符及汉字的集合', N'数据库中所有数据的集合', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.510' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(224 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(43 AS Numeric(18, 0)), N'下列不属于需求分析阶段工作的是', N'分析用户活动', N'分析用户活动', N'分析用户活动', N'建立数据字典', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.523' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(225 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(44 AS Numeric(18, 0)), N'候选码的属性可以有。', N'0个', N'1个', N'1个或多个', N'多个', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.537' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(226 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(44 AS Numeric(18, 0)), N'下列关于数据库系统的正确叙述是。', N'数据库系统减少了数据冗余', N'数据库系统避免了一切兀余', N'数据库系统避免了一切兀余', N'数据库系统中数据的一致性是指数据类型一致', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.550' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(227 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(44 AS Numeric(18, 0)), N'在数据库设计中，用E-R图来描述信息结构但不涉及信息在计算机中的表示，它属于数据库设计的&nbsp;&nbsp; 阶段。', N'需求分析', N'概念设计', N'概念设计', N'逻辑设计', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.560' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(228 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(45 AS Numeric(18, 0)), N'两个关系在没有公共属性时，其自然连接操作表现为（）', N'结果为空操作', N'笛卡尔积操作', N'笛卡尔积操作', N'等值连接操作', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.573' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(229 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(45 AS Numeric(18, 0)), N'若D1={a1，a2，a3}，D2={1,2,3}，则D1xD2集合中共有元组（）个', N'6', N'8', N'8', N'9', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.587' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(230 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(45 AS Numeric(18, 0)), N'下列不属于概念结构设计时常用的数据抽象方法的是&nbsp;', N'合并', N'聚集', N'聚集', N'概括', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.600' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(231 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(45 AS Numeric(18, 0)), N'下列不属于数据库物理设计阶段应考虑的问题是&nbsp;&nbsp;&nbsp;&nbsp;', N'概念模型', N'存取方法', N'存取方法', N'处理要求', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.617' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(232 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(46 AS Numeric(18, 0)), N'SQL 语言是的语言，易学习。', N'过程化', N'非过程化', N'非过程化', N'格式化', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.633' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(233 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(46 AS Numeric(18, 0)), N'SQL 语言是语言', N'层次数据库', N'网络数据库', N'网络数据库', N'关系数据库', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.647' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(234 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(46 AS Numeric(18, 0)), N'SQL语言具有的功能。', N'关系规范化，数据操纵，数据控制', N'数据定义，数据操纵，数据控制', N'数据定义，数据操纵，数据控制', N'数据定义，关系规范化，数据控制', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.657' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(235 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(46 AS Numeric(18, 0)), N'SQL语言具有两种使用方式，分别称为交互式SQL和', N'提示式SQL', N'多用户SQL', N'多用户SQL', N'嵌入式SQL', N'BC', N'多选题', NULL, CAST(N'2018-07-08 19:54:32.670' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(236 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'对关系模型叙述错误的是（）', N'建立在严格的数学理论、集合论和谓词演算公式基础之一', N'微机DBMS绝大部分采取关系数据模型', N'微机DBMS绝大部分采取关系数据模型', N'用二维表表示关系模型是其一大特点', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.697' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(237 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'根据关系数据库规范化理论，关系数据库中的关系要满足第一范式。下面部门关系中，因哪个属性而使它不满足第一范式？', N'部门总经理', N'部门成员', N'部门名', N'部门号', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.710' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(238 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'关系模式R分解成r={R1，R2，...,RK},那么对R中每个关系r与其投影连接表达式mr(r)间关系是    。', N'rímr(r)', N'mr(r)ír', N'r=mr(r)', N'r1mr(r)', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.720' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(239 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'关系模式的分解。', N'唯一', N'不唯一', N'不唯一', N'不确定', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.747' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(240 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'关系数据库在的码是指（）', N'能决定唯一关系的字段', N'不可改动的专用保留字', N'不可改动的专用保留字', N'关键的很重要的字段', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.763' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(241 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'设有关系W（工号，姓名，工种，定额），将其规范化到第三范式正确的答案是    。', N'W1（工号，姓名） W2（工种，定额）', N'B.W1（工号，工种，定额）W2（工号，姓名）', N'W1（工号，姓名，工种）W2（工种，定额）', N'以上都不对', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.777' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(206 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), CAST(37 AS Numeric(18, 0)), N'关系模式中，满足2NF的模式。', N'可能是1NF', N'必定是1NF', N'必定是3NF', N'必定是BCNF', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.243' AS DateTime), 2, CAST(12 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(242 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'数据字典中未保存下列信息。', N'模式和子模式', N'存储模式', N'存储模式', N'文件存储权限', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.790' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(243 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'在通常情况下，下面的关系中不可以作为关系数据库的关系是（）', N'R1（学生号，学生名，性别）', N'R2（学生号，学生名，班级号）', N'R2（学生号，学生名，班级号）', N'R3（学生号，学生名，宿舍号）', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.803' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(244 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), N'SQL 语言中，实现数据检索的语句是。', N'INSERT', N'SELECT', N'SELECT', N'UPDATE', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.817' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(245 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), N'SQL中，与NOT IN等价的操作符是。', N'=SOME', N'<>SOME', N'<>SOME', N'=ALL', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.827' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(246 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), N'若两个实体之间的联系是1：m，则实现1：m联系的方法是。', N'.在m端实体转换的关系中加入1端实体转换关系的码', N'将m端实体转换关系的码加入到1端的关系中', N'将m端实体转换关系的码加入到1端的关系中', N'在两个实体转换的关系中，分别加入另一个关系的码', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.843' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(247 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), N'下列SQL语句中，修改表结构的是。', N'ALTER', N'CREATE', N'CREATE', N'UPDATE', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.853' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(248 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), CAST(3 AS Numeric(18, 0)), N'在通常情况下，下面的关系中不可以作为关系数据库的关系是（）', N'R1（学生号，学生名，性别）', N'R2（学生号，学生名，班级号）', N'R2（学生号，学生名，班级号）', N'R3（学生号，学生名，宿舍号）', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.867' AS DateTime), 2, CAST(11 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(249 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(47 AS Numeric(18, 0)), N'若关系R的候选码都是由单属性构成的，则R的最高范式必定是    。', N'1NF', N'2NF', N'3NF', N'无法确定', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.893' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(250 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(47 AS Numeric(18, 0)), N'下列有关范式的叙述中正确的是。', N'如果关系模式R?1NF,且R中主属姓完全函数依赖于码，则R是2NF', N'如果关系视式R?3NF,X,YíU,考X→Y, 则R是BCNF', N'如果关系模式R?BCNF，若X→→Y(Y?X)是平凡的多值依赖，则R是4NF', N'一个关系模式如果属于4NF，则一定属于BCNF，反之不成立', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.907' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(251 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(48 AS Numeric(18, 0)), N'关系数据库管理系统应该能实现的专门关系运算包括（）', N'排序、索引、统计', N'选择、投影、连接', N'选择、投影、连接', N'关联、更新、排序', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.917' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(252 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(48 AS Numeric(18, 0)), N'数据库物理设计完成后，进入数据库实施阶段，下列各项中不属于实施阶段的工作是 。', N'建立数据库', N'扩充功能', N'扩充功能', N'加载数据', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.933' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(253 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(48 AS Numeric(18, 0)), N'数据模型用来表示实体间的联系，但不同的数据库管理系统支持不同的数据模型。在常用的数据模型中，不包括.', N'网状模型', N'链状模型', N'链状模型', N'层次模型', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.947' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(254 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(48 AS Numeric(18, 0)), N'通过指针链接来表示和实现实体之间联系的模型是.', N'关系模型', N'层次模型', N'层次模型', N'网状模型', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.963' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(255 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(48 AS Numeric(18, 0)), N'一个关系数据库文件中的各条记录（）', N'前后顺序不能任意颠倒，一定要按照输入的顺序排列', N'前后顺序可以任意颠倒，不影响库中的数据关系', N'前后顺序可以任意颠倒，不影响库中的数据关系', N'前后顺序可以任意颠倒，但排列顺序不同，统计处理的结果就可能不同', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.977' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(256 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(50 AS Numeric(18, 0)), N'当B属性函数依赖于A属性时，属性A与B的联系是。', N'一对多', N'多对1', N'多对多', N'以上都不是', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:32.993' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(257 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(50 AS Numeric(18, 0)), N'当局部E-R图合并成全局E-R图时可能出现冲突，不属于合并冲突的是&nbsp;', N'属性冲突', N'语法冲突', N'语法冲突', N'结构冲突', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.007' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(258 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(50 AS Numeric(18, 0)), N'关系模式R中的属性全部是主属性，则R的最高范式必定是。', N'2NF', N'3NF', N'BCNF', N'4NF', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.020' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(259 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(50 AS Numeric(18, 0)), N'关系模式的候选码可以有  ①   ，主码有   ②   。', N'0个', N'1个', N'1个或多个', N'多个', N'BCD', N'多选题', NULL, CAST(N'2018-07-08 19:54:33.033' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(260 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(50 AS Numeric(18, 0)), N'关系模式的任何属性（）', N'不可再分', N'可再分', N'可再分', N'命名在该关系模式中可以不唯一', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.047' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(261 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(50 AS Numeric(18, 0)), N'假设关系模式R(A,B)属于3NF，下列说法中是正确的。', N'它一定消除了插入和删除异常', N'仍存在一定的插入和删除异常', N'一定属于BCNF', N'A和C都是', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.060' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(262 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(50 AS Numeric(18, 0)), N'下列叙述中正确的是。', N'若X→→Y,其中Z=U-X-Y=f,则称X→→Y为平凡的多值依赖', N'若X→Y，其中Z=U-X-Y=f，则称X→Y为函数的依赖', N'对于函数依赖（A1，A2,...,An）→B来说，如果B是A中的某一个，则称为非平凡函数依赖', N'对于函数依赖（A1，A2，...,An）→B来说，如果B是A中的某一个，则称为平凡函数依赖', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.070' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(263 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(50 AS Numeric(18, 0)), N'消除了部分函数依赖的1NF的关系模式必定是。', N'1NF', N'2NF', N'3NF', N'4NF', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.083' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(264 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(50 AS Numeric(18, 0)), N'在关系模式中，如果属性A和B存在1对1的联系，则说    。', N'A→B', N'B→A', N'A←→B', N'以上都不是', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.097' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(265 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(52 AS Numeric(18, 0)), N'从E-R图导出关系模式时，如果两实体间的联系m：n，下列说法正确的是。', N'将m方码和联系的属性纳入n方的属性中', N'将n方码和联系的属性纳入m方的属性中', N'将n方码和联系的属性纳入m方的属性中', N'在m方属性和n方属性中均增加一个表示级别的属性', N'D', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.107' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(266 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(52 AS Numeric(18, 0)), N'若两个实体之间的联系是1：m，则实现1：m联系的方法是。<br/>', N'在m端实体转换的关系中加入1端实体转换关系的码', N'B.将m端实体转换关系的码加入到1端的关系中', N'B.将m端实体转换关系的码加入到1端的关系中', N'在两个实体转换的关系中，分别加入另一个关系的码', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.123' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(267 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(52 AS Numeric(18, 0)), N'数据流图（DFD）是用于描述结构化方法中阶段的工具', N'可行性描述', N'详细设计', N'详细设计', N'需求分析', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.140' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
GO
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(268 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(53 AS Numeric(18, 0)), N'根据关系模式的完整性规则，一个关系中的主码（）', N'不能有两个', N'不能成为另一个关系的主码', N'不能成为另一个关系的主码', N'不允许为空', N'CD', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.153' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(269 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(53 AS Numeric(18, 0)), N'在数据管理技术的发展过程中，经历了人工管理阶段、文件系统阶及和数据系统阶段。在这几个阶段中，数据独立性最高的是___阶段。', N'数据库系统', N'文件系统', N'文件系统', N'人工管理', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.167' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(270 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(55 AS Numeric(18, 0)), N'参加差运算的两个关系（）', N'属性个数可以不相同', N'属性个数必须相同', N'属性个数必须相同', N'一个关系包含另一个关系的属性', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.177' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(271 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(55 AS Numeric(18, 0)), N'从E-R图模型向关系模型转换时，一个m:n联系转换为关系模式时，该关系模式的码 。', N'm端实体的码', N'n端实体的码', N'n端实体的码', N'm端实体码与n端实体码的组合', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.190' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(272 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(55 AS Numeric(18, 0)), N'若关系R的候选码都是由单属性构成的，则R的最高范式必定是    。', N'1NF', N'2NF', N'3NF', N'无法确定', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.200' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(273 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(55 AS Numeric(18, 0)), N'有两个关系R和S，分别包含15个和10个元组，则在R∪S，R-S，R∩S中不可能出现的元组数目情况是（）', N'15，5，10', N'18，7，7', N'18，7，7', N'21，11，4', N'B', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.210' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(274 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(56 AS Numeric(18, 0)), N'关系模型中的关系模式至少是    。', N'1NF', N'2NF', N'3NF', N'BCNF', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.220' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(275 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(56 AS Numeric(18, 0)), N'关系数据库规格化是为解决关系数据库中问题而引人的。', N'插入异常、删除异常和数据冗余', N'提高查询速度', N'减少数据操作的复杂性', N'保证数据的安全性和完整性', N'A', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.230' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(276 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(56 AS Numeric(18, 0)), N'规范化过程主要为克服数据库逻辑结构中的插入异常、删除异常以及的缺陷。', N'数据的不一致性', N'结构不合理', N'冗余度大', N'数据丢失', N'C', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.243' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
INSERT [dbo].[Topic] ([TopicId], [SortId], [SecondPointId], [TopicTitle], [OptionA], [OptionB], [OptionC], [OptionD], [TitleAnswer], [TopicType], [NumberOfUse], [TopicCreateDate], [TopicState], [TopicSourceId]) VALUES (CAST(277 AS Numeric(18, 0)), CAST(7 AS Numeric(18, 0)), CAST(56 AS Numeric(18, 0)), N'在关系DB中，任何二元关系模式的最高范式必定是。', N'1NF', N'2NF', N'3NF', N'BCNF', N'BD', N'单选题', NULL, CAST(N'2018-07-08 19:54:33.253' AS DateTime), 2, CAST(13 AS Numeric(18, 0)))
SET IDENTITY_INSERT [dbo].[Topic] OFF
SET IDENTITY_INSERT [dbo].[TopicSource] ON 

INSERT [dbo].[TopicSource] ([TopicSourceId], [TopicSourceName], [IsChose]) VALUES (11, N'通用题库', 1)
INSERT [dbo].[TopicSource] ([TopicSourceId], [TopicSourceName], [IsChose]) VALUES (12, N'试题库', 1)
INSERT [dbo].[TopicSource] ([TopicSourceId], [TopicSourceName], [IsChose]) VALUES (13, N'习题库', 1)
SET IDENTITY_INSERT [dbo].[TopicSource] OFF
/****** Object:  Index [PK_AUTHORITY]    Script Date: 2018/7/8 20:11:20 ******/
ALTER TABLE [dbo].[Authority] ADD  CONSTRAINT [PK_AUTHORITY] PRIMARY KEY NONCLUSTERED 
(
	[AuthorityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_CLASS]    Script Date: 2018/7/8 20:11:20 ******/
ALTER TABLE [dbo].[Class] ADD  CONSTRAINT [PK_CLASS] PRIMARY KEY NONCLUSTERED 
(
	[ClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_EXAM]    Script Date: 2018/7/8 20:11:20 ******/
ALTER TABLE [dbo].[Exam] ADD  CONSTRAINT [PK_EXAM] PRIMARY KEY NONCLUSTERED 
(
	[ExamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [一次考试有多场考试_FK]    Script Date: 2018/7/8 20:11:20 ******/
CREATE NONCLUSTERED INDEX [一次考试有多场考试_FK] ON [dbo].[Exam]
(
	[TheExamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_FIRSTPOINT]    Script Date: 2018/7/8 20:11:20 ******/
ALTER TABLE [dbo].[FirstPoint] ADD  CONSTRAINT [PK_FIRSTPOINT] PRIMARY KEY NONCLUSTERED 
(
	[FirstPointId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_PAPER]    Script Date: 2018/7/8 20:11:20 ******/
ALTER TABLE [dbo].[Paper] ADD  CONSTRAINT [PK_PAPER] PRIMARY KEY NONCLUSTERED 
(
	[PaperId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [一场考试多份试卷_FK]    Script Date: 2018/7/8 20:11:20 ******/
CREATE NONCLUSTERED INDEX [一场考试多份试卷_FK] ON [dbo].[Paper]
(
	[ExamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PaperDetail_FK]    Script Date: 2018/7/8 20:11:20 ******/
CREATE NONCLUSTERED INDEX [PaperDetail_FK] ON [dbo].[PaperDetail]
(
	[TopicId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PaperDetail2_FK]    Script Date: 2018/7/8 20:11:20 ******/
CREATE NONCLUSTERED INDEX [PaperDetail2_FK] ON [dbo].[PaperDetail]
(
	[PaperId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_POINT]    Script Date: 2018/7/8 20:11:20 ******/
ALTER TABLE [dbo].[SecondPoint] ADD  CONSTRAINT [PK_POINT] PRIMARY KEY NONCLUSTERED 
(
	[SecondPointId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Relationship_5_FK]    Script Date: 2018/7/8 20:11:20 ******/
CREATE NONCLUSTERED INDEX [Relationship_5_FK] ON [dbo].[SecondPoint]
(
	[FIrstPointId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_SORT]    Script Date: 2018/7/8 20:11:20 ******/
ALTER TABLE [dbo].[Sort] ADD  CONSTRAINT [PK_SORT] PRIMARY KEY NONCLUSTERED 
(
	[SortId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PK_STUDENT]    Script Date: 2018/7/8 20:11:20 ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [PK_STUDENT] PRIMARY KEY NONCLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [StuExam_FK]    Script Date: 2018/7/8 20:11:20 ******/
CREATE NONCLUSTERED INDEX [StuExam_FK] ON [dbo].[StuExam]
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [StuExam2_FK]    Script Date: 2018/7/8 20:11:20 ******/
CREATE NONCLUSTERED INDEX [StuExam2_FK] ON [dbo].[StuExam]
(
	[PaperId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [StuExam3_FK]    Script Date: 2018/7/8 20:11:20 ******/
CREATE NONCLUSTERED INDEX [StuExam3_FK] ON [dbo].[StuExam]
(
	[TId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [StuPaper_FK]    Script Date: 2018/7/8 20:11:20 ******/
CREATE NONCLUSTERED INDEX [StuPaper_FK] ON [dbo].[StuPaper]
(
	[TopicId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [StuPaper2_FK]    Script Date: 2018/7/8 20:11:20 ******/
CREATE NONCLUSTERED INDEX [StuPaper2_FK] ON [dbo].[StuPaper]
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [TeaAuthority_FK]    Script Date: 2018/7/8 20:11:20 ******/
CREATE NONCLUSTERED INDEX [TeaAuthority_FK] ON [dbo].[TeaAuthority]
(
	[TId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [TeaAuthority2_FK]    Script Date: 2018/7/8 20:11:20 ******/
CREATE NONCLUSTERED INDEX [TeaAuthority2_FK] ON [dbo].[TeaAuthority]
(
	[AuthorityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PK_TEACHER]    Script Date: 2018/7/8 20:11:20 ******/
ALTER TABLE [dbo].[Teacher] ADD  CONSTRAINT [PK_TEACHER] PRIMARY KEY NONCLUSTERED 
(
	[TId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_THEEXAM]    Script Date: 2018/7/8 20:11:20 ******/
ALTER TABLE [dbo].[TheExam] ADD  CONSTRAINT [PK_THEEXAM] PRIMARY KEY NONCLUSTERED 
(
	[TheExamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_TOPIC]    Script Date: 2018/7/8 20:11:20 ******/
ALTER TABLE [dbo].[Topic] ADD  CONSTRAINT [PK_TOPIC] PRIMARY KEY NONCLUSTERED 
(
	[TopicId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Relationship_7_FK]    Script Date: 2018/7/8 20:11:20 ******/
CREATE NONCLUSTERED INDEX [Relationship_7_FK] ON [dbo].[Topic]
(
	[SecondPointId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Relationship_8_FK]    Script Date: 2018/7/8 20:11:20 ******/
CREATE NONCLUSTERED INDEX [Relationship_8_FK] ON [dbo].[Topic]
(
	[SortId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Invigilate]  WITH CHECK ADD FOREIGN KEY([ExamId])
REFERENCES [dbo].[Exam] ([ExamId])
GO
ALTER TABLE [dbo].[Invigilate]  WITH CHECK ADD FOREIGN KEY([TId])
REFERENCES [dbo].[Teacher] ([TId])
GO
ALTER TABLE [dbo].[StuPaper]  WITH CHECK ADD  CONSTRAINT [a_fk] FOREIGN KEY([ExamId])
REFERENCES [dbo].[Exam] ([ExamId])
GO
ALTER TABLE [dbo].[StuPaper] CHECK CONSTRAINT [a_fk]
GO
ALTER TABLE [dbo].[StuPaper]  WITH CHECK ADD  CONSTRAINT [examId_notNull] CHECK  (([ExamId] IS NOT NULL))
GO
ALTER TABLE [dbo].[StuPaper] CHECK CONSTRAINT [examId_notNull]
GO
/****** Object:  StoredProcedure [dbo].[proc_getAuthority]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[proc_getAuthority]  --获取教师权限
@Tid varchar(30)
as
	select * from Authority,TeaAuthority 
	where Authority.AuthorityId = TeaAuthority.AuthorityId 
	and TeaAuthority.TId = @Tid order by orderNo

GO
/****** Object:  StoredProcedure [dbo].[proc_getTeacherInfo]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[proc_getTeacherInfo] --获取教师信息
@Tid varchar(30)
as
	select * from Teacher where @Tid=Tid;

GO
/****** Object:  StoredProcedure [dbo].[proc_LogIn]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_LogIn]  --验证登陆
@uId varchar(30),
@pwd varchar(50),
@res int output
as
	if exists (select 1 from Teacher where TID=@uId)
	begin
		if exists (select 1 from Teacher where TID=@uId and TPwd=@pwd)
			set @res = 0;
		else
			set @res = 2;
	end
	else
		set @res=1;


GO
/****** Object:  StoredProcedure [dbo].[proc_ResetTeacherPwd]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[proc_ResetTeacherPwd]
(
@TPWd varchar(50),
 
@TId varchar(50)
)
as
begin
update Teacher
set   TPwd =@TPWd
	where TId=@TId
end

GO
/****** Object:  StoredProcedure [dbo].[proc_selectExistTeaByTId]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[proc_selectExistTeaByTId]
 (
 @TId varchar(50)
 )
 as 
 begin 
 declare  @temp int
 select @temp=count(*)from  Teacher where TId=@TId   
 end
 return @temp

GO
/****** Object:  StoredProcedure [dbo].[Proc_SellectAllTeacher]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Proc_SellectAllTeacher]
as
begin
select *from Teacher order by TeacherState desc, TId
end

GO
/****** Object:  StoredProcedure [dbo].[Proc_SellectTeacherInfoByTId]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create  proc  [dbo].[Proc_SellectTeacherInfoByTId]
(
@TId varchar(50)
)
as if exists(select *from Teacher where TId=@TId)
 begin 
  select *from Teacher where TId =@TId
  end

GO
/****** Object:  StoredProcedure [dbo].[proc_UpdateTeacherById]    Script Date: 2018/7/8 20:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[proc_UpdateTeacherById]
(
@TName varchar(20),
@TPhone Varchar(20),
@TId varchar(50)
)
as
begin
update Teacher
set TName =@TName,
    TPhone =@TPhone
	where TId=@TId
end

GO
USE [master]
GO
ALTER DATABASE [NewExam] SET  READ_WRITE 
GO
