using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Security;

namespace WorkforceManagementSoftware
{

    public partial class SiteMaster : MasterPage
    {

        //public string variable { get; set; }


        protected void Page_Load(object sender, EventArgs e)
        {

            bool isAdmin = false;
            string constr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();

                SqlCommand cmd1 = con.CreateCommand();
                cmd1.CommandText = "SELECT TOP (1000) [UserId],[Username],[Password],[Email],[CreatedDate],[LastLoginDate],[IsAdmin] FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Users] where Username = @Username";
                cmd1.Parameters.AddWithValue("@Username", this.Page.User.Identity.Name);

                using (SqlDataReader reader1 = cmd1.ExecuteReader())
                {

                    while (reader1.Read())
                    {

                        isAdmin = Convert.ToBoolean(reader1["IsAdmin"]);

                    }

                }
                con.Close();


                if (!this.Page.User.Identity.IsAuthenticated || !isAdmin)
                {


                    FormsAuthentication.RedirectToLoginPage();
                }


            }
        }

    }

}
