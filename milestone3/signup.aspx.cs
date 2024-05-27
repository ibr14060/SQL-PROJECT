using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;

namespace milestone3
{
    public partial class signup : System.Web.UI.Page
    {
        public class SignupResponse
        {
            public bool Success { get; set; }
            public string ErrorMessage { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static SignupResponse UserRegister(string userType, string email, string firstName, string lastName, string password, string birthDate)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["doniaAhmed"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("UserRegister", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@usertype", userType);
                        command.Parameters.AddWithValue("@email", email);
                        command.Parameters.AddWithValue("@first_name", firstName);
                        command.Parameters.AddWithValue("@last_name", lastName);
                        command.Parameters.AddWithValue("@password", password);
                        command.Parameters.AddWithValue("@birth_date", DateTime.Parse(birthDate));

                        // Declare and handle the output parameter
                        SqlParameter outputParameter = new SqlParameter("@user_id", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        command.Parameters.Add(outputParameter);

                        // Execute the stored procedure
                        command.ExecuteNonQuery();

                        // Retrieve the output parameter value
                        int userId = Convert.ToInt32(outputParameter.Value);

                        return new SignupResponse { Success = true, ErrorMessage = "" };
                    }
                }
                catch (Exception ex)
                {
                    return new SignupResponse { Success = false, ErrorMessage = ex.Message };
                }
            }
        }

    

}
}
