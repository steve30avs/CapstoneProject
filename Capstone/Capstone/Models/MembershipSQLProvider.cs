using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Web;
using System.Web.Security;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.Odbc;
using System.Configuration;


namespace Capstone.Models
{
    public class MembershipSQLProvider : MembershipProvider
    {
        capstoneEntities storeDB = new capstoneEntities();

        public override MembershipUser CreateUser(string username, string password,
       string email, string passwordQuestion, string passwordAnswer,
       bool isApproved, object providerUserKey, out MembershipCreateStatus status)
        {
            ValidatePasswordEventArgs args =
               new ValidatePasswordEventArgs(username, password, true);
            OnValidatingPassword(args);

            if (args.Cancel)
            {
                status = MembershipCreateStatus.InvalidPassword;
                return null;
            }

            if (RequiresUniqueEmail && GetUserNameByEmail(email) != string.Empty)
            {
                status = MembershipCreateStatus.DuplicateEmail;
                return null;
            }

            MembershipUser user = GetUser(username, true);

            if (user == null)
            {
                UserModel newUser = new UserModel();
                newUser.username = username;
                newUser.password = GetMD5Hash(password);
                newUser.user_email = email;

                Capstone.Controllers.UserController userRep = new Capstone.Controllers.UserController();
                userRep.RegisterUser(newUser);

                status = MembershipCreateStatus.Success;

                return GetUser(username, true);
            }
            else
            {
                status = MembershipCreateStatus.DuplicateUserName;
            }

            return null;
        }
        public override MembershipUser GetUser(string username, bool userIsOnline)
        {
            Capstone.Controllers.UserController userRep = new Capstone.Controllers.UserController();
            UserModel user = userRep.GetAllUsers().FirstOrDefault(u => u.username == username);
            if (user != null)
            {
                MembershipUser memUser = new MembershipUser("MembershipSQLProvider",
                                               username, user.user_num, user.user_email,
                                               string.Empty, string.Empty,
                                               true, false, DateTime.MinValue,
                                               DateTime.MinValue,
                                               DateTime.MinValue,
                                               DateTime.Now, DateTime.Now);
                return memUser;
            }
            return null;
        }

        public override bool ValidateUser(string username, string password)
        {
            string sha1Pswd = GetMD5Hash(password);
            Capstone.Controllers.UserController user = new Capstone.Controllers.UserController();
            UserModel userObj = user.GetUserByUserName(username, sha1Pswd);
            if (userObj != null)
                return true;
            return false;
        }

        public override int MinRequiredPasswordLength
        {
            get { return 6; }
        }

        public override bool RequiresUniqueEmail
        {
            // In a real application, you will essentially have to return true
            // and implement the GetUserNameByEmail method to identify duplicates
            get { return false; }
        }

        public static string GetMD5Hash(string value)
        {
            MD5 md5Hasher = MD5.Create();
            byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(value));
            StringBuilder sBuilder = new StringBuilder();
            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x2"));
            }
            return sBuilder.ToString();
        }

        public override string ApplicationName
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotImplementedException();
            }
        }

        public override bool ChangePassword(string username, string oldPassword, string newPassword)
        {
            var userItem = storeDB.users_table.FirstOrDefault(users_table => users_table.username == username.ToLower());
            try
            {
                userItem.password = GetMD5Hash(newPassword);
                storeDB.Entry(userItem).State = System.Data.EntityState.Modified;
                storeDB.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                throw e;
            }
    
        }

        public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteUser(string username, bool deleteAllRelatedData)
        {
            throw new NotImplementedException();
        }

        public override bool EnablePasswordReset
        {
            get { throw new NotImplementedException(); }
        }

        public override bool EnablePasswordRetrieval
        {
            get { throw new NotImplementedException(); }
        }

        public override MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override int GetNumberOfUsersOnline()
        {
            throw new NotImplementedException();
        }

        public override string GetPassword(string username, string answer)
        {
            throw new NotImplementedException();
        }

        public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
        {
            throw new NotImplementedException();
        }

        public override string GetUserNameByEmail(string email)
        {
            throw new NotImplementedException();
        }

        public override int MaxInvalidPasswordAttempts
        {
            get { throw new NotImplementedException(); }
        }

        public override int MinRequiredNonAlphanumericCharacters
        {
            get { throw new NotImplementedException(); }
        }

        public override int PasswordAttemptWindow
        {
            get { throw new NotImplementedException(); }
        }

        public override MembershipPasswordFormat PasswordFormat
        {
            get { throw new NotImplementedException(); }
        }

        public override string PasswordStrengthRegularExpression
        {
            get { throw new NotImplementedException(); }
        }

        public override bool RequiresQuestionAndAnswer
        {
            get { throw new NotImplementedException(); }
        }

        public override string ResetPassword(string username, string answer)
        {
            throw new NotImplementedException();
        }

        public override bool UnlockUser(string userName)
        {
            throw new NotImplementedException();
        }

        public override void UpdateUser(MembershipUser user)
        {
            throw new NotImplementedException();
        }
    }
}