<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="updatedeadline.aspx.cs" Inherits="milestone3.updatedeadline" %>

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
            url: "UserTasks.aspx/GetUserTaskData",
            data: JSON.stringify({ userId: userId }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                // Update the UI with the retrieved data
                $('#lblTaskId').text(data.d.Taskid);
                $('#lblName').text(data.d.Name || ''); // Handle null values
                $('#lblCreation').text(data.d.creation || ''); // Handle null values
                $('#lblDue').text(data.d.due || ''); // Handle null values
                $('#lblCategory').text(data.d.category || ''); // Handle null values
                $('#lblCreator').text(data.d.creator || ''); // Handle null values
                $('#lblStatus').text(data.d.statuss) || '';
                $('#lblReminder').text(data.d.reminder) || '';

                console.log(data.d);
                console.log(data.d.statuss);
            },

            error: function (error) {
                console.log(error);
            }
        });
        });
        function Submit() {
            var taskId = $('#lblTaskId').text(); // Use the task ID from the label
            var day = $('#ddlDay').val();
            var month = $('#ddlMonth').val();
            var year = $('#ddlYear').val();
            var deadlineDate = year + '-' + month + '-' + day;

            // Make AJAX call to server-side code
            $.ajax({
                type: 'POST',
                url: 'updatedeadline.aspx/updatedeadline',
                data: JSON.stringify({
                    taskId: taskId,
                    deadlinedate: deadlineDate
                }),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (result) {
                    var response = result.d;

                    if (response.Success) {
                        alert('Deadline updated successfully!');
                    } else {
                        alert('Error updating deadline: ' + response.ErrorMessage);
                        console.log(response.ErrorMessage);
                    }
                },
                error: function (xhr, status, error) {
                    console.error(xhr.responseText);
                    alert('Error updating deadline. Check the console for more details.');
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
            background-image: url('images/Presentation5.jpg');
            background-size: cover;

        }
        .titlee {
         font-size:175%;
         margin-top:2%; 
        margin-bottom:5%;
        } 
        .updatebody{
        display:flex;
        align-items:center;
        justify-content:center;
        flex-direction:column;
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
.data td{
    color :#ddd;
}
.data th{
    color:#000000;
}
  
  .data .line td {
    border-top: 1px solid #ddd;
  }
  .finishbut{
      background-color:#ff0000 ;
      color : #ddd ;
      border :none;
  }
    </style>
</head>
<body class="body">
   <header class="titlee"> Update Deadline </header>
        <div class ="updatebody">
              <table class="data">
                <thead>
                    <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Creation Date</th>
                    <th>Due Date</th>
                    <th>Category</th>
                    <th>Creator</th>
                    <th>Status</th>
                    <th>Reminder</th>
                    <th> Update Deadline </th>
                    <th>Actions</th>
                    </tr>
                </thead>
 <tbody>
                 <tr>
                    <td><span id="lblTaskId"></span></td>
                    <td><span id="lblName"></span></td>
                    <td><span id="lblCreation"></span></td>
                    <td><span id="lblDue"></span></td>
                    <td><span id="lblCategory"></span></td>
                    <td><span id="lblCreator"></span></td>
                    <td><span id="lblStatus"></span></td>
                    <td><span id="lblReminder"></span></td>


                                <td>
                                     <div style="display: flex;">
                <select id="ddlDay" class="type">
                    <!-- Populate with day options -->
                    <% for (int i = 1; i <= 31; i++) { %>
                        <option value="<%= i %>"><%= i %></option>
                    <% } %>
                </select>
                
                <select id="ddlMonth" class="type">
                    <!-- Populate with month options -->
                    <% string[] months = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }; %>
                    <% foreach (string month in months) { %>
                        <option value="<%= month %>"><%= month %></option>
                    <% } %>
                </select>
                
                <select id="ddlYear" class="type">
                    <!-- Populate with year options -->
                    <% for (int year = 1990; year <= 2023; year++) { %>
                        <option value="<%= year %>"><%= year %></option>
                    <% } %>
                </select>
            </div>
                                </td>
                     <td>
                           <button type="button" onclick="Submit()" class="Submit">Submit</button>
                     </td>
                            </tr>
                
                </tbody>
            </table>
        </div>
 
</body>
</html>
