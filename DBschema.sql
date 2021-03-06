SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[RoundTime] (@Time datetime, @RoundTo float) RETURNS datetime
AS
BEGIN
    DECLARE @RoundedTime smalldatetime, @Multiplier float

    SET @Multiplier = 24.0 / @RoundTo

    SET @RoundedTime= ROUND(CAST(CAST(CONVERT(varchar, @Time, 121) AS datetime) AS float) * @Multiplier, 0) / @Multiplier

    RETURN @RoundedTime
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function [dbo].[RoundTimeMin]
(
	@DT datetime,
	@TimeInterval int
) returns datetime
as
begin 
return dateadd(minute, datediff(minute, '1900-01-01', dateadd(second, 150, @DT))/@TimeInterval*@TimeInterval, 0)
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PerfmonImport](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ServerName] [varchar](50) NULL,
	[DateTimeStamp] [datetime] NULL,
	[CounterSet] [nvarchar](200) NULL,
	[CounterName] [nvarchar](200) NULL,
	[CounterInstance] [nvarchar](200) NULL,
	[CounterValue] [float] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PerfmonImportStage](
	[ServerName] [varchar](50) NULL,
	[DateTimeStamp] [datetime] NULL,
	[CounterSet] [nvarchar](200) NULL,
	[CounterName] [nvarchar](200) NULL,
	[CounterInstance] [nvarchar](200) NULL,
	[CounterValue] [float] NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED COLUMNSTORE INDEX [cci_PerfmonImport] ON [dbo].[PerfmonImport] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY]
GO
