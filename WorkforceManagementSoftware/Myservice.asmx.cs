using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Services;



namespace WorkforceManagementSoftware
{

    /// <summary>
    /// Summary description for Myservice
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class EventSeba
    {
        public string EventID;
        public string Subject;
        public string Description;
        public string Start;
        public string End;
        public string ThemeColor;
        public string IsFullDay;

    }
    public class Sljakeri
    {
        public string id;
        public string name;

    }
    [System.Web.Script.Services.ScriptService]
    public class Myservice : System.Web.Services.WebService
    {
        public object jsonString { get; private set; }

        [WebMethod]
        public JsonResult  GetEvents()
        {

            List<EventSeba> events = new List<EventSeba>();
            List<Sljakeri> sljakeri = new List<Sljakeri>();
            Dictionary<List<EventSeba>, List<EventSeba>> myLists = new Dictionary<List<EventSeba>, List<EventSeba>>();
            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connStr))
            using (SqlCommand command = new SqlCommand("SELECT TOP (1000) [EventID],[Subject],[Description],[Start],[End],[ThemeColor],[IsFullDay] FROM[metrisco_apartmentsgalli].[dbo].[Events] order by ThemeColor", connection))
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {

                EventSeba EventSeba = new EventSeba();
                EventSeba.EventID = reader["EventID"].ToString();
                EventSeba.Subject = reader["Subject"].ToString();
                EventSeba.Description = reader["Description"].ToString();
                EventSeba.Start = reader["Start"].ToString();
                EventSeba.End = reader["End"].ToString();
                EventSeba.ThemeColor = reader["ThemeColor"].ToString();
                EventSeba.IsFullDay = reader["IsFullDay"].ToString();
                events.Add(EventSeba);
                        string connStr1 = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
                        using (SqlConnection connection1 = new SqlConnection(connStr))
                        using (SqlCommand command1 = new SqlCommand("SELECT TOP (1000) [ID],[Name]FROM[metrisco_apartmentsgalli].[dbo].[Radnici]", connection1))
                        {
                            connection1.Open();
                            using (SqlDataReader reader1 = command1.ExecuteReader())
                            {

                                while (reader1.Read())
                                {
                                    Sljakeri Sljakeri = new Sljakeri();
                                    Sljakeri.id = reader1["ID"].ToString();
                                    Sljakeri.name = reader1["Name"].ToString();

                                    sljakeri.Add(Sljakeri);



                                }

                            }
                        }



                    }
                   
                    


                }
                
            }
            EventSeba[] array = events.ToArray();
            Sljakeri[] array2 = sljakeri.ToArray();
            var jaggedArray = new object[2];
            jaggedArray[0] = new[] { array };
            jaggedArray[1] = new[] { array2 };
            //JavaScriptSerializer jss = new JavaScriptSerializer();
            //jsonString = jss.Serialize(events);

            return new JsonResult { Data = jaggedArray, JsonRequestBehavior = JsonRequestBehavior.AllowGet };


            //return new JsonResult { Data = events, JsonRequestBehavior = JsonRequestBehavior.AllowGet };


        }

    }
}
