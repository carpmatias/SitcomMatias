using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using DAL;

namespace ProyectoFinal
{
    public class EncuestasController : Controller
    {
        private SitcomEntities db = new SitcomEntities();

        // GET: /Encuestas/
        public ActionResult Index()
        {
            var encuestas = db.Encuestas.Include(e => e.TiposEncuesta).Include(e => e.Preguntas);
            return View(encuestas.ToList());
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
            return View();
        }

        // POST: /Encuestas/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="idEncuesta,nombre,descripcion,idTipoEncuesta")] Encuestas encuestas)
        {
            if (ModelState.IsValid)
            {
                db.Encuestas.Add(encuestas);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.idTipoEncuesta = new SelectList(db.TiposEncuesta, "idTipoEncuesta", "nombre", encuestas.idTipoEncuesta);
            ViewBag.idEncuesta = new SelectList(db.Preguntas, "idPregunta", "textoPregunta", encuestas.idEncuesta);
            return View(encuestas);
        }

        // GET: /Encuestas/Edit/5
        public ActionResult Edit(int? id)
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
            ViewBag.idTipoEncuesta = new SelectList(db.TiposEncuesta, "idTipoEncuesta", "nombre", encuestas.idTipoEncuesta);
            ViewBag.idEncuesta = new SelectList(db.Preguntas, "idPregunta", "textoPregunta", encuestas.idEncuesta);
            return View(encuestas);
        }

        // POST: /Encuestas/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="idEncuesta,nombre,descripcion,idTipoEncuesta")] Encuestas encuestas)
        {
            if (ModelState.IsValid)
            {
                db.Entry(encuestas).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.idTipoEncuesta = new SelectList(db.TiposEncuesta, "idTipoEncuesta", "nombre", encuestas.idTipoEncuesta);
            ViewBag.idEncuesta = new SelectList(db.Preguntas, "idPregunta", "textoPregunta", encuestas.idEncuesta);
            return View(encuestas);
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
