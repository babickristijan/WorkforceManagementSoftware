using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WorkforceManagementSoftware
{

    public class Position
    {
        public string id;
        public string name;

    }


    public partial class Positions : System.Web.UI.Page
    {
        
        //public List<string> Sites = new List<string> { "test" };
        public List<Position> pozicije = new List<Position>();
        public void Page_Load(object sender, EventArgs e)
        {
            GetSumOfHour();

        }

        public List<Position> GetSumOfHour()
        {

            
            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString + "MultipleActiveResultSets=true";
            using (SqlConnection connection = new SqlConnection(connStr))
            using (SqlCommand command = new SqlCommand("SELECT TOP (1000) [id],[naziv_pozicije] FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Positions]", connection))
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        Position mojepozicije = new Position();
                        mojepozicije.id = reader["id"].ToString();
                        mojepozicije.name = reader["naziv_pozicije"].ToString();
                        pozicije.Add(mojepozicije);


                    }

                }

                connection.Close();

            }


            return pozicije;
        }
    }
}
