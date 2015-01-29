using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Web.Mvc;
using System.Web.Security;

namespace Capstone.Models
{
    public class DatePickedModel
    {
        [Required]
        [DataType(DataType.Date)]
        [Display(Name = "dateSelected")]
        private string _dateSelected;
        public string dateSelected {
            get
            {
                return _dateSelected;
            }
            set
            {
                _dateSelected = value;
                //DateTime tempDate = DateTime.Parse(_dateSelected);
                //_dateSelected = tempDate.ToString();
            }
        }
    }
}