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
    public class ResourcesChild
    {
        public string id;
        public string title;
        public string parentid;

    }

    public class ResourcesParent
    {
        public string id;
        public string title;

    }



    [System.Web.Script.Services.ScriptService]
    public class Myservice : System.Web.Services.WebService
    {
        public object jsonString { get; private set; }

        [WebMethod]
        public JsonResult  GetEvents()
        {

            List<EventSeba> events = new List<EventSeba>();
            List<ResourcesChild> sljakeri = new List<ResourcesChild>();
            List<ResourcesParent> sljakeriparent = new List<ResourcesParent>();
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
            using (SqlCommand command1 = new SqlCommand("SELECT TOP (1000) [id],[title],[Parentid] FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[ResourcesChild]", connection1))
            {
                connection1.Open();
                using (SqlDataReader reader1 = command1.ExecuteReader())
                {

                    while (reader1.Read())
                    {
                        ResourcesChild resources = new ResourcesChild();
                        resources.id = reader1["id"].ToString();
                        resources.title = reader1["title"].ToString();
                        resources.parentid = reader1["Parentid"].ToString();


                        sljakeri.Add(resources);



                    }

                }
            }


            string connStr2 = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            using (SqlConnection connection2 = new SqlConnection(connStr))
            using (SqlCommand command2 = new SqlCommand("SELECT TOP (1000) [id],[title]FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[ResourcesParent]", connection2))
            {
                connection2.Open();
                using (SqlDataReader reader2 = command2.ExecuteReader())
                {

                    while (reader2.Read())
                    {
                        ResourcesParent resourcesparent = new ResourcesParent();
                        resourcesparent.id = reader2["id"].ToString();
                        resourcesparent.title = reader2["title"].ToString();


                        sljakeriparent.Add(resourcesparent);



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
            ResourcesChild[] array2 = sljakeri.ToArray();
            ResourcesParent[] array3 = sljakeriparent.ToArray();
            var jaggedArray = new object[3];
            jaggedArray[0] = new[] { array };
            jaggedArray[1] = new[] { array2 };
            jaggedArray[2] = new[] { array3 };

            // JavaScriptSerializer jss = new JavaScriptSerializer();
            // jsonString = jss.Serialize(events);

            return new JsonResult { Data = jaggedArray, JsonRequestBehavior = JsonRequestBehavior.AllowGet };


            //return new JsonResult { Data = events, JsonRequestBehavior = JsonRequestBehavior.AllowGet };


        }

    }
}
