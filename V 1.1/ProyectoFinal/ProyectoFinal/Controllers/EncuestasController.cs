using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using DAL;
using BussinesEntities;
using BL;

namespace ProyectoFinal
{
    public class EncuestasController : Controller
    {
        private SitcomEntities db = new SitcomEntities();
        private EncuestasManager em = new EncuestasManager();

        // GET: /Encuestas/
        public ActionResult EncuestasIndex()
        {
            List<EncuestaEntityIndex> encuestas = em.GetAllEncuestas();
            return View(encuestas);
        }

        // GET: /Encuestas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Encuestas encuestas = db.Encuestas.Find(id);
            if (encuestas == null)
            {
                return HttpNotFound();
            }
            return View(encuestas);
        }

        // GET: /Encuestas/Create
        public ActionResult Create()
        {
            ViewBag.idTipoEncuesta = new SelectList(db.TiposEncuesta, "idTipoEncuesta", "nombre");
            ViewBag.idEncuesta = new SelectList(db.Preguntas, "idPregunta", "textoPregunta");
            ViewBag.idEncuesta = new SelectList(db.TiposEncuesta, "idTipoEncuesta", "nombre");
            return View();
        }

        // POST: /Encuestas/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="idEncuesta,nombre,descripcion,idTipoEncuesta,fechaVencimiento")] Encuestas encuestas)
        {
            if (ModelState.IsValid)
            {
                db.Encuestas.Add(encuestas);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idTipoEncuesta = new SelectList(db.TiposEncuesta, "idTipoEncuesta", "nombre", encuestas.idTipoEncuesta);
            ViewBag.idEncuesta = new SelectList(db.Preguntas, "idPregunta", "textoPregunta", encuestas.idEncuesta);
            ViewBag.idEncuesta = new SelectList(db.TiposEncuesta, "idTipoEncuesta", "nombre", encuestas.idEncuesta);
            return View(encuestas);
        }

        // GET: /Encuestas/Edit/5
        public ActionResult EditEncuesta(int? idEncuesta)
        {
            if (idEncuesta == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            EncuestaEntity en = em.GetEncuestaById(idEncuesta);
            if (en == null)
            {
                return HttpNotFound();
            }

            ViewBag.idTipoEncuesta = new SelectList(db.TiposEncuesta, "idTipoEncuesta", "nombre", en.idTipoEncuesta);
            //ViewBag.idEncuesta = new SelectList(db.TiposEncuesta, "idTipoEncuesta", "nombre", en.idEncuesta);

            return View(en);
        }

        // POST: /Encuestas/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditEncuesta([Bind(Include="idEncuesta,nombre,descripcion,idTipoEncuesta,fechaVencimiento")] EncuestaEntity en)
        {
            if(ModelState.IsValid)
            {
                em.EditEncuesta(en);
                return RedirectToAction("EncuestasIndex");
            }
            ViewBag.idTipoEncuesta = new SelectList(db.TiposEncuesta, "idTipoEncuesta", "nombre", en.idTipoEncuesta);

            return View(en);
        }

        // GET: /Encuestas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Encuestas encuestas = db.Encuestas.Find(id);
            if (encuestas == null)
            {
                return HttpNotFound();
            }
            return View(encuestas);
        }

        // POST: /Encuestas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Encuestas encuestas = db.Encuestas.Find(id);
            db.Encuestas.Remove(encuestas);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult PreguntasEncuesta(int idEncuesta)
        {
            List<PreguntasEntity> pregsEncuesta = em.GetPreguntasEncuesta(idEncuesta);

            ViewBag.IdEncuesta = idEncuesta;
            return View(pregsEncuesta);
        }

         // GET: /Preguntas/Create
        public ActionResult NuevaPregunta(int idEncuesta)
        {

            ViewBag.idTipoRespuesta = new SelectList(db.TiposRespuesta, "idTipoRespuesta", "nombre");
            ViewBag.idClasifPregunta = new SelectList(db.ClasifPregunta, "idClasifPregunta", "nombre");
            ViewBag.IdEncuesta = idEncuesta;
            return View();
        }

        // POST: /Encuestas/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult NuevaPregunta(PreguntasEntity pregunta)
        {
            if (ModelState.IsValid)
            {
                em.CrearPregunta(pregunta);
                return RedirectToAction("PreguntasEncuesta", new { idEncuesta = pregunta.idEncuesta });
            }

            ViewBag.idTipoRespuesta = new SelectList(db.TiposRespuesta, "idTipoRespuesta", "nombre");
            ViewBag.idClasifPregunta = new SelectList(db.ClasifPregunta, "idClasifPregunta", "nombre");
            ViewBag.IdEncuesta = pregunta.idEncuesta;
            
            return View(pregunta);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
