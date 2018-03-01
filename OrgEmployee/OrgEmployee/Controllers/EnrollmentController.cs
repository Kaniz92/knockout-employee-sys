using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using OrgEmployee.Models;

namespace OrgEmployee.Controllers
{
    public class EnrollmentController : Controller
    {
        private OrganizationEmployeeDataEntities db = new OrganizationEmployeeDataEntities();

        //
        // GET: /Enrollment/

        public ActionResult Index()
        {
            var enrollments = db.Enrollments.Include(e => e.Department).Include(e => e.Employee);
            return View(enrollments.ToList());
        }

        //
        // GET: /Enrollment/Details/5

        public ActionResult Details(int id = 0)
        {
            Enrollment enrollment = db.Enrollments.Find(id);
            if (enrollment == null)
            {
                return HttpNotFound();
            }
            return View(enrollment);
        }

        //
        // GET: /Enrollment/Create

        public ActionResult Create()
        {
            ViewBag.DepartmentID = new SelectList(db.Departments, "DepartmentID", "Title");
            ViewBag.EmployeeID = new SelectList(db.Employees, "EmployeeID", "LastName");
            return View();
        }

        //
        // POST: /Enrollment/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Enrollment enrollment)
        {
            if (ModelState.IsValid)
            {
                db.Enrollments.Add(enrollment);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.DepartmentID = new SelectList(db.Departments, "DepartmentID", "Title", enrollment.DepartmentID);
            ViewBag.EmployeeID = new SelectList(db.Employees, "EmployeeID", "LastName", enrollment.EmployeeID);
            return View(enrollment);
        }

        //
        // GET: /Enrollment/Edit/5

        public ActionResult Edit(int id = 0)
        {
            Enrollment enrollment = db.Enrollments.Find(id);
            if (enrollment == null)
            {
                return HttpNotFound();
            }
            ViewBag.DepartmentID = new SelectList(db.Departments, "DepartmentID", "Title", enrollment.DepartmentID);
            ViewBag.EmployeeID = new SelectList(db.Employees, "EmployeeID", "LastName", enrollment.EmployeeID);
            return View(enrollment);
        }

        //
        // POST: /Enrollment/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Enrollment enrollment)
        {
            if (ModelState.IsValid)
            {
                db.Entry(enrollment).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.DepartmentID = new SelectList(db.Departments, "DepartmentID", "Title", enrollment.DepartmentID);
            ViewBag.EmployeeID = new SelectList(db.Employees, "EmployeeID", "LastName", enrollment.EmployeeID);
            return View(enrollment);
        }

        //
        // GET: /Enrollment/Delete/5

        public ActionResult Delete(int id = 0)
        {
            Enrollment enrollment = db.Enrollments.Find(id);
            if (enrollment == null)
            {
                return HttpNotFound();
            }
            return View(enrollment);
        }

        //
        // POST: /Enrollment/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Enrollment enrollment = db.Enrollments.Find(id);
            db.Enrollments.Remove(enrollment);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}