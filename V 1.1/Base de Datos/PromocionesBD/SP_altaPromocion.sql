USE [Sitcom_Test2]
GO
/****** Object:  StoredProcedure [dbo].[altaPromocion]    Script Date: 03/01/2018 19:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[altaPromocion]
	-- Add the parameters for the stored procedure here
	@idNegocio INT,
	@fechaVencimiento DATE,
	@titulo VARCHAR(50),
	@descripcion VARCHAR(750),
	@diasBeneficio INT,
	@ofertaMaxima INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE
	@cantPromocionesVig INT,
	@errors INT;

	SET @errors = 0;

	SET @cantPromocionesVig = (SELECT COUNT(*)
							   FROM dbo.Promociones pr
							   WHERE pr.idNegocio=@idNegocio
							   AND GETDATE() BETWEEN pr.fechaAlta AND pr.fechaVencimiento);

	IF @cantPromocionesVig >= 3
	BEGIN
		--El negocio ya registro la cantidad maxima de promociones vigentes.		
		SELECT 1;

		SET @errors = @errors + 1;
	END	
	
	IF CAST(@fechaVencimiento AS DATETIME) - GETDATE() > 180
	BEGIN
		--La fecha de vencimiento supera los 180 dias.
		SELECT 2;
		SET @errors = @errors + 1;
	END


	IF @diasBeneficio > 90
	BEGIN
		--Los dias de beneficio superan los 90 dias.
		SELECT 3;
		SET @errors = @errors + 1;
	END

	IF @errors = 0 
	BEGIN
		INSERT INTO dbo.Promociones(idNegocio,fechaAlta,fechaVencimiento,titulo,descripcion,ofertaMaxima,diasBeneficio)
		VALUES (@idNegocio,GETDATE(),@fechaVencimiento,@titulo,@descripcion,@diasBeneficio,@ofertaMaxima);

		SELECT 0;
	END

END
