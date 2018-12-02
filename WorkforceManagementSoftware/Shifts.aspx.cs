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
    public class Shift
    {
        public string id;
        public string name;
        public string color;
        public string shift_value;
        public string is_godisnji_odmor;
    }

    public partial class Shifts : Page
    {
        public List<Shift> ListOfShifts = new List<Shift>();
        protected void Page_Load(object sender, EventArgs e)
        {
            GetShifts();
        }


        public List<Shift> GetShifts()
        {

            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString + "MultipleActiveResultSets=true";
            using (SqlConnection connection = new SqlConnection(connStr))
            using (SqlCommand command = new SqlCommand("SELECT TOP (1000) [id],[naziv],[color],[SmjenaSati],[is_godisnji_odmor] FROM [unipuhrhost25com_workforcemanagementsoftware].[dbo].[Smjene]", connection))
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        Shift Shift = new Shift();
                        Shift.id = reader["id"].ToString();
                        Shift.name = reader["naziv"].ToString();
                        Shift.color = reader["color"].ToString();
                        Shift.shift_value = reader["SmjenaSati"].ToString();
                        Shift.is_godisnji_odmor = reader["is_godisnji_odmor"].ToString();
                        if (Shift.is_godisnji_odmor == "1")
                        {
                            Shift.is_godisnji_odmor = "DA";
                        }
                        else
                        {
                            Shift.is_godisnji_odmor = "NE";
                        }
                        ListOfShifts.Add(Shift);

                    }
                }
                connection.Close();
            }

            return ListOfShifts;
        }
    }
}