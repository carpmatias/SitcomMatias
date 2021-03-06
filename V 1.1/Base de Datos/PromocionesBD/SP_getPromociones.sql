USE [Sitcom_Test2]
GO
/****** Object:  StoredProcedure [dbo].[getPromociones]    Script Date: 03/01/2018 20:03:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getPromociones] 
	@idNegocio INT,
	@esTurista INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


   IF @esTurista = 0
	   BEGIN
		   SELECT pr.idPromocion,ng.nombre AS "NEGOCIO", pr.titulo + ' - ' + pr.descripcion AS "PROMOCION", pr.fechaAlta AS "FECHA_ALTA", pr.ofertaMaxima AS "CANT_DISP",
				  pr.fechaVencimiento AS "VENCE", pr.diasBeneficio AS "DIAS_BENEFICIO", CASE
										   													 WHEN GETDATE() < pr.fechaVencimiento AND pr.ofertaMaxima > 0 THEN 'VIGENTE'
																							 WHEN GETDATE() >= pr.fechaVencimiento THEN 'VENCIDA'
																							 WHEN pr.ofertaMaxima = 0 THEN 'AGOTADA'
																						  END AS "ESTADO"
			FROM dbo.Promociones pr, dbo.Negocio ng
			WHERE pr.idNegocio=ng.idNegocio
			AND pr.idNegocio=@idNegocio;
		END;
	ELSE
	    BEGIN
		   SELECT pr.idPromocion,ng.nombre AS "NEGOCIO", pr.titulo + ' - ' + pr.descripcion AS "PROMOCION", pr.fechaAlta AS "FECHA_ALTA",
				  pr.fechaVencimiento AS "VENCE", pr.diasBeneficio AS "DIAS_BENEFICIO"
			FROM dbo.Promociones pr, dbo.Negocio ng
			WHERE pr.idNegocio=ng.idNegocio
			AND GETDATE() BETWEEN pr.fechaAlta AND pr.fechaVencimiento
			AND pr.idNegocio=@idNegocio
			AND pr.ofertaMaxima > 0;
		END;

END
