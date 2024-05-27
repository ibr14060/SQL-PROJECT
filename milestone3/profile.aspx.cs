using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;

namespace milestone3
{
    public partial class profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Retrieve the user ID from the query string
            string userId = Request.QueryString["userId"];

            if (!string.IsNullOrEmpty(userId))
            {
                // Assign the user ID to the literal for display
                // lblUserId.Text = userId;
            }
        }

        [WebMethod]
        public static ProfileData GetUserProfileData(string userId)
        {
            // This method will be called asynchronously via AJAX
            string connectionString = ConfigurationManager.ConnectionStrings["doniaAhmed"].ConnectionString;
            ProfileData profileData = new ProfileData();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("ViewProfile", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        // Parameters
                        command.Parameters.Add("@users_id", SqlDbType.Int).Value = Convert.ToInt32(userId);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Populate the user data
                                profileData.UserId = Convert.ToInt32(reader["users_id"]);
                                profileData.FirstName = reader["first_name"].ToString();
                                profileData.LastName = reader["last_name"].ToString();
                                profileData.Email = reader["email"].ToString();
                                profileData.Password = reader["password"].ToString();
                                profileData.Preference = reader["preference"].ToString();
                                profileData.Room = Convert.ToInt32(reader["room"]);
                                profileData.tyype = reader["tyype"].ToString();
                                profileData.Birthday = Convert.ToDateTime(reader["birth_date"]).ToString("yyyy-MM-dd");
                                profileData.Age = Convert.ToInt32(reader["age"]);
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

            return profileData;
        }
    }

    public class ProfileData
    {
        public int UserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Preference { get; set; } = string.Empty;
        public int Room { get; set; }
        public string tyype { get; set; }
        public string Birthday { get; set; }
        public int Age { get; set; }
    }
}
