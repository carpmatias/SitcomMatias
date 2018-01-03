USE [Sitcom_Test2]
GO
/****** Object:  StoredProcedure [dbo].[cancelPromociones]    Script Date: 03/01/2018 20:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[cancelPromociones] 
	@idPromocion INT
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE dbo.Promociones
	SET fechaVencimiento = GETDATE()-1
	WHERE idPromocion=@idPromocion;

	SELECT 0;


END
