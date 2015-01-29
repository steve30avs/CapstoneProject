using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Capstone.Models;

namespace Capstone.ViewModels
{
    public class PartViewModel
    {
        public List<parts_table> PartItems { get; set; }
        public List<car_table> CarList { get; set; }
        public List<int> CarId { get; set; }
    }
}