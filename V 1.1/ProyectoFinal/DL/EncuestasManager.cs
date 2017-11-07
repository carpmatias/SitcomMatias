using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;

namespace BL
{
    public class EncuestasManager
    {

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

    }
}
