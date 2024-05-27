<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminRemoveUsers.aspx.cs" Inherits="milestone3.AdminRemoveUsers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    function viewdet() {
        // Retrieve the user ID from the input field
        var userId = $('#Text1').val();

        // Call the WebMethod using AJAX
        $.ajax({
            type: "POST",
            url: "AdminRemoveUsers.aspx/Getusers",
            data: JSON.stringify({ userId: userId }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                // Update the UI with the retrieved data
                $('#lblUserId').text(data.d.UserId);
                $('#lblFirstName').text(data.d.FirstName || ''); // Handle null values
                $('#lblLastName').text(data.d.LastName || ''); // Handle null values
                $('#lblEmail').text(data.d.Email || ''); // Handle null values
                $('#lblRoom').text(data.d.Room);
                console.log(data.d);
            },
            error: function (error) {
                console.log(error);
            }
        });
    }
    // Function to get URL parameters by name
    function getUrlParameter(name) {
        name = name.replace(/[[]/, "\\[").replace(/[\]]/, "\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)");
        var results = regex.exec(location.search);
        return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }

    function deluser() {
        // Retrieve the user ID from the data attribute
        var userId = $('#lblUserId').text();

        // Retrieve the admin ID from the query string
        var adminId = getUrlParameter("userId");

        console.log(userId);
        console.log(adminId);

        // Call the WebMethod to remove the user
        $.ajax({
            type: "POST",
            url: "AdminRemoveUsers.aspx/RemoveUser",
            data: JSON.stringify({ userId: userId, adminId: adminId }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                // Handle success, e.g., display a message or update the UI
                console.log(data.d);
            },
            error: function (error) {
                console.log(error);
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
            background-image: url('images/Presentation8.jpg');
            background-size: cover;

        }
        .titlee {
         font-size:175%;
         margin-top:2%; 
        margin-bottom:5%;
        } 
        .adminremoveusersbody{
             display:flex;
        align-items:center;
        justify-content:center;
        flex-direction:column;
        }
        .removebut{
            background-color:#ff0000;

        }
              .data{
    border :#808080 1px solid ;
    margin-left: 2%;
}
.data td, .data th {
    border: 1px solid #808080;
    padding: 8px;
    text-align: left;
    flex-wrap:nowrap;
    white-space: nowrap;
    
    
  }
.ata td{
    color :#ddd;
}
.data th{
    color:#000000;
}
  
  .data .line td {
    border-top: 1px solid #ddd;
  }
    </style>
</head>
<body class ="body">
    <header class="titlee"> Admin control users</header>
        <div class ="adminremoveusersbody">
             <label>Enter the ID of the user you want</label>
            <input id="Text1" type="text"  placeholder="Enter User ID"/>
                  <button type="button" onclick="viewdet()" class="addreminder">View User</button>
             <table class="data">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Room</th>
                    <th>Remove</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><span id="lblUserId"></span></td>
                    <td><span id="lblFirstName"></span></td>
                    <td><span id="lblLastName"></span></td>
                    <td><span id="lblEmail"></span></td>
                    <td><span id="lblRoom"></span></td>
                    <td> <button type="button" onclick="deluser()" class="addreminder">Remove User</button></td>
                </tr>
            </tbody>
        </table>
        </div>
    
</body>
</html>
