using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq.Mapping;
using System.Web;
//using System.ComponentModel.DataAnnotations.Schema;
//using System.ComponentModel.DataAnnotations.Resources;

namespace Capstone.Models
{
    [Table(Name = "users_table")]
    public class UserModel
    {
        [Column(IsPrimaryKey = true, IsDbGenerated = true, AutoSync = AutoSync.OnInsert)]
        public int user_num { get; set; }
        [Column]
        public string username { get; set; }
        [Column]
        public string password { get; set; }
        [Column]
        public string user_email { get; set; }
        [Column]
        public string first_name { get; set; }
        [Column]
        public string last_name { get; set; }
        [Column]
        public string address { get; set; }

    }
}