using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;

namespace milestone3
{
    public partial class addreminder : System.Web.UI.Page
    {
        public class ReminderResponse
        {
            public bool Success { get; set; }
            public string ErrorMessage { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static ReminderResponse AddReminder(string taskId, string reminderDate)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["doniaAhmed"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("AddReminder", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@task_id", Convert.ToInt32(taskId));
                        command.Parameters.AddWithValue("@reminder", DateTime.Parse(reminderDate));

                        command.ExecuteNonQuery();

                        return new ReminderResponse { Success = true, ErrorMessage = "" };
                    }
                }
            }
            catch (Exception ex)
            {
                return new ReminderResponse { Success = false, ErrorMessage = ex.Message };
            }
        }
    }
}
