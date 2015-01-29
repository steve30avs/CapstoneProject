using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Capstone.Models;
using System.Net.Mail;

namespace Capstone.Controllers
{
    public class StatusOrderController : Controller
    {
        capstoneEntities storeDB = new capstoneEntities();

        //
        // GET: /AccountOrder/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ChangeOrderStatus(int id)
        {
            invoice_table currentInvoice = new invoice_table();
            foreach (var invoiceItem in storeDB.invoice_table)
            {
                if (invoiceItem.invoice_num == id)
                {
                    currentInvoice = invoiceItem;
                }
            }
            return View("Index", currentInvoice);
        }

        [HttpPost]
        [Authorize]
        public ActionResult ChangeOrderStatus(invoice_table model)
        {
            var changeInvoice = storeDB.invoice_table.FirstOrDefault(inv_table => inv_table.invoice_num == model.invoice_num);
            int invoiceUser = (int)changeInvoice.user_num;
            changeInvoice.invoice_filled = "Ready";

            storeDB.Entry(changeInvoice).State = System.Data.EntityState.Modified;
            storeDB.SaveChanges();

            // Send email to user that the order is ready
            MailMessage mail = new MailMessage();

            SmtpClient smtpServer = new SmtpClient("smtp.gmail.com");
            smtpServer.Credentials = new System.Net.NetworkCredential("stevecoautoparts", "******");
            smtpServer.Port = 587; // Gmail works on this port

            string userEmail = "";
            foreach (var userItem in storeDB.users_table)
            {
                if (userItem.user_num == invoiceUser)
                {
                    userEmail = userItem.user_email;
                }
            }

            // Send the message that the store owner created
            mail.From = new MailAddress("stevecoautoparts@gmail.com");
            mail.To.Add(userEmail);
            mail.Subject = "Order update";
            mail.Body = "Your order is now ready for pickup! Amount due: $" + changeInvoice.invoice_total;

            smtpServer.EnableSsl = true;
            smtpServer.Send(mail);

            return RedirectToAction("Account", "Account");
        }
    }
}
