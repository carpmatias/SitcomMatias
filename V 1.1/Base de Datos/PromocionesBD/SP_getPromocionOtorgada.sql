USE [Sitcom_Test2]
GO
/****** Object:  StoredProcedure [dbo].[getPromocionOtorgada]    Script Date: 03/01/2018 20:06:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getPromocionOtorgada]
	@codigo NVARCHAR(8)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT ng.nombre as "NEGOCIO", p.titulo + ' - ' + p.descripcion as "PROMOCION",
		   pro.fechaOtorgamiento as "OBTENIDA", pro.fechaVencimiento as "VENCE", 
		   CASE
			  WHEN pro.utilizada = 0 AND GETDATE() < pro.fechaVencimiento THEN 'DISPONIBLE'
			  WHEN pro.utilizada = 1 THEN 'UTILIZADA'
			  WHEN pro.utilizada = 0 AND GETDATE() >= pro.fechaVencimiento THEN 'VENCIDA'
		   END as "ESTADO", pro.codigo as "CODIGO", pro.idUsuario as "USUARIO"
	FROM dbo.PromocionesOtorgadas pro, dbo.Promociones p, dbo.Negocio ng
	WHERE pro.idPromocion=p.idPromocion
	AND p.idNegocio=ng.idNegocio
	AND pro.codigo=@codigo;

END
