using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web.Script.Services;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace milestone3
{
    public partial class AdminGuests : System.Web.UI.Page
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
        public static Guestsdata getadminguests(string userId)
        {
            // This method will be called asynchronously via AJAX
            string connectionString = ConfigurationManager.ConnectionStrings["doniaAhmed"].ConnectionString;
            Guestsdata Guestsdata = new Guestsdata();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("ViewAdmins", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        // Parameters
                        command.Parameters.Add("@admin_id", SqlDbType.Int).Value = Convert.ToInt32(userId);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Populate the user data
                                Guestsdata.UserId = Convert.ToInt32(reader["admin_id"]);
                                Guestsdata.NoGuests = Convert.ToInt32(reader["no_of_guests_allowed"]);
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

            return Guestsdata;
        }
        public class setresponse
        {
            public bool Success { get; set; }
            public string ErrorMessage { get; set; }
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        
        public static setresponse setallowed(string userId, string allowedguests)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["doniaAhmed"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("GuestsAllowed", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@admin_id", Convert.ToInt32(userId));
                        command.Parameters.AddWithValue("@number_of_guests", Convert.ToInt32(allowedguests));

                        command.ExecuteNonQuery();

                        return new setresponse { Success = true, ErrorMessage = "" };
                    }
                }
            }
            catch (Exception ex)
            {
                return new setresponse { Success = false, ErrorMessage = ex.Message };
            }
        }


    }

    public class Guestsdata
    {
        public int UserId { get; set; }
        public int NoGuests { get; set; }

    }
}