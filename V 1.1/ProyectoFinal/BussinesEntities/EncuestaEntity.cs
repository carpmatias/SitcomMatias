using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;

namespace BussinesEntities
{
    using System;
    using System.Collections.Generic;

    public class EncuestaEntity
    {
        public EncuestaEntity()
        {
            
        }

        public string nombre { get; set; }
        public string descripcion { get; set; }
        public Nullable<int> idTipoEncuesta { get; set; }

        public virtual TiposEncuesta TiposEncuesta { get; set; }
        public virtual ICollection<EncuestasAsignadas> EncuestasAsignadas { get; set; }
        
        public virtual ICollection<Preguntas> Preguntas { get; set; }
    }
}
