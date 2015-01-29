using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Capstone.Models;

namespace Capstone.Controllers
{
    [Authorize]
    public class CheckoutController : Controller
    {
        capstoneEntities storeDB = new capstoneEntities();
   
        //
        // GET: /Checkout/Confirmation

        public ActionResult Confirmation()
        {
            Capstone.ViewModels.CartViewModel tempCartViewModel = new ViewModels.CartViewModel();
            if (TempData["currentCartModel"] != null)
            {
                tempCartViewModel = (Capstone.ViewModels.CartViewModel)TempData["currentCartModel"];
                TempData.Clear();
                
            }
            return View(tempCartViewModel);
        }

        //
        // POST: /Checkout/Confirmation

        [HttpPost]
        public ActionResult Confirmation(ViewModels.CartViewModel viewModel)
        {
            var invoice = new invoice_table();
            TryUpdateModel(invoice);

            try
            {
                // Get user num
                int usernum = 0;
                foreach (var users in storeDB.users_table)
                {
                    if (users.username == HttpContext.User.Identity.Name)
                    {
                        usernum = users.user_num;
                    }
                }

                invoice.user_num = usernum;
                invoice.invoice_date = DateTime.Now;
                invoice.invoice_filled = "Pending";

                storeDB.invoice_table.Add(invoice);
                storeDB.SaveChanges();

                var cart = UserShoppingCart.GetCart(this.HttpContext);
                cart.CreateOrder(invoice);

                List<parts_table> tempPartsTable = new List<parts_table>();

                // Subtract stock from how much the user ordered
                foreach (var orderItem in storeDB.orders_table)
                {
                    if (orderItem.invoice_num == invoice.invoice_num)
                    {
                        var currentPart = storeDB.parts_table.FirstOrDefault(part_table => part_table.part_number == orderItem.part_num);
                        currentPart.part_stock = currentPart.part_stock - orderItem.quantity;
                        tempPartsTable.Add(currentPart);
                    }
                }

                // Run through and modify the stock of parts
                foreach (parts_table partItem in tempPartsTable)
                {
                    storeDB.Entry(partItem).State = System.Data.EntityState.Modified;
                    storeDB.SaveChanges();
                }

                return RedirectToAction("Finished", new { id = invoice.invoice_num });
            }
            catch (Exception)
            {
                return View(viewModel);
            }
        }

        //
        // GET: /Checkout/Finished

        public ActionResult Finished(int id)
        {
             int usernum = 0;
             foreach (var users in storeDB.users_table)
                {
                    if (users.username == HttpContext.User.Identity.Name)
                    {
                        usernum = users.user_num;
                    }
                }

             bool isValid = storeDB.invoice_table.Any(o => o.invoice_num ==
                 id && o.user_num == usernum);
             if (isValid)
             {
                 return View(id);
             }
             else
             {
                 return View("Error");
             }
        }
    }
}
