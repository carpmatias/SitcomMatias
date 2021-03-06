USE [Sitcom_Test2]
GO
/****** Object:  StoredProcedure [dbo].[updatePromociones]    Script Date: 03/01/2018 20:08:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updatePromociones] 
	@idPromocion INT,
	@fechaVencimiento DATE,
	@titulo VARCHAR(50),
	@descripcion VARCHAR(750),
	@diasBeneficio INT 
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF CAST(@fechaVencimiento AS DATETIME) - GETDATE() > 180
	BEGIN
		--La fecha de vencimiento supera los 180 dias.
		RETURN 'La fecha de vencimiento de la promoción supera los 180 días.';
	END


	IF @diasBeneficio > 90
	BEGIN
		--Los dias de beneficio superan los 90 dias.
		RETURN 'Los días de beneficio de la promoción superan los 90 días.';
	END

   UPDATE dbo.Promociones
	SET fechaVencimiento=@fechaVencimiento,
		titulo=@titulo,
		descripcion=@descripcion,
		diasBeneficio=@diasBeneficio
	WHERE idPromocion=@idPromocion;

END
