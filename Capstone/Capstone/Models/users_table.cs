//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Capstone.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class users_table
    {
        public users_table()
        {
            this.appointments_table = new HashSet<appointments_table>();
            this.invoice_table = new HashSet<invoice_table>();
            this.message_table = new HashSet<message_table>();
        }
    
        public int user_num { get; set; }
        public string username { get; set; }
        public string user_email { get; set; }
        public string first_name { get; set; }
        public string last_name { get; set; }
        public string address { get; set; }
        public string password { get; set; }
        public Nullable<int> car_year { get; set; }
        public string car_brand { get; set; }
        public string car_model { get; set; }
    
        public virtual ICollection<appointments_table> appointments_table { get; set; }
        public virtual ICollection<invoice_table> invoice_table { get; set; }
        public virtual ICollection<message_table> message_table { get; set; }
    }
}
