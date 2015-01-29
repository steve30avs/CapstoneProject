using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Capstone.Models;
using System.Net.Mail;

namespace Capstone.Controllers
{
    public class MessageController : Controller
    {
        capstoneEntities storeDB = new capstoneEntities();


        //
        // GET: /Message/

        public ActionResult Index(int id)
        {
            return View();
        }

        [Authorize]
        public ActionResult GetMessageDetails(int id)
        {
            message_table currentMessage = new message_table();
            foreach (var messageItem in storeDB.message_table)
            {
                if (messageItem.message_id == id)
                {
                    currentMessage = messageItem;
                }
            }
            return View("Index", currentMessage);
        }

        [HttpPost]
        [Authorize]
        public ActionResult GetMessageDetails(message_table model)
        {
            MailMessage mail = new MailMessage();

            SmtpClient smtpServer = new SmtpClient("smtp.gmail.com");
            smtpServer.Credentials = new System.Net.NetworkCredential("stevecoautoparts", "******");
            smtpServer.Port = 587; // Gmail works on this port

            string userEmail = "";
            foreach (var userItem in storeDB.users_table)
            {
                if (userItem.user_num == model.created_by_user_num)
                {
                    userEmail = userItem.user_email;
                }
            }

            // Send the message that the store owner created
            mail.From = new MailAddress("stevecoautoparts@gmail.com");
            mail.To.Add(userEmail);
            mail.Subject = "Reply to your question";
            mail.Body = model.user_message;

            smtpServer.EnableSsl = true;
            smtpServer.Send(mail);

            var modifiedMessage = storeDB.message_table.FirstOrDefault(msg_table => msg_table.message_id == model.message_id);

            modifiedMessage.message_status = "Responded";
            storeDB.Entry(modifiedMessage).State = System.Data.EntityState.Modified;
            storeDB.SaveChanges();


            return RedirectToAction("Account", "Account");
        }

    }
}
