using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;

namespace milestone3
{
    public partial class FinishTask : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string userId = Request.QueryString["userId"];

            if (!string.IsNullOrEmpty(userId))
            {
                // Assign the user ID to the literal for display
                //  lblUserId.Text = userId;
            }
        }

        [WebMethod]
        public static taskinfo GetUserTaskData(string userId)
        {
            // This method will be called asynchronously via AJAX
            string connectionString = ConfigurationManager.ConnectionStrings["doniaAhmed"].ConnectionString;
            taskinfo taskinfo = new taskinfo();

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
                                taskinfo.Taskid = Convert.ToInt32(reader["Task_id"]);
                                taskinfo.Name = reader["TaskName"].ToString();
                                taskinfo.creation = Convert.ToDateTime(reader["CreationDate"]).ToString("yyyy-MM-dd");
                                taskinfo.due = Convert.ToDateTime(reader["DueDate"]).ToString("yyyy-MM-dd");

                                taskinfo.reminder = Convert.ToDateTime(reader["reminder_date"]).ToString("yyyy-MM-dd");
                                taskinfo.category = reader["category"].ToString();
                                taskinfo.creator = Convert.ToInt32(reader["creator"]);
                                taskinfo.statuss = reader["statuss"].ToString();
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

            return taskinfo;
        }


        [WebMethod]
        public static FinishTaskResponse FinishTaskById(int taskId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["doniaAhmed"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("FinishMyTask", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@task_id", taskId);

                        command.ExecuteNonQuery();

                        return new FinishTaskResponse { Success = true, ErrorMessage = "" };
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the error using System.Diagnostics or a logging framework
                System.Diagnostics.Trace.WriteLine($"An error occurred: {ex.Message}");

                return new FinishTaskResponse { Success = false, ErrorMessage = ex.Message };
            }
            Console.WriteLine(taskId);
        }

   

}

    public class FinishTaskResponse
    {
        public bool Success { get; set; }
        public string ErrorMessage { get; set; }
    }
    public class taskinfo
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
