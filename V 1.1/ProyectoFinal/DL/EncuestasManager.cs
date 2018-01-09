using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
using BussinesEntities;
using System.Data.SqlClient;

namespace BL
{
    public class EncuestasManager
    {
        private ConvertidorEntitiesToDAL convert = new ConvertidorEntitiesToDAL();
        public List<EncuestaEntityIndex> GetAllEncuestas()
        {
            using (SitcomEntities db = new SitcomEntities())
            {
                return db.Database.SqlQuery<EncuestaEntityIndex>("exec getEncuestas").ToList();
            }
        }

       //Para mostrar el listado de encuestas asignadas en el panel de control del usuario.
        public List<EncuestasAsignadas> GetEncuestasByUser(int? idUsuario)
        {
            using (var db = new SitcomEntities())
            {
                var result = (from en in db.EncuestasAsignadas
                              where en.idUsuario == idUsuario
                              select new EncuestasAsignadas()
                              {
                                  fechaAsignacion = en.fechaAsignacion,
                                  fechaRespuesta = en.fechaRespuesta,
                                  Encuestas = (from enc in db.Encuestas
                                               where enc.idEncuesta == en.idEncuesta
                                               select new Encuestas()
                                               {
                                                   nombre = enc.nombre,
                                                   TiposEncuesta = (from tien in db.TiposEncuesta
                                                                    where tien.idTipoEncuesta == enc.idTipoEncuesta
                                                                    select tien).FirstOrDefault()
                                               }).FirstOrDefault()
                              }).ToList();

                return result;
            }
        }

        public void AsignarEncuesta(int? idTipoEncuesta, int idUsuario, int? idNegocio, string checkOutDate)
        {
            using (SitcomEntities db = new SitcomEntities())
            {
                SqlParameter paramIdTipoEncuesta = new SqlParameter("@pIdTipoEncuesta", idTipoEncuesta);
                SqlParameter paramIdUsuario = new SqlParameter("@pIdUsuario", idUsuario);
                SqlParameter paramIdNegocio = new SqlParameter("@pIdNegocio", idNegocio);
                SqlParameter paramCheckOutDate = new SqlParameter("@pCheckOutDate", checkOutDate);

                int result = db.Database.SqlQuery<Int32>("asignarEncuesta @idTipoEncuesta=@pIdTipoEncuesta, @idUsuario=@pIdUsuario, @idNegocio=@pIdNegocio, @checkOutDate=@pCheckOutDate", paramIdTipoEncuesta, paramIdUsuario, paramIdNegocio, paramCheckOutDate).FirstOrDefault();
            }
        }
        
        public EncuestaEntity GetEncuestaById(int? id)
        {
            using(SitcomEntities db = new SitcomEntities())
            {
                var result = (from en in db.Encuestas
                              where en.idEncuesta == id
                              select new EncuestaEntity()
                              {
                                  idEncuesta = en.idEncuesta,
                                  nombre = en.nombre,
                                  descripcion = en.descripcion,
                                  idTipoEncuesta = en.idTipoEncuesta,
                                  fechaVencimiento = en.fechaVencimiento,
                                  TiposEncuesta = (from te in db.TiposEncuesta
                                                   where te.idTipoEncuesta == en.idTipoEncuesta
                                                   select te).FirstOrDefault()
                              }).FirstOrDefault();

                return result;
            }
        }
        
        public void CrearPregunta(PreguntasEntity preg)
        {     

            using(SitcomEntities db = new SitcomEntities())
            {
                SqlParameter paramIdEncuesta = new SqlParameter("@pIdEncuesta", preg.idEncuesta);
                SqlParameter paramIdClasifPregunta = new SqlParameter("@pIdClasifPregunta", preg.idClasifPregunta);
                SqlParameter paramIdTipoRespuesta = new SqlParameter("@pIdTipoRespuesta", preg.idTipoRespuesta);
                SqlParameter paramTextoPregunta = new SqlParameter("@pTextoPregunta", preg.textoPregunta);

                int result = db.Database.SqlQuery<Int32>("addPregunta @idEncuesta=@pIdEncuesta, @idClasifPregunta=@pIdClasifPregunta, @idTipoRespuesta=@pIdTipoRespuesta, @textoPregunta=@pTextoPregunta", paramIdEncuesta, paramIdClasifPregunta, paramIdTipoRespuesta, paramTextoPregunta).FirstOrDefault();
            }
        }

        public void EditEncuesta(EncuestaEntity enc)
        {
            using(SitcomEntities db = new SitcomEntities())
            {
                var result = (from en in db.Encuestas
                              where en.idEncuesta == enc.idEncuesta
                              select en).FirstOrDefault();

                result.nombre = enc.nombre;
                result.descripcion = enc.descripcion;
                result.idTipoEncuesta = enc.idTipoEncuesta;
                result.fechaVencimiento = enc.fechaVencimiento;

                db.SaveChanges();
            }
        }
        
        public List<PreguntasEntity> GetPreguntasEncuesta(int idEncuesta)
        {
            using(SitcomEntities db = new SitcomEntities())
            {
                var result = (from preg in db.Preguntas
                             where preg.idEncuesta == idEncuesta
                             select new PreguntasEntity()
                             {
                                 idPregunta = preg.idPregunta,
                                 idTipoRespuesta = preg.idTipoRespuesta,
                                 textoPregunta = preg.textoPregunta,
                                 TiposRespuesta = (from tres in db.TiposRespuesta
                                                   where tres.idTipoRespuesta == preg.idTipoRespuesta
                                                   select tres).FirstOrDefault(),
                                 idClasifPregunta = preg.idClasifPregunta,
                                 ClasifPregunta = (from clasif in db.ClasifPregunta
                                                   where clasif.idClasifPregunta == preg.idClasifPregunta
                                                   select clasif).FirstOrDefault()
                             }).ToList();

                return result;
            }
        }

        

    }
}
