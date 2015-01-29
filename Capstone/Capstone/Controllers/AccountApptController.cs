using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Capstone.Models;

namespace Capstone.Controllers
{
    public class AccountApptController : Controller
    {
        capstoneEntities storeDB = new capstoneEntities();

        //
        // GET: /AccountOrder/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetAppointmentDetails(int id)
        {
            appointments_table currentAppt = new appointments_table();
            foreach (var apptItem in storeDB.appointments_table)
            {
                if (apptItem.appointment_num == id)
                {
                    currentAppt = apptItem;
                }
            }
            return View("Index", currentAppt);
        }

        [HttpPost]
        [Authorize]
        public ActionResult GetAppointmentDetails(appointments_table model)
        {

            var removeAppt = storeDB.appointments_table.FirstOrDefault(appt_table => appt_table.appointment_num == model.appointment_num);
            
            // Marking the approved item as null will make it appear as a free appointment
            removeAppt.approved = "";
            removeAppt.user_num_request = null;
            storeDB.Entry(removeAppt).State = System.Data.EntityState.Modified;
            storeDB.SaveChanges();
            return RedirectToAction("Account", "Account");
        }
    }
}
