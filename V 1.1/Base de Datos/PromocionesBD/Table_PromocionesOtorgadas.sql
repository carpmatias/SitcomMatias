USE [Sitcom_Test2]
GO

/****** Object:  Table [dbo].[PromocionesOtorgadas]    Script Date: 03/01/2018 20:11:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PromocionesOtorgadas](
	[idPromocion] [int] NOT NULL,
	[idUsuario] [int] NULL,
	[fechaOtorgamiento] [datetime] NULL,
	[fechaVencimiento] [datetime] NULL,
	[codigo] [nvarchar](8) NOT NULL,
	[utilizada] [int] NULL,
 CONSTRAINT [PK_PromocionesOtorgadas] PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[PromocionesOtorgadas]  WITH CHECK ADD  CONSTRAINT [FK_PromocionesOtorgadas_Promociones] FOREIGN KEY([idPromocion])
REFERENCES [dbo].[Promociones] ([idPromocion])
GO

ALTER TABLE [dbo].[PromocionesOtorgadas] CHECK CONSTRAINT [FK_PromocionesOtorgadas_Promociones]
GO

ALTER TABLE [dbo].[PromocionesOtorgadas]  WITH CHECK ADD  CONSTRAINT [FK_PromocionesOtorgadas_Usuarios] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO

ALTER TABLE [dbo].[PromocionesOtorgadas] CHECK CONSTRAINT [FK_PromocionesOtorgadas_Usuarios]
GO

