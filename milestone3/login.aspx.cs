using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace milestone3
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Add any additional initialization code here
        }

        [System.Web.Services.WebMethod]
        public static object UserLogin(string email, string password)
        {
            // Retrieve connection string from web.config
            string connectionString = ConfigurationManager.ConnectionStrings["doniaAhmed"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("UserLogin", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        // Parameters
                        command.Parameters.Add("@email", SqlDbType.VarChar).Value = email;
                        command.Parameters.Add("@password", SqlDbType.VarChar).Value = password;
                        command.Parameters.Add("@success", SqlDbType.Bit).Direction = ParameterDirection.Output;
                        command.Parameters.Add("@usser_id", SqlDbType.Int).Direction = ParameterDirection.Output;

                        // Execute the stored procedure
                        command.ExecuteNonQuery();

                        // Retrieve output parameters
                        bool success = Convert.ToBoolean(command.Parameters["@success"].Value);
                        int userId = Convert.ToInt32(command.Parameters["@usser_id"].Value);

                        return new
                        {
                            Success = success,
                            UserId = userId,
                            ErrorMessage = ""

                        };
                      
                    }
                }
            }
            catch (Exception ex)
            {
                return new
                {
                    Success = false,
                    UserId = -1,
                    ErrorMessage = ex.Message
                };
                // Handle exceptions
            }
        }
    }
}
