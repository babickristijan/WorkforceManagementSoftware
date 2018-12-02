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
    public partial class AddShift : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void SubmitForm(object sender, EventArgs e)
        {
            //   string test = ((TextBox)form3.FindControl("firstname")).Text;

            string name = shift_name.Text.ToString();
            string color = shift_color.Text.ToString();
            string value = shift_value.Text.ToString();
            bool is_godisnji = shift_is_godisnji.Checked;
            

            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connStr);

            con.Open();
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = "INSERT INTO [unipuhrhost25com_workforcemanagementsoftware].dbo.Smjene (naziv, color, SmjenaSati, is_godisnji_odmor) VALUES(@name, @color,@value, @is_godisnji)";
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@color", color);
            cmd.Parameters.AddWithValue("@value", value);
            cmd.Parameters.AddWithValue("@is_godisnji", is_godisnji);

            cmd.ExecuteNonQuery();



            con.Close();

            Response.Redirect(Request.Url.AbsoluteUri);
        }
    }
}