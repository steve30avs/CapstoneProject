using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Capstone.Models;
using System.Net.Mail;

namespace Capstone.Controllers
{
    public class StatusApptController : Controller
    {
        capstoneEntities storeDB = new capstoneEntities();

        //
        // GET: /AccountOrder/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetApptDetails(int id)
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
        public ActionResult GetApptDetails(appointments_table model)
        {
            var changeAppt = storeDB.appointments_table.FirstOrDefault(appt_table => appt_table.appointment_num == model.appointment_num);

            changeAppt.approved = "Approved";
            storeDB.Entry(changeAppt).State = System.Data.EntityState.Modified;
            storeDB.SaveChanges();


            // Send email to user that the appointment is ready
            MailMessage mail = new MailMessage();

            SmtpClient smtpServer = new SmtpClient("smtp.gmail.com");
            smtpServer.Credentials = new System.Net.NetworkCredential("stevecoautoparts", "capstone1");
            smtpServer.Port = 587; // Gmail works on this port

            string userEmail = "";
            foreach (var userItem in storeDB.users_table)
            {
                if (userItem.user_num == changeAppt.user_num_request)
                {
                    userEmail = userItem.user_email;
                }
            }

            // Send the message that the store owner created
            mail.From = new MailAddress("stevecoautoparts@gmail.com");
            mail.To.Add(userEmail);
            mail.Subject = "Appointment update";
            mail.Body = "Your appoinment has been approved! See you on: " + changeAppt.appointment_date.Value.ToShortDateString() + " at: " + changeAppt.appointment_time;

            smtpServer.EnableSsl = true;
            smtpServer.Send(mail);

            return RedirectToAction("Account", "Account");
        }
    }
}
