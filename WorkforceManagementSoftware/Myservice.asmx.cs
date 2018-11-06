using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
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
        public string ID;
        public string ResourceId;
        public string Start;
        public string End;
        public string Title;

    }
    public class Resources
    {
        public string id;
        public string title;
        public string resourceid;

    }
    [System.Web.Script.Services.ScriptService]
    public class Myservice : System.Web.Services.WebService
    {
        public object jsonString { get; private set; }

        [WebMethod]
        public JsonResult  GetEvents()
        {

            List<EventSeba> events = new List<EventSeba>();
            List<Resources> sljakeri = new List<Resources>();
            Dictionary<List<EventSeba>, List<EventSeba>> myLists = new Dictionary<List<EventSeba>, List<EventSeba>>();
            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connStr))
            using (SqlCommand command = new SqlCommand("SELECT TOP (1000) [ID],[ResourceId],[Start],[End],[Title] FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Events]", connection))
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {

                EventSeba EventSeba = new EventSeba();
                EventSeba.ID = reader["ID"].ToString();
                EventSeba.ResourceId = reader["ResourceId"].ToString();
                //EventSeba.Start = reader["Start"].ToString();
                EventSeba.Start = Convert.ToDateTime(reader["Start"]).ToString("MM/dd/yyyy");
                 EventSeba.End = Convert.ToDateTime(reader["End"]).ToString("MM/dd/yyyy");
                 EventSeba.Title = reader["Title"].ToString();
                events.Add(EventSeba);
                        



                    }




                }
                
            }


            string connStr1 = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            using (SqlConnection connection1 = new SqlConnection(connStr))
            using (SqlCommand command1 = new SqlCommand("SELECT unipuhrhost25com_workforcemanagementsoftware.dbo.ResourcesChild.id,unipuhrhost25com_workforcemanagementsoftware.dbo.ResourcesChild.title,unipuhrhost25com_workforcemanagementsoftware.dbo.ResourcesParent.id FROM unipuhrhost25com_workforcemanagementsoftware.dbo.ResourcesChild FULL OUTER JOIN unipuhrhost25com_workforcemanagementsoftware.dbo.ResourcesParentON unipuhrhost25com_workforcemanagementsoftware.dbo.ResourcesChild.resourceid = unipuhrhost25com_workforcemanagementsoftware.dbo.ResourcesParent.id", connection1))
            {
                connection1.Open();
                using (SqlDataReader reader1 = command1.ExecuteReader())
                {

                    while (reader1.Read())
                    {
                        Resources resources = new Resources();
                        resources.id = reader1["id"].ToString();
                        resources.title = reader1["title"].ToString();
                        
                        resources.resourceid = reader1["resourceid"].ToString();


                        sljakeri.Add(resources);



                    }

                }
            }
            //string seba = events.ToString();
            //var jObj = JsonConvert.DeserializeObject(seba) as JObject;
            //var result = jObj["data"].Children()
            //                .Cast<JProperty>()
            //                .Select(x => new {
            //                    Title = (string)x.Value["title"],
            //                    Author = (string)x.Value["author"],
            //                })
            //                .ToList();
            EventSeba[] array = events.ToArray();
            Resources[] array2 = sljakeri.ToArray();
            var jaggedArray = new object[2];
            jaggedArray[0] = new[] { array };
            jaggedArray[1] = new[] { array2 };
           // JavaScriptSerializer jss = new JavaScriptSerializer();
           // jsonString = jss.Serialize(events);

            return new JsonResult { Data = jaggedArray, JsonRequestBehavior = JsonRequestBehavior.AllowGet };


            //return new JsonResult { Data = events, JsonRequestBehavior = JsonRequestBehavior.AllowGet };


        }

    }
}
