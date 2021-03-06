USE [Sitcom_Test2]
GO
/****** Object:  StoredProcedure [dbo].[otorgarPromocion]    Script Date: 03/01/2018 20:07:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[otorgarPromocion]
	@idPromocion INT,
	@idUsuario INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE
		@fechaVenc DATE,
		@codigo VARCHAR(8),
		@cantPromosUser INT,
		@cantPromosNeg INT,
		@perfilUser INT,
		@cantCod INT,
		@cantOferMax INT,
		@errors INT

	SET @errors = 0;

	SET @cantCod = 1;

	SET @cantPromosUser = (SELECT COUNT(*)
						   FROM dbo.PromocionesOtorgadas po
						   WHERE po.idUsuario = @idUsuario
						   AND GETDATE() < po.fechaVencimiento
						   AND po.utilizada = 0);

	IF @cantPromosUser >=3
	BEGIN
		SELECT 1;
		--'El usuario ya tiene el numero maximo de promociones otorgadas.';
		SET @errors = @errors + 1;
	END


	SET @cantPromosNeg = (SELECT COUNT(*)
	                     FROM dbo.PromocionesOtorgadas po, dbo.Promociones pro
						 WHERE po.idPromocion = pro.idPromocion						
						 AND po.idUsuario = @idUsuario
						 AND GETDATE() BETWEEN po.fechaOtorgamiento AND po.fechaVencimiento
						 AND po.utilizada = 0
						 AND pro.idNegocio = (SELECT pro_2.idNegocio
											  FROM dbo.Promociones pro_2
											  WHERE pro_2.idPromocion = @idPromocion));
						 
						       
	IF @cantPromosNeg >= 1
	BEGIN
		SELECT 2;
		--'El usuario YA posee una promoción vigente asociada a este negocio.';
		SET @errors = @errors + 1;
	END;	
	
	SET @perfilUser = (SELECT us.idPerfil
					  FROM dbo.Usuarios us
					  WHERE us.idUsuario = @idUsuario);
					  
	IF @perfilUser <> 1
	BEGIN
		SELECT 3;
		-- 'El usuario NO es un usuario turista.';
		SET @errors = @errors + 1;
	END;					    
	

	IF @errors = 0
	BEGIN

			--Calculo la fecha de vencimiento de la promocion que se otorga (fecha hasta el usuario podra hacer uso de la misma).
			SELECT @fechaVenc=GETDATE()+pr.diasBeneficio
			FROM dbo.Promociones pr
			WHERE pr.idPromocion=@idPromocion;

			--Obtengo el codigo alfanumerico unico que se asociara a la promocion.
			WHILE @cantCod > 0
			BEGIN
		
				EXEC dbo.obtenerCodigoProm @codigo output;
				PRINT(@codigo);


				SELECT @cantCod = COUNT(*)
				FROM dbo.PromocionesOtorgadas pro
				WHERE pro.codigo = @codigo;

			END

			INSERT INTO dbo.PromocionesOtorgadas(idPromocion,idUsuario,fechaOtorgamiento,fechaVencimiento,codigo,utilizada)
			VALUES(@idPromocion,@idUsuario,GETDATE(),@fechaVenc,@codigo,0);

			SET @cantOferMax = (SELECT prom.ofertaMaxima
								FROM Promociones prom
								WHERE prom.idPromocion = @idPromocion);

			SET @cantOferMax = @cantOferMax - 1;

			UPDATE Promociones
			SET ofertaMaxima = @cantOferMax
			WHERE idPromocion = @idPromocion;

			SELECT 0;

	END;

	

END
