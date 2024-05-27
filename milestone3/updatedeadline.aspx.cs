using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;

namespace milestone3
{
    public partial class updatedeadline : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Retrieve the user ID from the query string
            string userId = Request.QueryString["userId"];

            if (!string.IsNullOrEmpty(userId))
            {
                // Assign the user ID to the literal for display
                //  lblUserId.Text = userId;
            }
        }

        [WebMethod]
        public static tasskdata GetUserTaskData(string userId)
        {
            // This method will be called asynchronously via AJAX
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["doniaAhmed"].ConnectionString;
            tasskdata tasskdata = new tasskdata();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("ViewMyTask", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        // Parameters
                        command.Parameters.Add("@user_id", SqlDbType.Int).Value = Convert.ToInt32(userId);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Populate the user data
                                tasskdata.Taskid = Convert.ToInt32(reader["Task_id"]);
                                tasskdata.Name = reader["TaskName"].ToString();
                                tasskdata.creation = Convert.ToDateTime(reader["CreationDate"]).ToString("yyyy-MM-dd");
                                tasskdata.due = Convert.ToDateTime(reader["DueDate"]).ToString("yyyy-MM-dd");

                                tasskdata.reminder = Convert.ToDateTime(reader["reminder_date"]).ToString("yyyy-MM-dd");
                                tasskdata.category = reader["category"].ToString();
                                tasskdata.creator = Convert.ToInt32(reader["creator"]);
                                tasskdata.statuss = reader["statuss"].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                // For now, let's log the error
                Console.WriteLine($"An error occurred: {ex.Message}");
            }

            return tasskdata;
        }
        public class DeadlineResponse
        {
            public bool Success { get; set; }
            public string ErrorMessage { get; set; }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static DeadlineResponse UpdateDeadline(string taskId, string deadlinedate)
        {
            try
            {
                if (string.IsNullOrEmpty(taskId) || string.IsNullOrEmpty(deadlinedate))
                {
                    return new DeadlineResponse { Success = false, ErrorMessage = "Invalid parameters" };
                }

                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["doniaAhmed"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("UpdateTaskDeadline", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@deadline", DateTime.Parse(deadlinedate));
                        command.Parameters.AddWithValue("@task_id", Convert.ToInt32(taskId));

                        command.ExecuteNonQuery();

                        return new DeadlineResponse { Success = true, ErrorMessage = "" };
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception using a logging framework or system
                // For example: Log.Error($"An error occurred: {ex.Message}");

                return new DeadlineResponse { Success = false, ErrorMessage = ex.Message };
            }
        }
    }

    public class tasskdata
    {
        public int Taskid { get; set; }
        public string Name { get; set; }
        public string creation { get; set; }
        public string due { get; set; }
        public string category { get; set; }
        public int creator { get; set; }
        public string statuss { get; set; }

        public string reminder { get; set; }
    }
}