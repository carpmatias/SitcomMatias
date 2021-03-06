USE [Sitcom_Test2]
GO
/****** Object:  StoredProcedure [dbo].[regUsoPromocion]    Script Date: 03/01/2018 20:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[regUsoPromocion]
	@codigo NVARCHAR(8)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE
		@utilizada INT,
		@vencida INT

	SELECT @utilizada = pro.utilizada, @vencida = CASE 
													 WHEN GETDATE() < pro.fechaVencimiento THEN 0
													 WHEN GETDATE() >= pro.fechaVencimiento THEN 1
												  END
	FROM dbo.PromocionesOtorgadas pro
	WHERE pro.codigo = @codigo;

	IF @utilizada = 1 OR @vencida = 1
	BEGIN
		--Promocion vencida o ya utilizada.
		SELECT 1;
	END


	UPDATE dbo.PromocionesOtorgadas
	SET utilizada = 1
	WHERE codigo = @codigo;
		
	SELECT 0;


END
