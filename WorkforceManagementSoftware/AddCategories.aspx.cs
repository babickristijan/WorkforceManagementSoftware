using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WorkforceManagementSoftware
{
    public partial class AddCategories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void SubmitForm(object sender, EventArgs e)
        {


            string name = category.Text.ToString();


            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connStr);

            con.Open();
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = "INSERT INTO [unipuhrhost25com_workforcemanagementsoftware].dbo.ResourcesParent (title) VALUES(@name)";
            cmd.Parameters.AddWithValue("@name", name);

            cmd.ExecuteNonQuery();



            con.Close();

            Response.Redirect(Request.Url.AbsoluteUri);
        }
    }
}