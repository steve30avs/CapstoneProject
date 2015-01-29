using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Data.Linq;
using System.Web;

namespace Capstone.Controllers
{
    public class UserController
    {
        private Table<Capstone.Models.UserModel> users_table;
        private DataContext context;

        public UserController()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CapstoneDBConnection"].ConnectionString;
            context = new DataContext(connectionString);
            users_table = context.GetTable<Capstone.Models.UserModel>();
        }

        // Gets user by their username and password
        public Capstone.Models.UserModel GetUserByUserName(string userName, string password)
        {
            Capstone.Models.UserModel userInstance = users_table.FirstOrDefault(u => u.username == userName && u.password == password);
            return userInstance;
        }

        // Gets user only by their username
        public Capstone.Models.UserModel GetUserByUserName(string userName)
        {
            Capstone.Models.UserModel userInstance = users_table.FirstOrDefault(u => u.username == userName);
            return userInstance;
        }

        public IEnumerable<Capstone.Models.UserModel> GetAllUsers()
        {
            return users_table.AsEnumerable();
        }

        public int RegisterUser(Capstone.Models.UserModel addedUser)
        {
            Capstone.Models.UserModel newUser = new Capstone.Models.UserModel();
            newUser.username = addedUser.username.ToLower();
            newUser.password = addedUser.password;
            newUser.user_email = addedUser.user_email;
            newUser.first_name = addedUser.first_name;
            newUser.last_name = addedUser.last_name;
            newUser.address = addedUser.address;
            
            users_table.InsertOnSubmit(newUser);
            context.SubmitChanges();

            return newUser.user_num;
        }
    }
}