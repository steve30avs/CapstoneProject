using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.Globalization;

namespace Capstone.Models
{
    public class ForgotPasswordModel
    {
        [Required]
        [DataType(DataType.Text)]
        [Display(Name = "Username")]
        public string username { get; set; }

        [Required]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "Registered email")]
        public string regEmail { get; set; }
    }
}