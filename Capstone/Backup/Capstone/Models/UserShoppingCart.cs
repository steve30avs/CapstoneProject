using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Capstone.Models
{
    public partial class UserShoppingCart
    {
        capstoneEntities storeDB = new capstoneEntities();
        string ShoppingCartId { get; set; }
        public const string CartSessionKey = "CartId";
        public static UserShoppingCart GetCart(HttpContextBase context)
        {
            var cart = new UserShoppingCart();
            cart.ShoppingCartId = cart.GetCartId(context);
            return cart;
        }
        // Helper method to simplify shopping cart calls
        public static UserShoppingCart GetCart(Controller controller)
        {
            return GetCart(controller.HttpContext);
        }
        public void AddToCart(parts_table part)
        {
            // Get the matching cart and part instances
            var cartItem = storeDB.cart_table.FirstOrDefault(c => c.cart_name == ShoppingCartId && c.part_number == part.part_number);

            if (cartItem == null)
            {
                // Create a new cart item if no cart item exists
                cartItem = new cart_table { part_number = part.part_number, cart_name = ShoppingCartId, part_quantity = 1, DateCreated = DateTime.Now };
                storeDB.cart_table.Add(cartItem);
            }
            else
            {
                // If the item does exist in the cart, 
                // then add one to the quantity
                cartItem.part_quantity++;
            }
            // Save changes
            storeDB.SaveChanges();
        }
        public int RemoveFromCart(int id)
        {
            // Get the cart
            //var cartItem = storeDB.Carts.Single(cart => cart.cartNum == ShoppingCartId);
            var cartItem = storeDB.cart_table.FirstOrDefault(cart => cart.cart_name == ShoppingCartId && cart.cart_instance_id == id);

            int itemCount = 0;

            if (cartItem != null)
            {
                if (cartItem.part_quantity > 1)
                {
                    cartItem.part_quantity--;
                    itemCount = Convert.ToInt32(cartItem.part_quantity);
                }
                else
                {
                    storeDB.cart_table.Remove(cartItem);
                }
                // Save changes
                storeDB.SaveChanges();
            }
            return itemCount;
        }
        public void EmptyCart()
        {
            var cartItems = storeDB.cart_table.Where(
                cart => cart.cart_name == ShoppingCartId);

            foreach (var cartItem in cartItems)
            {
                storeDB.cart_table.Remove(cartItem);
            }
            // Save changes
            storeDB.SaveChanges();
        }
        public List<cart_table> GetCartItems()
        {
            return storeDB.cart_table.Where(
                cart => cart.cart_name == ShoppingCartId).ToList();
        }
        public int GetCount()
        {
            // Get the count of each item in the cart and sum them up
            int? count = (from cartItems in storeDB.cart_table
                          where cartItems.cart_name == ShoppingCartId
                          select (int?)cartItems.part_quantity).Sum();
            // Return 0 if all entries are null
            return count ?? 0;
        }
        public decimal GetTotal()
        {
            // Multiply part price by count of that part to get 
            // the current price for each of those parts in the cart
            // sum all part price totals to get the cart total

            decimal? total = 0;

            // Search through cart items for the specific shopping cart
            foreach (var cartItems in storeDB.cart_table)
            {
                if (cartItems.cart_name == ShoppingCartId)
                {
                    decimal partPrice = 0;

                    // Find info on the current part in the cart
                    foreach (var partItems in storeDB.parts_table)
                    {
                        if (partItems.part_number == cartItems.part_number)
                        {
                            partPrice = (Decimal)partItems.part_price;
                        }
                    }
                    total = total + cartItems.part_quantity* partPrice;
                }
            }

            return total ?? decimal.Zero;
        }
        public int CreateOrder(invoice_table invoice)
        {
            decimal orderTotal = 0;

            var cartItems = GetCartItems();
            // Iterate over the items in the cart, 
            // adding the order details for each
            foreach (var item in cartItems)
            {
                var orderDetail = new orders_table
                {
                    invoice_num = invoice.invoice_num,
                    part_num = Convert.ToInt32(item.part_number),
                    //order_num = invoice.invoice_num,
                    //partPrice = item.part.part_price,
                    quantity = Convert.ToInt32(item.part_quantity)
                };
                // Set the order total of the shopping cart

                // Get the part info from the part table
                var partPrice = storeDB.parts_table.FirstOrDefault(p => p.part_number == item.part_number);
                orderTotal += (Decimal)(item.part_quantity * partPrice.part_price);

                storeDB.orders_table.Add(orderDetail);

            }
            // Set the order's total to the orderTotal count
            var invoiceDetail = storeDB.invoice_table.FirstOrDefault(inv_table => inv_table.invoice_num == invoice.invoice_num);
            invoiceDetail.invoice_total = orderTotal;

            storeDB.Entry(invoiceDetail).State = System.Data.EntityState.Modified;

            // Save the order
            storeDB.SaveChanges();
            // Empty the shopping cart
            EmptyCart();
            // Return the invoice_num as the confirmation number
            return invoice.invoice_num;
        }
        // We're using HttpContextBase to allow access to cookies.
        public string GetCartId(HttpContextBase context)
        {
            if (context.Session[CartSessionKey] == null)
            {
                if (!string.IsNullOrWhiteSpace(context.User.Identity.Name))
                {
                    context.Session[CartSessionKey] = context.User.Identity.Name;
                }
                else
                {
                    // Generate a new random GUID using System.Guid class
                    Guid tempCartId = Guid.NewGuid();
                    // Send tempCartId back to client as a cookie
                    context.Session[CartSessionKey] = tempCartId.ToString();
                }
            }
            return context.Session[CartSessionKey].ToString();
        }
        // When a user has logged in, migrate their shopping cart to
        // be associated with their username
        public void MigrateCart(string userName)
        {
            var shoppingCart = storeDB.cart_table.Where(c => c.cart_name == ShoppingCartId);

            foreach (cart_table item in shoppingCart)
            {
                item.cart_name = userName;
            }
            storeDB.SaveChanges();
        }
    }
}