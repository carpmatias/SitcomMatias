USE [Sitcom_Test2]
GO

/****** Object:  Table [dbo].[Negocio]    Script Date: 03/01/2018 20:13:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Negocio](
	[idNegocio] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](300) NULL,
	[descripcion] [varchar](500) NULL,
	[fechaAlta] [datetime] NULL,
	[idTipoNegocio] [int] NULL,
	[idUsuario] [int] NULL,
	[estaAprobado] [bit] NULL,
	[idNegocioModif] [int] NULL,
	[estaAnulado] [bit] NULL,
 CONSTRAINT [PK_Negocio] PRIMARY KEY CLUSTERED 
(
	[idNegocio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Negocio]  WITH CHECK ADD  CONSTRAINT [FK_Negocio_Negocio] FOREIGN KEY([idNegocioModif])
REFERENCES [dbo].[Negocio] ([idNegocio])
GO

ALTER TABLE [dbo].[Negocio] CHECK CONSTRAINT [FK_Negocio_Negocio]
GO

ALTER TABLE [dbo].[Negocio]  WITH CHECK ADD  CONSTRAINT [FK_Negocio_TipoDeNegocio] FOREIGN KEY([idTipoNegocio])
REFERENCES [dbo].[TipoDeNegocio] ([idTipoNegocio])
GO

ALTER TABLE [dbo].[Negocio] CHECK CONSTRAINT [FK_Negocio_TipoDeNegocio]
GO

ALTER TABLE [dbo].[Negocio]  WITH CHECK ADD  CONSTRAINT [FK_Negocio_Usuario] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO

ALTER TABLE [dbo].[Negocio] CHECK CONSTRAINT [FK_Negocio_Usuario]
GO

