using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Capstone.Models;

namespace Capstone.Controllers
{
    public class AccountOrderController : Controller
    {
        capstoneEntities storeDB = new capstoneEntities();

        //
        // GET: /AccountOrder/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetOrderDetails(int id)
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
        public ActionResult GetOrderDetails(invoice_table model)
        {
            // Remove associated orders first
            // Put into a list, then go through the list (cannot delete each item at once as a thread will still be accessing them)
            List<orders_table> orderTempList = new List<orders_table>();
            foreach (orders_table orderItem in storeDB.orders_table)
            {
                if (orderItem.invoice_num == model.invoice_num)
                {
                    orderTempList.Add(orderItem);
                }
            }

            // Run through and delete the list of orders
            foreach (orders_table orderItem in orderTempList)
            {
                storeDB.orders_table.Remove(orderItem);
                storeDB.SaveChanges();
            }

            orderTempList.Clear();

            var removeInvoice = storeDB.invoice_table.FirstOrDefault(inv_table => inv_table.invoice_num == model.invoice_num);
            storeDB.invoice_table.Remove(removeInvoice);
            storeDB.SaveChanges();
            return RedirectToAction("Account", "Account");
        }
    }
}
