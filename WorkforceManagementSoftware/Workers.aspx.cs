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
    public class Worker
    {
        public string id;
        public string title;
        public string ParentId;
        public string Email;
        public string FirstName;
        public string LastName;
        public string VacationDayLeft;
        public double hours;
        
    }

    public partial class Workers : Page
    {
        //public List<string> Sites = new List<string> { "test" };
        public List<Worker> ListOfWorkers = new List<Worker>();
        public void Page_Load(object sender, EventArgs e)
        {
            GetSumOfHour();
            
        }       

        public List <Worker>  GetSumOfHour()
        {
            
            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString + "MultipleActiveResultSets=true";
            using (SqlConnection connection = new SqlConnection(connStr))
            using (SqlCommand command = new SqlCommand("SELECT TOP (1000) [id],[title],[Parentid],[Email],[FirstName],[LastName],[VacationDayLeft] FROM [unipuhrhost25com_workforcemanagementsoftware].[dbo].[ResourcesChild] ORDER BY [FirstName]", connection))
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        Worker Worker = new Worker();
                        Worker.id = reader["id"].ToString();
                        Worker.title = reader["title"].ToString();
                        var parent_id= reader["Parentid"].ToString();
                     
                        Worker.FirstName = reader["FirstName"].ToString();
                        Worker.LastName = reader["LastName"].ToString();
                        Worker.VacationDayLeft = reader["VacationDayLeft"].ToString();
                        Worker.Email = reader["Email"].ToString();

                        using (SqlCommand command2 = new SqlCommand("SELECT TOP (1000) [title] FROM [unipuhrhost25com_workforcemanagementsoftware].[dbo].[ResourcesParent] WHERE id =" + parent_id, connection))
                        {

                            using (SqlDataReader reader2 = command2.ExecuteReader())
                            {

                                while (reader2.Read())
                                {

                                    Worker.ParentId = reader2["title"].ToString();

                                }




                            }

                        }
                        Double suma = 0;
                        using (SqlCommand command1 = new SqlCommand("SELECT TOP (1000) dbo.Events.[ID],[ResourceId],[Start],[End],[id_smjene],[SmjenaSati]FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Events] INNER JOIN[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Smjene] ON(dbo.Events.id_smjene = dbo.Smjene.[id]) where MONTH (Start) = MONTH(DATEADD (dd,0,GetDate())) and YEAR (Start) = YEAR(DATEADD (dd,0,GetDate())) and dbo.Events.ResourceId =" + Worker.id, connection))
                        {

                            using (SqlDataReader reader1 = command1.ExecuteReader())
                            {

                                while (reader1.Read())
                                {
                    
                                    Double SmjenaSati;

                                    DateTime StartDate = Convert.ToDateTime(reader1["Start"]);
                                    DateTime EndDate = Convert.ToDateTime(reader1["End"]);
                                    SmjenaSati = Convert.ToInt32(reader1["SmjenaSati"]);
                                    Double Days;
                                    
                                    
                                    Days = (EndDate - StartDate).TotalDays;
                                    if (Days == 0) Days = 1;
                                    suma += (Days * SmjenaSati);

                                }




                            }

                        }

                        Worker.hours = suma;
                        ListOfWorkers.Add(Worker);

                    }
                }
                connection.Close();
            }

            return ListOfWorkers;
        }
    }

}