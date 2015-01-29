using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Capstone.Models;

namespace Capstone.ViewModels
{
    public class CartViewModel
    {
        public List<cart_table> CartItems { get; set; }
        public List<parts_table> PartItems { get; set; }
        public decimal CartTotal { get; set; }
    }
}