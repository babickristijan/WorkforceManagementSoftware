using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Security;
using System.Security.Cryptography;
using System.Text;

namespace WorkforceManagementSoftware
{
    public partial class loginpage : System.Web.UI.Page
    {

        public string Hash(string input)
        {
            using (SHA256 hasher = SHA256.Create())
            {
                // Convert the input string to a byte array and compute the hash.
                byte[] data = hasher.ComputeHash(Encoding.Unicode.GetBytes(input));

                // Create a new Stringbuilder to collect the bytes
                // and create a string.
                StringBuilder sBuilder = new StringBuilder();

                // Loop through each byte of the hashed data 
                // and format each one as a hexadecimal string.
                for (int i = 0; i < data.Length; i++)
                {
                    sBuilder.Append(data[i].ToString("X2"));
                }

                // Return the hexadecimal string.
                return sBuilder.ToString();
            }
        }


        protected void ValidateUser(object sender, EventArgs e)
            {
            int userId = 0;
            var passwordIzBaze = "";
            var hashiraniPassword = "";
            bool isAdmin = false;
            string constr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
           
                using (SqlConnection con = new SqlConnection(constr))
                {
                con.Open();



                SqlCommand cmd1 = con.CreateCommand();
                cmd1.CommandText = "SELECT TOP (1000) [UserId],[Username],[Password],[Email],[CreatedDate],[LastLoginDate],[IsAdmin] FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Users] where Username = @Username";
                cmd1.Parameters.AddWithValue("@Username", Login1.UserName);


                using (SqlDataReader reader1 = cmd1.ExecuteReader())
                {

                    while (reader1.Read())
                    {

                        isAdmin = Convert.ToBoolean(reader1["IsAdmin"]);

                    }

                }
                con.Close();

                using (SqlCommand cmd = new SqlCommand("Validate_User"))
                    {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Username", Login1.UserName);
                    passwordIzBaze = Login1.Password.ToString();
                    hashiraniPassword = Hash(passwordIzBaze);
                    cmd.Parameters.AddWithValue("@Password", hashiraniPassword);
                    cmd.Connection = con;
                        con.Open();
                        userId = Convert.ToInt32(cmd.ExecuteScalar());
                        
                        con.Close();
                    }
                    switch (userId)
                    {
                        case -1:
                            Login1.FailureText = "Username and/or password is incorrect.";
                            break;
                        case -2:
                            Login1.FailureText = "Account has not been activated.";
                            break;
                        default:
                        FormsAuthentication.SetAuthCookie(Login1.UserName, Login1.RememberMeSet);
                        if (isAdmin == true) { 
                            
                            Response.Redirect("Default.aspx");
                        } else
                        {
                            Response.Redirect("User.aspx");
                        }
                        break;
                    }
                }
            }
        
    }
}