using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.Globalization;

namespace Capstone.Models
{
    public class AppointmentModel
    {
        [Required]
        [Display(Name = "Appointment Number")]
        public int ApptNum { get; set; }

        [Required]
        [Display(Name = "Appointment Date")]
        public string ApptDate { get; set; }

        [Required]
        [Display(Name = "Appointment Time")]
        public string ApptTime { get; set; }

        [Required]
        [Display(Name = "User Number")]
        public int UserNum { get; set; }

        [Required]
        [Display(Name = "Service Reason")]
        public string ServiceReason { get; set; }

        public string approved { get; set; }
    }
}