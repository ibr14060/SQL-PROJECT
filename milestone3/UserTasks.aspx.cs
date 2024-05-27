using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;

namespace milestone3
{
    public partial class UserTasks : System.Web.UI.Page
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
        public static TaskData GetUserTaskData(string userId)
        {
            // This method will be called asynchronously via AJAX
            string connectionString = ConfigurationManager.ConnectionStrings["doniaAhmed"].ConnectionString;
            TaskData TaskData = new TaskData();

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
                                TaskData.Taskid = Convert.ToInt32(reader["Task_id"]);
                                TaskData.Name = reader["TaskName"].ToString();
                                TaskData.creation = Convert.ToDateTime(reader["CreationDate"]).ToString("yyyy-MM-dd");
                                TaskData.due = Convert.ToDateTime(reader["DueDate"]).ToString("yyyy-MM-dd");
                              
                               TaskData.reminder= Convert.ToDateTime(reader["reminder_date"]).ToString("yyyy-MM-dd");
                                TaskData.category = reader["category"].ToString();
                                TaskData.creator = Convert.ToInt32(reader["creator"]);
                                TaskData.statuss = reader["statuss"].ToString();
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

            return TaskData;
        }
    }

    public class TaskData
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
