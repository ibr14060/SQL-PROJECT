using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;

namespace milestone3
{
    public partial class AdminRemoveUsers : System.Web.UI.Page
    {
        // Removed Page_Load method content for brevity
        protected void Page_Load(object sender, EventArgs e)
        {
            // Retrieve the admin ID from the query string
            string adminId = Request.QueryString["adminId"];

            if (!string.IsNullOrEmpty(adminId))
            {
                // Pass the adminId to the client-side script
                Page.ClientScript.RegisterStartupScript(this.GetType(), "adminId", $"var adminId = '{adminId}';", true);
            }
        }
        [WebMethod]
        public static users Getusers(string userId)
        {
            // This method will be called asynchronously via AJAX
            string connectionString = ConfigurationManager.ConnectionStrings["doniaAhmed"].ConnectionString;
            users users = new users();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("ViewUsers", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        // Parameters
                        command.Parameters.Add("@user_id", SqlDbType.Int).Value = Convert.ToInt32(userId);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Populate the user data
                                users.UserId = Convert.ToInt32(reader["users_id"]);
                                users.FirstName = reader["f_Name"].ToString();
                                users.LastName = reader["l_Name"].ToString();
                                users.Email = reader["email"].ToString();
                                users.Room = Convert.ToInt32(reader["room"]);
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

            return users;
        }

        [WebMethod]
        public static string RemoveUser(string userId, string adminId)
        {
            // This method will be called asynchronously via AJAX
            string connectionString = ConfigurationManager.ConnectionStrings["doniaAhmed"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("GuestRemove", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        // Parameters
                        command.Parameters.Add("@guest_id", SqlDbType.Int).Value = Convert.ToInt32(userId);
                        command.Parameters.Add("@admin_id", SqlDbType.Int).Value = Convert.ToInt32(adminId);

                        // Execute the stored procedure
                        command.ExecuteNonQuery();

                        // Return a success message or additional information if needed
                        return "User removed successfully.";
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                // For now, let's log the error
                Console.WriteLine($"An error occurred: {ex.Message}");
                return "An error occurred while removing the user.";
            }
        }
    }

    public class users
    {
        public int UserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public int Room { get; set; }
    }
}
