USE [Sitcom_Test2]
GO
/****** Object:  StoredProcedure [dbo].[getUltimaPromocionOtorgada]    Script Date: 03/01/2018 20:07:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[getUltimaPromocionOtorgada]
	@idUsuario INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT TOP 1 ng.nombre as "NEGOCIO", p.titulo + ' - ' + p.descripcion as "PROMOCION",
		   pro.fechaOtorgamiento as "OBTENIDA", pro.fechaVencimiento as "VENCE", pro.codigo as "CODIGO", 
		   CASE
			  WHEN pro.utilizada = 0 AND GETDATE() < pro.fechaVencimiento THEN 'DISPONIBLE'
			  WHEN pro.utilizada = 1 THEN 'UTILIZADA'
			  WHEN pro.utilizada = 0 AND GETDATE() >= pro.fechaVencimiento THEN 'VENCIDA'
		   END as "ESTADO"
	FROM dbo.PromocionesOtorgadas pro, dbo.Promociones p, dbo.Negocio ng
	WHERE pro.idPromocion=p.idPromocion
	AND p.idNegocio=ng.idNegocio
	AND pro.idUsuario=@idUsuario
	ORDER BY pro.fechaOtorgamiento DESC;

END
