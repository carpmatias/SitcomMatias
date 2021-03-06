USE [Sitcom_Test2]
GO
/****** Object:  StoredProcedure [dbo].[obtenerCodigoProm]    Script Date: 03/01/2018 20:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[obtenerCodigoProm]
	@codigo VARCHAR(8) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE 
		@r varchar(8)

	SELECT @r = coalesce(@r, '') + n
	FROM (SELECT top 8 
	CHAR(number) n FROM
	master..spt_values
	WHERE type = 'P' AND 
	(number between ascii(0) and ascii(9)
	or number between ascii('A') and ascii('Z')
	or number between ascii('a') and ascii('z'))
	ORDER BY newid()) a;

	SET @codigo = @r;

END
