using System.Linq;
using System.Web.Mvc;
using Capstone.Models;
using Capstone.ViewModels;
using System.Collections.Generic;

namespace Capstone.Controllers
{
    public class CartController : Controller
    {
        capstoneEntities storeDB = new capstoneEntities();
        
        //
        // GET: /ShoppingCart/
        public ActionResult Index()
        {
            var cart = UserShoppingCart.GetCart(this.HttpContext);
            var part = storeDB.parts_table.ToList();

            // Set up our ViewModel
            var viewModel = new CartViewModel
            {
                CartItems = cart.GetCartItems(),
                PartItems = part,
                CartTotal = cart.GetTotal()
            };
            // Return the view
            return View(viewModel);
        }

        //
        // GET: /Store/AddToCart/5
        public ActionResult AddToCart(int id)
        {
            // Retrieve the part from the database
            var addedPart = storeDB.parts_table.FirstOrDefault(parts_table => parts_table.part_number == id);

            // Add it to the shopping cart
            var cart = UserShoppingCart.GetCart(this.HttpContext);

            cart.AddToCart(addedPart);

            // Go back to the main store page for more shopping
            return RedirectToAction("Index");
        }
        //
        // AJAX: /ShoppingCart/RemoveFromCart/5
        public ActionResult RemoveFromCart(int id)
        {
            // Remove the item from the cart
            var cart = UserShoppingCart.GetCart(this.HttpContext);

            // Remove from cart
            int itemCount = cart.RemoveFromCart(id);

            // Display the confirmation message
            var results = new RemoveCartViewModel
            {
                Message = Server.HtmlEncode("testName1") +
                    " has been removed from your shopping cart.",
                CartTotal = cart.GetTotal(),
                CartCount = cart.GetCount(),
                ItemCount = itemCount,
                DeleteId = id
            };
            //return Json(results, JsonRequestBehavior.AllowGet);
            return RedirectToAction("");
        }
        //
        // GET: /ShoppingCart/CartSummary
        [ChildActionOnly]
        public ActionResult CartSummary()
        {
            var cart = UserShoppingCart.GetCart(this.HttpContext);

            ViewData["CartCount"] = cart.GetCount();
            return PartialView("CartSummary");
        }
    }
}
