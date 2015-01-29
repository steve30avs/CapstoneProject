using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Capstone.Models;
using System.Net.Mail;
using Microsoft.SqlServer;
using System.IO;
using System.Data.SqlClient;

namespace Capstone.Controllers
{
    public class AccountController : Controller
    {
        capstoneEntities storeDB = new capstoneEntities();

        //
        // GET: /Account/LogOn
        [Authorize]
        public ActionResult Account()
        {
            if (User.Identity.Name.ToLower() == "admin")
            {
                return View("AccountAdmin");
            }
            else if (User.Identity.Name.ToLower() == "owner")
            {
                return View("AccountOwner");
            }
            else
            {
                message_table model = new message_table();
                return View(model);
            }
        }

        //
        // POST: /Account/
        // Handles message sending to the site owner

        [HttpPost]
        [Authorize]
        public ActionResult Account(message_table model)
        {
            message_table addedMessage = new message_table();
            addedMessage.message_status = "Unreplied";

            // Get user num
            int usernum = 0;
            foreach (var users in storeDB.users_table)
            {
                if (users.username == HttpContext.User.Identity.Name)
                {
                    usernum = users.user_num;
                }
            }
            addedMessage.created_by_user_num = usernum;
            addedMessage.message_time = model.message_time;
            addedMessage.user_message = model.user_message;
            storeDB.message_table.Add(addedMessage);
            storeDB.SaveChanges();
            TempData["messageSent"] = "Sent";

            return View(model);
        }

        [Authorize]
        public ActionResult AccountAdminMessageUser(message_table userToMessage)
        {
            return View(userToMessage);
        }

        [Authorize]
        public ActionResult GetAdminMessageWindow(int id)
        {
            message_table userToMessage = new message_table();
            userToMessage.created_by_user_num = id;
            return View("AccountAdminMessageUser", userToMessage);
        }

        [HttpPost]
        [Authorize]
        public ActionResult GetAdminMessageWindow(message_table model)
        {
            MailMessage mail = new MailMessage();

            SmtpClient smtpServer = new SmtpClient("smtp.gmail.com");
            smtpServer.Credentials = new System.Net.NetworkCredential("stevecoautoparts", "******");
            smtpServer.Port = 587; // Gmail works on this port

            string userEmail = "";
            foreach (var userItem in storeDB.users_table)
            {
                // Created_by_user_num is just a placeholder for who the message is being sent to in this case
                if (userItem.user_num == model.created_by_user_num)
                {
                    userEmail = userItem.user_email;
                }
            }

            // Send the message that the store owner created
            mail.From = new MailAddress("stevecoautoparts@gmail.com");
            mail.To.Add(userEmail);
            mail.Subject = "New Message";
            mail.Body = model.user_message;

            smtpServer.EnableSsl = true;
            smtpServer.Send(mail);

            return RedirectToAction("Account", "Account");
        }

        [Authorize]
        public ActionResult GetPersonalDetails(int id)
        {
            var userItem = storeDB.users_table.FirstOrDefault(users_table => users_table.user_num == id);
            users_table userToEdit = new users_table();
            userToEdit.user_num = id;
            userToEdit.first_name = userItem.first_name;
            userToEdit.last_name = userItem.last_name;
            userToEdit.address = userItem.address;
            userToEdit.user_email = userItem.user_email;
            return View("AccountPersonalEdit", userToEdit);
        }

        [HttpPost]
        [Authorize]
        public ActionResult GetPersonalDetails(users_table userEdit)
        {
            var userItem = storeDB.users_table.FirstOrDefault(users_table => users_table.username == HttpContext.User.Identity.Name);
           
            userItem.address = userEdit.address;
            userItem.first_name = userEdit.first_name;
            userItem.last_name = userEdit.last_name;
            userItem.user_email = userEdit.user_email;

            storeDB.Entry(userItem).State = System.Data.EntityState.Modified;
            storeDB.SaveChanges();

            // Create new message table to give a date variable a placeholder in the account view
            message_table model = new message_table();
            return View("Account", model);
        }

        [Authorize]
        public ActionResult AddDefaultCar(int id)
        {
            // Save car id to user's info
            var userItem = storeDB.users_table.FirstOrDefault(users_table => users_table.username == HttpContext.User.Identity.Name);
            var carItem = storeDB.car_table.FirstOrDefault(car_table => car_table.car_id == id);

            userItem.car_brand = carItem.car_make;
            userItem.car_model = carItem.car_model;
            userItem.car_year = carItem.car_year;

            storeDB.Entry(userItem).State = System.Data.EntityState.Modified;
            storeDB.SaveChanges();
            TempData["carAdded"] = "added";
            return RedirectToAction("Parts", "Home");
        }

        public ActionResult LogOn()
        {
            return View();
        }

        //
        // POST: /Account/LogOn

        [HttpPost]
        public ActionResult LogOn(LogOnModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                if (Membership.ValidateUser(model.UserName, model.Password))
                {
                    FormsAuthentication.SetAuthCookie(model.UserName.ToLower(), model.RememberMe);
                    if (Url.IsLocalUrl(returnUrl) && returnUrl.Length > 1 && returnUrl.StartsWith("/")
                        && !returnUrl.StartsWith("//") && !returnUrl.StartsWith("/\\"))
                    {
                        return Redirect(returnUrl);
                    }
                    else
                    {
                        return RedirectToAction("Index", "Home");
                    }
                }
                else
                {
                    ModelState.AddModelError("", "The user name or password provided is incorrect.");
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/LogOff

        public ActionResult LogOff()
        {
            FormsAuthentication.SignOut();

            return RedirectToAction("Index", "Home");
        }

        //
        // GET: /Account/Appointments

        [Authorize]
        public ActionResult Appointments()
        {
            return View();
        }

        //
        // POST: /Account/Appointments

        [HttpPost]
        [Authorize]
        public ActionResult Appointments(DatePickedModel model)
        {
            // Check if user entered a date
            if (model.dateSelected != null)
            {
                TempData["DatePickedModel"] = model;
                return RedirectToAction("Appointment_Selected");
            }
            else
            {
                return View();
            }
        }

        //
        // GET: /Account/Appointment_Selected

        [Authorize]
        public ActionResult Appointment_Selected()
        {
            var datePicked = TempData["DatePickedModel"] as Capstone.Models.DatePickedModel;
            DateTime datePickedDBFormat = Convert.ToDateTime(datePicked.dateSelected);
            ViewBag.AvailableTimes = storeDB.appointments_table.Where(a => a.appointment_date == datePickedDBFormat && a.user_num_request == null).ToList();

            return View();
        }

        //
        // POST: /Account/Appointment_Selected

        [HttpPost]
        [Authorize]
        public ActionResult Appointment_Selected(AppointmentModel model)
        {
            var addedAppointment = storeDB.appointments_table.FirstOrDefault(appt_table => appt_table.appointment_num == model.ApptNum);
            //TempData["DatePickedModel"] = model;
            if (addedAppointment != null)
            {
                addedAppointment.approved = "Pending";

                // Get user num
                int usernum = 0;
                foreach (var users in storeDB.users_table)
                {
                    if (users.username == HttpContext.User.Identity.Name)
                    {
                        usernum = users.user_num;
                    }
                }
                addedAppointment.user_num_request = usernum;
                addedAppointment.service_reason = model.ServiceReason;
                storeDB.Entry(addedAppointment).State = System.Data.EntityState.Modified;
                storeDB.SaveChanges();


                return RedirectToAction("Account");
            }
            else
            {
                return RedirectToAction("Appointments");
            }

        }

        //
        // GET: /Account/Register

        public ActionResult Register()
        {
            return View();
        }

        //
        // POST: /Account/Register

        [HttpPost]
        public ActionResult Register(RegisterModel model)
        {
            if (ModelState.IsValid)
            {
                // Check if username is taken
                users_table existingUser = new users_table();
                existingUser = storeDB.users_table.FirstOrDefault(user_table => user_table.username == model.UserName.ToLower());
                if (existingUser == null)
                {
                    // Attempt to register the user
                    MembershipCreateStatus createStatus;
                    Membership.CreateUser(model.UserName.ToLower(), model.Password, model.Email.ToLower(), null, null, true, null, out createStatus);

                    if (createStatus == MembershipCreateStatus.Success)
                    {
                        FormsAuthentication.SetAuthCookie(model.UserName.ToLower(), false /* createPersistentCookie */);

                        // Update the new member to take extra information
                        // Get user num
                        int usernum = 0;
                        foreach (var users in storeDB.users_table)
                        {
                            if (users.username == HttpContext.User.Identity.Name)
                            {
                                usernum = users.user_num;
                            }
                        }
                        var addedUser = storeDB.users_table.FirstOrDefault(user_table => user_table.username == model.UserName.ToLower());
                        addedUser.first_name = model.FirstName;
                        addedUser.last_name = model.LastName;
                        addedUser.address = model.Address;
                        storeDB.Entry(addedUser).State = System.Data.EntityState.Modified;
                        storeDB.SaveChanges();

                        MailMessage mail = new MailMessage();

                        SmtpClient smtpServer = new SmtpClient("smtp.gmail.com");
                        smtpServer.Credentials = new System.Net.NetworkCredential("stevecoautoparts", "******");
                        smtpServer.Port = 587; // Gmail works on this port

                        string userEmail = "";
                        foreach (var userItem in storeDB.users_table)
                        {
                            if (userItem.user_num == addedUser.user_num)
                            {
                                userEmail = userItem.user_email;
                            }
                        }

                        // Send the message that the store owner created
                        mail.From = new MailAddress("stevecoautoparts@gmail.com");
                        mail.To.Add(userEmail);
                        mail.Subject = "New account registration";
                        mail.Body = "You just registered an account at Steveco Auto Parts.";

                        smtpServer.EnableSsl = true;
                        smtpServer.Send(mail);

                        return RedirectToAction("Index", "Home");
                    }
                    else
                    {
                        ModelState.AddModelError("", ErrorCodeToString(createStatus));
                    }
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/ChangePassword

        [Authorize]
        public ActionResult ChangePassword()
        {
            return View();
        }

        //
        // POST: /Account/ChangePassword

        [Authorize]
        [HttpPost]
        public ActionResult ChangePassword(ChangePasswordModel model)
        {
            if (ModelState.IsValid)
            {

                // ChangePassword will throw an exception rather
                // than return false in certain failure scenarios.
                bool changePasswordSucceeded;
                try
                {
                    MembershipUser currentUser = Membership.GetUser(User.Identity.Name, true /* userIsOnline */);
                    changePasswordSucceeded = currentUser.ChangePassword(model.OldPassword, model.NewPassword);
                }
                catch (Exception)
                {
                    changePasswordSucceeded = false;
                }

                if (changePasswordSucceeded)
                {
                    return RedirectToAction("ChangePasswordSuccess");
                }
                else
                {
                    ModelState.AddModelError("", "The current password is incorrect or the new password is invalid.");
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/ChangePasswordSuccess

        public ActionResult ChangePasswordSuccess()
        {
            return View();
        }

        //
        // GET: /Account/ForgotPass

        public ActionResult ForgotPass()
        {
            return View();
        }

        //
        // POST: /Account/ForgotPass

        [HttpPost]
        public ActionResult ForgotPass(ForgotPasswordModel model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var userItem = storeDB.users_table.FirstOrDefault(user_table => user_table.username == model.username.ToLower());
                    
                    // If a user was returned
                    if (userItem != null)
                    {
                        // If user entered their correct email
                        if (model.regEmail.ToLower() == userItem.user_email.ToLower())
                        {
                            // Reset the user's password to a random one
                            Random rand = new Random();
                            string newPassword = "JA3AU26U79U601148" + "#$%^&" + rand.Next(1, 21);
                            userItem.password = MembershipSQLProvider.GetMD5Hash(newPassword);

                            MailMessage mail = new MailMessage();

                            SmtpClient smtpServer = new SmtpClient("smtp.gmail.com");
                            smtpServer.Credentials = new System.Net.NetworkCredential("stevecoautoparts", "******");
                            smtpServer.Port = 587; // Gmail works on this port

                            // Send the message that the store owner created
                            mail.From = new MailAddress("stevecoautoparts@gmail.com");
                            mail.To.Add(model.regEmail);
                            mail.Subject = "New Password";
                            mail.Body = "Your new password is: " + newPassword;

                            smtpServer.EnableSsl = true;
                            smtpServer.Send(mail);


                            storeDB.Entry(userItem).State = System.Data.EntityState.Modified;
                            storeDB.SaveChanges();

                            TempData["passwordSent"] = "Sent";
                            return RedirectToAction("ForgotPass", "Account");
                        }
                        else
                        {
                            TempData["credentialError"] = "Sent";
                            return RedirectToAction("ForgotPass", "Account");
                        }
                    }
                    else
                    {
                        TempData["credentialError"] = "Sent";
                        return RedirectToAction("ForgotPass", "Account");
                    }
                }
                catch (Exception e)
                {
                    throw e;
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        #region Status Codes
        private static string ErrorCodeToString(MembershipCreateStatus createStatus)
        {
            // See http://go.microsoft.com/fwlink/?LinkID=177550 for
            // a full list of status codes.
            switch (createStatus)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "User name already exists. Please enter a different user name.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "A user name for that e-mail address already exists. Please enter a different e-mail address.";

                case MembershipCreateStatus.InvalidPassword:
                    return "The password provided is invalid. Please enter a valid password value.";

                case MembershipCreateStatus.InvalidEmail:
                    return "The e-mail address provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }
        #endregion
    }
}
