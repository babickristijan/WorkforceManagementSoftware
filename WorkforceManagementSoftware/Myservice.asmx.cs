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
using System.Web.Script.Services;
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
        public string color;
        public string godisnji;

    }

    public class EditWorker
    {
        public string id;
        public string title;
        public string parent_id;
        public string email;
        public string firstname;
        public string lastname;
        public string vacation_day_left;
    }
    public class ResourcesChild
    {
        public string id;
        public string title;
        public string parentid;
        public string firstname;
        public string lastname;

    }

    public class ResourcesParent
    {
        public string id;
        public string title;

    }

    public class PushEvents
    {
        public string ResourceId1;
        public string Start1;
        public string End1;
        public string Title1;
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
            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString + "MultipleActiveResultSets=true";
            using (SqlConnection connection = new SqlConnection(connStr))
            using (SqlCommand command = new SqlCommand("SELECT TOP (1000) [ID],[ResourceId],[Start],[End],[id_smjene] FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Events]", connection))
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {
                var naziv_smjene = "";
                var id_smjene = "";
                var godisnji = "";
                var color = "";
                EventSeba EventSeba = new EventSeba();
                EventSeba.ID = reader["ID"].ToString();
                EventSeba.ResourceId = reader["ResourceId"].ToString();
                EventSeba.Start = Convert.ToDateTime(reader["Start"]).ToString("MM/dd/yyyy");
                 EventSeba.End = Convert.ToDateTime(reader["End"]).ToString("MM/dd/yyyy");
                 
                 id_smjene = reader["id_smjene"].ToString();
                 events.Add(EventSeba);

                        using (SqlCommand command1 = new SqlCommand("SELECT TOP (100) [id],[naziv],[color],[is_godisnji_odmor],[color]FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Smjene] where id =" + id_smjene, connection))
                        {
                            
                            using (SqlDataReader reader1 = command1.ExecuteReader())
                            {

                                while (reader1.Read())
                                {

                                    naziv_smjene = reader1["naziv"].ToString();
                                    godisnji = reader1["is_godisnji_odmor"].ToString();
                                    color = reader1["color"].ToString();
                                    EventSeba.Title = naziv_smjene;
                                    EventSeba.color = color;
                                    EventSeba.godisnji = godisnji;









                                }




                            }

                        }


                    }

                }
                connection.Close();
                
            }





            string connStr1 = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            using (SqlConnection connection1 = new SqlConnection(connStr))
            using (SqlCommand command1 = new SqlCommand("SELECT TOP (1000) [id],[Positionid],[Parentid],[FirstName],[LastName] FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[ResourcesChild]", connection1))
            {
                connection1.Open();
                using (SqlDataReader reader1 = command1.ExecuteReader())
                {

                    while (reader1.Read())
                    {

                        var position_id = reader1["Positionid"].ToString();
                        ResourcesChild resources = new ResourcesChild();
                        using (SqlCommand command3 = new SqlCommand("SELECT TOP (1000) [naziv_pozicije] FROM [unipuhrhost25com_workforcemanagementsoftware].[dbo].[Positions] WHERE id =" + position_id, connection1))
                        {

                            using (SqlDataReader reader3 = command3.ExecuteReader())
                            {

                                while (reader3.Read())
                                {

                                 resources.title = reader3["naziv_pozicije"].ToString();

                                }




                            }

                        }
                       
                        resources.id = reader1["id"].ToString();
                       
                        resources.parentid = reader1["Parentid"].ToString();
                        resources.firstname = reader1["FirstName"].ToString();
                        resources.lastname = reader1["LastName"].ToString();


                        sljakeri.Add(resources);



                    }

                }
                connection1.Close();
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
                connection2.Close();
            }

            EventSeba[] array = events.ToArray();
            ResourcesChild[] array2 = sljakeri.ToArray();
            ResourcesParent[] array3 = sljakeriparent.ToArray();
            var jaggedArray = new object[3];
            jaggedArray[0] = new[] { array };
            jaggedArray[1] = new[] { array2 };
            jaggedArray[2] = new[] { array3 };


            return new JsonResult { Data = jaggedArray, JsonRequestBehavior = JsonRequestBehavior.AllowGet };



        }
       
        [WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        public JsonResult PushEvents(string startDate, string endDate, string shiftPicker, string resourceIdHidden, string godisnji)
        {
            int mojsql;
            var nazivSmjene = "";
            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connStr);
        

            con.Open();
            if (godisnji == "1")
            {
                SqlCommand cmd1 = con.CreateCommand();
                cmd1.CommandText = "UPDATE ResourcesChild SET [VacationDayLeft] = [VacationDayLeft]-1 WHERE[ID] = @idRes" ;
                cmd1.Parameters.AddWithValue("@idRes", resourceIdHidden);
               

                cmd1.ExecuteNonQuery();
            }
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = "INSERT INTO [unipuhrhost25com_workforcemanagementsoftware].dbo.Events (ResourceId, Start, \"End\", id_smjene) VALUES(@id, @startdate,@endDate, @shiftPicker)";
            cmd.Parameters.AddWithValue("@id", resourceIdHidden);
            cmd.Parameters.AddWithValue("@startdate", startDate);
            cmd.Parameters.AddWithValue("@endDate", endDate);
            cmd.Parameters.AddWithValue("@shiftPicker", shiftPicker);
            
            cmd.ExecuteNonQuery();

            cmd.CommandText = "Select @@Identity";
 
            mojsql = Convert.ToInt32(cmd.ExecuteScalar());



            using (SqlCommand command1 = new SqlCommand("SELECT TOP (100) [id],[naziv],[color]FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Smjene] where id =" + shiftPicker, con))
            {

                using (SqlDataReader reader1 = command1.ExecuteReader())
                {

                    while (reader1.Read())
                    {

                        nazivSmjene = reader1["naziv"].ToString();

                    }

                }

            }
            con.Close();
            
            var jaggedArray = new object[2];
            jaggedArray[0] = mojsql.ToString();
            jaggedArray[1] = nazivSmjene;

            return new JsonResult { Data = jaggedArray, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }



        [WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        public string UpdateEvents(string startDate, string endDate, string shiftPicker, string resourceIdHidden)
        {
          
            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connStr);

            con.Open();
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = "UPDATE Events SET [Start] =  @startDate,[End] = @endDate  WHERE[ID] = @shiftPicker";
            cmd.Parameters.AddWithValue("@id", resourceIdHidden);
            cmd.Parameters.AddWithValue("@startdate", startDate);
            cmd.Parameters.AddWithValue("@endDate", endDate);
            cmd.Parameters.AddWithValue("@shiftPicker", shiftPicker);

            cmd.ExecuteNonQuery();

          

            


            con.Close();

            return "";
        }

        [WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        public string UpdateShifts(string idSmjene, string idEventa)
        {

            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connStr);

            con.Open();
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = "UPDATE Events SET [id_smjene] =  @id_smjene WHERE[ID] = @id";
            cmd.Parameters.AddWithValue("@id", idEventa);
            cmd.Parameters.AddWithValue("@id_smjene", idSmjene);

            cmd.ExecuteNonQuery();






            con.Close();

            return "";
        }


        [WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        public string DeleteEvent(string idEventa, string godisnji, string resource_id_godisnji)
        {

            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connStr);

            con.Open();
            if(godisnji == "1")
            {
                SqlCommand cmd1 = con.CreateCommand();
                cmd1.CommandText = "UPDATE ResourcesChild SET [VacationDayLeft] = [VacationDayLeft]+1 WHERE [ID] = @id";
                cmd1.Parameters.AddWithValue("@id", resource_id_godisnji);

                

                cmd1.ExecuteNonQuery();
            }
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = "DELETE FROM Events WHERE [ID] = @id";
            cmd.Parameters.AddWithValue("@id", idEventa);

            cmd.ExecuteNonQuery();






            con.Close();

            return "";
        }


        [WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        public string DeleteWorker(string id)
        {

            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connStr);

            con.Open();
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = "DELETE FROM Events WHERE [ResourceId] = @ResourceId";
            cmd.Parameters.AddWithValue("@ResourceId", id);
            cmd.ExecuteNonQuery();

            cmd.CommandText = "DELETE FROM ResourcesChild WHERE [id] = @id";
            cmd.Parameters.AddWithValue("@id", id);

            cmd.ExecuteNonQuery();

     






            con.Close();

            return "";
        }

        [WebMethod]
        public JsonResult GetDataForEditWorker(string id_worker)
        {

            string id="";
            string position_id= "";
            string parent_id = "";
            string email = "";
            string firstname = "";
            string lastname = "";
            string vacation_day_left = "";

            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString + "MultipleActiveResultSets=true";
            using (SqlConnection connection = new SqlConnection(connStr))
            using (SqlCommand command = new SqlCommand("SELECT TOP (1000) [id],[Positionid],[Parentid],[Email],[FirstName],[LastName],[VacationDayLeft] FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[ResourcesChild] WHERE id="+id_worker, connection))
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {
                       
                        id = reader["id"].ToString();
                        position_id = reader["Positionid"].ToString();
                        parent_id = reader["Parentid"].ToString();
                        email = reader["Email"].ToString();
                        firstname = reader["FirstName"].ToString();
                        lastname = reader["LastName"].ToString();
                        vacation_day_left = reader["VacationDayLeft"].ToString();


                    }

                }
                connection.Close();

            }


            string [] array=new string[] { id, position_id, parent_id,email,firstname,lastname,vacation_day_left};
   


            return new JsonResult { Data = array, JsonRequestBehavior = JsonRequestBehavior.AllowGet };



        }

        [WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        public string UpdateWorker(string id, string firstname, string lastname, string vacationDayLeft, string workerCategory, string workerPosition, string email)
        {

            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connStr);

            con.Open();
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = "UPDATE ResourcesChild SET [Positionid] =  @positionid,[Parentid] = @parent_id,[Email] = @email,[FirstName] = @firstname,[LastName] = @lastname,[VacationDayLeft] = @vacation_left   WHERE[id] = @id";
            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@positionid", workerPosition);
            cmd.Parameters.AddWithValue("@firstname", firstname);
            cmd.Parameters.AddWithValue("@lastname", lastname);
            cmd.Parameters.AddWithValue("@email", email);
            cmd.Parameters.AddWithValue("@parent_id", workerCategory);
            cmd.Parameters.AddWithValue("@vacation_left", vacationDayLeft);
            cmd.ExecuteNonQuery();






            con.Close();

            return "";
        }

        [WebMethod]
        public JsonResult GetDataForEditShift(string id_shift)
        {

            string id = "";
            string name = "";
            string color = "";
            string value = "";
            string is_godisnji = "";
    

            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString + "MultipleActiveResultSets=true";
            using (SqlConnection connection = new SqlConnection(connStr))
            using (SqlCommand command = new SqlCommand("SELECT TOP (1000) [id],[naziv],[color],[SmjenaSati],[is_godisnji_odmor] FROM[unipuhrhost25com_workforcemanagementsoftware].[dbo].[Smjene] WHERE id=" + id_shift, connection))
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {

                        id = reader["id"].ToString();
                        name = reader["naziv"].ToString();
                        color = reader["color"].ToString();
                        value = reader["SmjenaSati"].ToString();
                        is_godisnji = reader["is_godisnji_odmor"].ToString();
 
                    }

                }
                connection.Close();

            }


            string[] array = new string[] { id, name, color, value, is_godisnji };



            return new JsonResult { Data = array, JsonRequestBehavior = JsonRequestBehavior.AllowGet };



        }

        [WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        public string UpdateShift(string id, string name, string color, string value, string is_godisnji)
        {

            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connStr);

            con.Open();
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = "UPDATE Smjene SET [naziv] =  @name,[color] = @color,[SmjenaSati] = @value,[is_godisnji_odmor] = @is_godisnji  WHERE[id] = @id";
            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@color", color);
            cmd.Parameters.AddWithValue("@value", value);
            cmd.Parameters.AddWithValue("@is_godisnji", Convert.ToBoolean(is_godisnji));
            cmd.ExecuteNonQuery();






            con.Close();

            return "";
        }

        [WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        public string DeleteShift(string id)
        {

            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connStr);

            con.Open();
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = "DELETE FROM Events WHERE [id_smjene] = @smjena_id";
            cmd.Parameters.AddWithValue("@smjena_id", id);
            cmd.ExecuteNonQuery();

            cmd.CommandText = "DELETE FROM Smjene WHERE [id] = @id";
            cmd.Parameters.AddWithValue("@id", id);

            cmd.ExecuteNonQuery();








            con.Close();

            return "";
        }
    }
}
