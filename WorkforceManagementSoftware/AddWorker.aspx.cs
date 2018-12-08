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
    public partial class AddWorker : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        public void SubmitForm(object sender, EventArgs e)
        {
         //   string test = ((TextBox)form3.FindControl("firstname")).Text;

            string firstName = firstname.Text.ToString(); 
            string lastName = lastname.Text.ToString();
            string Email = email.Text.ToString();
            int ParentId = Convert.ToInt32(parentID.SelectedValue);
            int PositionId = Convert.ToInt32(positionID.SelectedValue);
          //  String Title = agenttitle.Text.ToString();
            int VacationDayLeft = Convert.ToInt32(vacationdayleft.Text);

            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connStr);

            con.Open();
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = "INSERT INTO [unipuhrhost25com_workforcemanagementsoftware].dbo.ResourcesChild (Parentid,Positionid, Email, FirstName, LastName, VacationDayLeft) VALUES(@parentID,@PositionId,@email, @firstname, @lastname,@VacationDayLeft)";
            cmd.Parameters.AddWithValue("@firstname", firstName);
            cmd.Parameters.AddWithValue("@lastname", lastName);
            cmd.Parameters.AddWithValue("@email", Email);
            cmd.Parameters.AddWithValue("@parentID", ParentId);
            cmd.Parameters.AddWithValue("@PositionId", PositionId);
            cmd.Parameters.AddWithValue("@VacationDayLeft", VacationDayLeft);

            cmd.ExecuteNonQuery();



            con.Close();

            Response.Redirect(Request.Url.AbsoluteUri);
        }
       // ou need to change public void klik(PaintEventArgs pea, EventArgs e) to public void klik(object sender, System.EventArgs e) because there is no Click event handler with parameters PaintEventArgs pea, EventArgs e.
    }
}