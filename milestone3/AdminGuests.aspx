<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminGuests.aspx.cs" Inherits="milestone3.AdminGuests" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <script>
    $(document).ready(function () {
        // Retrieve the user ID from the query string
        var userId = '<%= Request.QueryString["userId"] %>';

            // Call the WebMethod using AJAX
            $.ajax({
                type: "POST",
                url: "AdminGuests.aspx/getadminguests",
                data: JSON.stringify({ userId: userId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // Update the UI with the retrieved data
                    $('#lblUserId').text(data.d.UserId);
                    $('#noofguests').text(data.d.NoGuests || ''); // Handle null values

                    console.log(data.d);
                },

                error: function (error) {
                    console.log(error);
                }
            });
    });
        function setguests() {
            var userId = '<%= Request.QueryString["userId"] %>';
            var allowedguests = document.getElementById('Guests').value;

            // Make AJAX call to server-side code
            $.ajax({
                type: 'POST',
                url: 'AdminGuests.aspx/setallowed',
                data: JSON.stringify({
                    userId: userId,
                    allowedguests: allowedguests
                }),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (result) {
                    var response = result.d;

                    if (response.Success) {
                        alert('Allowed number of guests updated successfully!');
                    } else {
                        alert('Error updating allowed number of guests: ' + response.ErrorMessage);
                        console.log(response.ErrorMessage);
                    }
                },
                error: function (xhr, status, error) {
                    console.error(xhr.responseText);
                    alert('Error updating allowed number of guests. Check the console for more details.');
                }
            });
        }

    </script>
    <style>

       .body{
            display: flex;
            flex-direction:column;
            align-items: center;
            justify-content: center;
            background-image: url('images/Presentation7.jpg');
            background-size: cover;

        }
        .titlee {
            font-size: 175%;
            margin-top: 2%;
            margin-bottom: 5%;
        } 
        .data{
    border :#808080 1px solid ;
 
    align-items:center;

}
.data td, .data th {
    border: 1px solid #808080;
    padding: 8px;
    text-align: left;
    flex-wrap:nowrap;
    white-space: nowrap;
    
    
  }
.data td{
    color :#ddd;
    align-items:center;
   
}
.data th{
    color:#000000;
}
  
  .data .line td {
    border-top: 1px solid #ddd;
  }
  .edit{
      margin-top:10%;
  }
  .guestsbody{
      display:flex;
        align-items:center;
        justify-content:center;
        flex-direction:column;
  }
  .dropdown{
      margin-top:5%;
      width:40%;
  }

    </style>
</head>
<body class ="body">
   <header class="titlee">  Admin control guests</header>
        <div class="guestsbody">
            <table class="data">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Number Of Guests</th>
                    <th>Set Number Of Guests</th>
                    <th>Action</th>

                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><span id="lblUserId"></span></td>
                    <td><span id="noofguests"></span></td>
                    <td>
                  <select id="Guests" class="dropdown">
                 
                    <% for (int i = 0; i <= 30; i++) { %>
                        <option value="<%= i %>"><%= i %></option>
                    <% } %>
                </select>
                                </td>
                    <td>
                          <button type="button" onclick="setguests()" class="addreminder">Set Number</button>
                    </td>
                    

                </tr>
            </tbody>
      </table>

        </div>
 
</body>
</html>
