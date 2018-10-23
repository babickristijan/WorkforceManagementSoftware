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
   
    public partial class SiteMaster : MasterPage
    {
        public string variable { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            if (ConfigurationManager.ConnectionStrings["myConnectionString"] != null)
                Response.Write("postoji koonekcija");
            using (SqlConnection connection = new SqlConnection(connStr))
            using (SqlCommand command = new SqlCommand("SELECT TOP (1000) [ID] FROM[metrisco_apartmentsgalli].[metrisco_seba].[Table_1] where ID = '5'", connection))
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        variable = (reader["ID"].ToString());
                        Response.Write(reader["ID"].ToString());

                    }
                }
            }


        }
    }
}