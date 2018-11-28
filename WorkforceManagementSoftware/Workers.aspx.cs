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
    public class EventKiki
    {
        public string ID_res;
        public string Title;
        public string ParentId;
        public string Email;
        public string FirstName;
        public string LastName;
        public string VacationDayLeft;
        public string ID_event;
        public string Res_ID;
        public string Start;
        public string End;
        public string ID_smjene;
        public string smjena_ID;
        public string naziv_smjene;
        public string SmjenaSati;
        public string sumaSati;
    }

    public partial class Workers : Page
    {

        public void Page_Load(object sender, EventArgs e)
        {
            GetSumOfHour();
        }

        public string GetSumOfHour()
        {
            List<EventKiki> events = new List<EventKiki>();
            Dictionary<List<EventKiki>, List<EventKiki>> myLists = new Dictionary<List<EventKiki>, List<EventKiki>>();
            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString + "MultipleActiveResultSets=true";
            using (SqlConnection connection = new SqlConnection(connStr))
            using (SqlCommand command = new SqlCommand("SELECT TOP (1000) [unipuhrhost25com_workforcemanagementsoftware].[dbo].[ResourcesChild].[id], [title], [Parentid], [Email], [FirstName], [LastName], [VacationDayLeft], [unipuhrhost25com_workforcemanagementsoftware].[dbo].[Events].[ID],[ResourceId],[Start],[End],[id_smjene],[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Smjene].[id],[naziv],[SmjenaSati], DATEDIFF(day,[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Events].[Start], [unipuhrhost25com_workforcemanagementsoftware].[dbo].[Events].[End]) * SmjenaSati as Suma FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[ResourcesChild] JOIN[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Events] ON ResourcesChild.id = Events.ResourceId JOIN[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Smjene] ON Events.id_smjene = Smjene.id ORDER BY ResourcesChild.id", connection))
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    { 
                        EventKiki EventKiki = new EventKiki();
                        EventKiki.ID_res = reader["id"].ToString();
                        EventKiki.Title = reader["title"].ToString();
                        EventKiki.ParentId = reader["Parentid"].ToString();
                        EventKiki.FirstName = reader["FirstName"].ToString();
                        EventKiki.LastName = reader["LastName"].ToString();
                        EventKiki.VacationDayLeft = reader["VacationDayLeft"].ToString();
                        EventKiki.ID_event = reader["ID"].ToString();
                        EventKiki.Res_ID = reader["ResourceId"].ToString();
                        EventKiki.Start = Convert.ToDateTime(reader["Start"]).ToString("MM/dd/yyyy");
                        EventKiki.End = Convert.ToDateTime(reader["End"]).ToString("MM/dd/yyyy");
                        EventKiki.ID_smjene = reader["id_smjene"].ToString();
                        EventKiki.smjena_ID = reader["id"].ToString();
                        EventKiki.naziv_smjene = reader["naziv"].ToString();
                        EventKiki.SmjenaSati = reader["SmjenaSati"].ToString();
                        EventKiki.sumaSati = reader["Suma"].ToString();

                       
                   

    
                        events.Add(EventKiki);
                       
                    
                    }
                }
                connection.Close();
            }

            return null;
        }
    }

}