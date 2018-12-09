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
    public class Categorie
    {
        public string id;
        public string name;

    }
    public partial class Categories : System.Web.UI.Page
    {
        public List<Categorie> categorie = new List<Categorie>();
        public void Page_Load(object sender, EventArgs e)
        {
            GetSumOfHour();

        }

        public List<Categorie> GetSumOfHour()
        {


            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString + "MultipleActiveResultSets=true";
            using (SqlConnection connection = new SqlConnection(connStr))
            using (SqlCommand command = new SqlCommand("SELECT TOP (1000) [id],[title] FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[ResourcesParent]", connection))
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        Categorie mycategorie = new Categorie();
                        mycategorie.id = reader["id"].ToString();
                        mycategorie.name = reader["title"].ToString();
                        categorie.Add(mycategorie);


                    }

                }

                connection.Close();

            }


            return categorie;
        }
    }
}