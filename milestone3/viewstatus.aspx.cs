using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
namespace milestone3
{
    public partial class viewstatus : System.Web.UI.Page
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
        public static statedata GetStatus(string userId)
        {
            // This method will be called asynchronously via AJAX
            string connectionString = ConfigurationManager.ConnectionStrings["doniaAhmed"].ConnectionString;
            statedata statedata = new statedata();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("ViewState", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        // Parameters
                        command.Parameters.Add("@task_id", SqlDbType.Int).Value = Convert.ToInt32(userId); // Changed parameter name

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Populate the user data
                                statedata.Taskid = Convert.ToInt32(reader["Task_id"]);
                                statedata.Name = reader["namee"].ToString();
                                statedata.statuss = reader["statuss"].ToString(); ;

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

            return statedata;
        }
    }

    public class statedata
    {
        public int Taskid { get; set; }
        public string Name { get; set; }
        public string statuss { get; set; }

    }
}