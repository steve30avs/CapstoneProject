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
    
    public partial class appointments_table
    {
        public int appointment_num { get; set; }
        public Nullable<System.DateTime> appointment_date { get; set; }
        public Nullable<System.TimeSpan> appointment_time { get; set; }
        public Nullable<int> user_num_request { get; set; }
        public string service_reason { get; set; }
        public string approved { get; set; }
    
        public virtual users_table users_table { get; set; }
    }
}
