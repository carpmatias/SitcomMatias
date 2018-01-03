USE [Sitcom_Test2]
GO

/****** Object:  Table [dbo].[Promociones]    Script Date: 03/01/2018 20:11:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Promociones](
	[idPromocion] [int] IDENTITY(1,1) NOT NULL,
	[fechaAlta] [datetime] NULL,
	[fechaVencimiento] [datetime] NULL,
	[titulo] [nvarchar](100) NULL,
	[descripcion] [nvarchar](200) NULL,
	[diasBeneficio] [int] NULL,
	[idNegocio] [int] NULL,
	[ofertaMaxima] [int] NULL,
 CONSTRAINT [PK_Promociones] PRIMARY KEY CLUSTERED 
(
	[idPromocion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Promociones]  WITH CHECK ADD  CONSTRAINT [FK_Promociones_Negocio] FOREIGN KEY([idNegocio])
REFERENCES [dbo].[Negocio] ([idNegocio])
GO

ALTER TABLE [dbo].[Promociones] CHECK CONSTRAINT [FK_Promociones_Negocio]
GO

